local M = {}

-- Store previous window reference locally within the module
local prevWin = nil

-- Creates a new buffer and window with given configuration
M.newWin = function(config, focus)
	local buf = vim.api.nvim_create_buf(false, true) -- Create an unnamed, scratch buffer
	local win = vim.api.nvim_open_win(buf, focus, config) -- Open a new floating or split window
	return { window = win, buffer = buf }
end

-- Creates a fixed-size window below the current one
M.newFixedWin = function(side, size, focus)
	return M.newWin({
		win = 0,
		split = side,
		height = size,
		style = "minimal"
	}, focus)
end

-- Deletes the specified window and its associated buffer
M.deleteWin = function(win)
	if not win or not vim.api.nvim_win_is_valid(win) then
		return
	end
	local buf = vim.api.nvim_win_get_buf(win)
	if vim.api.nvim_buf_is_valid(buf) then
		vim.api.nvim_buf_delete(buf, { force = true }) -- Force deletion of the buffer
	end
	vim.api.nvim_win_close(win, true) -- Close the window forcibly
end

-- Builds the current Go file in a terminal window
M.build = function()
	M.deleteWin(prevWin) -- Clean up any existing build window
	local name = vim.api.nvim_buf_get_name(0)
	if not vim.fn.filereadable(name) then
		vim.notify("File not readable: " .. name, vim.log.levels.ERROR)
		return
	end
	prevWin = M.newFixedWin("below", 3, true).window
	vim.cmd("edit term://go build " .. vim.fn.shellescape(name)) -- Escape filename for safety
	vim.cmd("keepalt file Building " .. name)
end

-- Runs the current Go file in a terminal window
M.run = function()
	M.deleteWin(prevWin) -- Clean up any existing run window
	local name = vim.api.nvim_buf_get_name(0)
	if not vim.fn.filereadable(name) then
		vim.notify("File not readable: " .. name, vim.log.levels.ERROR)
		return
	end
	prevWin = M.newFixedWin("below", 8, true).window
	vim.cmd("edit term://go run " .. vim.fn.shellescape(name)) -- Escape filename for safety
	vim.cmd("keepalt file Running " .. name)
end

-- Formats the current Go file using 'gofmt'
M.fmt = function()
	local name = vim.api.nvim_buf_get_name(0)
	if not vim.fn.executable("gofmt") then
		vim.notify("gofmt not found!", vim.log.levels.ERROR)
		return
	end
	if not vim.fn.filereadable(name) then
		vim.notify("File not readable: " .. name, vim.log.levels.ERROR)
		return
	end
	vim.system({ "gofmt", "-w", name }, { stdout = false, stdin = false, text = true }, vim.schedule_wrap(function()
		vim.cmd("e!") -- Reload the buffer to reflect changes
		vim.notify("Formatted!", vim.log.levels.INFO)
	end))
end

-- Creates user-defined commands for Go-related actions
M.createCommands = function(args)
	vim.api.nvim_buf_create_user_command(args.buf, "GoFmt", M.fmt, { nargs = 0 })
	vim.api.nvim_buf_create_user_command(args.buf, "GoRun", M.run, { nargs = 0 })
	vim.api.nvim_buf_create_user_command(args.buf, "GoBuild", M.build, { nargs = 0 })
end

-- Sets up key mappings for Go-related actions
M.createMaps = function(args)
	vim.keymap.set("n", "<space>f", M.fmt, { buffer = args.buf, desc = "Format Go File" })
	vim.keymap.set("n", "<space>g", M.run, { buffer = args.buf, desc = "Run Go File" })
	vim.keymap.set("n", "<space>b", M.build, { buffer = args.buf, desc = "Build Go File" })
end

-- Initializes the plugin by setting up commands and keymaps for Go files
M.main = function(args)
	M.createCommands(args)
	M.createMaps(args)
end

-- Configures autocommands for Go files and terminal windows
M.setup = function()
	local group = vim.api.nvim_create_augroup("nvim-go", { clear = true })
	vim.api.nvim_create_autocmd({ "FileType" }, {
		pattern = "go",
		callback = function() M.main({ buf = 0 }) end, -- Pass current buffer explicitly
		group = group
	})
	vim.api.nvim_create_autocmd({ "TermOpen" }, {
		command = "setlocal wrap!",
		group = group
	})
end

M.setup()
