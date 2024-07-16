local opt = vim.opt
-- local g = vim.g
local cmd = vim.cmd

opt.termguicolors = true

require("catppuccin").setup({
    flavour = "mocha", -- latte, frappe, macchiato, mocha
    background = {
        light = "latte",
        dark = "mocha",
    },
    styles = { comments = {}, conditionals = {} },
})

vim.cmd.colorscheme "catppuccin"

opt.showcmd = false
opt.cmdheight = 0

opt.virtualedit = 'all'
opt.mouse = 'a'

opt.expandtab = true
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4

opt.cursorlineopt = { 'screenline', 'number' }
opt.colorcolumn = { 110 }
opt.numberwidth = 5
opt.cursorline = true
opt.number = true

opt.fillchars:append('eob: ')
opt.shortmess:append('I')
opt.listchars:append('trail:·')
opt.list = true

-- KEY BINDING ESSENTIALS --

function map(mode, shortcut, command)
    vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

function nmap(shortcut, command) map('n', shortcut, command) end

function imap(shortcut, command) map('i', shortcut, command) end

function vmap(shortcut, command) map('v', shortcut, command) end

-- KEY BINDINGS --

nmap('<space>l', ':source $MYVIMRC<cr>')
nmap('<space>v', ':tabnew $MYVIMRC<cr>')

nmap('<space>w', ':w!<cr>')
nmap('<space>q', ':q!<cr>')
nmap('<space>x', ':x!<cr>')

nmap('<c-j>', '<c-w>j')
nmap('<c-l>', '<c-w>l')
nmap('<c-h>', '<c-w>h')
nmap('<c-k>', '<c-w>k')

nmap('<c-[>', ':tabprev<cr>')
nmap('<c-]>', ':tabnext<cr>')

nmap('q', '')
nmap('<space><space>', ':nohlsearch<cr>')
nmap('<space>tr', ':silent! %s/\\s\\+$//<cr> :nohlsearch<cr>')

nmap('j', 'gj')
nmap('k', 'gk')
vmap('j', 'gj')
vmap('k', 'gk')

nmap('B', '^')
nmap('E', '$')
vmap('B', '^')
vmap('E', '$')
