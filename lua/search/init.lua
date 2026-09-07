-- Fuzzy finding over files, buffers, help, LSP symbols and more.
--
-- Inside a picker, `<c-/>` (insert) or `?` (normal) lists that picker's own
-- keymaps. See `:help telescope` and `:help telescope.setup()`.

local gh = require('core.pack').gh

---@type (string|vim.pack.Spec)[]
local plugins = {
  gh 'nvim-lua/plenary.nvim',
  gh 'nvim-telescope/telescope.nvim',
  gh 'nvim-telescope/telescope-ui-select.nvim',
}
-- fzf-native is compiled by the PackChanged hook in `core.pack`.
if vim.fn.executable 'make' == 1 then table.insert(plugins, gh 'nvim-telescope/telescope-fzf-native.nvim') end

vim.pack.add(plugins)

require('telescope').setup {
  extensions = {
    ['ui-select'] = { require('telescope.themes').get_dropdown() },
  },
}

-- Both extensions are optional; ignore them when not installed.
pcall(require('telescope').load_extension, 'fzf')
pcall(require('telescope').load_extension, 'ui-select')

require 'search.keymaps'
