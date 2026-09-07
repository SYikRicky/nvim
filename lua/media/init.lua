-- Inline images and rendered diagrams in the terminal.

local gh = require('core.pack').gh

-- NOTE: image.nvim is cloned over SSH, so a working GitHub SSH key is required.
vim.pack.add {
  'git@github.com:3rd/image.nvim',
  gh '3rd/diagram.nvim',
}

require('image').setup {
  backend = 'kitty', -- or "ueberzug" or "sixel"
  processor = 'magick_cli', -- or "magick_rock"
  integrations = {
    markdown = {
      enabled = true,
      clear_in_insert_mode = false,
      download_remote_images = true,
      only_render_image_at_cursor = false,
      only_render_image_at_cursor_mode = 'popup', -- or "inline"
      floating_windows = false,
      filetypes = { 'markdown', 'vimwiki' }, -- markdown dialects (e.g. quarto) go here
    },
    asciidoc = {
      enabled = true,
      clear_in_insert_mode = false,
      download_remote_images = true,
      only_render_image_at_cursor = false,
      only_render_image_at_cursor_mode = 'popup',
      floating_windows = false,
      filetypes = { 'asciidoc', 'adoc' },
    },
    neorg = {
      enabled = true,
      filetypes = { 'norg' },
    },
    rst = {
      enabled = true,
    },
    typst = {
      enabled = true,
      filetypes = { 'typst' },
    },
    html = {
      enabled = false,
    },
    css = {
      enabled = false,
    },
  },
  max_width = nil,
  max_height = nil,
  max_width_window_percentage = nil,
  max_height_window_percentage = 50,
  scale_factor = 1.0,
  kitty_direct_chunk_size = 4096,
  window_overlap_clear_enabled = false,
  window_overlap_clear_ft_ignore = { 'cmp_menu', 'cmp_docs', 'snacks_notif', 'scrollview', 'scrollview_sign' },
  editor_only_render_when_focused = false,
  tmux_show_only_in_active_window = false, -- needs visual-activity off
  hijack_file_patterns = { '*.png', '*.jpg', '*.jpeg', '*.gif', '*.webp', '*.avif' },
}

require('diagram').setup {
  integrations = {
    require 'diagram.integrations.markdown',
    require 'diagram.integrations.neorg',
  },
  renderer_options = {
    mermaid = {
      -- mermaid-cli launches headless Chrome, which needs --no-sandbox here.
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
