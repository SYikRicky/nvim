-- dadbod-grip.nvim: editable database grids for Neovim.
-- Connect to PostgreSQL / MySQL / SQLite / DuckDB and edit tables like Vim buffers.
-- https://github.com/joryeugene/dadbod-grip.nvim
--
-- Self-contained: NO plugin dependencies required (vim-dadbod / -ui / -completion
-- are all optional). It does need a database CLI in PATH for each engine you use:
--   PostgreSQL -> psql   SQLite -> sqlite3   MySQL -> mysql   DuckDB -> duckdb
-- You currently have psql + sqlite3; install the others later only if needed.
--
-- Pinned to the latest stable v3.x release. Bug fixes / features arrive via
-- `:lua vim.pack.update()`; a future breaking v4 stays out until you bump this.
vim.pack.add {
  { src = 'https://github.com/joryeugene/dadbod-grip.nvim', version = vim.version.range '3.*' },
}

require('dadbod-grip').setup {
  picker = 'telescope', -- reuse your existing Telescope UI for pickers
  -- The rest below are defaults; uncomment to change.
  -- limit         = 100,     -- default row limit for SELECT queries
  -- max_col_width = 40,      -- max display width per column
  -- timeout       = 10000,   -- query timeout in ms (raise for slow tunnels)
  -- completion    = true,    -- built-in SQL completion (false -> use blink.cmp)
  -- border        = 'rounded',
}
