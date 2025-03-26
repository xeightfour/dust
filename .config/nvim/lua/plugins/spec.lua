return {
	{
		'catppuccin/nvim',
		name = 'catppuccin',
		lazy = true,
		config = true,
		opts = {
			flavour = 'mocha', -- latte, frappe, macchiato, mocha
			integrations = {
				treesitter = true,
				lsp = false,
				telescope = false,
				cmp = false,
			},
			show_end_of_buffer = true,
			background = {
				light = 'latte',
				dark = 'mocha',
			},
			styles = {
				comments = { 'italic' },
				conditionals = { 'italic' },
				numbers = { 'bold' },
			},
		},
	},

	{
		'ellisonleao/gruvbox.nvim',
		name = 'gruvbox',
		lazy = true,
		config = true,
		opts = {
			contrast = 'hard', -- hard, soft, or empty string
		},
	},

	{
		'lewpoly/sherbet.nvim',
		name = 'sherbet',
		lazy = false,
	},

	{
		'bfrg/vim-c-cpp-modern',
		lazy = true,
		ft = { 'cpp', 'cxx', 'c', 'h', 'hpp' },
	},

	{
		'charlespascoe/vim-go-syntax',
		lazy = true,
		ft = 'go'
	},

	{
		'tikhomirov/vim-glsl',
		lazy = true,
		ft = 'glsl'
	},
}
