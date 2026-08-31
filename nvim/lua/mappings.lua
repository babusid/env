require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "<leader>fw", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>", { desc = "Live Grep with Args" })
map("n", "<leader>fs", "<cmd>Telescope lsp_document_symbols<CR>", { desc = "LSP Document Symbols" })
map("n", "<leader>fd", "<cmd>Telescope lsp_definitions<CR>", { desc = "Telescope Go to Definition" })
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
