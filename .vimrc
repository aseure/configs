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
" And others.
"
""""""""""""""""""""""""""""""""""""""""""""

" Vundle {

  set nocompatible
  filetype off

  set rtp+=~/.vim/bundle/Vundle.vim
  call vundle#begin()

  Bundle 'gmarik/Vundle.vim'
  Bundle 'tpope/vim-surround'
  Bundle 'tpope/vim-fugitive'
  Bundle 'tpope/vim-liquid'
  Bundle 'tpope/vim-unimpaired'
  Bundle 'scrooloose/nerdcommenter'
  Bundle 'justinmk/vim-syntax-extra'
  Bundle 'kien/ctrlp.vim'
  Bundle 'bling/vim-airline'
  Bundle 'garbas/vim-snipmate'
  Bundle 'tomtom/tlib_vim'
  Bundle 'MarcWeber/vim-addon-mw-utils'
  Bundle 'honza/vim-snippets'
  Bundle 'junegunn/vim-easy-align'
  Bundle 'DoxygenToolkit.vim'
  Bundle 'plasticboy/vim-markdown'
  Bundle 'nelstrom/vim-markdown-folding'

  call vundle#end()

" }

" General {

  language C                " English please (General)
  set langmenu=en_US.UTF-8  " English please (GVim menu)

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
  set foldmethod=syntax     " Fold according to the syntax
  set foldlevelstart=99     " Open without folding

  set list                                       " Highlight special characters
  set listchars=tab:>─,extends:˺,trail:\ ,nbsp:. " List the special characters

  set backspace=eol,indent,start " Fix the backspace behavior

  " Disable Background Color Erase (BCE) so that color schemes render properly
  " when inside 256-color tmux and GNU screen.
  " See also http://snk.tuxfamily.org/log/vim-256color-bce.html
  if &term =~ '256color'
    set t_ut=
  endif

  colorscheme jellybeans    " Colorscheme

" }

" Formatting {

  set expandtab             " Spaces instead of tabulations
  set cindent

  set tabstop=8             " Length of a tabulation
  set shiftwidth=2          " Number of spaces inserted by < and >
  set softtabstop=2         " Number of spaces when hitting TAB

  set smarttab              " Use shiftwidth when tabbing manually
  set smartindent           " Smart indent...
  set autoindent            " Use the basic previous line indentation

  set wrap
  set linebreak
  set textwidth=79
  set colorcolumn=+1

" }

" Mappings {

  " Disable Ex mode
  nnoremap Q <nop>

  " Change the map leader key
  let mapleader=" "

  " Escape is too far away (QWERTY and Dvorak layout)
  "imap jj <Esc>
  imap hh <Esc>

  " Hardcore gamer (should be used though)
  "inoremap <up> <nop>
  "vnoremap <up> <nop>
  "noremap <up> <nop>
  "inoremap <down> <nop>
  "vnoremap <down> <nop>
  "noremap <down> <nop>
  "inoremap <left> <nop>
  "vnoremap <left> <nop>
  "noremap <left> <nop>
  "inoremap <right> <nop>
  "vnoremap <right> <nop>
  "noremap <right> <nop>

  " Center screen
  nmap <space> zz
  nmap n nzz
  nmap N Nzz

  " Tabs navigation
  nnoremap tj :tabnext<CR>
  nnoremap tk :tabprevious<CR>
  nnoremap tn :tabnew<CR>
  nnoremap tt :tabclose<CR>

  " Tags jumps
  if has("unix")
    let s:uname = system("uname -s")
      if s:uname == "Darwin\n"
        au BufWritePost *.c,*.h,*.hh,*.cpp,*.hpp,*.cc,*.hh,*.hxx silent! !/opt/local/bin/ctags -R &
      else
        au BufWritePost *.c,*.h,*.hh,*.cpp,*.hpp,*.cc,*.hh,*.hxx silent! !ctags -R &
      endif
  endif

  nmap <leader>t <C-]>
  nmap <leader>u <C-t>


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

" }

" Search {

  set magic                 " Improve the search

  set ignorecase            " Ignore case
  set smartcase             " Ignore case unless there is an uppercase letter in the pattern

  set incsearch             " Move cursor to the matched string
  set nohlsearch            " Highlight matched string
  set gdefault              " Set the 'g' option for substitution (don't hit me)

  set hls                   " Highlight search toggle <C-H>
  map <C-h> :set hls!<CR>

" }

" Syntax {

  " Markdown
  let g:pandoc_use_hard_wraps = 1
  let g:pandoc_auto_format = 1

  " Tiger
  au BufNewFile,BufRead *.tig so ~/.vim/syntax/tiger.vim

" }

" Airline plugin {

  let g:airline_powerline_fonts = 1

" }

" Fugitive plugin {

  " Use .. to go back in the tree buffer when using Fugitive
  autocmd User fugitive 
    \ if fugitive#buffer().type() =~# '^\%(tree\|blob\)$' |
    \   nnoremap <buffer> .. :edit %:h<CR> |
    \ endif

" }

" ctrlp plugin {

  set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pdf,*.o
  set wildignore+=*\\tmp\\*,*.exe,*.swp,*.zip,*.pdf,*.o

  let g:ctrlp_map = '<c-p>'
  let g:ctrlp_cmd = 'CtrlPMixed'

  let g:ctrlp_working_path_mode = 'ra'

  " MacOSX/Linux mode
  let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
  let g:ctrlp_extensions = ['tag']

  " Windows mode
  "let g:ctrlp_custom_ignore = {
  "\ 'dir': '\v[\/]\.(git|hg|svn)$',
  "\ 'file': '\v\.(exe|so|dll)$'
  "\ }

" }

" Easy align plugin {

  " Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
  vmap <Enter> <Plug>(EasyAlign)

  " Start interactive EasyAlign for a motion/text object (e.g. <Leader>aip)
  nmap <Leader>a <Plug>(EasyAlign)

" }

" vim-markdown plugin {
  " Disable markdown folding since I prefer the one from nelstrom
  let g:vim_markdown_folding_disabled=1
" }

" vim-markdown-folding plugin {
  " Treat *.md files as Markdown files
  autocmd BufNewFile,BufReadPost *.md set filetype=markdown
" }
