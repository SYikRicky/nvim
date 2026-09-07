-- Neovim entry point.
--
-- Every feature lives in `lua/<feature>/init.lua`, installs its own plugins with
-- `vim.pack.add` and configures them. Load order does not matter except where
-- noted below.

require 'core' -- options, keymaps, diagnostics, vim.pack build hooks

require 'ui'
require 'editor'
require 'search'
require 'explorer'
require 'lsp' -- before ftplugin/java.lua, which queries the mason registry
require 'completion'
require 'treesitter'
require 'format'
require 'linter'
require 'git'
require 'debugger'
require 'markdown'
require 'media'
require 'webdev'
require 'database'
