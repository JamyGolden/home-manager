local function is_empty(s)
  return s == nil or s == ''
end

local M = {
  is_empty = is_empty,
}

return M
