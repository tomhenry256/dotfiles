 " ----- dein setting start -----

"  let g:syntastic_shell = "/usr/local/bin/bash"

 let s:dein_dir = expand('~/dotfiles/vim/dein')
 let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
 set nocompatible
 " dein.vim をインストールしていない場合は自動インストール
 if !isdirectory(s:dein_repo_dir)
   echo "install dein.vim..."
   execute '!git clone git://github.com/Shougo/dein.vim' s:dein_repo_dir
 endif
 execute 'set runtimepath^=' . s:dein_repo_dir

 "---------------------------
 " Start dein.vim Settings.
 "---------------------------

 if dein#load_state(s:dein_dir)
   call dein#begin(s:dein_dir)

   let g:rc_dir    = expand('~/dotfiles/vim/dein')
   let s:toml      = g:rc_dir . '/dein.toml'
   let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'

   " TOMLファイルにpluginを記述
   call dein#load_toml(s:toml,      {'lazy': 0})
   call dein#load_toml(s:lazy_toml, {'lazy': 1})

   call dein#end()
   call dein#save_state()
 endif

 " 未インストールを確認
 if dein#check_install()
   call dein#install()
 endif

 "---------------------------
 " End dein.vim Settings.
 "---------------------------

 " ----- dein setting end -----

 " ----- plugins setting strat -----

 " --- ag unite.vim ---
 " insert modeで開始
 let g:unite_enable_start_insert = 1

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

 " CtrlPでも使う
 if executable('ag') " agが使える環境の場合
   let g:ctrlp_use_caching=0 " CtrlPのキャッシュを使わない
   let g:ctrlp_user_command='ag %s -i --hidden -g ""' " 「ag」の検索設定
 endif

 " --- lightline.vim ---
 set laststatus=2 " ステータスラインを常に表示
 set showmode " 現在のモードを表示
 set showcmd " 打ったコマンドをステータスラインの下に表示
 set ruler " ステータスラインの右側にカーソルの現在位置を表示する

 " -- previm ---
 let g:previm_open_cmd = 'open -a Google\ Chrome'
 augroup PrevimSettings
     autocmd!
     autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown
 augroup END

 " --- emmet vim ---
 let g:user_emmet_leader_key='<c-E>'

 " --- vim-easy-align ---
 " enterで整形設定に行くようにする
 vmap <Enter> <Plug>(EasyAlign)

 " --- vim-ref ---
 let g:ref_phpmanual_path = $HOME . '/vim-ref/php-chunked-xhtml' "マニュアルをDLしたディレクトリを指定

 " " syntax check
 " set statusline+=%#warningmsg#
 " set statusline+=%{SyntasticStatuslineFlag()}
 " set statusline+=%*

 let g:syntastic_always_populate_loc_list = 1
 let g:syntastic_auto_loc_list = 1
 let g:syntastic_check_on_open = 1
 let g:syntastic_check_on_wq = 0

 " --- neocomplete.vim ---
 " if has('lua') " lua機能が有効になっている場合・・・・・・①
 "     " コードの自動補完
 "     NeoBundle 'Shougo/neocomplete.vim'
 "     " スニペットの補完機能
 "     NeoBundle "Shougo/neosnippet"
 "     " スニペット集
 "     NeoBundle 'Shougo/neosnippet-snippets'
 " endif

 " --- CtrlP ---
 let g:ctrlp_match_window = 'order:ttb,min:20,max:20,results:100' " マッチウインドウの設定. 「下部に表示, 大きさ20行で固定, 検索結果100件」
 let g:ctrlp_show_hidden = 1 " .(ドット)から始まるファイルも検索対象にする
 " let g:ctrlp_types = ['funky'] "ファイル検索のみ使用
 " let g:ctrlp_extensions = ['funky', 'commandline'] " CtrlPの拡張として「funky」と「commandline」を使用
 " let g:ctrlp_extensions = ['line', 'funky', 'undo', 'changes'] " CtrlPの拡張として「funky」を使用
 let g:ctrlp_extensions = ['line', 'funky'] " CtrlPの拡張として「funky」を使用

 " CtrlPCommandLineの有効化
 " command! CtrlPCommandLine call ctrlp#init(ctrlp#commandline#id())

 " CtrlPFunkyの有効化
 let g:ctrlp_funky_matchtype = 'path'

 " Ctrl-pでfzfファイル検索
 " nmap <C-p> :Files<CR>

 " --- nerdtree ---
 nnoremap <silent><C-e> :NERDTreeToggle<CR>
 " autocmd vimenter * NERDTree
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
 call NERDTreeHighlightFile('json',   'yellow',  'none', 'yellow',  '#151515')
 call NERDTreeHighlightFile('html',   'yellow',  'none', 'yellow',  '#151515')
 call NERDTreeHighlightFile('styl',   'cyan',    'none', 'cyan',    '#151515')
 call NERDTreeHighlightFile('css',    'cyan',    'none', 'cyan',    '#151515')
 call NERDTreeHighlightFile('rb',     'Red',     'none', 'red',     '#151515')
 call NERDTreeHighlightFile('js',     'Red',     'none', '#ffa500', '#151515')
 call NERDTreeHighlightFile('php',    'Magenta', 'none', '#ff00ff', '#151515')
 let g:NERDTreeDirArrows = 0.5
 let g:NERDTreeDirArrowExpandable  = '>'
 let g:NERDTreeDirArrowCollapsible = '|'
 nnoremap <C-l> gt
 nnoremap <C-h> gT
 let NERDTreeWinSize=20

 " --- php doc ---
 inoremap <C-c> <ESC>:call PhpDocSingle()<CR>i
 nnoremap <C-c> :call PhpDocSingle()<CR>
 vnoremap <C-c> :call PhpDocRange()<CR>-

 " --- indent guide ---
 " let g:indent_guides_auto_colors=0
 " " vim立ち上げたときに、自動的にvim-indent-guidesをオンにする
 " let g:indent_guides_enable_on_vim_startup=1
 " " ガイドをスタートするインデントの量
 " let g:indent_guides_start_level=1
 " " 自動カラーを無効にする
 " let g:indent_guides_auto_colors=0
 " " 奇数インデントのカラー
 " autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#262626 ctermbg=gray
 " " 偶数インデントのカラー
 " autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#3c3c3c ctermbg=darkgray
 " " ハイライト色の変化の幅
 " let g:indent_guides_color_change_percent = 130
 " " ガイドの幅
 " let g:indent_guides_guide_size = 4

 " --- vim-fugitive ---
 " grep検索の実行後にQuickFix Listを表示する
 autocmd QuickFixCmdPost *grep* cwindow

 " ----- vim setting start -----

 " 初期設定
 set encoding=utf-8
 scriptencoding utf-8

 " 文字コード
 set fileencoding=utf-8 " 保存時の文字コード
 set fileencodings=ucs-boms,utf-8,euc-jp,cp932 " 読み込み時の文字コードの自動判別. 左側が優先される
 set fileformats=unix,dos,mac " 改行コードの自動判別. 左側が優先される
 set ambiwidth=double " □や○文字が崩れる問題を解決 "

 " tab indent
 set expandtab " タブ入力を複数の空白入力に置き換える
 set tabstop=4 " 画面上でタブ文字が占める幅
 set softtabstop=4 " 連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅
 set autoindent " 改行時に前の行のインデントを継続する
 set smartindent " 改行時に前の行の構文をチェックし次の行のインデントを増減する
 set shiftwidth=4 " smartindentで増減する幅 "


 " 文字列検索
 set incsearch " インクリメンタルサーチ. １文字入力毎に検索を行う
 set ignorecase " 検索パターンに大文字小文字を区別しない
 set smartcase " 検索パターンに大文字を含んでいたら大文字小文字を区別する
 set hlsearch " 検索結果をハイライト

 " ESCキー2度押しでハイライトの切り替え
 nnoremap <silent><Esc><Esc> :<C-u>set nohlsearch!<CR> "

 " カーソル関係
 set whichwrap=b,s,h,l,<,>,[,],~ " カーソルの左右移動で行末から次の行の行頭への移動が可能になる
 set number " 行番号を表示
 " set cursorline " カーソルラインをハイライト

 " 行が折り返し表示されていた場合、行単位ではなく表示行単位でカーソルを移動する
 nnoremap j gj
 nnoremap k gk
 nnoremap <down> gj
 nnoremap <up> gk

 " バックスペースキーの有効化
 set backspace=indent,eol,start "

 " 括弧,タグジャンプ
 set showmatch " 括弧の対応関係を一瞬表示する
 source $VIMRUNTIME/macros/matchit.vim " Vimの「%」を拡張する

 " コマンド補完
 set wildmenu " コマンドモードの補完
 set history=5000 " 保存するコマンド履歴の数

 " マウス有効化
 if has('mouse')
     set mouse=a
     if has('mouse_sgr')
         set ttymouse=sgr
     elseif v:version > 703 || v:version is 703 && has('patch632')
         set ttymouse=sgr
     else
         set ttymouse=xterm2
     endif
 endif

 " paste設定
 if &term =~ "xterm"
     let &t_SI .= "\e[?2004h"
     let &t_EI .= "\e[?2004l"
     let &pastetoggle = "\e[201~"

     function XTermPasteBegin(ret)
         set paste
         return a:ret
     endfunction

     inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
 endif
 " pasteモード(,iでもペーストモードへ. ノーマルに戻るとインサートに戻す)
 nnoremap ,i :<C-u>set paste<Return>i
 " クリップボード共有
 set clipboard=unnamed,autoselect
 " yankしたものを貼り付ける
 nnoremap <C-y> "0P"

 " ファイル名表示
 set title

 syntax on "color code
 set background=dark
 colorscheme solarized

 set t_Co=256 " iTerm2など既に256色環境なら無くても良い
 syntax enable


 filetype plugin indent on

 " 不可視文字表示
 set list  " 不可視文字を表示する
 set listchars=tab:>-,trail:.  " タブを >--- 半スペを . で表示する
 function! ZenkakuSpace()
     highlight ZenkakuSpace cterm=reverse ctermfg=DarkMagenta gui=reverse guifg=DarkMagenta
 endfunction
 if has('syntax')
     augroup ZenkakuSpace
         autocmd!
         autocmd ColorScheme       * call ZenkakuSpace()
         autocmd VimEnter,WinEnter * match ZenkakuSpace /　/
     augroup END
     call ZenkakuSpace()
 endif

 " insert mode hjkl delete
 imap <C-k> <Up>
 imap <C-j> <Down>
 imap <C-h> <Left>
 imap <C-l> <Right>
 imap <C-g> <backspace>

 " swap output directory
 set directory=~/dotfiles/vim/swap
 " backup output directory
 set backupdir=~/dotfiles/vim/backup

 " カーソル位置を最後に開いた場所にする
 augroup vimrcEx
   au BufRead * if line("'\"") > 0 && line("'\"") <= line("$") |
   \ exe "normal g`\"" | endif
 augroup END

 " ビープ音を消す
 set belloff=all
 " Jsonの"が消えなくなる
 set conceallevel=0
 " let g:vim_json_syntax_conceal = 0

 nnoremap <S-U> :Unite tab<CR>


 nnoremap <C-@> :FZFFileList<CR>
 command! FZFFileList call fzf#run({
             \ 'source': 'find . -type d -name .git -prune -o ! -name .DS_Store',
             \ 'sink': 'e'})

 " nnoremap tt :tab sp<CR> :exe("tjump ".expand('<cword>'))<CR>
 nnoremap tt :call TagTabJump()<CR>

 function! TagTabJump()
    let l = line(".")
    let c = col(".")
    :tabe%
    :call cursor(l,c)
    :exe "normal \<c-]>"
 endfunction

 " ----- vim setting end -----
