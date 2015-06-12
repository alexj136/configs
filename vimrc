" ==============================================================================
"                                ALEX'S VIMRC
" ==============================================================================

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

" ====================
" Vundle Configuration
" ====================

set nocompatible
filetype off
set runtimepath+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Vundle manages itself
Plugin 'gmarik/Vundle.vim'

" Snipmate + dependencies
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'

" Color schemes
Plugin 'flazz/vim-colorschemes'

call vundle#end()
filetype plugin indent on

" ===================
" Indentation Options
" ===================

set tabstop=4               " Set tab width to 4
set expandtab               " Always use spaces instead of tabs
set softtabstop=4           " Insert 4 spaces when tab is pressed
set shiftwidth=4            " An indent is always 4 spaces
set smarttab                " Indent instead of tab at the start of a line
set shiftround              " Round spaces to the nearest shiftwidth multiple
set nojoinspaces            " Don't convert spaces to tabs

" ===================
" Appearence Settings
" ===================

syntax on                   " Enable syntax highlighting.
set colorcolumn=81          " Enable ruler
set guioptions=a            " Disable menu bar & toolbar in gvim
set number                  " Show line numbers at launch
set showcmd                 " Show current command info in status line
set background=dark         " Use a dark background
set guifont=Inconsolata\ 11 " Use Inconsolata font at size 11

" Color schemes - if we're in gvim, or a terminal that supports 256 colors,
" use solarized. Otherwise, use the default color scheme.
if has ("gui_running")
  colorscheme solarized
elseif match ($TERM, "xterm-256color")  != -1 ||
     \ match ($TERM, "xterm")           != -1 ||
     \ match ($TERM, "screen-256color") != -1
  set t_Co=256
  colorscheme solarized
else
  colorscheme default
endif

" ================
" WildMenu Options
" ================

if has ("wildmenu")
    set wildmenu
    set wildmode=longest,list
    set wildignore+=*.o,*.hi,*.swp,*.pyc,*.class,*.aux,*.log,*.dvi
endif

" ============
" Key Bindings
" ============

" Move cursor with display lines
map j gj
map k gk

" Scroll through buffers with Ctrl+N and Ctrl+Shift+N
nnoremap <C-n> :bnext<CR>
nnoremap <C-S-n> :bprevious<CR>

" List buffers and give a prompt to change with a number by pressing F12
nnoremap <F12> :buffers<CR>:buffer 

" Disable entering ex mode with Shift+Q - I never use ex mode
nnoremap Q <nop>

" Toggle spell-check with F5
map <F5> :setlocal spell! spelllang=en_gb<CR>

" =============
" Misc Settings
" =============

" Jump to the last position when reopening a file
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$")
\ | exe "normal! g'\"" | endif

" Enable incremental search (submit search after each keypress while searching)
set incsearch

" Highlight search matches, and clear them by pressing return
set hlsearch
nnoremap <silent> <CR> :nohlsearch<CR><CR>

" Do smart case matching when searching
set smartcase

" Wrap long display lines only between separate words, do not wrap within a word
set wrap lbr

" Allow movement past the end of a line in visual block mode
set virtualedit=block

" Do not auto insert carriage returns at long lines
set textwidth=0

" Allow hiding of unsaved modified buffers
set hidden

" When inserting a bracket, breifly move the cursor to its matching bracket
set showmatch

" Enable mouse usage in console vim
set mouse=a
