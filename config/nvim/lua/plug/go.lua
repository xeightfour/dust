local M = {}

function M.newTerm(size)
    vim.cmd('below split')
    vim.api.nvim_win_set_height(0, size)
    vim.cmd.terminal()
    vim.api.nvim_feedkeys('a', 't', false)
end

function M.build()
    local name = vim.api.nvim_buf_get_name(0)
    M.newTerm(8)
    vim.api.nvim_chan_send(vim.bo.channel, 'go build ' .. name .. '\r')
end

function M.run()
    local name = vim.api.nvim_buf_get_name(0)
    M.newTerm(8)
    vim.api.nvim_chan_send(vim.bo.channel, 'go run ' .. name .. '\r')
end

function M.commands(args)
    vim.api.nvim_buf_create_user_command(args.buf, 'Gun', M.run, { nargs = 0 })
    vim.api.nvim_buf_create_user_command(args.buf, 'Guild', M.build, { nargs = 0 })
end

function M.maps(args)
    vim.keymap.set('n', '<space>g', M.run, { buffer = args.buf })
    vim.keymap.set('n', '<space>b', M.build, { buffer = args.buf })
end

function M.main(args)
    M.commands(args)
    M.maps(args)
end

function M.setup()
    local goGroup = vim.api.nvim_create_augroup('goGroup', { clear = true })
    vim.api.nvim_create_autocmd({ 'FileType' }, {
        pattern = 'go',
        callback = M.main,
        group = goGroup
    })
    vim.api.nvim_create_autocmd({ 'TermOpen' }, {
        command = 'setlocal wrap!',
        group = goGroup
    })
end

return M
