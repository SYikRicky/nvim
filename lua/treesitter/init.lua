-- Treesitter: syntax highlighting, indentation and structural editing.
-- See `:help nvim-treesitter-intro`.

local gh = require('core.pack').gh

vim.pack.add { { src = gh 'nvim-treesitter/nvim-treesitter', version = 'main' } }

local parsers = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc', 'css' }
require('nvim-treesitter').install(parsers)

---@param buf integer
---@param language string
local function try_attach(buf, language)
  if not vim.treesitter.language.add(language) then return end
  vim.treesitter.start(buf, language)

  -- Treesitter-based folds. See `:help folds`.
  -- vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
  -- vim.wo.foldmethod = 'expr'

  -- Without an indent query, indentexpr would fall back to Vim's built-in one
  -- anyway, so only set it when a query exists.
  if vim.treesitter.query.get(language, 'indents') ~= nil then vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()" end
end

local available_parsers = require('nvim-treesitter').get_available()
vim.api.nvim_create_autocmd('FileType', {
  callback = function(args)
    local buf, filetype = args.buf, args.match

    local language = vim.treesitter.language.get_lang(filetype)
    if not language then return end

    local installed = require('nvim-treesitter').get_installed 'parsers'

    if vim.tbl_contains(installed, language) then
      try_attach(buf, language)
    elseif vim.tbl_contains(available_parsers, language) then
      -- Install on demand, then attach once the install finishes.
      require('nvim-treesitter').install(language):await(function() try_attach(buf, language) end)
    else
      -- The parser may exist outside nvim-treesitter; try anyway.
      try_attach(buf, language)
    end
  end,
})
