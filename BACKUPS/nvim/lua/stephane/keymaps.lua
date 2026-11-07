-- ~/.config/nvim/lua/stephane/keymaps.lua
local keymap = vim.keymap.set

-- Options par défaut pour nos raccourcis
local opts = { silent = true }

-- Raccourcis pour l'Explorateur (NvimTree)
keymap("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle NvimTree", silent = true })
keymap("n", "<leader>f", "<cmd>lua require('nvim-tree.api').tree.focus()<CR>", { desc = "Focus NvimTree", silent = true })

-- Navigation entre buffers
keymap("n", "<leader>bn", ":bnext<CR>", { desc = "Next buffer", silent = true })
keymap("n", "<leader>bp", ":bprevious<CR>", { desc = "Previous buffer", silent = true })
keymap("n", "<leader>bd", ":bd<CR>", { desc = "Delete buffer", silent = true })

-- ~/.config/nvim/lua/stephane/keymaps.lua
local keymap = vim.keymap.set

-- Diagnostics (Erreurs et avertissements du LSP)
keymap("n", "<leader>d", vim.diagnostic.open_float, { desc = "Afficher l'erreur sous le curseur", silent = true })
keymap("n", "[d", function() vim.diagnostic.jump({ count = -1 }) end, { desc = "Aller à l'erreur précédente", silent = true })
keymap("n", "]d", function() vim.diagnostic.jump({ count = 1 }) end, { desc = "Aller à l'erreur suivante", silent = true })

-- Recherche avec Telescope
local builtin = require('telescope.builtin')
keymap('n', '<leader>pf', builtin.find_files, { desc = 'Chercher un fichier par son nom', silent = true })
keymap('n', '<leader>ps', builtin.live_grep, { desc = 'Chercher un mot dans tout le projet', silent = true })
keymap('n', '<leader>pb', builtin.buffers, { desc = 'Chercher parmi les fichiers ouverts', silent = true })
