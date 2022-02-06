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
"
"
" For Universal-ctags
" Install packaages necessary to build project
" sudo apt install gcc make pkg-config autoconf automake python3-docutils libseccomp-dev libjansson-dev libyaml-dev libxml2-dev
"
" When you add the plugging with Plug run the following command before to build the proyect
"
" :source %
" :PlugInstall
"
" Then build the proyect with
" cd .vim/plugged/ctags
" ./autogen.sh
" ./configure --prefix=/where/you/want # defaults to /usr/local
" make
" make install # may require extra privileges depending on where to install

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
set laststatus=2                " Always show the status line on bottom
set noshowmode                  " Not show the vim mode
set hlsearch                    " Highlight active when search

" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

" --------------------------------------------------------------------------------------------------------
" Plugin manager
" --------------------------------------------------------------------------------------------------------
call plug#begin('~/.vim/plugged')

"Status bar Vim
"Plug 'maximbaz/lightline-ale'
Plug 'itchyny/lightline.vim'                                " Show status bar bellow
Plug 'tpope/vim-fugitive'
" Themes
Plug 'morhetz/gruvbox'
Plug 'shinchu/lightline-gruvbox.vim'

" Syntaxs format
Plug 'ntpeters/vim-better-whitespace'                       " Paint red when there are spaces or tabs the rest

" Git view
Plug 'APZelos/blamer.nvim'                                  " Show the data commit, commiter, and comment of commit

" Lookand behavior like an IDE
Plug 'scrooloose/nerdtree'					                " Show tree of project directory
Plug 'christoomey/vim-tmux-navigator'			            " Navigate between f iles
Plug 'universal-ctags/ctags'                                " ctags pluggin
Plug 'preservim/tagbar'                                     " show definition on right side windows of vim
" Plug 'vim-syntastic/syntastic'                            " Indicate errors and warning
Plug 'tabnine/YouCompleteMe'                                " Install Tabnine for autocompletion with AI
"Plug 'github/copilot.vim', {'branch': 'release'}           " Install copilot to use auto-complete

call plug#end()

" Configuration for lightline
let g:lightline = {
            \ 'colorscheme': 'wombat',
            \ 'active': {
            \   'left': [ [ 'mode', 'paste' ],
            \             ['gitbranch', 'filename'] ]
            \ },
            \ 'component_function': {
            \   'gitbranch': 'FugitiveHead'
            \ },
            \ }

" Configuration for gruvbox
colorscheme gruvbox
set background=dark
let g:gruvbox_contrast_dark = "hard"

" Configuration for vim-better-whitespace
let g:better_whitespace_ctermcolor='red'
let g:better_whitespace_guicolor='#990000'
let g:better_whitespace_enabled=1

" Configure Blamer
let g:blamer_enabled = 1
let g:blamer_delay = 1000
let g:blamer_show_in_visual_mode = 0
let g:blamer_show_in_insert_mode = 0
let g:blamer_date_format = '%d/%m/%y'

" Configure NERDTree
let NERDTreeWinSize = 31                                    " Set panel width to 31 columns
autocmd VimEnter * NERDTree "| wincmd p                      Start NERDTree when opening vim and put the cursor back in the other window.

" Configure ctags
function CreateTags()
    let directory = g:NERDTreeFileNode.GetSelected().path.isDirectory ? g:NERDTreeFileNode.GetSelected().path.str() : g:NERDTreeFileNode.GetSelected().parent.path.str()
    let result1 = system("rm -rf $HOME/.vim/tags")
    let cmd = '$HOME/.vim/plugged/ctags/bin/ctags -R -f $HOME/.vim/tags "' . directory . '"'
    let result2 = system(cmd)
endfunction

function! DelTagOfFile(file)
  let fullpath = a:file
  let cwd = getcwd()
  let tagfilename = "$HOME/.vim/tags"
  let f = substitute(fullpath, cwd . "/", "", "")
  let f = escape(f, './')
  let cmd = 'sed -i "/' . f . '/d" "' . tagfilename . '"'
  let resp = system(cmd)
endfunction

function UpdateTags()
  let file = expand("%:p")
  let cmd = '$HOME/.vim/plugged/ctags/bin/ctags -a -f $HOME/.vim/tags "' . file . '"'
  call DelTagOfFile(file)
  let result = system(cmd)
endfunction

set tags=$HOME/.vim/tags,tags;
autocmd VimEnter * call CreateTags()
autocmd BufWritePost *.cpp,*.hpp,*.c,*.h call UpdateTags()

" Configure tagbar
let g:tagbar_ctags_bin = '$HOME/.vim/plugged/ctags/bin/ctags'
let g:tagbar_width = 35                                 " Set width of windows
autocmd VimEnter * Tagbar                               " Start Tagbar when opening vim

" Configure syntactic
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0
" let g:syntastic_c_checkers= ["gcc"]
" let g:syntastic_cpp_checkers= ["gcc"]

" Configure shortkey
let mapleader=" "
map <Leader>nt :NERDTreeToggle<CR>
map <Leader>ct :ctags -R .<CR>
map <Leader>w  :w<CR>
map <Leader>q  :q<CR>
map <Leader>wq :wq<CR>
