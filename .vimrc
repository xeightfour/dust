syn on

color habamax

set noshowcmd

set virtualedit=all
set foldmethod=marker

set tabstop=4
set shiftwidth=4
set cinoptions=g0,(s,m1

set cursorlineopt=screenline,number
set cursorline

set numberwidth=4
set relativenumber
set number

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
