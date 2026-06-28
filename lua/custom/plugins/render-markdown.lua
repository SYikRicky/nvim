-- NOTE: nvim-treesitter and mini.nvim are already installed in init.lua, so we
-- only add render-markdown itself here (vim.pack.add dedupes, but the duplicate
-- entries were redundant).
vim.pack.add {
  'https://github.com/MeanderingProgrammer/render-markdown.nvim',
}
require('render-markdown').setup {} -- only mandatory if you want to set custom options
