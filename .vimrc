" Color

autocmd ColorScheme * highlight Normal ctermbg=none
autocmd ColorScheme * highlight LineNr ctermbg=none

syntax enable
set t_Co=256
colorscheme molokai

highlight Normal ctermbg=NONE
highlight LineNr ctermfg=244

" Line number
set number

set expandtab
set tabstop=2
set shiftwidth=2

""""""""""""""""""""""""""""""
" Plugin
""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')

Plug 'itchyny/lightline.vim'
" File Open
Plug 'Shougo/unite.vim'
" Unite.vimで最近使ったファイルを表示できるようにする
Plug 'Shougo/neomru.vim'
" tree
Plug 'scrooloose/nerdtree'
" Rails向けのコマンドを提供する
Plug 'tpope/vim-rails'
" リアルタイムlint
Plug 'scrooloose/syntastic'
Plug 'w0rp/ale'
" コメントアウト "
Plug 'scrooloose/nerdcommenter'


call plug#end()
""""""""""""""""""""""""""""""

set laststatus=2 

""""""""""""""""""""""""""""""
" Unit.vimの設定
""""""""""""""""""""""""""""""
" 入力モードで開始する
let g:unite_enable_start_insert=0
" バッファ一覧
noremap <C-P> :Unite buffer<CR>
" ファイル一覧
noremap <C-N> :Unite -buffer-name=file file<CR>
" 最近使ったファイルの一覧
noremap <C-Z> :Unite file_mru<CR>
" sourcesを「今開いているファイルのディレクトリ」とする
noremap :uff :<C-u>UniteWithBufferDir file -buffer-name=file<CR>
" ウィンドウを分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
" ウィンドウを縦に分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
" ESCキーを2回押すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>

au FileType unite nnoremap <silent> <buffer> i <ESC>k<CR>
""""""""""""""""""""""""""""""

"NERDTreeToggle"
nnoremap <silent><C-e> :NERDTreeToggle<CR>


"Window keybinding"
nnoremap s <Nop>
nnoremap sk <C-w>j
nnoremap si <C-w>k
nnoremap sl <C-w>l
nnoremap sj <C-w>h
nnoremap sK <C-w>J
nnoremap sI <C-w>K
nnoremap sL <C-w>L
nnoremap sJ <C-w>H
nnoremap sn gt
nnoremap sp gT
nnoremap sr <C-w>r
nnoremap s= <C-w>=
nnoremap sw <C-w>w
nnoremap so <C-w>_<C-w>
nnoremap sO <C-w>=
nnoremap sN :<C-u>bn<CR>
nnoremap sP :<C-u>bp<CR>
nnoremap st :<C-u>tabnew<CR>
nnoremap sT :<C-u>Unite tab<CR>
nnoremap ss :<C-u>sp<CR>
nnoremap sv :<C-u>vs<CR>
nnoremap sq :<C-u>q!<CR>
nnoremap sQ :<C-u>bd<CR>
nnoremap <D-...> l

"バッファ移動"
nnoremap <silent> bp :bprevious<CR>
nnoremap <silent> bn :bnext<CR>

"esc"
inoremap jj <esc>
vnoremap jj <esc>
noremap oo a

"移動キー"
noremap i k
noremap j h
noremap k j
noremap <C-j> ^
noremap <C-l> $

"save"
noremap qq :w<CR>
