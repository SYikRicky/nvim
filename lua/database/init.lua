-- Editable database grids: connect to PostgreSQL / MySQL / SQLite / DuckDB and
-- edit tables like ordinary buffers.
--
-- Self-contained: vim-dadbod and friends are optional. It does need a database
-- CLI on PATH for each engine used:
--   PostgreSQL -> psql   SQLite -> sqlite3   MySQL -> mysql   DuckDB -> duckdb
--
-- Pinned to the 3.x line so a future breaking v4 stays out until this is bumped;
-- fixes still arrive through `:lua vim.pack.update()`.

local gh = require('core.pack').gh

vim.pack.add {
  { src = gh 'joryeugene/dadbod-grip.nvim', version = vim.version.range '3.*' },
}

require('dadbod-grip').setup {
  picker = 'telescope', -- reuse the existing Telescope UI
  -- Defaults, uncomment to change:
  -- limit         = 100,     -- default row limit for SELECT queries
  -- max_col_width = 40,      -- max display width per column
  -- timeout       = 10000,   -- query timeout in ms (raise for slow tunnels)
  -- completion    = true,    -- built-in SQL completion (false -> use blink.cmp)
  -- border        = 'rounded',
}
