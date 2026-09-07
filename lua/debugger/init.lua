-- Debug Adapter Protocol.
--
-- NOTE: the DAP stack (dap, dap-ui, nio, mason-nvim-dap, dap-go) costs ~28ms at
-- startup, so it is installed and configured on first use instead. The keymaps
-- below are registered immediately; pressing one, or opening a Java buffer
-- (ftplugin/java.lua calls `ensure_loaded` before wiring up Java debugging),
-- triggers the real load.
--
-- The module is named `debugger`: `dap` would shadow nvim-dap's own module and
-- `debug` would return Lua's built-in debug library.

local gh = require('core.pack').gh

local M = {}

local loaded = false

---Install and configure the DAP stack. Runs its body at most once.
function M.ensure_loaded()
  if loaded then return end
  loaded = true

  -- mason.nvim is already installed by the `lsp` module.
  vim.pack.add {
    gh 'mfussenegger/nvim-dap',
    gh 'rcarriga/nvim-dap-ui',
    gh 'nvim-neotest/nvim-nio',
    gh 'jay-babu/mason-nvim-dap.nvim',
    gh 'leoluz/nvim-dap-go',
  }

  local dap = require 'dap'
  local dapui = require 'dapui'

  require('mason-nvim-dap').setup {
    automatic_installation = true,
    handlers = {},
    ensure_installed = {
      'delve',
    },
  }

  -- See `:help nvim-dap-ui`. Icons are plain characters so they render in any
  -- terminal.
  ---@diagnostic disable-next-line: missing-fields
  dapui.setup {
    icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
    ---@diagnostic disable-next-line: missing-fields
    controls = {
      icons = {
        pause = '⏸',
        play = '▶',
        step_into = '⏎',
        step_over = '⏭',
        step_out = '⏮',
        step_back = 'b',
        run_last = '▶▶',
        terminate = '⏹',
        disconnect = '⏏',
      },
    },
  }

  dap.listeners.after.event_initialized['dapui_config'] = dapui.open
  dap.listeners.before.event_terminated['dapui_config'] = dapui.close
  dap.listeners.before.event_exited['dapui_config'] = dapui.close

  require('dap-go').setup {
    delve = {
      -- On Windows delve must be run attached or it crashes.
      -- https://github.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
      detached = vim.fn.has 'win32' == 0,
    },
  }
end

---Wrap a debug action so the stack is loaded on first use.
local function lazy(fn)
  return function()
    M.ensure_loaded()
    fn()
  end
end

vim.keymap.set('n', '<F5>', lazy(function() require('dap').continue() end), { desc = 'Debug: Start/Continue' })
vim.keymap.set('n', '<F1>', lazy(function() require('dap').step_into() end), { desc = 'Debug: Step Into' })
vim.keymap.set('n', '<F2>', lazy(function() require('dap').step_over() end), { desc = 'Debug: Step Over' })
vim.keymap.set('n', '<F3>', lazy(function() require('dap').step_out() end), { desc = 'Debug: Step Out' })
vim.keymap.set('n', '<leader>b', lazy(function() require('dap').toggle_breakpoint() end), { desc = 'Debug: Toggle Breakpoint' })
vim.keymap.set('n', '<leader>B', lazy(function() require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ') end), { desc = 'Debug: Set Breakpoint' })
-- Without this you cannot see session output after an unhandled exception.
vim.keymap.set('n', '<F7>', lazy(function() require('dapui').toggle() end), { desc = 'Debug: See last session result.' })

return M
