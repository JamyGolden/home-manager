local keymaps = require("jamygolden/utils/keymaps")
local map = keymaps.map

local set_path_to_global_clipboard_func = function(is_absolute)
  return function()
    local current_file_path = vim.fn.expand(is_absolute and "%:p" or "%:~:.")

    vim.fn.setreg("+y", current_file_path)
  end
end

map({ "n", "v" }, "<leader>y", '"+y', { silent = false, desc = "Yank to global clipboard" })
map({ "n" }, "<leader>Y", 'gg"+yG', { silent = false, desc = "Yank entire file to global cipboard" })
map({ "n" }, "<C-u>", "<C-u>zz", { desc = "Centre content when navigating with <C-u>" })
map({ "n" }, "<C-d>", "<C-d>zz", { desc = "Centre content when navigating with <C-d>" })
map({ "v" }, "<leader>p", '"_dP', { desc = "Paste but don't change yanked content" })
map({ "n" }, "<leader>cp", set_path_to_global_clipboard_func(), { desc = "Copy project-relative path to file" })
map({ "n" }, "<leader>cP", set_path_to_global_clipboard_func(true), { desc = "Copy absolute path to file" })
