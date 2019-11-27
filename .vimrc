call plug#begin()

Plug '/usr/local/opt/fzf'
Plug 'Lokaltog/vim-easymotion'
Plug 'arcticicestudio/nord-vim'
Plug 'godlygeek/tabular'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-surround'

call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                                                    General "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

colorscheme nord
filetype off
filetype plugin indent on
language C
syntax on

set autoindent
set autoread
set background=dark
set backspace=eol,indent,start
set gdefault
set hls
set ignorecase
set incsearch
set magic
set smartcase
set cindent
set clipboard=unnamed
set colorcolumn=+1
set encoding=utf8
set expandtab
set fillchars-=vert:\| | set fillchars+=vert:\⎜
set foldenable
set foldlevelstart=99
set foldmethod=indent
set guioptions-=r
set hidden
set langmenu=en_US.UTF-8
set laststatus=2
set linebreak
set list
set listchars=tab:›\ ,extends:˺,trail:\ ,nbsp:.
set mouse=a
set nocompatible
set noerrorbells
set noshowmode
set nospell
set noswapfile
set novisualbell
set nowrap
set nowritebackup
set number
set ruler
set scrolloff=10
set shiftwidth=2
set shortmess=a
set showmatch
set smartindent
set smarttab
set softtabstop=2
set t_vb=
set tabstop=4
set tags=~/tags
set textwidth=79
set visualbell
set wildignorecase
set wildmenu
set wildmode=list:longest:full

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                                                   Commands "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

command Ws :execute ':silent w !sudo tee % > /dev/null' | :edit!

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                                                   Mappings "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nnoremap Q <nop>
let mapleader=" "

imap uu <Esc>
if exists('&esckeys')
  set noesckeys
endif

" Hardcore gamer (should be used though)
inoremap <up> <nop>
vnoremap <up> <nop>
noremap <up> <nop>
inoremap <down> <nop>
vnoremap <down> <nop>
noremap <down> <nop>
inoremap <left> <nop>
vnoremap <left> <nop>
noremap <left> <nop>
inoremap <right> <nop>
vnoremap <right> <nop>
noremap <right> <nop>

" Move in quickfix list using arrow keys
nmap <silent> <right> :cprevious<CR>
nmap <silent> <left> :cnext<CR>
nmap <silent> <up> :cfirst<CR>
nmap <silent> <down> :clast<CR>

" Center screen
nmap <space> zz
nmap n nzz
nmap N Nzz

" Buffer navigation
nnoremap tj :bnext<CR>
nnoremap tk :bprevious<CR>
nnoremap tt :bdelete<CR>

" Quick window navigation
nmap <leader>h <C-W>h
nmap <leader>j <C-W>j
nmap <leader>k <C-W>k
nmap <leader>l <C-W>l

" Insert lines quickly
nmap <leader>o o<esc>
nmap <leader>O O<esc>

" Yank from cursor to end of line, to be consistent with C and D
nnoremap Y y$

" Improve copy pasting by automatically switching to paste mode
set pastetoggle=<F2>
inoremap <C-v> <F2><C-r>+<F2>

" Highlight search toggle <C-H>
map <C-h> :set hls!<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                                           junegunn/fzf.vim "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                                         tpope/vim-fugitive "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

autocmd User fugitive 
  \ if fugitive#buffer().type() =~# '^\%(tree\|blob\)$' |
  \   nnoremap <buffer> .. :edit %:h<CR> |
  \ endif

nmap <leader>gl :silent! Glog<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                                    Lokaltog/vim-easymotion "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
map  n <Plug>(easymotion-next)
map  N <Plug>(easymotion-prev)

