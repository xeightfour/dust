local nmap = function(combo, command)
	vim.keymap.set('n', combo, command, {})
end
local imap = function(combo, command)
	vim.keymap.set('i', combo, command, {})
end
local vmap = function(combo, command)
	vim.keymap.set('v', combo, command, {})
end
local tmap = function(combo, command)
	vim.keymap.set('t', combo, command, {})
end

nmap('<space>l', ':luafile ~/.config/nvim/init.lua<cr>')
nmap('<space>v', ':tabnew ~/.config/nvim<cr>')

nmap('<space>w', ':w!<cr>')
nmap('<space>Q', ':q!<cr>')
nmap('<space>x', ':x!<cr>')

nmap('<c-j>', '<c-w>j')
nmap('<c-l>', '<c-w>l')
nmap('<c-h>', '<c-w>h')
nmap('<c-k>', '<c-w>k')

nmap('H', ':tabprev<cr>')
nmap('L', ':tabnext<cr>')

nmap('<space><space>', ':nohlsearch<cr>')
nmap('<space>tr', ':silent! %s/\\s\\+$//<cr> :nohlsearch<cr>')

nmap('j', 'gj')
vmap('j', 'gj')
nmap('k', 'gk')
vmap('k', 'gk')

nmap('B', '^')
vmap('B', '^')
nmap('E', '$')
vmap('E', '$')

nmap('<esc>', '<>')
tmap('<esc>', '<c-\\><c-n>')
