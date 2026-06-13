-- Launches eclipse.jdt.ls (jdtls) for Java buffers via nvim-jdtls.
-- Mason must have installed: jdtls, java-debug-adapter, java-test
-- (see ensure_installed in init.lua). On first open run :Mason if anything is missing.

local ok, jdtls = pcall(require, 'jdtls')
if not ok then return end

local mr_ok, mason_registry = pcall(require, 'mason-registry')
if not mr_ok then return end

local mason_pkg_root = vim.fn.stdpath('data') .. '/mason/packages'
local function pkg_path(name)
  if not mason_registry.is_installed(name) then
    vim.notify(('Mason package %q not installed yet — run :Mason'):format(name), vim.log.levels.WARN)
    return nil
  end
  return mason_pkg_root .. '/' .. name
end

local jdtls_path = pkg_path 'jdtls'
if not jdtls_path then return end

local sysname = vim.uv.os_uname().sysname
local config_subdir = sysname == 'Darwin' and 'config_mac' or sysname == 'Linux' and 'config_linux' or 'config_win'

local launcher = vim.fn.glob(jdtls_path .. '/plugins/org.eclipse.equinox.launcher_*.jar', false, true)[1]
if not launcher or launcher == '' then
  vim.notify('jdtls equinox launcher not found in ' .. jdtls_path, vim.log.levels.ERROR)
  return
end

local root_dir = vim.fs.root(0, { 'gradlew', 'mvnw', 'pom.xml', 'build.gradle', 'build.gradle.kts', '.git' }) or vim.fn.getcwd()
local project_name = vim.fn.fnamemodify(root_dir, ':p:h:t')
local workspace_dir = vim.fn.stdpath 'cache' .. '/jdtls/workspace/' .. project_name

local bundles = {}
local jdb = pkg_path 'java-debug-adapter'
if jdb then vim.list_extend(bundles, vim.fn.glob(jdb .. '/extension/server/com.microsoft.java.debug.plugin-*.jar', false, true)) end
local jtest = pkg_path 'java-test'
if jtest then vim.list_extend(bundles, vim.fn.glob(jtest .. '/extension/server/*.jar', false, true)) end

jdtls.start_or_attach {
  cmd = {
    'java',
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xmx1g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
    '-jar', launcher,
    '-configuration', jdtls_path .. '/' .. config_subdir,
    '-data', workspace_dir,
  },
  root_dir = root_dir,
  settings = {
    java = {
      eclipse = { downloadSources = true },
      maven = { downloadSources = true },
      signatureHelp = { enabled = true },
      contentProvider = { preferred = 'fernflower' },
      completion = {
        favoriteStaticMembers = {
          'org.junit.jupiter.api.Assertions.*',
          'org.junit.Assert.*',
          'org.mockito.Mockito.*',
        },
      },
      sources = { organizeImports = { starThreshold = 9999, staticStarThreshold = 9999 } },
      configuration = { updateBuildConfiguration = 'interactive' },
    },
  },
  init_options = { bundles = bundles },
  on_attach = function()
    jdtls.setup_dap { hotcodereplace = 'auto' }
    pcall(function() require('jdtls.dap').setup_dap_main_class_configs() end)
  end,
}

-- Java-specific keymaps (only set in Java buffers because this is an ftplugin)
local map = function(lhs, rhs, desc) vim.keymap.set('n', lhs, rhs, { buffer = 0, desc = 'Java: ' .. desc }) end
map('<leader>Jo', jdtls.organize_imports, '[O]rganize imports')
map('<leader>Jv', function() jdtls.extract_variable() end, 'Extract [v]ariable')
map('<leader>Jc', function() jdtls.extract_constant() end, 'Extract [c]onstant')
map('<leader>Jt', function() require('jdtls').test_nearest_method() end, '[T]est nearest method')
map('<leader>JT', function() require('jdtls').test_class() end, '[T]est class')
