"--------------------------------------------------------------------
" This section is required for Vundle
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'tpope/vim-fugitive'
Plugin 'vim-scripts/a.vim'
Plugin 'majutsushi/tagbar'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'Chiel92/vim-autoformat'
Plugin 'brookhong/cscope.vim'
Plugin 'sheerun/vim-polyglot'
Plugin 'rakr/vim-one'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'mileszs/ack.vim'
Plugin 'noah/vim256-color'
Plugin 'w0rp/ale'
Plugin 'scrooloose/nerdcommenter'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
"--------------------------------------------------------------------

" Some common options
set nocompatible
set backspace=indent,eol,start
set incsearch
set hlsearch
set autoindent
set cindent
set nowrap
set modeline
set ruler
set encoding=utf-8
set laststatus=2

" Autocompletion for file names (with bash-like behaviors)
set wildignorecase
set wildignore=*.o,*.pyc
set wildmenu
set wildmode=full

" Refresh if files are updated outside of vim
set autoread

" Disable speaker/visual bell
set vb t_vb=

" Backup!!!
set backup
set backupdir=~/.vim/backups
set directory=~/.vim/swaps

" xterm mouse report
set mouse=a

" Fix HOME/END key madness
map <Esc>OH <Home>
map! <Esc>OH <Home>
map <Esc>OF <End>
map! <Esc>OF <End>

" Line numbers and guide lines
set cursorline
set number

" key mappings for tab browsing
map  <F8> :tabe<CR>
imap <F8> <ESC>:tabe<CR>i

map  <C-h> :tabp<CR>
imap <C-h> <ESC>:tabp<CR>i

map  <C-l> :tabn<CR>
imap <C-l> <ESC>:tabn<CR>i

" Location list for make/cscope
autocmd QuickFixCmdPost * lwindow 12

map <C-g> :lmake<CR><CR>
map <C-j> :lnext<CR>
map <C-k> :lprev<CR>

set wildignore+=*.o,*.so,*.a

" BESS
autocmd BufNewFile,BufRead *.bess set filetype=python

"--------------------------------------------------------------------
" Configuration for scrooloose/nerdtree
map  <F10> :NERDTreeToggle<CR>
imap <F10> <ESC>:NERDTreeToggle<CR>i

" work around http://github.com/scrooloose/nerdtree/issues/489
let g:NERDTreeGlyphReadOnly = "RO"

let NERDTreeIgnore=['\.o$[[file]]']
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : ":M:",
    \ "Staged"    : ":+:",
    \ "Untracked" : ":?:",
    \ "Renamed"   : ":R:",
    \ "Unmerged"  : ":=:",
    \ "Deleted"   : ":-:",
    \ "Dirty"     : ":✗:",
    \ "Clean"     : ":✔︎:",
    \ "Unknown"   : ":!:"
    \ }

"--------------------------------------------------------------------
" Configuration for majutsushi/tagbar
set updatetime=300
let g:tagbar_width=32
let g:tagbar_left=1
let g:tagbar_sort=0

map  <F9> :TagbarToggle<CR>
imap <F9> <ESC>:TagbarToggle<CR>i

"--------------------------------------------------------------------
" Configuration for Chiel92/vim-autoformat
" Prefer yapf over autopep8
let g:formatters_python = ['yapf', 'autopep8']

" My favorite shortcut
vnoremap = :Autoformat<CR>

"--------------------------------------------------------------------
" Configuration for brookhong/cscope.vim
set cscopetag
set csto=0

for c in ['s', 'g', 'c', 't', 'e', 'f', 'i', 'd']
  exe "nnoremap <C-\\>". c ":call CscopeFind('". c "', expand('<cword>'))<CR>"
endfor
nnoremap <leader>l :call ToggleLocationList()<CR>

if filereadable("cscope.out")
    cs add cscope.out
endif

for file in split(glob('~/cscopes/*/cscope.out'), '\n')
    exec "cs add" file fnamemodify(file, ":h")
endfor

"--------------------------------------------------------------------
" Configuration for onedark
syntax on

if (has("termguicolors"))
" If you have vim >=8.0 or Neovim >= 0.1.5, enable 24bit truecolor
  set termguicolors
  let g:one_allow_italics = 1
  colorscheme one
  set background=dark
  let g:airline_theme='one'
else
  set background=dark
  colorscheme Tomorrow-Night
endif

"--------------------------------------------------------------------
" Configuration for vim-airline
let g:airline#extensions#whitespace#enabled=0

"--------------------------------------------------------------------
" Configuration for ack.vim
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

cnoreabbrev Ack LAck

"--------------------------------------------------------------------
" Configuration for w0rp/ale
let g:ale_linters = {
    \ 'cpp': ['clang', 'g++'],
    \ }

let g:ale_set_quickfix=1
let g:ale_cpp_clang_options='-std=c++11 -Wall -isystem /home/shinae/bess/deps/dpdk-17.05/build/include'
let g:ale_cpp_gcc_options='-std=c++11 -Wall -isystem /home/shinae/bess/deps/dpdk-17.05/build/include'

"--------------------------------------------------------------------
" Configuration for scrooloose/nerdcommenter

"Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

"Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

"--------------------------------------------------------------------
" LAST: For configuration after loading plugins, add commands to
"       .vim/after/plugin/last.vim
"--------------------------------------------------------------------
