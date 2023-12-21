vim.opt.number = true                       -- Print the line number in front of each line
vim.opt.numberwidth = 1                     -- Number of columns used for the line number
vim.opt.clipboard = "unnamed"               -- Use the clipboard as the unnamed register
vim.opt.clipboard = "unnamedplus"           -- Use the clipboard as the unnamed register
vim.opt.mouse = "a"                         -- Enable the use of mouse clicks
vim.opt.tabstop = 4                         -- Number of spaces that <Tab> in file uses
vim.opt.shiftwidth = 4                      -- Number of spaces to use for (auto)indent step
vim.opt.expandtab = true                    -- Use spaces when <Tab> is inserted
vim.opt.laststatus = 2                      -- Tells when last window has status lines
vim.opt.showmode = false                    -- Not show the neovim mode
vim.opt.showmatch = true                    -- Briefly jump to matching bracket if insert one
vim.opt.guifont = "Hack Nerd Font 12"       -- GUI: Name(s) of font(s) to be used
vim.opt.syntax = "ON"                       -- Syntax to be loaded for current buffer


-- =============================== Plugin manager ===============================

-- Install pluging manager (lazy)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Themes
require("lazy").setup({
    ------ Themes -----
    "Mofiqul/vscode.nvim",                                                              -- Add color style in the code
    {"nvim-lualine/lualine.nvim", dependencies = { "nvim-tree/nvim-web-devicons" }},    -- Custom statusline and statusbar
    "ryanoasis/vim-devicons",                                                           -- Icons and glyph for statusline, NERDTree, etc
    "tpope/vim-fugitive",                                                               -- Show the name of branch on the statusline
    -------------------

    -- Syntax format --
    "ntpeters/vim-better-whitespace",                                                   -- Paint red when there are spaces or tabs the rest
    "APZelos/blamer.nvim",                                                              -- Show information of commiteer, date and commit per line
    "Yggdroot/indentLine",                                                              -- Vertical line at each indentation level for code indented with space
    -------------------

    ------- IDE -------
    {"romgrk/barbar.nvim", dependencies = { 'nvim-tree/nvim-web-devicons' }},           -- Allow have a lot bar file on top
    "nvim-tree/nvim-tree.lua",                                                          -- Show tree of project directory
    {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},                           -- Install Treesitter for Highlighting
    "christoomey/vim-tmux-navigator",                                                   -- Navigate between files
    "nvim-lua/plenary.nvim",                                                            -- Telescope
    "nvim-telescope/telescope.nvim",                                                    -- Telescope
    "williamboman/mason.nvim",                                                          -- LSP servers installation automaticaly,
    "neovim/nvim-lspconfig",                                                            -- LSP server for navigation code
    "hrsh7th/cmp-nvim-lsp",                                                             -- Autocompleation (LSP source for nvim-cmp)
    "hrsh7th/nvim-cmp",                                                                 -- Autocompleation (Autocompletion engine)
    "L3MON4D3/LuaSnip",                                                                 -- Autocompleation (Snippets plugin)
    "saadparwaiz1/cmp_luasnip"                                                          -- Autocompleation (Snippets source for nvim-cmp)
    -------------------
})


-- =========================== Pluggins configuration ===========================


------------ Configuration vscode-nvim -----------
vim.o.background = "dark"

local color = require("vscode.colors").get_colors()

require("vscode").setup({
    -- Enable transparent background
    transparent = true,

    -- Enable italic comment
    italic_comments = true,

    -- Disable nvim-tree background color
    disable_nvimtree_bg = true,

    -- Override colors (see ./lua/vscode/colors.lua)
    color_overrides = {
        vscLineNumber = "#FFFFFF",
    },

    -- Override highlight groups (see ./lua/vscode/theme.lua)
    group_overrides = {
        -- this supports the same val table as vim.api.nvim_set_hl
        -- use colors from this colorscheme by requiring vscode.colors!
        Cursor = { fg=color.vscDarkBlue, bg=color.vscLightGreen, bold=true },
    }
})
require("vscode").load()
--------------------------------------------------

-------------- Configuration Lualine -------------
require("lualine").setup({
    option = {
        icons_enabled = true,
        theme = "vscode"
    }
})
--------------------------------------------------

------- Configuration vim-better-whitespace ------
vim.g.better_whitespace_ctermcolor="red"
vim.g.better_whitespace_guicolor="#990000"
vim.g.better_whitespace_enabled=1
--------------------------------------------------

-------------- Configuration Blamer --------------
vim.g.blamer_enabled = 1
vim.g.blamer_delay = 1000
vim.g.blamer_show_in_visual_mode = 0
vim.g.blamer_show_in_insert_mode = 0
vim.g.blamer_date_format = "%d/%m/%y"
--------------------------------------------------

-------------- Configuration Barbar --------------
vim.g.barbar_auto_setup = false

require("barbar").setup {
    icon = {
        filetype = {
            enabled = true
        },
        separator = {left = '| ', right = ''},
        separator_at_end = true
    }
}

local NvimTreeEvents = require("nvim-tree.events")
local BufferlineAPI = require("bufferline.api")

local function get_tree_size()
  return require("nvim-tree.view").View.width
end

NvimTreeEvents.subscribe("TreeOpen", function()
  BufferlineAPI.set_offset(get_tree_size())
end)

NvimTreeEvents.subscribe("Resize", function()
  BufferlineAPI.set_offset(get_tree_size())
end)

NvimTreeEvents.subscribe("TreeClose", function()
  BufferlineAPI.set_offset(0)
end)
--------------------------------------------------

------------- Configuration Nvim-tree ------------
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup({
    view = {
        adaptive_size = false,
        centralize_selection = false,
        width = 31,
        side = "left",
        preserve_window_proportions = false,
        number = false,
        relativenumber = false,
        signcolumn = "yes",
    },
})

-- Function to open nvim-tree when neovim open directory
local function open_nvim_tree(data)
  -- buffer is a [No Name]
  local no_name = data.file == "" and vim.bo[data.buf].buftype == ""

  -- buffer is a directory
  local directory = vim.fn.isdirectory(data.file) == 1

  if not no_name and not directory then
    return
  end

  -- change to the directory
  if directory then
    vim.cmd.cd(data.file)
  end

  -- open the tree
  require("nvim-tree.api").tree.open()
end

-- Register event
vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
--------------------------------------------------

------------ Configuration Tree-sitter -----------
require("nvim-treesitter.configs").setup {
    -- A list of parser names, or "all"
    ensure_installed = { "c", "cpp", "cmake", "lua", "vim", "json" },
    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,
    -- List of parsers to ignore installing (or "all")
    ignore_install = { "javascript" },
    highlight = {
        enable = true,
        disable  = { "" }
    },
    indent = {
        enable = false
    }
}
--------------------------------------------------

------------ Configuration LSP-server ------------
require("mason").setup()

local capability = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capability)

require("lspconfig").clangd.setup{capabilities = capabilities}
require("lspconfig").cmake.setup{capabilities = capabilities}
require("lspconfig").lua_ls.setup{}

capability.textDocument.completion.completionItem.snippetSupport = true
require("lspconfig").jsonls.setup{capabilities = capability}
--------------------------------------------------

---------- Configuration autocompleation ---------
local cmp = require("cmp")

local function next_item(fallback)
    if cmp.visible() then
        cmp.select_next_item()
    elseif require("luasnip").expand_or_jumpable() then
        require("luasnip").expand_or_jump()
    else
        fallback()
    end
end


local function previous_item(fallback)
    if cmp.visible() then
        cmp.select_prev_item()
    elseif require("luasnip").jumpable(-1) then
        require("luasnip").jump(-1)
    else
        fallback()
    end
end

cmp.setup{
    -- Specify the snippet engine
    snippet = { expand = function(args) require('luasnip').lsp_expand(args.body) end },

    mapping = cmp.mapping.preset.insert({
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<CR>"]      = cmp.mapping.confirm{ behavior = cmp.ConfirmBehavior.Replace, select = true},
        ["<Tab>"]     = cmp.mapping(next_item,     {"i", "s"}),
        ['<S-Tab>']   = cmp.mapping(previous_item, {"i", "s"}),
    }),
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" }
    },
    {
        { name = "buffer" }
    })
}
--------------------------------------------------

-- =========================== Shortkey configuration ===========================
vim.g.mapleader = " "

vim.keymap.set("n", "<leader>w" , "<cmd>write<CR>")
vim.keymap.set("n", "<leader>q" , "<cmd>quit<CR>")
vim.keymap.set("n", "<leader>wq", ":wq<CR>")


-- Mapping for barbar
vim.keymap.set("n", "<Tab>"    , "<cmd>BufferNext<CR>"    , {silent = true})
vim.keymap.set("n", "<S-Tab>"  , "<cmd>BufferPrevious<CR>", {silent = true})
vim.keymap.set("n", "<leader>c", "<cmd>BufferClose<CR>"   , {silent = true})

-- Open Nvim-tree
vim.keymap.set("n", "<leader>nt", ":NvimTreeToggle<CR>", {silent = true})


-- Find files using Telescope command-line sugar.
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>", {silent = true})
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<CR>",  {silent = true})
-- ==============================================================================
