local options = require "nvchad.configs.cmp"

options.sources = options.sources or {}

local has_copilot = false
for _, source in ipairs(options.sources) do
  if source.name == "copilot" then
    has_copilot = true
    break
  end
end

if not has_copilot then
  table.insert(options.sources, { name = "copilot", group_index = 2 })
end

if vim.fn.hlexists("CmpItemKindCopilot") == 0 then
  vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { link = "CmpItemKindFunction" })
end

return options
