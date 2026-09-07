-- Installs the language servers and CLI tools the rest of the config expects.
-- Browse and manage them with `:Mason` (`g?` for help).

local gh = require('core.pack').gh

---@param servers table<string, vim.lsp.Config>
return function(servers)
  vim.pack.add {
    gh 'mason-org/mason.nvim',
    gh 'mason-org/mason-lspconfig.nvim',
    gh 'WhoIsSethDaniel/mason-tool-installer.nvim',
  }

  -- NOTE: `mason.setup()` has no `ensure_installed` key -- passing one there
  -- silently does nothing. Installation is driven by mason-tool-installer below.
  require('mason').setup {}

  -- Server names are translated to mason package names by mason-lspconfig;
  -- everything else below is a literal mason package name.
  local ensure_installed = vim.tbl_keys(servers)
  vim.list_extend(ensure_installed, {
    -- Python. `ty` is the language server (see lsp/servers.lua); `ruff` is both
    -- the linter (nvim-lint) and the formatter (conform).
    'ty',
    'ruff',

    -- Java. jdtls is started by ftplugin/java.lua, not through lspconfig.
    'jdtls',
    'java-debug-adapter',
    'java-test',
    'vscode-spring-boot-tools',

    -- Formatters.
    'stylua',

    -- Linters used by the `lint` module.
    'stylelint',
    'htmlhint',
    'jsonlint',
    'hadolint',

    -- Install only; enable it by adding `html = {}` to lsp/servers.lua.
    'html-lsp',
  })

  require('mason-tool-installer').setup { ensure_installed = ensure_installed }
end
