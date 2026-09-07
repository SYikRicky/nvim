-- Look and feel: colorscheme, statusline, keymap hints, indent guides, colour
-- previews and TODO highlighting.

local gh = require('core.pack').gh

-- Detect and apply a file's existing indentation instead of forcing ours.
vim.pack.add { gh 'NMAC427/guess-indent.nvim' }
require('guess-indent').setup {}

-- Icons only render correctly with a patched font, so they are opt-in.
if vim.g.have_nerd_font then vim.pack.add { gh 'nvim-tree/nvim-web-devicons' } end

-- Pending-keybind popup.
vim.pack.add { gh 'folke/which-key.nvim' }
require('which-key').setup {
  delay = 0,
  icons = { mappings = vim.g.have_nerd_font },
  -- Names for the key chains defined by the other feature modules.
  spec = {
    { '<leader>s', group = '[S]earch', mode = { 'n', 'v' } },
    { '<leader>t', group = '[T]oggle' },
    { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
    { '<leader>J', group = '[J]ava' },
    { 'gr', group = 'LSP Actions', mode = { 'n' } },
  },
}

vim.pack.add { gh 'folke/tokyonight.nvim' }
---@diagnostic disable-next-line: missing-fields
require('tokyonight').setup {
  styles = {
    comments = { italic = false },
  },
}
-- Other styles: tokyonight-storm, tokyonight-moon, tokyonight-day.
vim.cmd.colorscheme 'tokyonight-night'

vim.pack.add { gh 'folke/todo-comments.nvim' }
require('todo-comments').setup { signs = false }

-- Indentation guides, including on blank lines. See `:help ibl`.
vim.pack.add { gh 'lukas-reineke/indent-blankline.nvim' }
require('ibl').setup {}

-- Inline previews for colour literals; needs true colour.
vim.pack.add { gh 'brenoprata10/nvim-highlight-colors' }
vim.o.termguicolors = true
require('nvim-highlight-colors').setup {}

-- mini.nvim is a collection of small modules; `editor` uses others from it.
vim.pack.add { gh 'nvim-mini/mini.nvim' }
local statusline = require 'mini.statusline'
statusline.setup { use_icons = vim.g.have_nerd_font }
---@diagnostic disable-next-line: duplicate-set-field
statusline.section_location = function() return '%2l:%-2v' end
