" ==============================================================================
"                            INSTRUCTIONS FOR PLUGGIN
"
" * For coc.nvim:
"   Install nodejs >= 12.12 (Always I recommend use the LTS version)

" ==============================================================================

set number                                                                      " Show lines number
set mouse=a                                                                     " Allow use the mouse
set numberwidth=1                                                               " Set the width number lines
set clipboard=unnamed
set clipboard=unnamedplus
set ruler
set backspace=indent,eol,start                                                  " Enable backspace key to do everything
set showmatch
set tabstop=4                                                                   " Show existing tab with witdth 4 space
set shiftwidth=4                                                                " When indenting with '>' will use 4 space
set expandtab                                                                   " Pressing TAB insert 4 space
set laststatus=2                                                                " Always show the status line on bottom
set noshowmode                                                                  " Not show the neovim mode
set hlsearch                                                                    " Highlight active when search
syntax enable                                                                   " Enable syntax for languages programing


" =============================== Plugin manager ===============================

call plug#begin('~/.config/nvim/plugged')

" Statusbar nvim
Plug 'itchyny/lightline.vim'                                                    " Show status bar bellow
Plug 'tpope/vim-fugitive'                                                       " Show git branch in current file

" Themes
"Plug 'morhetz/gruvbox'
Plug 'tomasiser/vim-code-dark'

" Syntaxs format
Plug 'ntpeters/vim-better-whitespace'                                           " Paint red when there are spaces or tabs the rest
Plug 'APZelos/blamer.nvim'                                                      " Show information of commiteer, date and commit per line

"IDE
Plug 'scrooloose/nerdtree'                                                      " Show tree of project directory
Plug 'christoomey/vim-tmux-navigator'                                           " Navigate between files
Plug 'neoclide/coc.nvim', {'branch': 'release'}                                 " Completion syntaxs
Plug 'nvim-lua/plenary.nvim'                                                    " Telescope
Plug 'nvim-telescope/telescope.nvim'                                            " Telescope
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}                     " Treesitter pluggint to navigate for the code

call plug#end()

" ==============================================================================

" =========================== Plugging configuration ===========================

" Configuration lightline
let g:lightline = {'colorscheme': 'wombat','active': {'left': [ [ 'mode', 'paste' ],['gitbranch', 'filename'] ]},'component_function': {'gitbranch': 'FugitiveHead'},}

" Configuration Theme
colorscheme codedark

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

" Configuration Conquer of Completion
set hidden                                                                      " TextEdit might fail if hidden is not set.
set nobackup                                                                    " Some servers have issues with backup files, see #649.
set nowritebackup                                                               " Some servers have issues with backup files, see #649.
set cmdheight=2                                                                 " Give more space for displaying messages.
set updatetime=300                                                              " Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable delays and poor user experience.
set shortmess+=c                                                                " Don't pass messages to ins-completion-menu.
" Use Ctrl+space to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()
"Go to definitions
nmap <silent> gd <Plug>(coc-definition)
" Go to type definition
nmap <silent> gy <Plug>(coc-type-definition)
 " Go to implementation
nmap <silent> gi <Plug>(coc-implementation)
" Goto references
nmap <silent> gr <Plug>(coc-references)

" ==============================================================================


" =========================== Shortkey configuration ===========================
let mapleader=" "

map <Leader>nt :NERDTreeToggle<CR>
map <Leader>w  :w<CR>
map <Leader>q  :q<CR>
map <Leader>wq :wq<CR>

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Using Lua functions
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
" ==============================================================================
