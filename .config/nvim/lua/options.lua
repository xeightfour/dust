local opt = vim.opt

vim.cmd('set notermguicolors')
vim.cmd('color sorbet')

opt.showcmd = false

opt.virtualedit = 'all'
opt.foldmethod = 'marker'

opt.tabstop = 4
opt.shiftwidth = 4
opt.cinoptions = { 'g0', '(0', 'm1' }

opt.cursorlineopt = { 'screenline', 'number' }
opt.cursorline = true

opt.numberwidth = 4
opt.relativenumber = false
opt.number = true

opt.ignorecase = true
opt.smartcase = true

opt.shortmess:append { I = true }
opt.listchars:append { trail = '·', tab = '│  ' }
opt.list = true

opt.lazyredraw = true
