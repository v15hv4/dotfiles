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
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  is_bootstrap = true
  vim.fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
  vim.cmd([[packadd packer.nvim]])
end

require("packer").startup(function(use)
  -- Package manager
  use("wbthomason/packer.nvim")

  -- One Nvim colorscheme
  use("Th3Whit3Wolf/one-nvim")

  -- Tree
  use("nvim-tree/nvim-tree.lua")

  -- Git
  use("lewis6991/gitsigns.nvim")

  -- LSP
  use({
    "VonHeikemen/lsp-zero.nvim",
    branch = "v2.x",
    requires = {
      -- LSP Support
      { "neovim/nvim-lspconfig" }, -- Required
      {                         -- Optional
        "williamboman/mason.nvim",
        run = function()
          pcall(vim.cmd, "MasonUpdate")
        end,
      },
      { "williamboman/mason-lspconfig.nvim" }, -- Optional

      -- Autocompletion
      { "hrsh7th/nvim-cmp" },  -- Required
      { "hrsh7th/cmp-nvim-lsp" }, -- Required
      { "L3MON4D3/LuaSnip" },  -- Required
    },
  })
  use({
    "jose-elias-alvarez/null-ls.nvim",
    requires = { "nvim-lua/plenary.nvim" },
  })
  use("jay-babu/mason-null-ls.nvim")
  use("nvim-treesitter/nvim-treesitter")

  -- Copilot
  use("zbirenbaum/copilot.lua")

  -- Statusline
  use({
    "nvim-lualine/lualine.nvim",
    requires = { "nvim-tree/nvim-web-devicons", opt = true },
  })

  -- Telescope
  use({
    "nvim-telescope/telescope.nvim",
    tag = "0.1.2",
    requires = { "nvim-lua/plenary.nvim" },
  })

  -- Other useful plugins
  use("numToStr/Comment.nvim")      -- 'gc' to comment visual regions/lines
  use("tpope/vim-sleuth")           -- Detect tabstop and shiftwidth automatically
  use("m4xshen/autoclose.nvim")     -- Automatically close brackets and quotes
  use("nvim-tree/nvim-web-devicons") -- Better icons

  if is_bootstrap then
    require("packer").sync()
  end
end)

-- When we are bootstrapping a configuration, it doesn't
-- make sense to execute the rest of the init.lua.
--
-- You'll need to restart nvim, and then it will work.
if is_bootstrap then
  print("==================================")
  print("    Plugins are being installed")
  print("    Wait until Packer completes,")
  print("       then restart nvim")
  print("==================================")
  return
end

-- Automatically source and re-compile packer whenever you save this init.lua
local packer_group = vim.api.nvim_create_augroup("Packer", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
  command = "source <afile> | silent! LspStop | silent! LspStart | PackerCompile",
  group = packer_group,
  pattern = vim.fn.expand("$MYVIMRC"),
})

-- }}}

-- OPTIONS -- {{{
-- See `:help vim.o`

-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

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
vim.o.encoding = "utf-8"

-- Tab configuration
vim.o.tabstop = 2
vim.o.softtabstop = 0
vim.o.expandtab = true
vim.o.shiftwidth = 2
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
vim.wo.signcolumn = "yes"

-- Set colorscheme
vim.o.background = "light"
vim.o.termguicolors = true
vim.cmd([[colorscheme one-nvim]])

-- Fold on markers
vim.o.foldmethod = "marker"

-- Transparent background
vim.cmd([[hi Normal guibg=none]])
vim.g.one_nvim_transparent_bg = true

-- Highlight on yank
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})

-- }}}

-- KEYBINDS -- {{{
-- Navigating splits
vim.keymap.set("n", "<C-Up>", "<C-W><C-Up>")
vim.keymap.set("n", "<C-Down>", "<C-W><C-Down>")
vim.keymap.set("n", "<C-Right>", "<C-W><C-L>")
vim.keymap.set("n", "<C-Left>", "<C-W><C-H>")

-- Navigating tabs
vim.keymap.set("n", "<M-Right>", ":tabn<CR>")
vim.keymap.set("n", "<M-Left>", ":tabp<CR>")

-- Nvim Tree
vim.keymap.set("n", "<C-b>", ":NvimTreeToggle<CR>")
-- }}}

-- SPLITS -- {{{
vim.o.splitbelow = true
vim.o.splitright = true
-- }}}

-- PLUGINS -- {{{
require("Comment").setup()
require("autoclose").setup()
require("gitsigns").setup()

-- Lualine
local bubbles_onelight = require("lualine.themes.onelight")
require("lualine").setup({
  options = {
    theme = bubbles_onelight,
    component_separators = "|",
    section_separators = { left = "", right = "" },
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "filename", "branch" },
    lualine_c = { "fileformat" },
    lualine_x = {},
    lualine_y = { "filetype", "progress" },
    lualine_z = { "location" },
  },
  inactive_sections = {
    lualine_a = { "filename" },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = { "location" },
  },
  tabline = {},
  extensions = {},
})

-- Treesitter
require("nvim-treesitter.configs").setup({
  auto_install = true,
  highlight = {
    enable = true,
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
})

-- LSP
local lsp = require("lsp-zero").preset({})

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({ buffer = bufnr })
end)

-- (Optional) Configure lua language server for neovim
require("lspconfig").lua_ls.setup(lsp.nvim_lua_ls())

-- Format on save
lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({ buffer = bufnr })
  lsp.buffer_autoformat()
end)

lsp.setup()

-- LSP features
vim.api.nvim_create_autocmd("LspAttach", {
  desc = "LSP actions",
  callback = function()
    local bufmap = function(mode, lhs, rhs)
      local opts = { buffer = true }
      vim.keymap.set(mode, lhs, rhs, opts)
    end

    -- Displays hover information about the symbol under the cursor
    bufmap("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>")

    -- Jump to the definition
    bufmap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>")

    -- Jump to declaration
    bufmap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>")

    -- Lists all the implementations for the symbol under the cursor
    bufmap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>")

    -- Jumps to the definition of the type symbol
    bufmap("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>")

    -- Lists all the references
    bufmap("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>")

    -- Displays a function's signature information
    bufmap("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>")

    -- Renames all references to the symbol under the cursor
    bufmap("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>")

    -- Selects a code action available at the current cursor position
    bufmap("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>")
    bufmap("x", "<F4>", "<cmd>lua vim.lsp.buf.range_code_action()<cr>")

    -- Show diagnostics in a floating window
    bufmap("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>")

    -- Move to the previous diagnostic
    bufmap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>")

    -- Move to the next diagnostic
    bufmap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>")
  end,
})

-- Configure null-ls
local null_ls = require("null-ls")

null_ls.setup({
  sources = {
    -- Here you can add tools not supported by mason.nvim
    -- make sure the source name is supported by null-ls
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
  },
})

require("mason-null-ls").setup({
  ensure_installed = nil,
  automatic_installation = false, -- You can still set this to `true`
  handlers = {
    -- Here you can add functions to register sources.
    -- See https://github.com/jay-babu/mason-null-ls.nvim#handlers-usage
    --
    -- If left empty, mason-null-ls will  use a "default handler"
    -- to register all sources
  },
})

-- Configure cmp
local cmp = require("cmp")
local luasnip = require("luasnip")
-- local cmp_action = require('lsp-zero').cmp_action()

local select_opts = { behavior = cmp.SelectBehavior.Select }
cmp.setup({
  mapping = {
    ["<Up>"] = cmp.mapping.select_prev_item(select_opts),
    ["<Down>"] = cmp.mapping.select_next_item(select_opts),

    ["<C-p>"] = cmp.mapping.select_prev_item(select_opts),
    ["<C-n>"] = cmp.mapping.select_next_item(select_opts),

    ["<C-e>"] = cmp.mapping.scroll_docs(-4),
    ["<C-d>"] = cmp.mapping.scroll_docs(4),

    ["<C-u>"] = cmp.mapping.abort(),
    ["<C-y>"] = cmp.mapping.confirm({ select = true }),
    ["<CR>"] = cmp.mapping.confirm({ select = false }),

    ["<C-f>"] = cmp.mapping(function(fallback)
      if luasnip.jumpable(1) then
        luasnip.jump(1)
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<C-b>"] = cmp.mapping(function(fallback)
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<Tab>"] = cmp.mapping(function(fallback)
      if require("copilot.suggestion").is_visible() then
        require("copilot.suggestion").accept()
      elseif cmp.visible() then
        cmp.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true })
      elseif require("luasnip").expand_or_jumpable() then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item(select_opts)
      else
        fallback()
      end
    end, { "i", "s" }),
  },
})

-- Copilot
require("copilot").setup({
  panel = {
    enabled = true,
    auto_refresh = false,
    keymap = {
      jump_prev = "[[",
      jump_next = "]]",
      accept = "<CR>",
      refresh = "gr",
      open = "<M-CR>",
    },
    layout = {
      position = "bottom", -- | top | left | right
      ratio = 0.4,
    },
  },
  suggestion = {
    enabled = true,
    auto_trigger = true,
    debounce = 75,
    keymap = {
      accept = "<M-l>",
      accept_word = false,
      accept_line = false,
      next = "<M-]>",
      prev = "<M-[>",
      dismiss = "<C-]>",
    },
  },
  filetypes = {
    yaml = false,
    markdown = false,
    help = false,
    gitcommit = false,
    gitrebase = false,
    hgcommit = false,
    svn = false,
    cvs = false,
    ["."] = false,
  },
  copilot_node_command = "node", -- Node.js version must be > 16.x
  server_opts_overrides = {},
})

cmp.event:on("menu_opened", function()
  vim.b.copilot_suggestion_hidden = true
end)

cmp.event:on("menu_closed", function()
  vim.b.copilot_suggestion_hidden = false
end)

-- Nvim Tree
-- OR setup with some options
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    width = 25,
  },
  renderer = {
    group_empty = true,
  },
  -- filters = {
  --   dotfiles = true,
  -- },
})

-- Telescope
require("telescope").setup()
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<C-f>", builtin.find_files, {})
vim.keymap.set("n", "<C-_>", builtin.live_grep, {})
-- }}}
