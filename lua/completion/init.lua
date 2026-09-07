-- Autocompletion and snippets.

local gh = require('core.pack').gh

-- Version ranges pin a plugin to a git tag range. See `:help vim.version.range()`.
vim.pack.add { { src = gh 'L3MON4D3/LuaSnip', version = vim.version.range '2.*' } }
require('luasnip').setup {}

-- Premade snippets, if you want them:
-- vim.pack.add { gh 'rafamadriz/friendly-snippets' }
-- require('luasnip.loaders.from_vscode').lazy_load()

vim.pack.add { { src = gh 'saghen/blink.cmp', version = vim.version.range '1.*' } }
require('blink.cmp').setup {
  -- The 'default' preset mirrors built-in completion: <c-y> accepts (and
  -- auto-imports / expands snippets), <c-space> opens the menu or the docs,
  -- <c-n>/<c-p> move, <c-e> hides, <c-k> toggles signature help, <tab>/<s-tab>
  -- move through snippet placeholders. See `:help ins-completion` and
  -- `:help blink-cmp-config-keymap`.
  keymap = { preset = 'default' },

  appearance = {
    nerd_font_variant = 'mono',
  },

  completion = {
    documentation = { auto_show = false, auto_show_delay_ms = 500 },
  },

  sources = {
    default = { 'lsp', 'path', 'snippets' },
  },

  snippets = { preset = 'luasnip' },

  -- The rust matcher downloads a prebuilt binary; the Lua one needs nothing.
  -- See `:help blink-cmp-config-fuzzy`.
  fuzzy = { implementation = 'lua' },

  signature = { enabled = true },
}
