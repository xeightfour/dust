vim.opt.termguicolors = true
require('catppuccin').setup({
    flavour = 'mocha', -- latte, frappe, macchiato, mocha
    background = {
        light = 'latte',
        dark = 'mocha'
    },
    styles = {
        comments = { 'italic' },
        conditionals = { 'italic' }
    },
    default_integrations = false,
    integrations = {
        treesitter = true
    }
})
vim.cmd('colorscheme catppuccin')
