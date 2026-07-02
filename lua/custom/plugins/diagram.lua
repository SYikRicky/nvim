vim.pack.add {
  { src = 'https://github.com/3rd/diagram.nvim' },
  'git@github.com:3rd/image.nvim',
}

require('diagram').setup {
  integrations = {
    require 'diagram.integrations.markdown',
    require 'diagram.integrations.neorg',
  },
  renderer_options = {
    mermaid = {
      cli_args = { '-p', vim.fn.stdpath 'config' .. '/puppeteer-config.json' },
      theme = 'forest',
    },
    plantuml = {
      charset = 'utf-8',
    },
    d2 = {
      cli_args = { '--pad', '0' },
      theme_id = 1,
    },
    gnuplot = {
      theme = 'dark',
      size = '800,600',
    },
  },
}
