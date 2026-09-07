-- Formatting via conform.nvim.

local gh = require('core.pack').gh

vim.pack.add { gh 'stevearc/conform.nvim' }
require('conform').setup {
  notify_on_error = false,

  -- prettier / ruff / stylua finish in a few milliseconds, so blocking the save
  -- on them is fine. Java is deliberately absent: jdtls' LSP formatting is slow
  -- and the async reformat was distracting, so format Java on demand with
  -- <leader>f (which respects the 4-space setting from ftplugin/java.lua).
  format_on_save = function(bufnr)
    local sync_filetypes = {
      lua = true,
      python = true,
      json = true,
      html = true,
      css = true,
      javascript = true,
    }
    if sync_filetypes[vim.bo[bufnr].filetype] then return { timeout_ms = 500 } end
    return nil
  end,

  default_format_opts = {
    -- Use the formatters below when configured, otherwise fall back to the LSP.
    lsp_format = 'fallback',
  },

  formatters_by_ft = {
    -- NOTE: the bare `ruff` formatter is a deprecated alias for `ruff_fix`
    -- (`ruff check --fix`), which lint-fixes but never reformats.
    python = { 'ruff_organize_imports', 'ruff_format' },

    -- `stop_after_first` runs the first formatter that is actually installed.
    javascript = { 'prettierd', 'prettier', stop_after_first = true },
    typescript = { 'prettier' },
    javascriptreact = { 'prettier' },
    typescriptreact = { 'prettier' },
    svelte = { 'prettier' },
    css = { 'prettier' },
    html = { 'prettier' },
    json = { 'prettier' },
    yaml = { 'prettier' },
    markdown = { 'prettier' },
    java = { 'google-java-format' },
  },

  -- NOTE: the key is `formatters` (plural); spelled `formatter` it is silently
  -- ignored and `--aosp` never reaches google-java-format.
  formatters = {
    ['google-java-format'] = {
      prepend_args = { '--aosp' },
    },
  },
}

vim.keymap.set({ 'n', 'v' }, '<leader>f', function() require('conform').format { async = true } end, { desc = '[F]ormat buffer' })
