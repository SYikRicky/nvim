-- Java tooling. jdtls itself is launched per-buffer by ftplugin/java.lua; this
-- module only installs the plugins and decides whether the Spring Boot language
-- server should run.

local gh = require('core.pack').gh

vim.pack.add {
  gh 'mfussenegger/nvim-jdtls',
  gh 'JavaHello/spring-boot.nvim', -- Spring Boot LS + jdtls bundles
}

-- The Spring Boot LS is a second heavyweight JVM, so start it only for actual
-- Spring projects. Detection walks up from the launch directory, so Neovim has
-- to be started inside the project.
local function project_is_spring()
  local build_files = { 'pom.xml', 'build.gradle', 'build.gradle.kts' }
  local root = vim.fs.root(vim.fn.getcwd(), build_files)
  if not root then return false end
  for _, name in ipairs(build_files) do
    local path = root .. '/' .. name
    if vim.fn.filereadable(path) == 1 then
      for _, line in ipairs(vim.fn.readfile(path)) do
        if line:find('spring-boot', 1, true) or line:find('springframework', 1, true) then return true end
      end
    end
  end
  return false
end

local spring_ok, spring_boot = pcall(require, 'spring_boot')
local registry_ok, registry = pcall(require, 'mason-registry')
if spring_ok and registry_ok and registry.is_installed 'vscode-spring-boot-tools' and project_is_spring() then spring_boot.setup {} end
