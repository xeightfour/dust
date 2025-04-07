local opt = vim.opt

vim.cmd("set termguicolors")
vim.cmd("color sorbet")

opt.showcmd = true

opt.virtualedit = "all"
opt.foldmethod = "marker"

opt.autoindent = true
opt.smartindent = true

opt.tabstop = 4
opt.shiftwidth = 4
opt.cinoptions = { "g0", "(s", "us", "U1", "ks", "m1" }

opt.cursorlineopt = { "screenline", "number" }
opt.cursorline = true
opt.colorcolumn = { 80 }

opt.numberwidth = 4
opt.relativenumber = false
opt.number = true

opt.ignorecase = true
opt.smartcase = true

opt.shortmess:append { I = true }
opt.listchars:append { trail = "·", tab = "│  " }
opt.list = true

opt.lazyredraw = true
