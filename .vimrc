" Wazuh SYSINFO
" Copyright (C) 2022.
" January 30, 2022.
"
" This program is free software; you can redistribute it
" and/or modify it under the terms of the GNU General Public
" License (version 3) as published by the FSF - Free Software
" Foundation.
"
" How install vim to this configuration works
" Clone official vim repository
"
" * git clone https://github.com/vim/vim.git
"
" Install packages to compile vim with the necessary option
" 	sudo apt install git
"	sudo apt install make
"	sudo apt install clang
"	sudo apt install libtool-bin
"	sudo apt install libxt-dev       Add X windows clipboard support (also needed for GUI)
"	sudo apt install libgtk-3-dev    Add GUI support
"	sudo apt install libpython3-dev  Add python 3 support
"
" Uncomment this line in Makefile 'CONF_OPT_PYTHON3 = --enable-python3interp'
" cd vim/src
" make distclean (Only if you build vim before)
" ./configure --with-features=huge
" make reconfig
" make
" sudo make install
"
" For tabnine, after install pluggin you must to open de directory where it
" was installed (.vim/plugged/YouCompleteMe) and execute the conmand
"
" python3 install.py --clangd-completer (For C/C++ autocomplete)

set number                      " Show the lines number
set mouse=a                     " Allow use the mouse in Vim
set numberwidth=1               " Set the width on number lines
set clipboard=unnamed
set clipboard=unnamedplus
syntax enable                   " Enable the syntax for languages programming
set showcmd
set ruler
set encoding=utf-8              " Encoding of text UTF-8
set backspace=indent,eol,start  " Enable backspace key to do everything
set showmatch
set tabstop=4		            " Show existing tab with 4 spaces width
set shiftwidth=4	            " When indenting with '>', use 4 spaces width
set expandtab		            " On pressing tab, insert 4 spaces
set laststatus=2

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" --------------------------------------------------------------------------------------------------------
" Plugin manager
" --------------------------------------------------------------------------------------------------------
call plug#begin('~/.vim/plugged')

"Status bar Vim
Plug 'maximbaz/lightline-ale'
Plug 'itchyny/lightline.vim'

" Themes
Plug 'morhetz/gruvbox'
Plug 'shinchu/lightline-gruvbox.vim'

" Syntaxs format
Plug 'ntpeters/vim-better-whitespace'

" Lookand behavior like an IDE
Plug 'scrooloose/nerdtree'					                " Show tree of project directory
Plug 'christoomey/vim-tmux-navigator'				        " Navigate between files
Plug 'vim-syntastic/syntastic'                              " Indicate errors and warning
Plug 'tabnine/YouCompleteMe'                                " Install Tabnine for autocompletion with AI
"Plug 'jiangmiao/auto-pairs' 					            " Always close brackets, braces, curly brackets
"Plug 'https://github.com/xavierd/clang_complete.git'		" Auto-complete for C/C++
"Plug 'github/copilot.vim', {'branch': 'release'}           " Install copilot to use auto-complete

call plug#end()

" Configuration for gruvbox
" Colorscheme gruvbox
set background=dark
let g:gruvbox_contrast_dark = "hard"

" Configuration for vim-better-whitespace
let g:better_whitespace_ctermcolor='red'
let g:better_whitespace_guicolor='#990000'
let g:better_whitespace_enabled=1

" Configure syntactic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_c_checkers= ["gcc"]
let g:syntastic_cpp_checkers= ["gcc"]

" Configure shortkey
let mapleader=" "
map <Leader>nt :NERDTreeFind<CR>
map <Leader>w  :w<CR>
map <Leader>q  :q<CR>
map <Leader>wq :wq<CR>
