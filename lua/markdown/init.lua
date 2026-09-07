-- Markdown rendering.

local gh = require('core.pack').gh

vim.pack.add {
  gh 'MeanderingProgrammer/render-markdown.nvim',
  gh 'ice345/markdown-table-wrap.nvim',
}

-- markdown-table-wrap renders wide tables better than render-markdown's own
-- pipe_table renderer: it wraps long cells to a viewport-relative width instead
-- of letting the table overflow horizontally. Table rendering is handed over to
-- it, and render-markdown's pipe_table is disabled so the two do not fight over
-- the same buffer regions.
require('render-markdown').setup {
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
