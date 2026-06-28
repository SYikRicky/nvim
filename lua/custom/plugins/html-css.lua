vim.pack.add { src = 'https://github.com/jezda1337/nvim-html-css' }
-- example
require('html-css').setup {
  enable_on = { 'html' },
  -- if you want custom opt for handlers
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
