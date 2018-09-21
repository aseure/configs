""""""""""""""""""""""""""""""""""""""""""""
"
" Vim configuration file
"
" Author:
"
" Anthony Seure
" <anthony.seure@gmail.com>
" https://github.com/aseure/configs
"
" Acknowledgements:
"
" Kévin "Chewie" Sztern
" <chewie@deliciousmuffins.net>
" https://github.com/Chewie/configs
"
" Romain "Chmool" Lannel
" <chewie@deliciousmuffins.net>
" https://bitbucket.org/Chmool/linux-conf
"
" Marc "null" Angel
" <marc@angel.pm>
" https://bitbucket.org/null_/configs/src
"
" And others.
"
""""""""""""""""""""""""""""""""""""""""""""

" {{{ Vundle

  set nocompatible
  filetype off

  set rtp+=~/.vim/bundle/Vundle.vim
  call vundle#begin()

  Bundle 'Lokaltog/vim-easymotion'
  Bundle 'SirVer/ultisnips'
  Bundle 'cespare/vim-toml'
  Bundle 'chrisbra/csv.vim'
  Bundle 'chriskempson/vim-tomorrow-theme'
  Bundle 'ctrlpvim/ctrlp.vim'
  Bundle 'dhruvasagar/vim-table-mode'
  Bundle 'fatih/vim-go'
  Bundle 'gmarik/Vundle.vim'
  Bundle 'godlygeek/tabular'
  Bundle 'honza/vim-snippets'
  Bundle 'jiangmiao/auto-pairs'
  Bundle 'junegunn/goyo.vim'
  Bundle 'junegunn/vim-easy-align'
  Bundle 'rust-lang/rust.vim'
  Bundle 'scrooloose/nerdcommenter'
  Bundle 'tpope/vim-abolish'
  Bundle 'tpope/vim-fugitive'
  Bundle 'tpope/vim-repeat'
  Bundle 'tpope/vim-speeddating'
  Bundle 'tpope/vim-surround'
  Bundle 'vim-airline/vim-airline'
  Bundle 'vim-airline/vim-airline-themes'

  call vundle#end()

" }}}

" {{{ General

  language C                " English please (General)
  set langmenu=en_US.UTF-8  " English please (GVim menu)
  set encoding=utf8         " Vim character encoding

  filetype plugin indent on " Load syntax plugins

  syntax on

  set mouse=a               " Allow mouse use
  set showmatch             " Highlight matching parenthesis

  set number                " Display line number
  set ruler                 " Display the line/column in the status bar
  set cursorline            " Highlight the current line

  set wildmenu              " Completion when typing a command
  set wildignorecase        " Ignore case when searching
  set wildmode=list:longest:full

  set laststatus=2          " Force tha status line display
  set noshowmode            " Same

  set hidden                " Avoid file closing/buffer hidding behavior
  set autoread              " Automatic reload of modified files
  set scrolloff=10          " Allow to scroll before top/bottom cursor reaching

  set noswapfile            " Avoid to produce swap files
  set nowritebackup         " Avoid to produce backup files when overwriting

  set noerrorbells          " Disable sound errors
  set novisualbell          " Same
  set visualbell            " Same
  set t_vb=                 " Same

  set foldenable            " Enable folding
  set foldmethod=indent     " Fold according to the indentation
  set foldlevelstart=99     " Open without folding

  set shortmess=a           " Shorter messages
  set clipboard=unnamed     " Merge unamed register and "* register

  set background=dark
  colorscheme Tomorrow-Night

  set backspace=eol,indent,start                  " Fix the backspace behavior
  set list                                        " Highlight special characters
  set listchars=tab:›\ ,extends:˺,trail:\ ,nbsp:. " List the special characters

  " Use the `W' command to save as root
  command Ws :execute ':silent w !sudo tee % > /dev/null' | :edit!

  " Use longer pipe as vertical separation
  set fillchars-=vert:\| | set fillchars+=vert:\⎜

  " Disable Background Color Erase (BCE) so that color schemes render properly
  " when inside 256-color tmux and GNU screen.
  " See also http://snk.tuxfamily.org/log/vim-256color-bce.html
  "if &term =~ '256color'
    "set t_ut=
  "endif

  set tags=~/tags

  set guioptions-=r         " Disable the scrollbar

  set spell spelllang=en    " Enable spell checking for English
  set nospell

" }}}

" {{{ Formatting

  set expandtab             " Spaces instead of tabulations
  set cindent

  set tabstop=4             " Length of a tabulation
  set shiftwidth=2          " Number of spaces inserted by < and >
  set softtabstop=2         " Number of spaces when hitting TAB

  set smarttab              " Use shiftwidth when tabbing manually
  set smartindent           " Smart indent...
  set autoindent            " Use the basic previous line indentation

  set nowrap
  set linebreak
  set textwidth=79
  set colorcolumn=+1

" }}}

" {{{ Mappings

  " Disable Ex mode
  nnoremap Q <nop>

  " Change the map leader key
  let mapleader=" "

  imap uu <Esc>             " Escape is too far away (QWERTY and Dvorak layout)
  if exists('&esckeys')
    set noesckeys           " Faster <Esc>
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

  " Tags jumps
  nmap <leader>t <C-]>
  nmap <leader>e <C-t>

  " Spelling
  map <silent> <F7> "<Esc>:silent setlocal spell! spelllang=en<CR>"
  map <silent> <F8> "<Esc>:silent setlocal spell! spelllang=fr<CR>"

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

  " Move between misspelled words
  nmap mn ]s
  nmap mp [s

  " Suggest alternatives for the word under the cursor according to spell
  " checking
  map <leader>s z=

  set pastetoggle=<F2>
  inoremap <C-v> <F2><C-r>+<F2>

  nmap <leader>w :set wrap!<CR>

  nmap <leader>g :Goyo<CR>

" }}}

" {{{ Search

  set gdefault              " Set the 'g' option for substitution (don't hit me)
  set hls                   " Highlight matched string
  set ignorecase            " Ignore case
  set incsearch             " Move cursor to the matched string
  set magic                 " Improve the search
  set smartcase             " Ignore case unless there is an uppercase letter in the pattern

  " Highlight search toggle <C-H>
  map <C-h> :set hls!<CR>
  hi Search cterm=NONE ctermfg=Black ctermbg=Yellow

  " Refine `Find` command to use ripgrep
  command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)

" }}}

" {{{ Fugitive plugin

  " Use .. to go back in the tree buffer when using Fugitive
  autocmd User fugitive 
    \ if fugitive#buffer().type() =~# '^\%(tree\|blob\)$' |
    \   nnoremap <buffer> .. :edit %:h<CR> |
    \ endif

  " Alias gl on :Glog
  nmap <leader>gl :silent! Glog<CR>

" }}}

" {{{ ctrlp plugin

  let g:ctrlp_cmd = 'CtrlP'
  let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn|pyc)$'
  let g:ctrlp_extensions = ['tag']
  let g:ctrlp_map = '<c-p>'
  let g:ctrlp_max_files = 0
  let g:ctrlp_working_path_mode = 'ra'
  nnoremap <C-.> :CtrlPTag<CR>
  set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pdf,*.o,*.pyc

  if executable('rg')
    set grepprg=rg\ --color=never
    let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
    let g:ctrlp_use_caching = 0
  endif

" }}}

" {{{ Easy align plugin

  " Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
  vmap <Enter> <Plug>(EasyAlign)

  " Start interactive EasyAlign for a motion/text object (e.g. <Leader>aip)
  nmap <Leader>a <Plug>(EasyAlign)

" }}}

" {{{ Easymotion plugin

  " Replace default search
  map  / <Plug>(easymotion-sn)
  omap / <Plug>(easymotion-tn)
  map  n <Plug>(easymotion-next)
  map  N <Plug>(easymotion-prev)

" }}}

" {{{ vim-go

  " Enable syntax highlighting
  let g:go_highlight_build_constraints = 1
  let g:go_highlight_extra_types = 1
  let g:go_highlight_fields = 1
  let g:go_highlight_functions = 1
  let g:go_highlight_methods = 1
  let g:go_highlight_operators = 1
  let g:go_highlight_structs = 1
  let g:go_highlight_types = 1

  " Automatically imports modules
  let g:go_fmt_command = "goimports"

" }}}

" {{{ vim-table-mode

  let g:table_mode_corner='|'

" }}}

" {{{ rust.vim

  let g:rustfmt_autosave = 1

" }}}

" {{{ vim-airline

  let g:airline#extensions#tabline#enabled = 1
  let g:airline_powerline_fonts = 1
  let g:airline_theme='tomorrow'

" }}}
