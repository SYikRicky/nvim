-- Cache compiled Lua modules for a faster startup.
vim.loader.enable()

-- Leaders must be set before any plugin is loaded, otherwise mappings defined
-- during plugin setup bind to the old leader.
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Drives icon usage across which-key, mini.statusline, neo-tree and blink.cmp.
vim.g.have_nerd_font = false

-- See `:help option-list`
vim.o.number = true
vim.o.relativenumber = true
vim.o.mouse = 'a'
vim.o.showmode = false -- already shown in the statusline

-- Clipboard is deliberately left independent of the OS clipboard. To sync it,
-- schedule the setting after UiEnter so it does not cost startup time:
-- vim.schedule(function() vim.o.clipboard = 'unnamedplus' end)

vim.o.breakindent = true
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.expandtab = true
vim.o.undofile = true

-- Case-insensitive search unless the pattern contains \C or a capital letter.
vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.signcolumn = 'yes'
vim.o.colorcolumn = '80'

vim.o.updatetime = 50
vim.o.timeoutlen = 300

vim.o.splitright = true
vim.o.splitbelow = true

vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

vim.o.inccommand = 'split' -- live preview of :substitute
vim.o.cursorline = true
vim.o.scrolloff = 10
vim.o.confirm = true -- prompt to save instead of failing :q
