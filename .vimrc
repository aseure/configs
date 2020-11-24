call plug#begin()

Plug '/usr/local/opt/fzf'
Plug 'Lokaltog/vim-easymotion'
Plug 'arcticicestudio/nord-vim'
Plug 'godlygeek/tabular'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'preservim/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'stephpy/vim-yaml'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-surround'

call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                                                    General "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

filetype off
filetype plugin indent on
language C
syntax on

set t_Co=256
colorscheme nord
set background=dark
highlight Comment ctermfg=Yellow
highlight LineNr ctermfg=Yellow

set autoindent
set autoread
set backspace=eol,indent,start
set cindent
set clipboard=unnamed
set cmdheight=2
set colorcolumn=+1
set colorcolumn=80
set encoding=utf8
set expandtab
set fillchars-=vert:\| | set fillchars+=vert:\⎜
set foldenable
set foldlevelstart=99
set foldmethod=indent
set formatprg=gfmt\ -w\ 80\ -u\ -c
set gdefault
set guioptions-=r
set hidden
set hls
set ignorecase
set incsearch
set langmenu=en_US.UTF-8
set laststatus=2
set linebreak
set list
set listchars=tab:›\ ,extends:˺,trail:\ ,nbsp:.
set magic
set mouse=a
set nobackup
set nocompatible
set noerrorbells
set nojoinspaces
set noshowmode
set nospell
set noswapfile
set novisualbell
set nowrap
set nowritebackup
set number
set ruler
set scrolloff=10
set shiftwidth=4
set shortmess+=c
set shortmess=a
set showmatch
set signcolumn=yes
set smartcase
set smartindent
set smarttab
set softtabstop=2
set t_vb=
set tabstop=2
set textwidth=80
set updatetime=300
set visualbell
set wildignorecase
set wildmenu
set wildmode=list:longest:full

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                                                   Commands "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Save as root with :W command
command Ws :execute ':silent w !sudo tee % > /dev/null' | :edit!

" Remove all trailing spaces on save
autocmd BufWritePre * %s/\s\+$//e

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

" Navigate back and forth between locations
nmap <leader>[ <C-o>
nmap <leader>] <C-i>

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

nnoremap <C-h> :set hlsearch!<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                                           junegunn/fzf.vim "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --glob "!{*.pyc}" --color=always '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'up:60%'),
  \   <bang>0)

nnoremap <C-p> :Files<Cr>
nnoremap <C-g> :Rg<Cr>

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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                                      itchyny/lightline.vim "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:lightline = {
      \ 'colorscheme': 'nord',
      \ }

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                                         tpope/vim-surround "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nnoremap <leader>s ysiW

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                                         preservim/nerdtree "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

map <C-t> :NERDTreeToggle<CR>
