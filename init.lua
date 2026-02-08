vim.pack.add({
    {src = 'https://github.com/nvim-tree/nvim-tree.lua'},
    {src = 'https://github.com/folke/zen-mode.nvim'},
    {src = 'https://github.com/rose-pine/neovim'},
    {src = 'https://github.com/dhruvasagar/vim-table-mode'},
    {src = 'https://github.com/nvim-treesitter/nvim-treesitter'},
    {src = 'https://github.com/nvim-mini/mini.icons'},
    {src = 'https://github.com/MeanderingProgrammer/render-markdown.nvim'},
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
    window = {
        backdrop = 1,
        width = 80,
        height = 0.9
    }
})

vim.filetype.add({
  extension = {
    mdx = "markdown",
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

vim.g.markdown_folding = 1
vim.o.foldlevelstart = 1
vim.o.foldlevel = 1

vim.o.wrap = true
vim.o.linebreak = true
vim.o.termguicolors = true
vim.o.backup = false
vim.o.writebackup = false
vim.o.updatetime = 300
vim.o.signcolumn = 'yes'
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.fillchars = "vert:|,horiz:━,eob: "

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

map(NORMAL, CR, 'za')
map(NORMAL, SPACE .. CR, 'zx')
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

map(NORMAL, SPACE .. 'zz', '', { callback = function()
    require('zen-mode').toggle()
end })

map(NORMAL, SPACE .. 'dd', '', { callback = function()
    local fs = vim.fn.foldclosed(".")
    if fs ~= -1 then
        local fe = vim.fn.foldclosedend(".")
        vim.cmd(fs .. "," .. fe .. "delete")
    else
        vim.cmd("normal! dd")
    end
end })

