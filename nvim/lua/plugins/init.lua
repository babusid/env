return {
  {
    "stevearc/conform.nvim",
    opts = require "configs.conform",
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      { "nvim-telescope/telescope-live-grep-args.nvim" },
      { "nvim-telescope/telescope-smart-history.nvim" },
      { "kkharji/sqlite.lua" },
    },
    opts = function()
      local conf = require "nvchad.configs.telescope"
      local actions = require "telescope.actions"
      
      conf.extensions_list = { "themes", "terms", "live_grep_args", "smart_history" }
      conf.defaults = conf.defaults or {}
      conf.defaults.history = {
        path = vim.fn.stdpath("data") .. "/telescope_history.sqlite3",
        limit = 100,
      }
      conf.defaults.mappings = conf.defaults.mappings or {}
      conf.defaults.mappings.i = conf.defaults.mappings.i or {}
      conf.defaults.mappings.i["<C-S-Up>"] = actions.cycle_history_next
      conf.defaults.mappings.i["<C-S-Down>"] = actions.cycle_history_prev
      return conf
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      {
        "zbirenbaum/copilot-cmp",
        dependencies = {
          {
            "zbirenbaum/copilot.lua",
            cmd = "Copilot",
            opts = {
              suggestion = { enabled = false },
              panel = { enabled = false },
            },
          },
        },
        config = function()
          require("copilot_cmp").setup()
        end,
      },
    },
    opts = require "configs.cmp",
  },
  {
    "kevinhwang91/promise-async",
  },
  {
    "kevinhwang91/nvim-ufo",
    lazy = false,
    dependencies = { "kevinhwang91/promise-async" },
    opts = {
      provider_selector = function(_, filetype, _)
        -- jdtls 1.58.0 crashes on foldingRange requests
        if filetype == "java" then return { "indent" } end
        return { "lsp", "indent" }
      end,
    },
    init = function()
      vim.opt.foldcolumn = "0"
      vim.opt.foldlevel = 99
      vim.opt.foldlevelstart = 99
      vim.opt.foldenable = true
    end,
    keys = {
      {
        "zR",
        function()
          require("ufo").openAllFolds()
        end,
        desc = "Open all folds",
      },
      {
        "zM",
        function()
          require("ufo").closeAllFolds()
        end,
        desc = "Close all folds",
      },
    },
  },
}
