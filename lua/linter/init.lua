-- Linting via nvim-lint, for tools that are not language servers.
--
-- The module is named `linter`, not `lint`, because `lua/lint/` on the config
-- runtimepath would shadow nvim-lint's own `lint` module.

local gh = require('core.pack').gh

vim.pack.add { gh 'mfussenegger/nvim-lint' }

local lint = require 'lint'
lint.linters_by_ft = {
  -- Python diagnostics are split: `ty` (LSP) reports type errors, `ruff` here
  -- reports lint rules. The ruff language server is deliberately not enabled,
  -- since it would publish the same diagnostics a second time.
  python = { 'ruff' },
  dockerfile = { 'hadolint' },
  css = { 'stylelint' },
  html = { 'htmlhint' },
  json = { 'jsonlint' },
}

vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
  group = vim.api.nvim_create_augroup('user-lint', { clear = true }),
  callback = function()
    -- Skip unmodifiable buffers, notably the Markdown-rendered LSP hover popups.
    if vim.bo.modifiable then lint.try_lint() end
  end,
})
