vim.pack.add {
  { src = 'https://github.com/brenoprata10/nvim-highlight-colors' },
}

-- Ensure termguicolors is enabled if not already
vim.opt.termguicolors = true

require('nvim-highlight-colors').setup {}
