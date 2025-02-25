local M = {}

local bundle = vim.fn.stdpath('data') .. '/site/pack/bundle/opt'
local manifest = vim.fn.stdpath('config') .. '/manifest.lua'

local plugins = {}
local state = {
	todo = 0,
	done = 0,
	fail = 0,
	updates = 0,
	ongoing = 0
}

-- Function to convert author and plugin name to a GitHub URL
M.toGitURL = function(author, plugin)
	return string.format('https://github.com/%s/%s.git', author, plugin)
end

-- Function to note a successful update
M.noteUpdate = function()
	state.updates = state.updates + 1
	if state.updates == #plugins then
		vim.notify('Updated!', vim.log.levels.INFO)
	end
end

-- Function to pull the latest changes from a Git repository
M.gitPull = function(name, onSuccess)
	local dir = bundle .. '/' .. name
	-- Get the current branch name
	local branch = vim.fn.system('git -C ' .. dir .. ' branch --show-current | tr -d \'\\n\'')
	if vim.v.shell_error ~= 0 then
		vim.notify('Failed to get current branch for ' .. name, vim.log.levels.ERROR)
		return
	end

	-- Spawn the git pull command
	vim.uv.spawn('git', {
		args = {
			'pull', 'origin', branch, '--update-shallow', '--ff-only', '--progress', '--rebase=false'
		},
		cwd = dir
	}, vim.schedule_wrap(function(code, signal)
		state.ongoing = state.ongoing - 1
		if code == 0 then
			M.noteUpdate()
			onSuccess(name)
		else
			vim.notify(name .. ' pull was unsuccessful!', vim.log.levels.ERROR)
		end
	end))
end

-- Function to clone a Git repository
M.gitClone = function(name, url, onSuccess)
	vim.uv.spawn('git', {
		args = {
			'clone', '--depth=1', url, name
		},
		cwd = bundle
	}, vim.schedule_wrap(function(code)
		if code == 0 then
			state.done = state.done + 1
			onSuccess(name)
		else
			state.fail = state.fail + 1
			vim.notify(name .. ' clone was unsuccessful!', vim.log.levels.ERROR)
		end
		M.loadNVIM()
	end))
end

-- Function to update all installed plugins
M.packUpdate = function()
	if state.ongoing ~= 0 then
		vim.notify('Wait for previous operation to complete...', vim.log.levels.INFO)
		return
	end
	state.updates = 0
	state.ongoing = #plugins
	for i, data in ipairs(plugins) do
		local onSuccess = function(plugin)
			vim.cmd('packadd ' .. plugin)
			if data.postUpdate then
				local dir = bundle .. '/' .. plugin
				if type(data.postUpdate) == 'function' then
					-- Use pcall to handle errors in the function
					local success, err = pcall(data.postUpdate, dir)
					if not success then
						vim.notify('Post-update function failed for ' .. plugin .. ': ' .. err, vim.log.levels.ERROR)
					end
				elseif type(data.postUpdate) == 'table' then
					vim.uv.spawn(data.postUpdate[1], {
						args = data.postUpdate.args,
						cwd = dir
					}, vim.schedule_wrap(function(code)
						if code ~= 0 then
							vim.notify(string.format('Failed to run %s', vim.inspect(data.postUpdate)), vim.log.levels.ERROR)
						end
					end))
				else
					vim.notify('Invalid postUpdate type for ' .. plugin, vim.log.levels.ERROR)
				end
			end
		end
		if vim.fn.isdirectory(bundle .. '/' .. data.name) ~= 0 then
			M.gitPull(data.name, onSuccess)
		else
			M.gitClone(data.name, M.toGitURL(data.author, data.plugin), onSuccess)
		end
	end
end

-- Function to edit the manifest file
M.packEdit = function()
	if vim.fn.filereadable(manifest) == 0 then
		vim.notify('Manifest file does not exist!', vim.log.levels.ERROR)
		return
	end
	vim.cmd('tabnew ' .. manifest)
end

-- Function to load configuration files
M.loadConfig = function()
	local dir = vim.fn.stdpath('config') .. '/lua'
	local tab = vim.fs.find(function(name, path)
		return name:match('.*%.lua$') and not name:match('bundle.lua')
	end, { limit = math.huge, type = 'file', path = dir })
	for i, name in ipairs(tab) do
		-- Use pcall to handle errors in dofile
		local success, err = pcall(dofile, name)
		if not success then
			vim.notify('Failed to load config file ' .. name .. ': ' .. err, vim.log.levels.ERROR)
		end
	end
end

-- Function to reload configuration files
M.reloadConfig = function()
	M.loadConfig()
	vim.notify('Reloaded!', vim.log.levels.INFO)
end

-- Function to create custom commands
M.createCommands = function()
	vim.api.nvim_create_user_command('PackUpdate', M.packUpdate, {})
	vim.api.nvim_create_user_command('PackEdit', M.packEdit, {})
	vim.api.nvim_create_user_command('ReloadConfig', M.reloadConfig, {})
end

-- Function to load Neovim environment
M.loadNVIM = function()
	if state.todo == 0 then
		M.createCommands()
		M.loadConfig()
	elseif state.todo == state.done then
		vim.notify('Installed some plugins, please restart neovim...', vim.log.levels.INFO)
	elseif state.todo == state.done + state.fail then
		vim.notify('Failed to install some plugins, please restart neovim...', vim.log.levels.INFO)
	end
end

-- Function to set up the plugin manager
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
			state.todo = state.todo + 1
			M.gitClone(opts.name, M.toGitURL(author, plugin), function()
				vim.cmd('packadd! ' .. opts.name)
			end)
		end
	end
	if vim.fn.filereadable(manifest) ~= 0 then
		-- Use pcall to handle errors in dofile
		local success, err = pcall(dofile, manifest)
		if not success then
			vim.notify('Failed to load manifest file: ' .. err, vim.log.levels.ERROR)
		end
	end
	using = nil
	if state.todo == 0 then
		M.loadNVIM()
	end
end

return { setup = M.setup }
