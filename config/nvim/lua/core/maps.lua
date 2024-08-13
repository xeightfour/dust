nmap('<space>l', ':lua ReloadConfig()<cr>')
nmap('<space>v', ':tabnew ~/.config/nvim<cr>')

nmap('<space>w', ':w!<cr>')
nmap('<space>Q', ':q!<cr>') -- painful
nmap('<space>x', ':x!<cr>')

nmap('<c-j>', '<c-w>j')
nmap('<c-l>', '<c-w>l')
nmap('<c-h>', '<c-w>h')
nmap('<c-k>', '<c-w>k')

nmap(',', ':tabprev<cr>')
nmap('.', ':tabnext<cr>')
nmap('<esc>', '')
nmap('q', '') -- FUQ

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

tmap('<esc>', '<c-\\><c-n>')
