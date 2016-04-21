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

  Bundle 'Chun-Yang/vim-action-ag'
  Bundle 'Lokaltog/vim-easymotion'
  Bundle 'MarcWeber/vim-addon-mw-utils'
  Bundle 'chrisbra/csv.vim'
  Bundle 'ervandew/supertab'
  Bundle 'fatih/vim-go'
  Bundle 'garbas/vim-snipmate'
  Bundle 'gmarik/Vundle.vim'
  Bundle 'honza/vim-snippets'
  Bundle 'junegunn/vim-easy-align'
  Bundle 'justinmk/vim-syntax-extra'
  Bundle 'kien/ctrlp.vim'
  Bundle 'nelstrom/vim-markdown-folding'
  Bundle 'rizzatti/dash.vim'
  Bundle 'rking/ag.vim'
  Bundle 'scrooloose/nerdcommenter'
  Bundle 'scrooloose/nerdtree'
  Bundle 'tomtom/tlib_vim'
  Bundle 'tpope/vim-fugitive'
  Bundle 'tpope/vim-speeddating'
  Bundle 'tpope/vim-surround'
  Bundle 'vim-airline/vim-airline'
  Bundle 'vim-airline/vim-airline-themes'
  Bundle 'vim-scripts/AnsiEsc.vim'
  Bundle 'altercation/vim-colors-solarized'

  call vundle#end()

" }}}

" {{{ General

  language C                " English please (General)
  set langmenu=en_US.UTF-8  " English please (GVim menu)
  set encoding=utf8         " Vim character encoding

  filetype plugin indent on " Load syntax plugins

  syntax on                 " Really?

  let &t_SI .= "\<Esc>[6 q" " Set vertical bar cursor in insert mode
  let &t_EI .= "\<Esc>[2 q" " Same

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

  set background=light
  colorscheme solarized     " Colorscheme

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
  if &term =~ '256color'
    set t_ut=
  endif

  set tags=~/tags

  set guioptions-=r         " Disable the scrollbar

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
  set noesckeys             " Faster <Esc>

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

  " Sort the block of lines around the cursor
  nmap <leader>s vip:sort<CR>

" }}}

" {{{ Search

  set magic                 " Improve the search

  set ignorecase            " Ignore case
  set smartcase             " Ignore case unless there is an uppercase letter in the pattern

  set incsearch             " Move cursor to the matched string
  set hls                   " Highlight matched string
  set gdefault              " Set the 'g' option for substitution (don't hit me)

  " Highlight search toggle <C-H>
  map <C-h> :set hls!<CR>
  hi Search cterm=NONE ctermfg=Black ctermbg=Yellow

" }}}

" {{{ Syntax

  " Markdown
  let g:pandoc_use_hard_wraps = 1
  let g:pandoc_auto_format = 1

  " Tiger
  au BufNewFile,BufRead *.tig so ~/.vim/syntax/tiger.vim

  " Dockerfile
  au BufNewFile,BufRead Dockerfile* set syntax=dockerfile

" }}}

" {{{ Airline plugin

  let g:airline_powerline_fonts = 1
  let g:airline#extensions#tabline#enabled = 1

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

" {{{ Nerd Tree plugin

  nnoremap <silent> <F9> :NERDTreeToggle<CR>
  nnoremap <silent> <F10> :TlistToggle<CR>

" }}}

" {{{ ctrlp plugin

  set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pdf,*.o,*.pyc

  let g:ctrlp_map = '<c-p>'
  let g:ctrlp_cmd = 'CtrlPMixed'

  let g:ctrlp_working_path_mode = 'ra'

  let g:ctrlp_max_files = 0

  " MacOSX/Linux mode
  let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn|pyc)$'
  let g:ctrlp_extensions = ['tag']

  " Use the_silver_search instead of grep if installed
  if executable('ag')
    " Use ag over grep
    set grepprg=ag\ --nogroup\ --nocolor

    " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

    " ag is fast enough that CtrlP doesn't need to cache
    let g:ctrlp_use_caching = 0
  endif

  nnoremap <C-.> :CtrlPTag<CR>

" }}}

" {{{ Easy align plugin

  " Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
  vmap <Enter> <Plug>(EasyAlign)

  " Start interactive EasyAlign for a motion/text object (e.g. <Leader>aip)
  nmap <Leader>a <Plug>(EasyAlign)

" }}}

" {{{ vim-markdown plugin

  " Disable markdown folding since I prefer the one from nelstrom
  let g:vim_markdown_folding_disabled=1

" }}}

" {{{ vim-markdown-folding plugin

  " Treat *.md files as Markdown files
  autocmd BufNewFile,BufReadPost *.md set filetype=markdown

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
  let g:go_highlight_functions = 1
  let g:go_highlight_methods = 1
  let g:go_highlight_structs = 1
  let g:go_highlight_operators = 1
  let g:go_highlight_build_constraints = 1

  " Automatically imports modules
  let g:go_fmt_command = "goimports"

" }}}

" {{{ dash.vim

  nmap <silent> <leader>d <Plug>DashSearch

" }}}

" {{{ vim-action-ag

  nmap <silent> <leader>ag gagiw

" }}}

" {{{ AnsiEsc.vim

  nmap <leader>a :AnsiEsc<CR>

" }}}
