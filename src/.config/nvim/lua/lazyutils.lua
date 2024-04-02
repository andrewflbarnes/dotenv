--- Convenience functions for working with lazy.
--- Largely unnecessary but thought it would be interesting to learn some lua.
---@class lazyutils
local M = {}

---Return type of lazy_keys
---@class lazykeys
local LK = {
  key_init = {},
}

---Returns a table with functions for providing LazySpec keys and performing
---@param self lazykeys
---@return table
---@nodiscard
LK.triggers = function(self)
  local key_table
  if type(self.key_init) == 'function' then
    key_table = self.key_init({})
  else
    key_table = self.key_init
  end
  local lazy_key_triggers = {}
  for _, mapping in pairs(key_table) do
    local modes = mapping[1]
    local seq = mapping[2]
    local opts = mapping[4] or {}
    local desc = opts.desc
    table.insert(lazy_key_triggers, { seq, mode = modes, desc = desc })
  end
  return lazy_key_triggers
end

---Sets key bindings via vim.keymap.set
---@param self lazykeys
---@param ctx any
LK.map_keys = function(self, ctx)
  local key_table
  if type(self.key_init) == 'function' then
    key_table = self.key_init(ctx)
  else
    key_table = self.key_init
  end
  for _, mapping in pairs(key_table) do
    local modes = mapping[1]
    local seq = mapping[2]
    local cmd
    if type(mapping[3]) == 'table' then
      cmd = mapping[3][1](ctx)
    else
      cmd = mapping[3]
    end
    local opts = mapping[4] or {}
    vim.keymap.set(modes, seq, cmd, opts)
  end
end

---Returns a table with functions for providing LazySpec keys and performing
-- the bindings via vim.keymap.set. keys may either be a table containing modes,
-- lhs, rhs, opts or a function taking a context object which provides it. In
-- both cases the rhs may be a table containing an unkeyed function which accepts
-- the context.
---@return lazykeys
function M.lazy_keys(keys)
  local lk = { key_init = keys }
  setmetatable(lk, { __index = LK })
  return lk
end

return M
