let dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(dir . '/autoload/plug.vim'))
	silent execute '!curl -fLo ' . dir . '/autoload/plug.vim --create-dirs ' .
				\  'https://raw.githubusercontent.com/junegunn/vim-plug/' .
				\  'master/plug.vim'
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

Plug 'bfrg/vim-c-cpp-modern'
Plug 'jasonccox/vim-wayland-clipboard'

call plug#end()

filetype plugin on
syn on

set termguicolors
color sorbet

set showcmd

set virtualedit=all
set foldmethod=marker

filetype indent on
set smartindent

set scrolloff=4
set sidescrolloff=4

set splitbelow
set splitright

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

set incsearch
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

nnoremap <space>s :set spell!<cr>
nnoremap <space><space> :nohlsearch<cr>
nnoremap <space>tr :silent! %s/\s\+$//<cr> :nohlsearch<cr>

nnoremap j gj
vnoremap j gj
nnoremap k gk
vnoremap k gk

tnoremap <esc> <c-\><c-n>
