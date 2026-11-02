return {
  "sindrets/diffview.nvim",
  cmd = {
    "DiffviewOpen",
    "DiffviewClose",
    "DiffviewFileHistory",
    "DiffviewToggleFiles",
    "DiffviewFocusFiles",
    "DiffviewRefresh",
  },
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  opts = {},
  keys = {
    { "<leader>gd", "<cmd>DiffviewOpen<CR>", desc = "Open Diffview" },
    { "<leader>gD", "<cmd>DiffviewClose<CR>", desc = "Close Diffview" },
    { "<leader>gh", "<cmd>DiffviewFileHistory %<CR>", desc = "Current file history" },
    { "<leader>gH", "<cmd>DiffviewFileHistory<CR>", desc = "Repository file history" },
  },
}
