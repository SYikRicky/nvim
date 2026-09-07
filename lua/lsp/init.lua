-- Language Server Protocol wiring.
--
-- Servers are external programs (installed by `lsp.mason`) that Neovim talks to
-- over LSP. See `:help lsp` and `:help lsp-vs-treesitter`.

local gh = require('core.pack').gh

-- Progress notifications for slow servers.
vim.pack.add { gh 'j-hui/fidget.nvim' }
require('fidget').setup {}

vim.pack.add { gh 'neovim/nvim-lspconfig' }

local servers = require 'lsp.servers'

require 'lsp.keymaps'
require 'lsp.mason'(servers)
require 'lsp.java'

for name, config in pairs(servers) do
  vim.lsp.config(name, config)
  vim.lsp.enable(name)
end
