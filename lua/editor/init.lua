-- Text-editing behaviour: text objects, surroundings, auto-pairs.

local gh = require('core.pack').gh

-- `vim.pack.add` on an already-installed plugin only puts it on the
-- runtimepath, so adding mini.nvim here as well as in `ui` costs nothing and
-- keeps the two modules independent of each other's load order.
vim.pack.add { gh 'nvim-mini/mini.nvim' }

-- Around/inside text objects:
--   va)  - [V]isually select [A]round [)]paren
--   yiiq - [Y]ank [I]nside [I]+1 [Q]uote
--   ci'  - [C]hange [I]nside [']quote
require('mini.ai').setup {
  -- The default `an`/`in` would shadow the built-in incremental selection
  -- mappings on Neovim >= 0.12. See `:help treesitter-incremental-selection`.
  mappings = {
    around_next = 'aa',
    inside_next = 'ii',
  },
  n_lines = 500,
}

-- Add/delete/replace surroundings:
--   saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
--   sd'   - [S]urround [D]elete [']quotes
--   sr)'  - [S]urround [R]eplace [)] [']
require('mini.surround').setup()

vim.pack.add { gh 'windwp/nvim-autopairs' }
require('nvim-autopairs').setup {}
