set nocompatible
filetype plugin indent on
no <up> <Nop>
no <down> <Nop>
no <left> <Nop>
no <right> <Nop>
ino <up> <Nop>
ino <down> <Nop>
ino <left> <Nop>
ino <right> <Nop>
set matchpairs+=<:>
set ruler
set backspace=eol,start,indent
set shiftwidth=2
nmap <silent> <RIGHT>        :cnext<CR>
nmap <silent> <RIGHT><RIGHT> :cnfile<CR><C-G>
nmap <silent> <LEFT>         :cprev<CR>
nmap <silent> <LEFT><LEFT>   :cpfile<CR><C-G>
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>
nnoremap <C-p> :<C-u>FZF<CR>
syntax on
let g:netrw_liststyle = 3
set foldmethod=syntax
set number relativenumber
set background=dark
set autochdir

packadd minpac
call minpac#init()
call minpac#add('junegunn/fzf')
call minpac#add('preservim/nerdtree')
command! PackUpdate call minpac#update()
command! PackClean call minpac#clean()
