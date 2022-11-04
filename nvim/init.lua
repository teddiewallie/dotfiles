local Plug = vim.fn['plug#']

vim.call('plug#begin')

Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'arcticicestudio/nord-vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'folke/zen-mode.nvim'

vim.call('plug#end')

require('zen-mode').setup({
  window = {
    backdrop = 1,
    width = 80,
    height = 0.8
  }
})

vim.cmd([[colorscheme nord]])
vim.cmd([[set linebreak]])

vim.cmd([[
let g:airline#extensions#tabline#enabled = 1
let g:airline_extensions = []
let g:airline_section_x = ''
let g:airline_section_y = ''
let g:airline_section_z = airline#section#create(['linenr', ':%v'])

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

let g:airline_powerline_fonts = 1

let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''
]])

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

vim.cmd 'cnoreabbrev log exe \'tabe $LOG/\'.strftime(\'%y%m%d\').\'.txt\''
o.expandtab = true
o.smartindent = true
o.tabstop = 2
o.shiftwidth = 2

g.mapleader = SPACE

require 'nvim-tree'.setup({
  view = {
    adaptive_size = true
  },
  update_focused_file = {
    enable = true,
    update_root = true
  }
})

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

function amap(key, command)
  map(ALL, key, command, { silent = true })
end

function nmap(key, command)
  map(NORMAL, key, command, { silent = true })
end

function spacemap(key, command)
  nmap(SPACE .. key, command)
end

function imap(key, command)
  map(INPUT, key, command, { silent = true })
end

function vmap(key, command)
  map(VISUAL, key, command, { silent = true })
end

function callmap(key, command)
  vim.api.nvim_set_keymap(NORMAL, SPACE .. key, '', { callback = command, noremap = true })
end

-- KEYMAPS

cmap('log', 'exe \'tabe $LOG/\'.strftime(\'%y%m%d\').\'.txt\'')

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

