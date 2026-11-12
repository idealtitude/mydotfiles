-- ~/.config/nvim/init.lua
vim.g.mapleader = " "

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

vim.notify = function(msg, ...)
  if msg:match("tsserver is deprecated") then
    return
  end
  return vim.notify_orig(msg, ...)
end

vim.notify_orig = vim.notify

-- Chargement des modules persos
require("stephane.options")
require("stephane.plugins")
require("stephane.lsp")
require("stephane.keymaps")
require("stephane.nvimtree")

-- Cycle through text
-- vim.opt.whichwrap:append("h,l,<,>,b,s")
