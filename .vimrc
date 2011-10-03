set nocompatible
set nobackup

filetype plugin indent on
syntax on

set hidden
set history=10000
set sessionoptions=buffers,curdir,folds,options,resize,winpos,winsize

set clipboard+=unnamed " use clipboard

set incsearch	" do incremental searching
set ignorecase	" ignore case while searching
set smartcase

set autoindent
set expandtab
set shiftwidth=4

set formatoptions-=t

set foldmethod=indent
set foldnestmax=1
set foldlevel=2

set wildchar=<Tab> " Expand the command line using tab

" arrows warp around lines
set whichwrap=bs<>[]

" Insert space then paste
nmap <M-p> a<Space><ESC>p

" Edit and return to normal mode
nnoremap <CR> i<CR><ESC>
nnoremap <Space> i<Space><ESC>l
nnoremap <Tab> i<Tab><ESC>l

" Buffer nav
nmap <C-Tab> :bn<CR>
nmap <S-C-Tab> :bp<CR>

" allow backspacing over everything in insert mode
set backspace=eol,start,indent

set ruler	" show the cursor position all the time
set showcmd	" display incomplete commands
set guioptions-=m	" no menu
set guioptions-=T	" no toolbar
set guifont=Menlo\ Regular:h\ 12
