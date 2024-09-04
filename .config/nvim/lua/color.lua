vim.opt.termguicolors = true
require('catppuccin').setup({
	flavour = 'mocha', -- latte, frappe, macchiato, mocha
	show_end_of_buffer = true,
	background = {
		light = 'latte',
		dark = 'mocha'
	},
	styles = {
		comments = { 'italic' },
		conditionals = { 'italic' },
		numbers = { 'bold' }
	}
})
vim.cmd('colorscheme catppuccin')
