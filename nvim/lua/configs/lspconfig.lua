local nv_configs = require("nvchad.configs.lspconfig")
local base_on_attach = nv_configs.on_attach
local on_init = nv_configs.on_init
local capabilities = nv_configs.capabilities

local on_attach = function(client, bufnr)
  base_on_attach(client, bufnr)

  if client:supports_method("textDocument/foldingRange") then
    vim.schedule(function()
      if vim.api.nvim_buf_is_valid(bufnr) and vim.api.nvim_get_current_buf() == bufnr then
        pcall(vim.cmd, "silent! normal! zx")
      end
    end)
  end
end

local function setup(server, opts)
  vim.lsp.config(server, vim.tbl_deep_extend("force", {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }, opts or {}))
  vim.lsp.enable(server)
end

-- 1. Setup generic servers
local generic_servers = { "html", "cssls", "clangd", "marksman" }
for _, lsp in ipairs(generic_servers) do
  setup(lsp)
end

-- jdtls with lombok javaagent (project uses lombok annotations)
local lombok_jar = vim.fn.stdpath("data") .. "/mason/packages/jdtls/lombok.jar"
setup("jdtls", {
  cmd_env = {
    JDTLS_JVM_ARGS = "-javaagent:" .. lombok_jar,
  },
})

-- python stuff
-- 2. Setup Pyright with specific settings (to avoid "noise")
setup("basedpyright", {
  settings = {
    pyright = { disableOrganizeImports = true },
    python = { analysis = { diagnosticMode = "openFilesOnly" } },
  },
})

-- Ruff for pylinting
setup("ruff")

vim.keymap.set('n', 'gl', vim.diagnostic.open_float, { desc = "Floating diagnostic" })
