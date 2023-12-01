local fn = vim.fn
local cmd = vim.cmd
local g = vim.g
local set_theme_path = "$XDG_CONFIG_HOME/tinted-theming/set_theme.lua"
local is_set_theme_file_readable = fn.filereadable(fn.expand(set_theme_path)) == 1 and true or false

if is_set_theme_file_readable then
  g.base16colorspace = 256
  cmd("source " .. set_theme_path)
end