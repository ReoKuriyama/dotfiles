set encoding=utf-8
" Color

autocmd ColorScheme * highlight Normal ctermbg=none
autocmd ColorScheme * highlight LineNr ctermbg=none

syntax enable
set t_Co=256
colorscheme molokai

highlight Normal ctermbg=NONE
highlight LineNr ctermfg=244

hi TabLineFill ctermfg=16
hi TabLine ctermfg=251 ctermbg=235 cterm=none
hi TabLineSel cterm=underline ctermbg=17 ctermfg=white
hi VertSplit ctermfg=16 ctermbg=16   cterm=none

hi StatusLine ctermfg=17
hi StatusLineNC ctermfg=256 ctermbg=251

" for performance
set re=1
set nocursorline
set norelativenumber
set nocursorcolumn
set guicursor=
" set synmaxcol=180
" syntax sync minlines=100 maxlines=1000

" Line number
set number

set expandtab
set tabstop=2
set shiftwidth=2

set incsearch
set clipboard+=unnamed

set backspace=indent,eol,start

function! CopyPath()
  let @*=expand('%')
endfunction

command! CopyPath     call CopyPath()

nnoremap <silent>cp :CopyPath<CR>

""""""""""""""""""""""""""""""
" Plugin
""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')

"Plug 'itchyny/lightline.vim'
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
Plug 'kana/vim-submode'

Plug 'terryma/vim-multiple-cursors'
Plug 'slim-template/vim-slim'
Plug 'thinca/vim-ref'

Plug 'kchmck/vim-coffee-script'
Plug 'tpope/vim-fugitive'

call plug#end()
""""""""""""""""""""""""""""""

set laststatus=2

""""""""""""""""""""""""""""""
" LightLine
""""""""""""""""""""""""""""""
let g:lightline = {
      \ 'colorscheme': 'powerline',
      \ 'mode_map': {'c': 'NORMAL'},
      \ 'active': {
      \   'left': [ ['mode', 'paste'], ['fugitive', 'filename', 'currenttag'] ],
      \   'right': [ [ 'lineinfo',  'syntastic' ],
      \              [ 'percent' ],
      \              [ 'fileformat', 'fileencoding', 'filetype' ] ]
      \ }
    \ }

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

autocmd FileType unite nnoremap <buffer> i k
autocmd FileType unite noremap <buffer> j h
autocmd FileType unite noremap <buffer> k j
""""""""""""""""""""""""""""""

" NERDTreeToggle"
nnoremap <silent><C-e> :NERDTreeToggle<CR>
autocmd FileType nerdtree nnoremap <buffer> i k
hi Directory guifg=#FF0000 ctermfg=249

" NERDTress File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
 exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
 exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

call NERDTreeHighlightFile('py',     'yellow',  'none', 'yellow',  '#151515')
call NERDTreeHighlightFile('md',     'blue',    'none', '#3366FF', '#151515')
call NERDTreeHighlightFile('yml',    'yellow',  'none', 'yellow',  '#151515')
call NERDTreeHighlightFile('config', 'yellow',  'none', 'yellow',  '#151515')
call NERDTreeHighlightFile('conf',   'yellow',  'none', 'yellow',  '#151515')
call NERDTreeHighlightFile('html',   'yellow',  'none', 'yellow',  '#151515')
call NERDTreeHighlightFile('css',    'cyan',    'none', 'cyan',    '#151515')
call NERDTreeHighlightFile('rb',     'Red',     'none', 'red',     '#151515')
call NERDTreeHighlightFile('js',     'lightgreen',   'none', '#CCFFCC', '#CCFFCC')

" ステータスラインの表示
  set statusline=%<     " 行が長すぎるときに切り詰める位置
  set statusline+=[%n]  " バッファ番号
  set statusline+=%m    " %m 修正フラグ
  set statusline+=%r    " %r 読み込み専用フラグ
  set statusline+=%h    " %h ヘルプバッファフラグ
  set statusline+=%w    " %w プレビューウィンドウフラグ
  set statusline+=\     " 空白スペース
  set statusline+=%f    " ファイル名のみ
  set statusline+=%=    " 左寄せ項目と右寄せ項目の区切り
  set statusline+=%{fugitive#statusline()}  " Gitのブランチ名を表示
  set statusline+=\ \   " 空白スペース2個
  set statusline+=%1l   " 何行目にカーソルがあるか
  set statusline+=/
  set statusline+=%L    " バッファ内の総行数
  set statusline+=,
  set statusline+=%c    " 何列目にカーソルがあるか
  set statusline+=%V    " 画面上の何列目にカーソルがあるか

let g:ref_refe_cmd = $HOME.'/.rbenv/shims/refe' "refeコマンドのパス

"insertmode時のキーマップ"
inoremap s s
inoremap ss ss

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
nnoremap <C-l> gt
nnoremap <C-j> gT
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

call submode#enter_with('bufmove', 'n', '', 's>', '<C-w>>')
call submode#enter_with('bufmove', 'n', '', 's<', '<C-w><')
call submode#enter_with('bufmove', 'n', '', 's+', '<C-w>+')
call submode#enter_with('bufmove', 'n', '', 's-', '<C-w>-')
call submode#map('bufmove', 'n', '', '>', '<C-w>>')
call submode#map('bufmove', 'n', '', '<', '<C-w><')
call submode#map('bufmove', 'n', '', '+', '<C-w>+')
call submode#map('bufmove', 'n', '', '-', '<C-w>-')
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
noremap aj ^
noremap al $
noremap <C-i> 50k
noremap <C-k> 50j

"insert mode"
noremap oo a
noremap h i

"挿入"
nnoremap 0 :<C-u>call append(expand('.'), '')<Cr>j

"save"
inoremap qq <esc>:w<CR>
noremap qq :w<CR>
