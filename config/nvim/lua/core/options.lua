local opt = vim.opt

opt.termguicolors = true

opt.showcmd = false
opt.cmdheight = 0

opt.virtualedit = 'all'
opt.mouse = ''

opt.smartindent = true
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true

opt.cursorlineopt = { 'screenline', 'number' }
opt.colorcolumn = { 110 }
opt.numberwidth = 5
opt.cursorline = true
opt.number = true

opt.fillchars:append('eob: ')
opt.shortmess:append('I')
opt.listchars:append('trail:·')
opt.list = true
