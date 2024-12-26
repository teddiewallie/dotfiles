-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("lazy").setup({
  spec = {
    { "nvim-tree/nvim-tree.lua" },
    { "folke/zen-mode.nvim" },
    { "rose-pine/neovim", name = "rose-pine" },
  },
  -- install = { colorscheme = { "habamax" } },
  checker = { enabled = true },
})

vim.cmd([[colorscheme rose-pine]])

require('nvim-tree').setup({
  view = {
    adaptive_size = true
  },
  update_focused_file = {
    enable = true,
    update_root = true
  }
})

require('zen-mode').setup({
  window = {
    backdrop = 1,
    width = 120,
    height = 0.9
  }
})

-- COLORS
-- vim.cmd([[highlight Normal guibg=#222222]])
-- vim.cmd([[highlight StatusLine guibg=#222222 guifg=#dddddd]])

vim.o.termguicolors = true
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.updatetime = 300
vim.opt.signcolumn = 'yes'

local ALL = 'a'
local NORMAL = 'n'
local INPUT = 'i'
local VISUAL = 'v'

local SPACE = '<space>'
local CR = '<CR>'
local TAB = '<TAB>'

local THISFILE = '/Users/tafd/.config/nvim/init.lua'

local o = vim.o
local g = vim.g

o.expandtab = true
o.smartindent = true
o.tabstop = 2
o.shiftwidth = 2

g.mapleader = SPACE

function cmap(name, command)
  vim.cmd('cnoreabbrev ' .. name .. ' ' .. command)
end

function map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

function nmap(key, command)
  map(NORMAL, key, command, { silent = true })
end

function spacemap(key, command)
  nmap(SPACE .. key, command)
end

function callmap(key, command)
  vim.api.nvim_set_keymap(NORMAL, SPACE .. key, '', { callback = command, noremap = true })
end

-- KEYMAPS

spacemap('k', '<C-a>')
spacemap('j', '<C-x>')

spacemap('ww', ':w' .. CR)
spacemap('wq', ':wq' .. CR)
spacemap('ss', ':source ' .. THISFILE .. CR)

spacemap('tj', ':tabprev' .. CR)
spacemap('tk', ':tabnext' .. CR)
spacemap('tq', ':tabclose' .. CR)

spacemap('nf', ':NvimTreeFindFileToggle' .. CR)

spacemap(SPACE, ':')
spacemap('fs', '/')

spacemap('cc', ':CocList commands' .. CR)
spacemap('cd', ':CocList diagnostics' .. CR)
spacemap('co', ':CocList outline' .. CR)

callmap('zz', function()
  require('zen-mode').toggle()
  end
)

