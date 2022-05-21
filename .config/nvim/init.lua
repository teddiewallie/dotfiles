local fn = vim.fn
local cmd = vim.cmd

-- PACKAGES

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system ({ 'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path
  })
end

require('packer').startup(function()
  use 'jremmen/vim-ripgrep'
  use 'junegunn/fzf'
  use 'junegunn/fzf.vim'
  use 'kyazdani42/nvim-web-devicons'
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons' }
  }
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons'
    }
  }
  use {
    'ahmedkhalf/project.nvim',
    config = function()
      require('project_nvim').setup {
      }
    end
  }
  use 'chriskempson/base16-shell'
  use {
    'chriskempson/base16-vim',
    requires = {'chriskempson/base16-shell'}
  }
end)

-- LUALINE

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = ' ', right = ' '},
    section_separators = { left = ' ', right = ' '},
    disabled_filetypes = {},
    always_divide_middle = true,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}

-- NVIMTREE
require'nvim-tree'.setup { -- BEGIN_DEFAULT_OPTS
  auto_reload_on_write = true,
  disable_netrw = false,
  hijack_cursor = false,
  hijack_netrw = true,
  hijack_unnamed_buffer_when_opening = false,
  ignore_buffer_on_setup = false,
  open_on_setup = false,
  open_on_setup_file = false,
  open_on_tab = false,
  sort_by = "name",
  update_cwd = false,
  reload_on_bufenter = false,
  view = {
    width = 30,
    height = 30,
    hide_root_folder = false,
    side = "left",
    preserve_window_proportions = false,
    number = false,
    relativenumber = false,
    signcolumn = "yes",
    mappings = {
      custom_only = false,
      list = {
        -- user mappings go here
      },
    },
  },
  renderer = {
    indent_markers = {
      enable = false,
      icons = {
        corner = "└ ",
        edge = "│ ",
        none = "  ",
      },
    },
    icons = {
      webdev_colors = true,
      git_placement = "before",
    },
  },
  hijack_directories = {
    enable = true,
    auto_open = true,
  },
  update_focused_file = {
    enable = false,
    update_cwd = false,
    ignore_list = {},
  },
  ignore_ft_on_setup = {},
  system_open = {
    cmd = "",
    args = {},
  },
  diagnostics = {
    enable = false,
    show_on_dirs = false,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },
  filters = {
    dotfiles = false,
    custom = {},
    exclude = {},
  },
  git = {
    enable = true,
    ignore = true,
    timeout = 400,
  },
  actions = {
    use_system_clipboard = true,
    change_dir = {
      enable = true,
      global = false,
      restrict_above_cwd = false,
    },
    open_file = {
      quit_on_open = false,
      resize_window = false,
      window_picker = {
        enable = true,
        chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
        exclude = {
          filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
          buftype = { "nofile", "terminal", "help" },
        },
      },
    },
  },
  trash = {
    cmd = "trash",
    require_confirm = true,
  },
  live_filter = {
    prefix = "[FILTER]: ",
    always_show_folders = true,
  },
  log = {
    enable = false,
    truncate = false,
    types = {
      all = false,
      config = false,
      copy_paste = false,
      diagnostics = false,
      git = false,
      profile = false,
    },
  },
}

-- CONFIG
cmd([[
let base16colorspace=256
colorscheme base16-apathy
set termguicolors
set shortmess=a
set encoding=utf-8
set wrap
set noerrorbells
set mouse=a
set title
set autoread
set backspace=indent,eol,start
set nobackup nowritebackup
set formatoptions+=j
set history=4000
set nomodeline
set noswapfile
set nrformats-=octal
set wildignore+=.pyc,.swp
set guicursor=a:blinkon0
set timeoutlen=500
set updatetime=50
set expandtab
set tabstop=2
set shiftwidth=2
set autoindent
set smarttab
set hlsearch
set ignorecase
set incsearch
set smartcase
set cmdheight=2
]])

-- KEYMAP

local CR = '<cr>'
local SPACE = '<space>'
local ESC = '<ESC>'
local N = 'n'
local I = 'i'
local T = 't'
local treeconf = require'nvim-tree.config'.nvim_tree_callback

function ex(string)
  return ':' .. string .. CR
end

function rawmap(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

function map(mode, shortcut, command)
  rawmap(mode, shortcut, command)
end

map(N, SPACE .. 'tj', ex('tabprevious'))
map(N, SPACE .. 'tk', ex('tabnext'))
map(N, SPACE .. 'tc', ex('tabnew'))
map(N, SPACE .. 'tq', ex('tabclose'))
map(N, SPACE .. 'TJ', ex('tabmove-'))
map(N, SPACE .. 'TK', ex('tabmove+'))

map(N, SPACE .. 'cs', ex('source ~/.config/nvim/init.lua'))

map(N, SPACE .. 'ff', ex('Files'))
map(N, SPACE .. 'fr', ':Rg ')
map(N, SPACE .. 'fs', '/')

map(N, SPACE .. 'ww', ':w' .. CR)
map(N, SPACE .. 'wq', ':wq' .. CR)

map(N, SPACE .. 'r', '.')

map(N, SPACE .. 'qq', ':q' .. CR)

map(N, SPACE .. 'nt', ex('NvimTreeFindFileToggle'))
map(N, SPACE .. 'nf', ex('NvimTreeFindFileToggle'))
map(N, SPACE .. 'nl', treeconf('cd'))
map(N, SPACE .. 'nh', treeconf('dir_up'))

local function highlight(group, guifg, guibg, ctermfg, ctermbg, attr, guisp)
  local parts = {group}
  if guifg then table.insert(parts, "guifg=#"..guifg) end
  if guibg then table.insert(parts, "guibg=#"..guibg) end
  if ctermfg then table.insert(parts, "ctermfg="..ctermfg) end
  if ctermbg then table.insert(parts, "ctermbg="..ctermfg) end
  if attr then
    table.insert(parts, "gui="..attr)
    table.insert(parts, "cterm="..attr)
  end
  if guisp then table.insert(parts, "guisp=#"..guisp) end

  vim.api.nvim_command('highlight '..table.concat(parts, ' '))
end

highlight('TabLine', '2B685E', '171717', '08', '18', 'none', nil)
highlight('TabLineFill', '2B685E', '171717', '08', '18', 'none', nil)
highlight('TabLineSel', 'F81B5AC', '171717', '08', '18', 'none', nil)
highlight('StatusLine', '2B685E', '171717', '08', '18', 'none', nil)

