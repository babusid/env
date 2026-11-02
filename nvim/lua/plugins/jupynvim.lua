return {
  "sheng-tse/jupynvim",
  version = "*",
  -- Register notebook read handlers before the first .ipynb is opened.
  lazy = false,
  build = function(plugin)
    dofile(plugin.dir .. "/lua/jupynvim/install.lua").run(plugin)
  end,
  opts = {
    log_level = "info",
    image_renderer = "placeholder",
    -- Keep NvChad's global explorer, picker and terminal mappings.
    -- Remote commands remain available through :JupynvimConnect, etc.
    explorer_keys = {},
    explorer_cwd_keys = {},
    terminal_keys = {},
    terminal_right_keys = {},
    pick_keys = { files = {}, grep = {} },
  },
  config = function(_, opts)
    local notebook = require "jupynvim"
    -- Leave room for the notebook gutter and output indentation.
    opts.image_cols = math.max(12, vim.o.columns - 12)
    opts.image_rows = math.max(4, math.floor(opts.image_cols / 3))
    notebook.setup(opts)

    local function fit_images()
      local buf = vim.api.nvim_get_current_buf()
      local nb = require("jupynvim.notebook").get(buf)
      if not nb then return end
      local win = vim.api.nvim_get_current_win()
      local info = vim.fn.getwininfo(win)[1]
      local cols = math.max(12, vim.api.nvim_win_get_width(win) - info.textoff - 10)
      local rows = math.max(4, math.floor(cols / 3))
      if notebook.config.image_cols == cols and notebook.config.image_rows == rows then return end
      notebook.config.image_cols = cols
      notebook.config.image_rows = rows
      require("jupynvim.notebook.image").set_size { cols = cols, rows = rows }
      require("jupynvim.notebook.render").refresh(nb, win)
    end

    vim.api.nvim_create_autocmd({ "BufWinEnter", "WinEnter", "WinResized", "VimResized" }, {
      group = vim.api.nvim_create_augroup("JupynvimFitImages", { clear = true }),
      callback = function()
        vim.schedule(fit_images)
      end,
    })
    vim.api.nvim_create_user_command("JupynvimFitImages", fit_images, {
      desc = "Fit notebook figures to the current window",
    })
  end,
}
