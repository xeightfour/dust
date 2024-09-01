local M = {}

local prevWin = nil

M.newWin = function(config, focus)
	local buf = vim.api.nvim_create_buf(false, true)
	local win = vim.api.nvim_open_win(buf, focus, config)
	return { window = win, buffer = buf }
end

M.newFixedWin = function(side, size, focus)
	return M.newWin({
		win = 0,
		split = side,
		height = size,
		style = 'minimal'
	}, focus)
end

M.deleteWin = function(win)
	if win ~= nil then
		if vim.api.nvim_win_is_valid(win) == true then
			buf = vim.api.nvim_win_get_buf(win)
			vim.api.nvim_buf_delete(buf, { force = true })
		end
	end
end

M.build = function()
	M.deleteWin(prevWin)
	local name = vim.api.nvim_buf_get_name(0)
	local win = M.newFixedWin('below', 3, true)
	prevWin = win.window
	vim.cmd('edit term://go build ' .. name)
	vim.cmd('keepalt file Building ' .. name)
end

M.run = function()
	M.deleteWin(prevWin)
	local name = vim.api.nvim_buf_get_name(0)
	local win = M.newFixedWin('below', 8, true)
	prevWin = win.window
	vim.cmd('edit term://go run ' .. name)
	vim.cmd('keepalt file Running ' .. name)
end

M.createCommands = function(args)
	vim.api.nvim_buf_create_user_command(args.buf, 'GoRun', M.run, { nargs = 0 })
	vim.api.nvim_buf_create_user_command(args.buf, 'GoBuild', M.build, { nargs = 0 })
end

M.createMaps = function(args)
	vim.keymap.set('n', '<space>g', M.run, { buffer = args.buf })
	vim.keymap.set('n', '<space>b', M.build, { buffer = args.buf })
end

M.main = function(args)
	M.createCommands(args)
	M.createMaps(args)
end

M.setup = function()
	local group = vim.api.nvim_create_augroup('nvim-go', { clear = true })
	vim.api.nvim_create_autocmd({ 'FileType' }, {
		pattern = 'go',
		callback = M.main,
		group = group
	})
	vim.api.nvim_create_autocmd({ 'TermOpen' }, {
		command = 'setlocal wrap!',
		group = group
	})
end

M.setup()
