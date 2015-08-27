" allow bash aliases
let $BASH_ENV = "~/.bash_aliases"

" Backup!!!
set backup
set backupdir=~/.vim/backups
set directory=~/.vim/swaps

" Some common options
set number
set incsearch
set nocompatible
set autoindent
set cindent
set nowrap
set modeline
set ruler
set laststatus=2

" Sane coloring
set background=dark
colorscheme default
syntax on

set hlsearch
highlight Search term=reverse ctermfg=231 ctermbg=11

highlight DiffAdd	ctermbg=234
highlight DiffDelete	ctermbg=234
highlight DiffChange 	ctermbg=234
highlight DiffText 	cterm=bold,underline ctermbg=233

" Status line with Git branch info 
let g:git_branch_status_text=""
let g:git_branch_status_around="<>"
let g:git_branch_status_nogit="<not in a git repo>"
let g:git_branch_status_head_current=1
let g:git_branch_check_write=1
highlight SLGit 	ctermfg=110 ctermbg=52
highlight SLFile 	ctermfg=150 ctermbg=52
set statusline=[%02n]\ %#SLGit#\ %{GitBranchInfoString()}\ %#SLFile#%f\ %#StatusLine#\ %(\[%M%R%H]%)%=\ %4l,%02c%2V\ %P%*

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
