vim.pack.add({
  {src = "https://github.com/nvim-tree/nvim-tree.lua"},
  {src = "https://github.com/folke/zen-mode.nvim"},
  {src = "https://github.com/rose-pine/neovim"},
  {src = "https://github.com/dhruvasagar/vim-table-mode"},
});

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
  on_open = function()
    local buf = vim.api.nvim_get_current_buf()
    local path = vim.api.nvim_buf_get_name(buf)

    -- Only map 'q' if the file path contains "notes"
    if path:match("notes") then
      vim.api.nvim_buf_set_keymap(buf, "n", "q",
        [[:lua if #vim.fn.getbufinfo({buflisted=1}) == 1 then vim.cmd('confirm qa') else vim.cmd('confirm bd') end<CR>]],
        { noremap = true, silent = true }
      )
    end

    -- Remap :q in this window to close the buffer
    vim.api.nvim_buf_set_keymap(0, "n", ":q",
      [[:lua if #vim.fn.getbufinfo({buflisted=1}) == 1 then vim.cmd('qa') else vim.cmd('bd') end<CR>]],
      { noremap = true, silent = true }
    )
  end,
  window = {
    backdrop = 1,
    width = 80,
    height = 0.9,
    options = {
      number = false,
    },
  },
})

local ALL = 'a'
local NORMAL = 'n'
local INPUT = 'i'
local VISUAL = 'v'

local SPACE = '<space>'
local CR = '<CR>'
local TAB = '<TAB>'

vim.g.mapleader = SPACE
vim.g.maplocalleader = "\\"

vim.o.number = true
vim.o.wrap = true
vim.o.linebreak = true
vim.o.termguicolors = true
vim.o.backup = false
vim.o.writebackup = false
vim.o.updatetime = 300
vim.o.signcolumn = 'yes'
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2

vim.cmd([[
augroup TransparentBackground
autocmd!
autocmd ColorScheme * highlight Normal ctermbg=none guibg=none
autocmd ColorScheme * highlight NormalNC ctermbg=none guibg=none
autocmd ColorScheme * highlight NormalSB ctermbg=none guibg=none
autocmd ColorScheme * highlight NonText ctermbg=none guibg=none
autocmd ColorScheme * highlight StatusLine ctermbg=none guibg=none
autocmd ColorScheme * highlight StatusLineNC ctermbg=none guibg=none
autocmd ColorScheme * highlight StatusLineSB ctermbg=none guibg=none
autocmd ColorScheme * highlight TabLine ctermbg=none guibg=none
autocmd ColorScheme * highlight TabLineSel ctermbg=none guibg=none
autocmd ColorScheme * highlight TabLineFill ctermbg=none guibg=none
autocmd ColorScheme * highlight ZenBg ctermbg=none guibg=none
augroup END

colorscheme rose-pine
]])

-- KEYMAPS

function map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map(NORMAL, SPACE .. 'k', '<C-a>')
map(NORMAL, SPACE .. 'j', '<C-x>')

map(NORMAL, SPACE .. 'ww', ':w' .. CR)

map(NORMAL, SPACE .. 'tj', ':tabprev' .. CR)
map(NORMAL, SPACE .. 'tk', ':tabnext' .. CR)
map(NORMAL, SPACE .. 'tq', ':tabclose' .. CR)

map(NORMAL, SPACE .. 'nf', ':NvimTreeFindFileToggle' .. CR)

map(NORMAL, SPACE .. SPACE, ':')
map(NORMAL, SPACE .. 'fs', '/')

map(VISUAL, SPACE .. 'y', '"+y');

map(NORMAL, SPACE .. 'zz', '', { callback = function() require('zen-mode').toggle() end })

