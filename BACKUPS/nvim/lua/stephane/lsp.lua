-- ~/.config/nvim/lua/stephane/lsp.lua

local lspconfig = require("lspconfig")

-- Langages que tu utilises souvent
--lspconfig.pyright.setup{}
lspconfig.pylsp.setup{}
lspconfig.clangd.setup{}       -- C / C++
--lspconfig.rust_analyzer.setup{} -- Rust
lspconfig.bashls.setup{}       -- Bash
--lspconfig.html.setup{}
--lspconfig.cssls.setup{}
--lspconfig.tsserver.setup{}     -- JS/TS
--lspconfig.jsonls.setup{}
--lspconfig.lua_ls.setup{}       -- Lua

-- Pour PHP, il y a : `intelephense` (installable via npm)
-- Pour SQL, il y a `sqlls`, mais pas toujours utile.
-- Pour Makefile et CMake, les LSP sont très limités.

-- Configuration de la complétion
local cmp = require'cmp'
cmp.setup({
  mapping = cmp.mapping.preset.insert({
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }),
  sources = {
    { name = 'nvim_lsp' },
  }
})
