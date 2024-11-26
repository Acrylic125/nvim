local status, _ = pcall(vim.cmd, "colorscheme onedark")
if not status then
  print("Colorscheme not found!") -- print error if colorscheme not installed
  return
end

local cfg = vim.g.onedark_config

require('onedark').setup {
  style = 'dark', -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
  colors = {
    bright_orange = "#ff8800",    -- define a new color
    green = '#00ffaa',            -- redefine an existing color
    dark_red = "#fb7185",
    dark_yellow = "#eab308",
    dark_cyan = "#06b6d4",
    dark_purple = "#a855f7"
  },
}

 require('onedark').load()

