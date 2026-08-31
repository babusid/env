require "nvchad.autocmds"

local md_len_group = vim.api.nvim_create_augroup("markdown_line_length", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  group = md_len_group,
  pattern = "markdown",
  callback = function(args)
    vim.opt_local.textwidth = 140
    vim.opt_local.colorcolumn = "141"
    vim.opt_local.wrap = false

    local ok, old = pcall(vim.api.nvim_buf_get_var, args.buf, "md_overlength_match")
    if ok then
      pcall(vim.fn.matchdelete, old)
    end

    local id = vim.fn.matchadd("DiagnosticWarn", [[\%141v.\+]])
    pcall(vim.api.nvim_buf_set_var, args.buf, "md_overlength_match", id)
  end,
})
