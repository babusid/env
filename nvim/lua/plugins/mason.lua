return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        -- LSP servers
        "clangd",
        "basedpyright",
        "ruff",
        "marksman", -- Markdown LSP
        
        -- Formatters (you can add more as needed)
        -- "stylua",  -- lua formatter
        -- "prettier", -- web formatter
      },
    },
  },
}
