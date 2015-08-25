" allow bash aliases
let $BASH_ENV = "~/.bash_aliases"

" Backup!!!
set backup
set backupdir=~/.vim/backups
set directory=~/.vim/swaps

" Sane coloring
set background=dark
syntax on
set hlsearch
colorscheme default

highlight DiffAdd    ctermbg=234
highlight DiffDelete ctermbg=234
highlight DiffChange ctermbg=234
highlight DiffText   cterm=bold,underline ctermbg=233

set number
set incsearch
set nocompatible
set autoindent
set cindent
set nowrap
set modeline

set ruler
set statusline=[%02n]\ %f\ %(\[%M%R%H]%)%=\ %4l,%02c%2V\ %P%*
set laststatus=2

" QuickFix for make
autocmd QuickFixCmdPost [^l]* botright cwindow

map <C-g> :make<CR><CR>
map <C-j> :cnext<CR><CR>
map <C-k> :cprev<CR><CR>

" key mappings for tab browsing
map <F8> :tabe<CR>
map <F9> :tabp<CR>
map <F10> :tabn<CR>

imap <F8> <ESC>:tabe<CR>i
imap <F9> <ESC>:tabp<CR>i
imap <F10> <ESC>:tabn<CR>i

" ftplugin (see .vim/ftplugin/*.vim)
filetype plugin indent on

au BufNewFile,BufRead *.ringo set filetype=python

cscope add ~/cscopes/linux/cscope.out ~/cscopes/linux
cscope add ~/cscopes/dpdk/cscope.out ~/cscopes/dpdk
