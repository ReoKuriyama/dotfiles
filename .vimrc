set encoding=utf-8
" Color

autocmd ColorScheme * highlight Normal ctermbg=none
autocmd ColorScheme * highlight LineNr ctermbg=none

syntax enable
set t_Co=256
colorscheme molokai

highlight Normal ctermbg=NONE
highlight LineNr ctermfg=244
highlight Visual ctermbg=248

hi TabLineFill ctermfg=16
hi TabLine ctermfg=251 ctermbg=16 cterm=none
hi TabLineSel cterm=underline ctermbg=17 ctermfg=white
hi VertSplit ctermfg=16 ctermbg=16   cterm=none

hi StatusLine ctermfg=17
hi StatusLineNC ctermfg=235 ctermbg=251

hi CursorLineNr term=bold   cterm=NONE ctermfg=white ctermbg=NONE

hi Comment ctermfg=241
highlight EndOfBuffer ctermfg=black ctermbg=black

" for performance
set re=1
set nocursorline
set norelativenumber
set nocursorcolumn
set guicursor=
" set synmaxcol=180
" syntax sync minlines=100 maxlines=1000

" Line number
set cursorline
hi clear CursorLine

set expandtab
set tabstop=2
set shiftwidth=2

set noswapfile
set wildmenu wildmode=list:full
set incsearch
set clipboard+=unnamed

if has('persistent_undo')
  set undodir=~/.vim/undo
  set undofile
endif

set backspace=indent,eol,start

function! CopyPath()
  let @*=expand('%:P')
endfunction

function! CopyFullPath()
  let @*=expand('%:p')
endfunction

command! CopyPath     call CopyPath()
command! CopyFullPath     call CopyFullPath()

nnoremap <silent>cp :CopyPath<CR>
nnoremap <silent>cfp :CopyFullPath<CR>

""""""""""""""""""""""""""""""
" Plugin
""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')

Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
let g:go_bin_path = $GOPATH.'/bin'
filetype plugin indent on

"Plug 'itchyny/lightline.vim'
" File Open
Plug 'Shougo/unite.vim'
" Unite.vimで最近使ったファイルを表示できるようにする
Plug 'Shougo/neomru.vim'
" grep
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
" tree
Plug 'scrooloose/nerdtree'
" Rails向けのコマンドを提供する
Plug 'tpope/vim-rails'
" リアルタイムlint
Plug 'w0rp/ale'

Plug 'kamykn/spelunker.vim'
" コメントアウト "
Plug 'scrooloose/nerdcommenter'
Plug 'kana/vim-submode'

Plug 'tpope/vim-endwise'

Plug 'terryma/vim-multiple-cursors'
Plug 'slim-template/vim-slim'
Plug 'thinca/vim-ref'

Plug 'kchmck/vim-coffee-script'
Plug 'tpope/vim-fugitive'

Plug 'tpope/vim-surround'

Plug 'airblade/vim-gitgutter'

Plug 'pangloss/vim-javascript'
Plug 'tpope/vim-fugitive'
Plug 'leafgarland/typescript-vim'

Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'

let g:deoplete#enable_at_startup = 1

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
let g:unite_enable_start_insert=1
" バッファ一覧
noremap <C-P> :Unite buffer<CR>
" ファイル一覧
noremap <C-H> :Unite -buffer-name=file file<CR>

" 最近使ったファイルの一覧
noremap <C-Z> :Unite file_mru<CR>
" grep検索
nnoremap <silent> ,g  :Unite grep<CR>
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
noremap cn :Unite file/new<CR>

" 大文字小文字を区別しない
let g:unite_enable_ignore_case = 1
let g:unite_enable_smart_case = 1

" grep検索
nnoremap <silent> ,g  :<C-u>Unite grep:. -buffer-name=search-buffer<CR>

" カーソル位置の単語をgrep検索
nnoremap <silent> ,cg :<C-u>Unite grep:. -buffer-name=search-buffer<CR><C-R><C-W>

" grep検索結果の再呼出
nnoremap <silent> ,r  :<C-u>UniteResume search-buffer<CR>

" unite grep に ag(The Silver Searcher) を使う
if executable('ag')
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
  let g:unite_source_grep_recursive_opt = ''
endif
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
  set statusline+=%m    " %m 修正フラグ
  set statusline+=%r    " %r 読み込み専用フラグ
  set statusline+=%h    " %h ヘルプバッファフラグ
  set statusline+=%w    " %w プレビューウィンドウフラグ
  set statusline+=\     " 空白スペース
  set statusline+=%f    " ファイル名のみ
  set statusline+=%=    " 左寄せ項目と右寄せ項目の区切り

let g:ale_linters = {
      \ 'ruby': ['rubocop'],
      \ 'go': ['golint'],
      \ 'scss': ['stylelint'],
      \ 'javascript': ['eslint'],
      \ 'slim': ['slim_lint']
      \ }

let g:ale_fixers = {
      \ 'ruby': ['rubocop'],
      \ 'go': ['golint'],
      \ 'scss': ['stylelint'],
      \ 'javascript': ['eslint'],
      \ 'typescript': ['tslint']
      \ }

let g:ale_sign_error = '!'
let g:ale_sign_warning = '?'
let g:ale_ruby_rubocop_executable = 'bundle'
let g:ale_fix_on_save = 0
highlight ALEWarning ctermbg=88
nnoremap <C-F> :ALEFix<CR>

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
nnoremap tl :tabm +1<CR>
nnoremap tj :tabm -1<CR>
nnoremap sr <C-w>r
nnoremap s= <C-w>=
nnoremap sw <C-w>w
nnoremap so <C-w>_<C-w>
nnoremap sO <C-w>=
nnoremap sN :<C-u>bn<CR>
nnoremap sP :<C-u>bp<CR>
nnoremap st :<C-u>tabnew<CR>:e Gemfile<CR>
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

nnoremap <C-]> g<C-]>
"ファイル前後移動
noremap fj <C-^>

"esc"
inoremap jj <esc>
vnoremap jl <esc>

"移動キー"
noremap i k
noremap j h
noremap k j
noremap aj ^
noremap al $
noremap <Space>l w
noremap <Space>j b
noremap <C-i> 50k
noremap <C-k> 50j

"変更履歴"
nnoremap gj g;
nnoremap gl g,

"move to insert mode"
noremap h i
noremap oo <Esc>$a
inoremap oo <Esc>$a

"置換
nnoremap <C-d> :%s///g
"単語選択
vnoremap h iw
noremap ff viw
noremap ffh ciw<C-r>0<ESC>

" 全体コピー
nnoremap  <C-a>  ggV G

" 予測
inoremap nn <C-p>
inoremap <expr> <C-k> pumvisible() ? "\<C-n>" : "\<C-k>"
inoremap <expr> <C-i> pumvisible() ? "\<C-p>" : "\<C-i>"

nnoremap  <C-n> :set number<CR>

"空行挿入"
nnoremap 0 :<C-u>call append(expand('.'), '')<Cr>j

noremap ee :e!<CR>
"save"
inoremap qq <esc>:w<CR>
noremap qq :w<CR>

nnoremap rr :source ~/.vimrc<CR>

nnoremap vim :e ~/.vimrc<CR>
nnoremap gem :e Gemfile<CR>
