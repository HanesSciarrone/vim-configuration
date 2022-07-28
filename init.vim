set number                                                                      " Show lines number
set numberwidth=1                                                               " Set the width number lines
set clipboard=unnamed                                                           " Allow share the clipboard OS
set clipboard=unnamedplus                                                       " Allow share the clipboard OS
set mouse=a                                                                     " Allow mouse interaction
set tabstop=4                                                                   " Show existing tab with witdth 4 space
set shiftwidth=4                                                                " When indenting with '>' will use 4 space
set expandtab                                                                   " Pressing TAB insert 4 space
set laststatus=2                                                                " Always show the status line on bottom
set noshowmode                                                                  " Not show the neovim mode
set hlsearch                                                                    " Highlight active when search
set guifont=Hack\ Nerd\ Font\ 12                                                " Set type font for vim-devicons
syntax enable                                                                   " Enable syntax for languages programing

" =============================== Plugin manager ===============================

call plug#begin('~/.config/nvim/plugged')

" Themes
Plug 'tomasiser/vim-code-dark'                                                  " Add color style in the code
Plug 'vim-airline/vim-airline'                                                  " Custom statusline and statusbar
Plug 'vim-airline/vim-airline-themes'                                           " Theme for the statusline and statusbar
Plug 'ryanoasis/vim-devicons'                                                   " Icons and glyph for statusline, NERDTree, etc
Plug 'tpope/vim-fugitive'                                                       " Show the name of branch on the statusline

" Syntaxs format
Plug 'ntpeters/vim-better-whitespace'                                           " Paint red when there are spaces or tabs the rest
Plug 'APZelos/blamer.nvim'                                                      " Show information of commiteer, date and commit per line
Plug 'Yggdroot/indentLine'                                                      " Vertical line at each indentation level for code indented with space

"IDE
Plug 'scrooloose/nerdtree'                                                      " Show tree of project directory
Plug 'christoomey/vim-tmux-navigator'                                           " Navigate between files
Plug 'nvim-lua/plenary.nvim'                                                    " Telescope
Plug 'nvim-telescope/telescope.nvim'                                            " Telescope
Plug 'voldikss/vim-floaterm'                                                    " Allow has flow terminal
Plug 'neovim/nvim-lspconfig'                                                    " Install LSP for navigation code
Plug 'williamboman/nvim-lsp-installer'                                          " Installation of server LSP/Debugger/Other
Plug 'hrsh7th/nvim-cmp'                                                         " Autocompleation (Autocompletion plugin)
Plug 'hrsh7th/cmp-nvim-lsp'                                                     " Autocompleation (LSP source for nvim-cmp)
Plug 'saadparwaiz1/cmp_luasnip'                                                 " Autocompleation (Snippets source for nvim-cmp)
Plug 'L3MON4D3/LuaSnip'                                                         " Autocompleation (Snippets plugin)
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}                     " Install Treesitter for Highlighting

call plug#end()

" ==============================================================================

" =========================== Plugging configuration ===========================

" Theme
colorscheme codedark

" Configuration Airline
let g:airline_theme = 'codedark'
let g:airline_powerline_fonts = 1

" configuration vim-better-whitespace
let g:better_whitespace_ctermcolor='red'
let g:better_whitespace_guicolor='#990000'
let g:better_whitespace_enabled=1

" Configuration Blamer
let g:blamer_enabled = 1
let g:blamer_delay = 1000
let g:blamer_show_in_visual_mode = 0
let g:blamer_show_in_insert_mode = 0
let g:blamer_date_format = '%d/%m/%y'

" Configuration NERDTree
let NERDTreeWinSize = 31                                                        " Setup width windows to 31 columns
let NERDTreeShowHidden = 1                                                      " Show the hidden file
autocmd StdinReadPre * let s:std_in=1                                           " Start NERDTree when Vim is started without file arguments.
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif     " Start NERDTree when Vim is started without file arguments.

" Configure Floaterm
let g:floaterm_position = 'bottomright'
let g:floaterm_height = 0.6
let g:floaterm_width = 0.85


" Configure LSP-Installer
lua << EOL
require("nvim-lsp-installer").setup {}
EOL

" Configure LSP-config
lua << EOL
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

require('lspconfig').clangd.setup{
    capabilities = capabilities,
}
require'lspconfig'.cmake.setup{
    capabilities = capabilities,
}
EOL

" Autocompleation configuration
lua << EOL
require('cmp').setup{
    snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
    },
    mapping = require('cmp').mapping.preset.insert({
        ['<C-Space>'] = require('cmp').mapping.complete(),
        ['<CR>'] = require('cmp').mapping.confirm {
            behavior = require('cmp').ConfirmBehavior.Replace,
            select = true,
        },
        ['<Tab>'] = require('cmp').mapping(
        function(fallback)
            if require('cmp').visible() then
                require('cmp').select_next_item()
            elseif require('luasnip').expand_or_jumpable() then
                require('luasnip').expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = require('cmp').mapping(function(fallback)
            if require('cmp').visible() then
                require('cmp').select_prev_item()
            elseif require('luasnip').jumpable(-1) then
                require('luasnip').jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    }),
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    },
}
EOL

" Treesitter
lua << EOL
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "c", "cpp", "cmake", "json" },  -- A list of parser names, or "all"
  sync_install = false,  -- Install parsers synchronously (only applied to `ensure_installed`)
  ignore_install = { "javascript" },

  highlight = {
    enable = true,
    disable = { "" },
  },
  indent = {
    enable = false
  }
}
EOL

" ==============================================================================

" =========================== Shortkey configuration ===========================
let mapleader=" "

map <Leader>w  :w<CR>
map <Leader>q  :q<CR>
map <Leader>wq :wq<CR>
map <Leader>s  <C-\><C-n>

" Open NERDTree
nnoremap <silent>nt :NERDTreeToggle<CR>

" Find files using Telescope command-line sugar.
nnoremap <silent>ff <cmd>Telescope find_files<cr>
nnoremap <silent>fg <cmd>Telescope live_grep<cr>

" Open floaterm
nnoremap <silent> <F12> :FloatermToggle<CR>
tnoremap <silent> <F12> <C-\><C-n>:FloatermToggle<CR>

" Option to navigate for file
nnoremap <silent> <Leader>gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> <Leader>gf <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> <Leader>k <cmd>lua vim.lsp.buf.hover()<CR>

