"---------------------------------
" 参照：https://gatito.hateblo.jp/entry/top/neovim/init.vim
"[start]   Neko 基本的な設定
"---------------------------------

""------------------------------------------------------------------------
" ウインドウの設定
"------------------------------------------------------------------------
set guicursor=a:blinkon0    " カーソルの点滅なし
set termguicolors
set linespace=1             " 行間隔
set encoding=UTF-8
set encoding=utf-8
set fileencodings=iso-2022-jp,euc-jp,sjis,utf-8
set fileformats=unix,dos,mac

"set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Plus\ Nerd\ File\ Types\ 11
"set columns=180            " ウインドウ幅
"set lines=57               " ウインドウ高
"set cmdheight=2            " コマンドライン幅
"if has("gui")
"    winpos  200  10        " ウインドウ位置
"endif
"set guioptions-=T          " ツールバー消去
"set guioptions-=m          " メニューバー非表示
"set display=lastline       " 長い行を省略せずに表示する
"set pumheight=10           " 補完リストの高さ
set number
set laststatus=2            " Powerline のため
"set notitle                " タイトルなし
"set shortmess+=I           " タイトルなし

"------------------------------------------------------------------------
" 編集に関する設定
"------------------------------------------------------------------------
" set cursorline                          " 行に下線を表示
set cursorline
"highlight CursorLine cterm=none ctermbg=darkblue
"highlight cursorLine term=reverse ctermfg=Blue
"highlight cursorline term=reverse cterm=reverse
set ambiwidth=double                    " 2バイト文字でカーソル位置がずれる問題の対策
set iminsert=0 imsearch=0               " 挿入モード・検索モードでのデフォルトのIME状態設定
set expandtab                           " タブ入力時に自動的にスペースに変える
set tabstop=4                           " 1タブの幅
set softtabstop=4                       " 1タブ当たりの半角スペースの個数 (通常入力時)
set shiftwidth=4                        " 1タブ当たりの半角スペースの個数 (コマンドや自動インデント)
"set clipboard=unnamed                  " xterm への S-Insert でのペーストOKだが、firefox にペーストできない (ginit.vim あり)
"set clipboard+=unnamed                 " 同上
"set clipboard=unnamedplus              " firefox などに S-Insert でペーストできるが, xterm へのペーストができない (ginit.vim あり)
set clipboard=unnamed,unnamedplus       " firefox, xterm への S-Insert でのペーストが出来た (ginit.vim あり)

set autoindent                          " 自動的にインデントする (noautoindent:インデントしない)
set backspace=indent,eol,start          " バックスペースでインデントや改行を削除できるようにする
set showmatch matchtime=1               " 入力時対応する括弧に飛ぶ。表示時間 ＝ 0.1 * matchtime (秒)
set autoindent                          " 自動的にインデントする (noautoindent:インデントしない)
set backspace=indent,eol,start          " バックスペースでインデントや改行を削除できるようにする
set showmatch matchtime=1               " 入力時対応する括弧に飛ぶ。表示時間 ＝ 0.1 * matchtime (秒)
set wildmenu                            " コマンドライン補完するときに強化されたものを使う(参照 :help wildmenu)
set nobackup                            " バックアップファイルを作成しない
"set noundofile                          " undoファイル (*.un~) を作成しない
set undodir=$HOME/.config/nvim/undo
nnoremap Y y$                           " Y を y$ と同じにする。(ノーマルモード・再割り当て無し) 
set scrolloff=5                         " スクロールする時に下が見えるようにする
set wildmenu                            " コマンドライン補完するときに強化されたものを使う
" , の後に自動的にスペースを入れる
" inoremap , ,<Space>
" 文字が無い部分でも矩形選択を可能にする
set virtualedit=block

augroup grlcd                           "ファイルを開くと、ファイルがあるディレクトリに移動する
    autocmd!
    autocmd BufEnter * lcd %:p:h
augroup END

if 1    " 4-6. yank した文字列とカーソル位置の単語を置換する
    nnoremap    <silent> cy   ce<C-r>0<ESC>:let@=/=@1<CR>:noh<CR>
    vnoremap    <silent> cy   ce<C-r>0<ESC>:let@=/=@1<CR>:noh<CR>
    nnoremap    <silent> ciy  ciw<C-r>0<ESC>:let@=/=@1<CR>:noh<CR>
endif

"------------------------------------------------------------------------
" 検索に関する設定
"------------------------------------------------------------------------
set incsearch                               " 一致したもの全てハイライトする
" 4-16. Esc 2回でハイライトを消す
nnoremap <ESC><ESC> :nohlsearch<CR>
"set ignorecase                             " 検索時に大文字小文字を無視 (noignorecase:無視しない)
set smartcase                               " 大文字小文字の両方が含まれている場合は大文字小文字を区別
set wrapscan                                " 検索時にファイルの最後まで行ったら最初に戻る (nowrapscan:戻らない)
" 検索した後に移動しない
nnoremap * *N
nnoremap # #N

"augroup grepopen                           " vimgrep 実行後に自動的に copen して QuickFix ウインドウを開く。
"    autocmd!
"    autocmd QuickfixCmdPost vimgrep cw
"augroup END


if &compatible
  set nocompatible
endif

" dein.vimインストール時に指定したディレクトリをセット
let s:dein_dir = expand('~/.cache/dein')

" dein.vimの実体があるディレクトリをセット
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" dein.vimが存在していない場合はgithubからclone
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " dein.toml, dein_layz.tomlファイルのディレクトリをセット
  let s:toml_dir = expand('~/.config/nvim')

  " 起動時に読み込むプラグイン群
  call dein#load_toml(s:toml_dir . '/dein.toml', {'lazy': 0})

  " 遅延読み込みしたいプラグイン群
  call dein#load_toml(s:toml_dir . '/dein_lazy.toml', {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
" syntax enable
syntax on

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

