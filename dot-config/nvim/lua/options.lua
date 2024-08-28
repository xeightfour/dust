local opt = vim.opt

opt.mouse = ''
opt.showcmd = false
opt.cmdheight = 0
opt.virtualedit = 'all'

opt.tabstop = 4
opt.shiftwidth = 4
opt.cinoptions = { '(s', 'm1' }

opt.cursorlineopt = { 'screenline', 'number' }
opt.numberwidth = 4
opt.cursorline = true
opt.number = true

opt.shortmess:append { I = true }
opt.listchars:append { trail = '·', tab = '│  ' }
opt.list = true
