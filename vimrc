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

" Snipmate + dependencies + snippets
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
Plugin 'honza/vim-snippets'

" Workflow stuff
Plugin 'tpope/vim-surround'
Plugin 'godlygeek/tabular'

" For seamless switching between vim viewports and tmux panes. Requires
" corresponding bindings in ~/.tmux.conf.
Plugin 'christoomey/vim-tmux-navigator'

" Solarized color scheme
Plugin 'altercation/vim-colors-solarized'

" Airline - status etc
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" PL-specific plugins
Plugin 'derekwyatt/vim-scala'
Plugin 'neovimhaskell/haskell-vim'
Plugin 'rust-lang/rust.vim'

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
set colorcolumn=80          " Enable ruler
set guioptions=a            " Disable menu bar & toolbar in gvim
set number                  " Show line numbers at launch

" ====================
" Color Settings
" ====================

" Settings for MacVim
if has ("gui_macvim")
  colorscheme solarized
  set guifont=Inconsolata\ Regular:h15
  set columns=84

" Settings for gvim on Linux
elseif has ("gui_running")
  set background=light
  colorscheme solarized
  set guifont=Inconsolata\ 11

" Settings for terminal vim
elseif match ($TERM, "xterm-256color"       ) != -1 ||
     \ match ($TERM, "xterm"                ) != -1 ||
     \ match ($TERM, "rxvt-unicode"         ) != -1 ||
     \ match ($TERM, "rxvt-unicode-256color") != -1 ||
     \ match ($TERM, "screen-256color"      ) != -1
  set background=light
  set t_Co=16
  let g:solarized_termcolors=16
  colorscheme solarized

" If the terminal isn't recognised then use vim's default scheme
else
  colorscheme default

endif

" ================
" WildMenu Options
" ================

set wildmenu
set wildmode=longest,list
set wildignore+=*.o,*.hi,*.swp,*.pyc,*.class,*.aux,*.log,*.dvi,*.bbl,*.blg,
    \*.pdf

" ============
" Key Bindings
" ============

" Move cursor with display lines
map j gj
map k gk

" Display partial wrapped lines when the full line won't fit on the screen
" instead of the @ placeholders at the bottom-left
set display=lastline

" Scroll through buffers with tab and shift-tab
nnoremap <silent> <tab> :bnext<CR>
nnoremap <silent> <S-tab> :bprevious<CR>

" Disable bindings to enter ex mode - I never use ex mode
nnoremap Q <nop>
nnoremap q: <nop>

" Command to toggle spell-check
command! SpellToggle setlocal spell! spelllang=en_gb

" Enable spell checking by default in tex, md, txt
autocmd Filetype tex setlocal spell spelllang=en_gb
autocmd Filetype md  setlocal spell spelllang=en_gb
autocmd Filetype txt setlocal spell spelllang=en_gb

" Command to toggle light/dark background when using the solarized color scheme
command! BGToggle
  \ if &background=="light" | set background=dark  |
  \ else                    | set background=light |
  \ endif

" =============
" Misc Settings
" =============

" Put swap-files in a convenient location
set directory^=$HOME/.vim/swapfiles//

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

" Disable bells
set visualbell t_vb=

" Scroll the buffer when the cursor is within 4 lines of the top or bottom
set scrolloff=4

" Read project-specific vimrc if present, but disable unsafe commands in those
" external vimrcs (no autocmd, no shelling out, no write commands)
set exrc
set secure

" Enable airline buffer bar. Don't use separators. Disable some unicode symbols
" which don't render properly everywhere.
set laststatus=2
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = ' '
let g:airline#extensions#tabline#right_sep = ' '
let g:airline#extensions#tabline#right_alt_sep = ' '
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_theme='solarized'
if !exists('g:airline_symbols') | let g:airline_symbols = {} | endif
let g:airline_symbols.linenr = ''
let g:airline_symbols.maxlinenr = ''

" Disable auto-indentation settings in haskell-vim, because they're annoying
let g:haskell_indent_disable = 1
