-- ~/.config/nvim/lua/stephane/options.lua

local opt = vim.opt

opt.number = true
opt.relativenumber = false
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = false
opt.mouse = "a"
opt.clipboard = "unnamedplus"
opt.wrap = false
opt.termguicolors = true

-- Autoriser h, l, les flèches (mode Normal) et les flèches (mode Insertion) à changer de ligne
opt.whichwrap:append("h,l,<,>,[,]")

