local M = {}

local bundle = vim.fn.stdpath('data') .. '/site/pack/bundle/opt'
local manifest = vim.fn.stdpath('config') .. '/manifest.lua'

local plugins = {}

local todo = 0
local done = 0
local fail = 0

local updates = 0
local ongoing = 0

M.toGitURL = function(author, plugin)
    return string.format('https://github.com/%s/%s.git', author, plugin)
end

M.noteUpdate = function()
    updates = updates + 1
    if updates == #plugins then
        vim.notify('Updated!', vim.log.levels.INFO)
    end
end

M.gitPull = function(name, onSuccess)
    local dir = bundle .. '/' .. name
    local branch = vim.fn.system('git -C ' .. dir .. ' branch --show-current | tr -d \'\\n\'')
    vim.uv.spawn('git', {
        args = {
            'pull', 'origin', branch, '--update-shallow', '--ff-only', '--progress', '--rebase=false'
        },
        cwd = dir
    }, vim.schedule_wrap(function(code, signal)
        ongoing = ongoing - 1
        if code == 0 then
            M.noteUpdate()
            onSuccess(name)
        else
            vim.notify(name .. ' pull was unsuccessful!', vim.log.levels.ERROR)
        end
    end))
end

M.gitClone = function(name, url, onSuccess)
    vim.uv.spawn('git', {
        args = {
            'clone', '--depth=1', url, name
        },
        cwd = bundle
    }, vim.schedule_wrap(function(code)
        if code == 0 then
            done = done + 1
            onSuccess(name)
        else
            fail = fail + 1
            vim.notify(name .. ' clone was unsuccessful!', vim.log.levels.ERROR)
        end
        M.loadNVIM()
    end))
end

M.packUpdate = function()
    if ongoing ~= 0 then
        vim.notify('Wait for previous operation to complete...', vim.log.levels.INFO)
        return
    end
    updates = 0
    ongoing = #plugins
    for i, data in ipairs(plugins) do
        local onSuccess = function(plugin)
            vim.cmd('packadd ' .. plugin)
            if data.postUpdate then
                local dir = bundle .. '/' .. plugin
                if type(data.postUpdate) == 'function' then
                    data.postUpdate(dir)
                elseif type(data.postUpdate) == 'table' then
                    vim.uv.spawn(data.postUpdate[1], {
                        args = data.postUpdate.args,
                        cwd = dir
                    }, vim.schedule_wrap(function(code)
                        if code ~= 0 then
                            vim.notify(string.format('Failed to run %s', vim.inspect(data.postUpdate)), vim.log.levels.ERROR)
                        end
                    end))
                end
            end
        end
        if vim.fn.isdirectory(bundle .. '/' .. data.name) ~= 0 then
            M.gitPull(data.name, onSuccess)
        else
            M.gitClone(data.name, M.toGitURL(data.author .. '/' .. data.plugin), onSuccess)
        end
    end
end

M.packEdit = function()
    vim.cmd('tabnew ' .. manifest)
end

M.loadConfig = function()
    local dir = vim.fn.stdpath('config') .. '/lua'
    local tab = vim.fs.find(function(name, path)
        return name:match('.*%.lua$') and not name:match('bundle.lua')
    end, { limit = math.huge, type = 'file', path = dir })
    for i, name in ipairs(tab) do
        dofile(name)
    end
end

M.reloadConfig = function()
    M.loadConfig()
    vim.notify('Reloaded!', vim.log.levels.INFO)
end

M.createCommands = function()
    vim.api.nvim_create_user_command('PackUpdate', M.packUpdate, {})
    vim.api.nvim_create_user_command('PackEdit', M.packEdit, {})
    vim.api.nvim_create_user_command('ReloadConfig', M.reloadConfig, {})
end

M.loadNVIM = function()
    if todo == 0 then
        M.createCommands()
        M.loadConfig()
    elseif todo == done then
        vim.notify('Installed some plugins, please restart neovim...', vim.log.levels.INFO)
    elseif todo == done + fail then
        vim.notify('Failed to install some plugins, please restart neovim...', vim.log.levels.INFO)
    end
end

M.setup = function()
    vim.fn.mkdir(bundle, 'p')
    using = function(opts)
        if type(opts.github) ~= 'string' then
            vim.notify('Github link is required!', vim.log.levels.ERROR)
            return
        end
        local st, en, author, plugin = string.find(opts.github, '^([^ /]+)/([^ /]+)$')
        if author == nil or plugin == nil then
            vim.notify(opts.github .. ' is not valid!', vim.log.levels.ERROR)
            return
        end
        if type(opts.name) ~= 'string' then
            opts.name = plugin
        end
        table.insert(plugins, {
            name = opts.name,
            plugin = plugin,
            author = author,
            postUpdate = opts.postUpdate
        })
        if vim.fn.isdirectory(bundle .. '/' .. opts.name) ~= 0 then
            vim.cmd('packadd ' .. opts.name)
        else
            todo = todo + 1
            M.gitClone(opts.name, M.toGitURL(author, plugin), function()
                vim.cmd('packadd! ' .. opts.name)
            end)
        end
    end
    if vim.fn.filereadable(manifest) ~= 0 then
        dofile(manifest)
    end
    using = nil
    if todo == 0 then
        M.loadNVIM()
    end
end

return { setup = M.setup }
