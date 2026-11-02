-- Port of Rex's built-in Misty Forest palette to NvChad/base46.
-- Colors come from Rex's themes.json: source ANSI colors and UI surface tokens.
local M = {}

M.base_30 = {
  white = "#c4d2c5",
  darker_black = "#131a16",
  black = "#181e1a", -- Rex terminal surface
  black2 = "#1a211d",
  one_bg = "#242b27",
  one_bg2 = "#2c3f33",
  one_bg3 = "#323b35",
  grey = "#454e48",
  grey_fg = "#55665a",
  grey_fg2 = "#69746c",
  light_grey = "#869288",
  red = "#cf7a70",
  baby_pink = "#e09489",
  pink = "#bfadd1",
  line = "#323b35",
  green = "#8fbf8f",
  vibrant_green = "#a9d6a6",
  nord_blue = "#93bccb",
  blue = "#77a3b5",
  yellow = "#c9ad72",
  sun = "#ddc48d",
  purple = "#a793bb",
  dark_purple = "#a793bb",
  teal = "#7cb5a3",
  orange = "#e09489",
  cyan = "#97cdbb",
  statusline_bg = "#1a211d",
  lightbg = "#242b27",
  pmenu_bg = "#9dc2a0",
  folder_bg = "#77a3b5",
}

M.base_16 = {
  base00 = "#181e1a",
  base01 = "#242b27",
  base02 = "#2c3f33",
  base03 = "#69746c",
  base04 = "#869288",
  base05 = "#c4d2c5",
  base06 = "#aebbaf",
  base07 = "#e2ece2",
  base08 = "#cf7a70",
  base09 = "#e09489",
  base0A = "#c9ad72",
  base0B = "#8fbf8f",
  base0C = "#7cb5a3",
  base0D = "#77a3b5",
  base0E = "#a793bb",
  base0F = "#bfadd1",
}

M.type = "dark"
M.polish_hl = {
  defaults = {
    Cursor = { fg = "#131a16", bg = "#9dc2a0" },
    Visual = { fg = "#e2ece2", bg = "#2c3f33" },
  },
}

return require("base46").override_theme(M, "rex_misty_forest")
