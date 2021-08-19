"base
set noswapfile
" Auto reload changed files
set autoread
" Set character encoding to use in vim
set encoding=utf-8
" Let vim know what encoding we use in our terminal
set termencoding=utf-8
" Enaple jumping fot tags by '%'
packadd! matchit
"--------------------------------------
"colors
syntax on
colorscheme sublimemonokai
set termguicolors
"--------------------------------------
"добавляем нумерацию
set number 
"--------------------------------------
"tab options
" helper for indent mistake
set list listchars=tab:»·,trail:·
" Copy indent from previous line
set autoindent
" Enable smart indent. It add additional indents whe necessary
set smartindent
" Replace tabs with spaces
set expandtab
" When you hit tab at start of line, indent added according to shiftwidth value
set smarttab
" Number of spaces to use for each step of indent
set shiftwidth=2
" Number of spaces that a Tab in the file counts for
set tabstop=2
" Same but for editing operation (not sure what exactly does it means)
" but in most cases tabstop and softtabstop better be the same
set softtabstop=2
" Round indent to multiple of 'shiftwidth'.
" Indentation always be multiple of shiftwidth " Applies to  < and > command "set shiftround
set indentexpr=
"--------------------------------------
"подсветка
":nnoremap <esc> :noh<return><esc>
set hlsearch
" Add the g flag to search/replace by default                                  
set gdefault
" Ignore case in search patterns                                               
"set ignorecase
" Live search. While typing a search command, show where the pattern           
set incsearch
" Show matching brackets
set showmatch
"--------------------------------------
"copy past Ctr Shift C/V 
"apt install vim-gtk
inoremap <C-v> <ESC>"+pa
vnoremap <C-c> "+y
vnoremap <C-d> "+d
"--------------------------------------
call plug#begin('~/.vim/plugged')

"lightline, который меняет вид строки состояния при работе с файлами.
" https://github.com/itchyny/lightline.vim
Plug 'itchyny/lightline.vim'

" https://github.com/scrooloose/nerdtree

"""nerdtree
Plug 'scrooloose/nerdtree'
"icons
Plug 'ryanoasis/vim-devicons'
"git status in nerdtree
Plug 'Xuyuanp/nerdtree-git-plugin'
"---

"git
Plug 'airblade/vim-gitgutter'

"searching
Plug 'jremmen/vim-ripgrep'
Plug 'mileszs/ack.vim'
Plug 'hotoo/jsgf.vim'

"комментирование строк
Plug 'tomtom/tcomment_vim'

"syntax
" Plug 'vim-syntastic/syntastic'
"frontend
Plug 'pangloss/vim-javascript'
Plug 'othree/html5.vim'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'elzr/vim-json'
Plug 'hail2u/vim-css3-syntax'
"Highlights the matching HTML tag when the cursor
"is positioned on a tag.
Plug 'leafOfTree/vim-matchtag'

"auto import 
"npm install -g import-js
Plug 'Galooshi/vim-import-js'

"выравнивание
Plug 'prettier/vim-prettier', { 'do': 'npm install' }

"для маппинга, в частности дл 'jk'
Plug 'kana/vim-arpeggio'

Plug 'Valloric/YouCompleteMe', { 'do': './install.py --tern-completer' }

Plug 'ErichDonGubler/vim-sublime-monokai'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
call plug#end()

"--------------------------------------
"syntax
"vim-matchtag
let g:vim_matchtag_both=1
"--------------------------------------
"vim-import-js
"for import-js configuration
"https://github.com/Galooshi/import-js#configuration
"
"commands
" :ImportJSWord Import the module for the variable under the cursor.
" :ImportJSFix  Import any missing modules and remove any modules that are not used.
" :ImportJSGoto Go to the module of the variable under the cursor.
map <F4> :ImportJSFix<CR>
"--------------------------------------
"NERDThee opts
"autocmd vimenter * NERDTree "запуск при старте
map <F2> :NERDTreeToggle<CR>

"--------------------------------------
"searching
" ack.vim

" Use ripgrep for searching ⚡️
" Options include:
" --vimgrep -> Needed to parse the rg response properly for ack.vim
" --type-not sql -> Avoid huge sql file dumps as it slows down the search
" --smart-case -> Search case insensitive if all lowercase pattern, Search
" case sensitively otherwise
let g:ackprg = 'rg --vimgrep --type-not sql --smart-case'

" Auto close the Quickfix list after pressing '<enter>' on a list item
let g:ack_autoclose = 1

" Any empty ack search will search for the work the cursor is on
let g:ack_use_cword_for_empty_search = 1

" Don't jump to first match
cnoreabbrev Ack Ack!

" Maps <leader>/ so we're ready to type the search keyword
nnoremap <Leader>g :Ack!<Space>

" Navigate quickfix list with ease
" nnoremap <silent> [q :cprevious<CR>
" nnoremap <silent> ]q :cnext<CR>
nnoremap <silent> K :cprevious<CR>
nnoremap <silent> J :cnext<CR>

"--------------------------------------
" jsgf
set autochdir
"--------------------------------------
"vim-airline-themes
let g:airline_theme='powerlineish'
" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
"--------------------------------------
"vim-gitgutter
function! GitStatus()
  let [a,m,r] = GitGutterGetHunkSummary()
  return printf('+%d ~%d -%d', a, m, r)
endfunction
set statusline+=%{GitStatus()}
"--------------------------------------
"Prettier opts
nmap <F3> <Plug>(PrettierAsync)
" Enable auto formatting of files that have "@format" or "@prettier" tag
let g:prettier#autoformat = 1
" Allow auto formatting for files without "@format" or "@prettier" tag
let g:prettier#autoformat_require_pragma = 0
"--------------------------------------
" Arpeggio

" Map jk to escape
call arpeggio#map('i', '', 0, 'jk', '<ESC>')

"--------------------------------------
" "Start autocompletion after 4 chars
" let g:ycm_min_num_of_chars_for_completion = 4
" let g:ycm_min_num_identifier_candidate_chars = 4
" let g:ycm_enable_diagnostic_highlighting = 0
" " Don't show YCM's preview window [ I find it really annoying ]
" set completeopt-=preview
" let g:ycm_add_preview_to_completeopt = 0

if !exists("g:ycm_semantic_triggers")
  let g:ycm_semantic_triggers = {}
endif
let g:ycm_semantic_triggers['typescript'] = ['.']

"Autocmd

" It executes specific command when specific events occured
" like reading or writing file, or open or close buffer
if has("autocmd")
  " Define group of commands,
  " Commands defined in .vimrc don't bind twice if .vimrc will reload
  augroup vimrc
    " Delete any previously defined autocommands
    au!
    " Auto reload vim after your change it
    au BufWritePost *.vim source $MYVIMRC | AirlineRefresh
    au BufWritePost .vimrc source $MYVIMRC | AirlineRefresh

    " Restore cursor position :help last-position-jump
    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
          \| exe "normal g'\"" | endif

    " Set filetypes aliases
    au FileType htmldjango set ft=html.htmldjango
    au FileType scss set ft=scss.css
    au FileType less set ft=less.css
    au BufWinEnter * if line2byte(line("$") + 1) > 100000 | syntax clear | endif
    au BufRead,BufNewFile *.js set ft=javascript.javascript-jquery
    au BufRead,BufNewFile *.json set ft=json
    " Execute python \ -mjson.tool for autoformatting *.json
    au BufRead,BufNewFile *.bemhtml set ft=javascript
    au BufRead,BufNewFile *.bemtree set ft=javascript
    au BufRead,BufNewFile *.xjst set ft=javascript
    au BufRead,BufNewFile *.tt2 set ft=tt2
    au BufRead,BufNewFile *.plaintex set ft=plaintex.tex

    " Auto close preview window, it uses with tags,
    " I don't use it
    autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
    autocmd InsertLeave * if pumvisible() == 0|pclose|endif

    " Enable omni completion.
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType typescript setlocal omnifunc=typescriptcomlete#CompleteTS

    "NERDThee
    " Disable vertical line at max string length in NERDTree
    autocmd FileType * setlocal colorcolumn=+1
    autocmd FileType nerdtree setlocal colorcolumn=""
    "Change the default arrows
    let g:NERDTreeDirArrowExpandable = '▸'
    let g:NERDTreeDirArrowCollapsible = '▾'

    " Exit Vim if NERDTree is the only window remaining in the only tab.
    autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
    " Close the tab if NERDTree is the only window remaining in it.
    autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

    " au FileType javascript* call JavaScriptFold()

  endif
  " Group end
augroup END
