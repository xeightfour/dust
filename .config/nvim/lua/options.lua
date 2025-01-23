local opt = vim.opt

opt.showcmd = false

opt.virtualedit = 'all'
opt.foldmethod = 'marker'

opt.tabstop = 4
opt.shiftwidth = 4
opt.cinoptions = { 'g0', '(s', 'm1' }

opt.cursorlineopt = { 'screenline', 'number' }
opt.cursorline = true

opt.numberwidth = 4
opt.relativenumber = false
opt.number = true

opt.shortmess:append { I = true }
opt.listchars:append { trail = '·', tab = '│  ' }
opt.list = true

opt.lazyredraw = true
