-- Language servers to configure and enable. Keys are `nvim-lspconfig` server
-- names; an empty table means "use the shipped defaults verbatim".
-- See `:help lsp-config`.
---@type table<string, vim.lsp.Config>
return {
  ts_ls = {},
  eslint = {},
  tailwindcss = {},
  lemminx = {},
  emmet_language_server = {},

  -- Python: `ty` (Astral) is both the language server and the type checker.
  -- It discovers the project's `.venv` by walking up from the project root, so
  -- unlike pyright it needs no `pythonPath` plumbing here. Per-project
  -- overrides (unusual venv location, python version) belong in the project's
  -- own `pyproject.toml` under `[tool.ty.environment]`.
  -- Linting and formatting stay with `ruff` (see `lint` and `format`).
  ty = {},

  lua_ls = {
    on_init = function(client)
      -- Formatting is handled by stylua through conform.
      client.server_capabilities.documentFormattingProvider = false

      -- A project with its own .luarc.json configures itself; don't override it.
      if client.workspace_folders then
        local path = client.workspace_folders[1].name
        if path ~= vim.fn.stdpath 'config' and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc')) then return end
      end

      client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
        runtime = {
          version = 'LuaJIT',
          path = { 'lua/?.lua', 'lua/?/init.lua' },
        },
        workspace = {
          checkThirdParty = false,
          -- NOTE: pulling in the whole runtime is slow and misbehaves when
          -- editing this config itself.
          -- See https://github.com/neovim/nvim-lspconfig/issues/3189
          library = vim.tbl_extend('force', vim.api.nvim_get_runtime_file('', true), {
            '${3rd}/luv/library',
            '${3rd}/busted/library',
          }),
        },
      })
    end,
    ---@type lspconfig.settings.lua_ls
    settings = {
      Lua = {
        format = { enable = false },
      },
    },
  },
}
