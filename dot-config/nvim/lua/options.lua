local opt = vim.opt

opt.mouse = ''
opt.showcmd = false
opt.cmdheight = 0
opt.virtualedit = 'all'

opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true

opt.cursorlineopt = { 'screenline', 'number' }
opt.numberwidth = 4
opt.cursorline = true
opt.number = true

opt.shortmess:append { I = true }
opt.listchars:append { trail = '·' }
opt.list = true
