local M = {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true, },
    indent = {
      enable = true,
      blank = {
        char = "·",
      },
    },
    input = { enable = true },
    notifier = { enabled = true },
    words = { enabled = true },
  },
  keys = {
    { "]]", function() Snacks.words.jump(vim.v.count1) end,  desc = "Next Reference", mode = { "n", "t" } },
    { "[[", function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference", mode = { "n", "t" } },
  },
}

return M
