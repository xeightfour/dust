require('catppuccin').setup({
    flavour = 'mocha', -- latte, frappe, macchiato, mocha
    background = {
        light = 'latte',
        dark = 'mocha'
    },
    styles = { comments = { 'italic' }, conditionals = {} }
})

vim.cmd.colorscheme 'catppuccin'
