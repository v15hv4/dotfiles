
--        .          .
--      ';;,.        ::'
--    ,:::;,,        :ccc,
--   ,::c::,,,,.     :cccc,
--   ,cccc:;;;;;.    cllll,
--   ,cccc;.;;;;;,   cllll;
--   :cccc; .;;;;;;. coooo;
--   ;llll;   ,:::::'loooo;
--   ;llll:    ':::::loooo:
--   :oooo:     .::::llodd:
--   .;ooo:       ;cclooo:.
--     .;oc        'coo;.
--       .'         .,.


-- PACKER -- {{{
-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  is_bootstrap = true
  vim.fn.system { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path }
  vim.cmd [[packadd packer.nvim]]
end

require('packer').startup(function(use)
  -- Package manager
  use 'wbthomason/packer.nvim'

  -- One Nvim colorscheme
  use 'Th3Whit3Wolf/one-nvim'

  -- Fuzzy Finder (files, lsp, etc)
  use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  use 'nvim-telescope/telescope-file-browser.nvim'
  use 'nvim-tree/nvim-web-devicons'

  -- Git
  use 'lewis6991/gitsigns.nvim'

  -- LSP
  use { 
    'VonHeikemen/lsp-zero.nvim', 
    branch = 'v2.x', 
    requires = {
      {'neovim/nvim-lspconfig'},             -- Required
      {                                      -- Optional
        'williamboman/mason.nvim',
        build = function()
          pcall(vim.cmd, 'MasonUpdate')
        end,
      },
      {'williamboman/mason-lspconfig.nvim'}, -- Optional

      -- Autocompletion
      {'hrsh7th/nvim-cmp'},     -- Required
      {'hrsh7th/cmp-nvim-lsp'}, -- Required
      {'L3MON4D3/LuaSnip'},     -- Required
    }
  }

  -- Statusline
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  }

  -- Other useful plugins
  use 'numToStr/Comment.nvim' -- 'gc' to comment visual regions/lines
  use 'tpope/vim-sleuth' -- Detect tabstop and shiftwidth automatically
  use 'm4xshen/autoclose.nvim' -- Automatically close brackets and quotes

  if is_bootstrap then
    require('packer').sync()
  end
end)

-- When we are bootstrapping a configuration, it doesn't
-- make sense to execute the rest of the init.lua.
--
-- You'll need to restart nvim, and then it will work.
if is_bootstrap then
  print '=================================='
  print '    Plugins are being installed'
  print '    Wait until Packer completes,'
  print '       then restart nvim'
  print '=================================='
  return
end

-- Automatically source and re-compile packer whenever you save this init.lua
local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
  command = 'source <afile> | silent! LspStop | silent! LspStart | PackerCompile',
  group = packer_group,
  pattern = vim.fn.expand '$MYVIMRC',
})

-- }}}

-- OPTIONS -- {{{
-- See `:help vim.o`

-- Reload files changed outside of Vim
vim.o.autoread = true

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true

-- Show cursorline
vim.wo.cursorline = true

-- Don't show current mode
vim.o.showmode = false

-- Use Unicode
vim.o.encoding = 'utf-8'

-- Tab configuration
vim.o.tabstop = 4
vim.o.softtabstop = 0
vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.smarttab = true

-- Make scrolling and painting faster
vim.o.ttyfast = true
vim.o.lazyredraw = true

-- Enable break indent
vim.o.breakindent = true

-- Make`gg` move to start of line
vim.o.startofline = true

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true

-- Don't wrap lines
vim.o.wrap = false

-- Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'

-- Set colorscheme
vim.o.background = 'light'
vim.o.termguicolors = true
vim.cmd [[colorscheme one-nvim]]

-- Fold on markers
vim.o.foldmethod = 'marker'

-- Transparent background 
vim.cmd [[hi Normal guibg=none]]
vim.g.one_nvim_transparent_bg = true

-- Highlight on yank
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- }}}

-- KEYBINDS -- {{{
-- Telescope
local telescope_builtin = require('telescope.builtin')
vim.keymap.set({'n', 'i'}, '<C-b>', ':Telescope file_browser<CR>', {})
vim.keymap.set({'n', 'i'}, '<C-f>', telescope_builtin.live_grep, {})

-- Navigating splits
vim.keymap.set('n', '<C-Up>', '<C-W><C-Up>')
vim.keymap.set('n', '<C-Down>', '<C-W><C-Down>')
vim.keymap.set('n', '<C-Right>', '<C-W><C-L>')
vim.keymap.set('n', '<C-Left>', '<C-W><C-H>')

-- Navigating tabs
vim.keymap.set('n', '<M-Right>', ':tabn<CR>')
vim.keymap.set('n', '<M-Left>', ':tabp<CR>')
-- }}}

-- SPLITS -- {{{
vim.o.splitbelow = true
vim.o.splitright = true
-- }}}

-- PLUGINS -- {{{
require('Comment').setup()
require('autoclose').setup()
require('gitsigns').setup()

-- Telescope
require('telescope').setup {
  extensions = {
    file_browser = {
      hijack_netrw = true,
    }
  }
}
require('telescope').load_extension 'file_browser'

-- LSP
local lsp = require('lsp-zero').preset({})
lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({buffer = bufnr})
end)
lsp.setup()

local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()
cmp.setup({
  mapping = {
    ['<CR>'] = cmp.mapping.confirm({select = true}),
    ['<Tab>'] = cmp_action.luasnip_supertab(),
    ['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  }
})

-- Lualine
local bubbles_onelight = require('lualine.themes.onelight')
require('lualine').setup {
  options = {
    theme = bubbles_onelight,
    component_separators = '|',
    section_separators = { left = '', right = '' },
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'filename', 'branch' },
    lualine_c = { 'fileformat' },
    lualine_x = {},
    lualine_y = { 'filetype', 'progress' },
    lualine_z = { 'location' },
  },
  inactive_sections = {
    lualine_a = { 'filename' },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = { 'location' },
  },
  tabline = {},
  extensions = {},
}
-- }}}
