-- CSS class-name completion (plus hover and peek) inside HTML buffers.
--
-- NOTE: setup() parses the remote `style_sheets` below (Bootstrap + Bulma from
-- a CDN), which costs ~16ms at startup. Since it is only useful in HTML
-- buffers, it is lazy-loaded on the first `FileType html`.

local gh = require('core.pack').gh

local loaded = false

local function load_html_css(args)
  if loaded then return end
  loaded = true

  vim.pack.add { gh 'jezda1337/nvim-html-css' }

  require('html-css').setup {
    enable_on = { 'html' },
    handlers = {
      definition = {
        bind = 'gd',
      },
      hover = {
        bind = 'K',
        wrap = true,
        border = 'none',
        position = 'cursor',
      },
    },
    documentation = {
      auto_show = true,
    },
    peek = {
      enabled = true,
      border = 'rounded',
      position = 'center',
      width = 0.5,
      height = 0.5,
      focus = true,
      style = 'minimal',
    },
    style_sheets = {
      'https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css',
      'https://cdnjs.cloudflare.com/ajax/libs/bulma/1.0.3/css/bulma.min.css',
    },
  }

  -- The buffer that triggered this load already fired its own FileType event
  -- before html-css registered its autocmds, so re-emit it for that buffer to
  -- make the plugin attach right away. The `loaded` guard keeps this loader
  -- from running a second time.
  vim.api.nvim_exec_autocmds('FileType', { buffer = args.buf })
end

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'html' },
  callback = load_html_css,
})
