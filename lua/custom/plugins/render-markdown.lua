-- NOTE: nvim-treesitter and mini.nvim are already installed in init.lua, so we
-- only add render-markdown itself here (vim.pack.add dedupes, but the duplicate
-- entries were redundant).
--
-- markdown-table-wrap.nvim renders wide tables far better than render-markdown's
-- built-in pipe_table renderer: it wraps long cells to a viewport-relative width
-- instead of letting the table overflow horizontally. We hand table rendering
-- over to it and disable render-markdown's own pipe_table so the two don't fight
-- over the same buffer regions.
vim.pack.add {
  'https://github.com/MeanderingProgrammer/render-markdown.nvim',
  'https://github.com/ice345/markdown-table-wrap.nvim',
}

require('render-markdown').setup {
  -- Let markdown-table-wrap own table rendering (see note above).
  pipe_table = {
    enabled = false,
  },
}

require('markdown-table-wrap').setup {
  max_width_ratio = 0.9, -- cap table width at 90% of the window
  min_col_width = 8,
  max_col_width = 50, -- wrap cell content past this many columns
  border = 'rounded',
}
