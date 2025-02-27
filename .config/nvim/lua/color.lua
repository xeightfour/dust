vim.opt.termguicolors = true

require('gruvbox').setup({
	contrast = 'hard' -- hard, soft or empty string
})

require('catppuccin').setup({
	flavour = 'mocha', -- latte, frappe, macchiato, mocha
	integrations = {
		treesitter = false,
		lsp = false,
		telescope = false,
		cmp = false
	},
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
