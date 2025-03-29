let dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(dir . '/autoload/plug.vim'))
	silent execute '!curl -fLo ' . dir . '/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

Plug 'bfrg/vim-c-cpp-modern'

call plug#end()

autocmd BufNewFile,BufRead *.mac set filetype=maxima

filetype plugin on
syn on

set notermguicolors
color sorbet

set showcmd

set virtualedit=all
set foldmethod=marker

filetype indent on
set autoindent
set smartindent

set tabstop=4
set shiftwidth=4
set cinoptions=g0,(s,us,U1,ks,m1
set noexpandtab

set cursorlineopt=screenline,number
set cursorline
set colorcolumn=80

set numberwidth=4
set relativenumber
set number

set hlsearch
set ignorecase
set smartcase

set listchars=tab:│\ \ ,trail:·
set list

nnoremap <space>l :source $MYVIMRC<cr>
nnoremap <space>v :tabnew $MYVIMRC<cr>

nnoremap <space>w :w!<cr>
nnoremap <space>Q :q!<cr>
nnoremap <space>x :x!<cr>

nnoremap <c-j> <c-w>j
nnoremap <c-l> <c-w>l
nnoremap <c-h> <c-w>h
nnoremap <c-k> <c-w>k

nnoremap H :tabprev<cr>
nnoremap L :tabnext<cr>

nnoremap <space><space> :nohlsearch<cr>
nnoremap <space>tr :silent! %s/\s\+$//<cr> :nohlsearch<cr>

nnoremap j gj
vnoremap j gj
nnoremap k gk
vnoremap k gk

nnoremap B ^
vnoremap B ^
nnoremap E $
vnoremap E $

nnoremap <esc> <nop>
tnoremap <esc> <c-\><c-n>
