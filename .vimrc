" Author: Slevin Zhang <slevinz@outlook.com>
" Source: https://github.com/LiyinZ/vimrc
" Inspired By: 'AssailantLF/vimrc', 'thoughtbot/dotfiles', /r/vim


" ===========================================================================
" VIM-PLUG {{{
" ===========================================================================
" (minimalist plugin manager)

call plug#begin()

" *PRIMARY PLUGINS*
Plug 'tpope/vim-sensible'           " one step above 'nocompatible' mode
Plug 'tpope/vim-surround'           " surroundings manipulation
Plug 'tpope/vim-commentary'         " easier commenting
Plug 'scrooloose/Syntastic'         " real time error checking
Plug 'ctrlpvim/ctrlp.vim'               " fuzzy file/buffer search
Plug 'FelikZ/ctrlp-py-matcher'      " Faster ctrl p matcher with Python
" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'junegunn/vim-easy-align'      " text alignment plugin
Plug 'junegunn/goyo.vim'            " distraction free text editing
Plug 'tommcdo/vim-exchange'         " easy text exchange for vim
Plug 'ervandew/supertab'            " tab auto completion
if has('python') || has('python3')
  Plug 'SirVer/UltiSnips'           " snippet plugin
  Plug 'honza/vim-snippets'         " preconfigured snippet package
endif
Plug 'rstacruz/sparkup', {'rtp': 'vim/'} " simpler emmet
Plug 'terryma/vim-multiple-cursors' " multiple cursor
Plug 'Raimondi/delimitMate'         " closing brackets
Plug 'lfilho/cosco.vim'             " smart comma, semicolon
Plug 'justinmk/vim-sneak'           " slim easy motion
" Plug 'Valloric/YouCompleteMe'       " code completion engine
" Plug 'wellle/targets.vim'           " new and improved text objects
Plug 'tpope/vim-fugitive'           " Git integration
" Plug 'tpope/vim-unimpaired'         " many helpful mappings

" *SYNTAX PLUGINS*
" Plug 'plasticboy/vim-markdown'      " markdown
Plug 'digitaltoad/vim-jade'         " jade template
Plug 'wavded/vim-stylus'            " stylus syntax
Plug 'jelera/vim-javascript-syntax' " Enhanced JS

" *AESTHETIC PLUGINS*
Plug 'kristijanhusak/vim-hybrid-material' " material theme
Plug 'itchyny/lightline.vim'        " better looking UI
Plug 'Yggdroot/indentLine'          " shows indents made of spaces

call plug#end()



" }}}
" ===========================================================================
"  GENERAL SETTINGS {{{
" ===========================================================================

set nobackup
set nowritebackup
set noswapfile
set autoread         " auto reload changed files
set autowrite     " Automatically :write before running commands
set synmaxcol=400    " don't highlight past 400 characters
set ignorecase       " search isn't case sensitive
set lazyredraw       " redraw the screen less often

set number
set numberwidth=5

set splitbelow  " Open new split panes to right and bottom,
set splitright  "  which feels more natural
set diffopt+=vertical " Always use vertical diffs


" }}}
" ===========================================================================
"  APPEARANCE/AESTHETIC {{{
" ===========================================================================

set guioptions=  " remove extra gui elements
set t_Co=256     " 256 colors, please

" fallback default colorscheme
colorscheme default
" colorscheme of choice
silent! colorscheme hybrid_reverse

" highlight cursor line on active window
augroup CursorLine
au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END


" }}}
" ===========================================================================
" TEXT AND FORMATTING {{{
" ===========================================================================

set tabstop=2       " Softtabs, 2 spaces
set shiftwidth=2
set shiftround
set expandtab

set textwidth=80    " Make it obvious where 80 characters is
set colorcolumn=+1

" indent/format settings for different file types
augroup filetype_specific
  au!
  au FileType vim  :setlocal ts=2 sts=0 sw=2 et fdm=marker fdl=0
augroup END

" last knwon cursor, auto markdown
" {{{
augroup vimrcEx
  autocmd!

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Set syntax highlighting for specific file types
  autocmd BufRead,BufNewFile Appraisals set filetype=ruby
  autocmd BufRead,BufNewFile *.md set filetype=markdown

  " Enable spellchecking for Markdown
  autocmd FileType markdown setlocal spell

  " Automatically wrap at 80 characters for Markdown
  autocmd BufRead,BufNewFile *.md setlocal textwidth=80

  " Automatically wrap at 72 characters and spell check git commit messages
  autocmd FileType gitcommit setlocal textwidth=72
  autocmd FileType gitcommit setlocal spell

  " Allow stylesheets to autocomplete hyphenated words
  autocmd FileType css,scss,sass setlocal iskeyword+=-

  autocmd BufWinLeave *.* mkview
  autocmd BufWinEnter *.* silent loadview
augroup END
" }}}

" }}}
" ===========================================================================
" KEY MAPPINGS + ALIASES {{{
" ===========================================================================
" anything related to plugins is located
" under its respective PLUGIN SETTINGS section

" ---------------------------------------------------------------------------
" REMAPS OF DEFAULTS {{{
" ---------------------------------------------------------------------------

" Y yanks until EOL, more like D and C
nnoremap Y y$

" U as a more sensible redo
nnoremap U <C-r>

" ctrl d toggle between shell and vim
" nnoremap <C-z> :sh<cr>

" use ctrl j for Join line
noremap <C-j> J

" [S]plit line (sister to [J]oin lines)
nnoremap <C-s> i<CR><Esc>^mwgk:silent! s/\v +$//<CR>:noh<CR>

" big J / K travel 10 lines
noremap J 10j
noremap K 10k

" Ctrl h / l for easy beginning / end of line
noremap <C-h> ^
noremap <C-l> $

" - quick go to line, Enter for EOL
noremap - gg
nnoremap <CR> G$

" qq to record, Q to replay
nnoremap Q @q

" alt x save and quit all
nnoremap ≈ :xa<CR>

" move by wrapped lines instead of line numbers
noremap j gj
noremap k gk
noremap gj j
noremap gk k

" Left right flipping pages, remap less used keys
nnoremap <Left> <C-b>
nnoremap <Right> <C-f>
nnoremap <Up> <C-u>
nnoremap <Down> <C-d>

" { and } skip over closed folds
nnoremap <expr> } foldclosed(search('^$', 'Wn')) == -1 ? "}" : "}j}"
nnoremap <expr> { foldclosed(search('^$', 'Wnb')) == -1 ? "{" : "{k{"

" jump to the end of pasted text
" useful for pasting multi-lines of text
" xnoremap p p`]
" nnoremap p p`

" }}}
" ---------------------------------------------------------------------------
" NORMAL MAPS {{{
" ---------------------------------------------------------------------------

" F9 to toggle paste mode
set pastetoggle=<F9>

" circular windows navigation
nnoremap <Tab>   <c-W>w
nnoremap <Backspace> <c-W>W

" insert current datetime
nnoremap <F5> "=strftime("%c")<CR>P
inoremap <F5> <C-R>=strftime("%c")<CR>


" }}}
" ---------------------------------------------------------------------------
" LEADER MAPS {{{
" ---------------------------------------------------------------------------

let mapleader = " "     " space leader

" Switch between the last two files
nnoremap <leader><leader> <c-^>

" write file / all files
nnoremap <Leader>w :w<CR>
nnoremap <Leader>W :wa<CR>

" open vimrc
nnoremap <Leader>v :e $MYVIMRC<CR>
nnoremap <Leader>V :tabnew $MYVIMRC<CR>

" quickly manage buffers
nnoremap <Leader>B :ls<CR>:bd!<Space>

" quick all windows
nnoremap <Leader>q :q<CR>
nnoremap <Leader>Q :qa<CR>

function! HandleURL()
  let s:uri = matchstr(getline("."), '[a-z]*:\/\/[^ >,;]*')
  echo s:uri
  if s:uri != ""
    silent exec "!open '".s:uri."'"
  else
    echo "No URI found in line."
  endif
endfunction
noremap <leader>u :call HandleURL()<cr>

" }}}
" ---------------------------------------------------------------------------
" COMMAND ALIASES {{{
" ---------------------------------------------------------------------------

" Clear Trailing White spaces
cabbrev ctw s/\s\+$//e

" delete all buffers
cabbrev bdall 0,999bd!

" }}}
" ---------------------------------------------------------------------------

" }}}
" ===========================================================================
" PLUGIN SETTINGS {{{
" ===========================================================================

" CtrlP {{{
" ignore .git folders to speed up searches
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
" include hidden files
let g:ctrlp_show_hidden = 1
" change default CtrlP mapping
let g:ctrlp_map = '<Leader>p'
" Use python matcher
let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch'  }
" specific directory search
nnoremap <Leader><C-p> :CtrlP<Space>
" access recent files and buffers
nnoremap <Leader>e :CtrlPMRUFiles<CR>
nnoremap <Leader>b :CtrlPBuffer<CR>
" }}}

" Goyo {{{
" toggle Goyo (distraction free editing)
nnoremap <Leader>G :Goyo<CR>
" }}}

" NERDTree {{{
" disable netrw use nerdtree instead
let g:loaded_netrw       = 1
let g:loaded_netrwPlugin = 1
" NERDTree Toggle shortcut
map <C-_> :NERDTreeToggle<CR><C-w>=
" Auto delete buffer
let NERDTreeAutoDeleteBuffer=1
" Auto CWD
let NERDTreeChDirMode=1
" Show hidden file by default
let NERDTreeShowHidden=1
" map key help from ? to ÷
let NERDTreeMapHelp='÷'
" so that I can use default J/K within NT
let NERDTreeMapJumpLastChild='gj'
let NERDTreeMapJumpFirstChild='gk'
" so that I can use vim-sneak within NT
let NERDTreeMapOpenVSplit='<C-v>'
" New tab to open new project
noremap <Leader>nn :NERDTree ~/
noremap <Leader>ndl :NERDTree ~/Downloads/
noremap <Leader>ndp :NERDTree ~/Dropbox/
noremap <Leader>no :NERDTree ~/Dropbox/Notes<CR>
" }}}

" vim-easy-align {{{
" Start interactive EasyAlign in visual mode (e.g. vipga)
vmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
" }}}

" indentLine {{{
nnoremap <Leader>i :IndentLinesToggle<CR>
" }}}

" Syntastic {{{
" opens errors in the location list
nnoremap <Leader>rr :Errors<CR>
" reset Syntastic (clears errors)
nnoremap <Leader>rs :SyntasticReset<CR>
" }}}

" delimitMate {{{
" auto new line space expansion
let delimitMate_expand_space=1
let delimitMate_expand_cr=1
" semicolon end 
inoremap <C-l> <C-o>A;<Esc>
" }}}

" cosco.vim {{{
" ctrl z for smart semi colons
autocmd FileType javascript,css nnoremap <silent> <C-k> :call cosco#commaOrSemiColon()<CR>
autocmd FileType javascript,css inoremap <silent> <C-k> <c-o>:call cosco#commaOrSemiColon()<CR>
" }}}

" vim-sneak {{{
" Emulate easyMotion
let g:sneak#streak=1
" let g:sneak#use_ic_scs=1
" }}}

" Fugitive {{{
nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>gd :Gdiff<cr>
nnoremap <leader>gD :Gdiff HEAD<cr>
nnoremap <leader>ga :Git add 
nnoremap <leader>gc :Gcommit<cr>
nnoremap <leader>gl :Git log -
nnoremap <leader>gp :Git push<cr>
nnoremap <leader>gw :Gwrite<cr>
nnoremap <leader>gr :Gremove<cr>
" }}}

" }}}
" ===========================================================================
" GUI ONLY {{{
" ===========================================================================
if has('gui_running')
  set relativenumber
  " More comfortable scroll
  noremap <D-j> 10jzz
  noremap <D-k> 10kzz
  " Sublime style comment
  noremap <D-/> :Commentary<CR>

  " open a NERDTree automatically when mvim starts up
  autocmd vimenter * NERDTree
endif
" }}}
" ===========================================================================
