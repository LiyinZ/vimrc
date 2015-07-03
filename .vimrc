" Author: Slevin Zhang <slevinz@outlook.com>
" Source: https://github.com/LiyinZ/vimrc
" Inspirations: 'AssailantLF/vimrc', 'thoughtbot/dotfiles', /r/vim


" ===========================================================================
" VIM-PLUG {{{
" ===========================================================================
" (minimalist plugin manager)

call plug#begin()

" *PRIMARY PLUGINS*
Plug 'tpope/vim-sensible'           " one step above 'nocompatible' mode
Plug 'tpope/vim-surround'           " surroundings manipulation
" Plug 'tpope/vim-fugitive'           " Git integration
" Plug 'tpope/vim-unimpaired'         " many helpful mappings
Plug 'tpope/vim-commentary'         " easier commenting
" Plug 'scrooloose/Syntastic'         " real time error checking
Plug 'kien/CtrlP.vim'               " fuzzy file/buffer search
" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'junegunn/vim-easy-align'      " text alignment plugin
" Plug 'junegunn/vim-github-dashboard'" browse GitHub events on vim
Plug 'junegunn/goyo.vim'            " distraction free text editing
Plug 'tommcdo/vim-exchange'         " easy text exchange for vim
" Plug 'wellle/targets.vim'           " new and improved text objects
" Plug 'ervandew/supertab'            " tab auto completion
if has('python') || has('python3')
  Plug 'SirVer/UltiSnips'           " snippet plugin
  Plug 'honza/vim-snippets'         " preconfigured snippet package
endif
Plug 'mattn/emmet-vim'              " emmet
Plug 'terryma/vim-multiple-cursors' " multiple cursor

" *SYNTAX PLUGINS*
Plug 'plasticboy/vim-markdown'      " markdown
Plug 'digitaltoad/vim-jade'         " jade template
Plug 'wavded/vim-stylus'            " stylus syntax

" *AESTHETIC PLUGINS*
Plug 'kristijanhusak/vim-hybrid-material' " material theme
Plug 'itchyny/lightline.vim'        " better looking UI
" Plug 'mhinz/vim-Startify'           " nice startup screen
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
silent! colorscheme hybrid_material

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

" K for kill window
noremap K <c-W>c

" Y yanks until EOL, more like D and C
nnoremap Y y$

" U as a more sensible redo
nnoremap U <C-r>

" ctrl d toggle between shell and vim
nnoremap <C-z> :sh<cr>

" [S]plit line (sister to [J]oin lines)
" nnoremap S i<CR><Esc>^mwgk:silent! s/\v +$//<CR>:noh<CR>

" qq to record, Q to replay
" nnoremap Q @q

" move by wrapped lines instead of line numbers
noremap j gj
noremap k gk
noremap gj j
noremap gk k

" Get off my lawn
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" { and } skip over closed folds
" nnoremap <expr> } foldclosed(search('^$', 'Wn')) == -1 ? "}" : "}j}"
" nnoremap <expr> { foldclosed(search('^$', 'Wnb')) == -1 ? "{" : "{k{"

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

" vim paste
noremap <C-p> "+p

" habits
inoremap <C-a> <Home>
cnoremap <C-a> <Home>
inoremap <C-e> <End>
cnoremap <C-e> <End>

" convenient page scrolling
nnoremap <C-j> <C-d>
nnoremap <C-k> <C-u>

" circular windows navigation
nnoremap <Tab>   <c-W>w
nnoremap <Backspace> <c-W>W


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
nnoremap <Leader>b :ls<CR>:b<Space>
nnoremap <Leader>B :ls<CR>:bd!<Space>

" quick all windows
nnoremap <Leader>Q :qa<CR>


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

" Fugitive {{{
" don't need them for now since i use ctrl d switch to shell
" }}}

" CtrlP {{{
" ignore .git folders to speed up searches
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
" include hidden files
let g:ctrlp_show_hidden = 1
" change default CtrlP mapping
let g:ctrlp_map = '<Leader>p'
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
" open a NERDTree automatically when vim starts up
autocmd vimenter * NERDTree
" open a NERDTree automatically when vim starts up if no files were specified
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" close vim if the only window left open is a NERDTree
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
" Set width
let g:NERDTreeWinSize = 40
" NERDTree Toggle shortcut
map <C-n> :NERDTreeToggle<CR>

" vim-easy-align {{{
" Start interactive EasyAlign in visual mode (e.g. vipga)
vmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
" }}}

" indentLine {{{
nnoremap <Leader>i :IndentLinesToggle<CR>
" }}}

" lightline {{{
" toggle lightline
" nnoremap <silent> <Leader>L :exec lightline#toggle()<CR>
" }}}

" Syntastic {{{
" opens errors in the location list
" nnoremap <Leader>e :Errors<CR>
" reset Syntastic (clears errors)
" nnoremap <Leader>r :SyntasticReset<CR>
" }}}

" vim-multiple-cursors {{{
let g:multi_cursor_next_key='<C-d>'
let g:multi_cursor_prev_key='<C-u>'


" }}}
" ===========================================================================
