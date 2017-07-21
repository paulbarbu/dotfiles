" Use Pathogen to manage plugins
execute pathogen#infect()

""""""" Tabs and spaces
" This configuration is the second scenario in :h tabstop, as follows:
"
" 2. Set 'tabstop' and 'shiftwidth' to whatever you prefer and use
" 'expandtab'.  This way you will always insert spaces.  The
" formatting will never be messed up when 'tabstop' is changed.

" Act like a tab character has 4 spaces
set tabstop=4

" << and >> should move 4 spaces
set shiftwidth=4

" tab characters should always be expanded to spaces
set expandtab

""""""" Others
" Highlight all search matches
set hlsearch

" Use smartcase for searching if the searched string contains uppercase chars the search will be
" case-sensitive, otherwise will be case-insensitive
set ignorecase
set smartcase

" Change the current directory to the one the current file is in
set autochdir

" Highlight the 120th colum 
set colorcolumn=120
" Highlight the column with dark gray
highlight ColorColumn ctermbg=darkgray

" Display line numbers
set number

" Enable syntax highlighting
syntax on

" Enable filetype detection, plugins and indentation
filetype plugin indent on

" Allow per project .vimrc
set exrc

" Avoid security holes created by allowing .vimrc on a per project basis
" This option will restrict usage of some commands in non-default .vimrc files
" commands that write to file or execute shell commands are not allowed and map 
" commands are displayed.
set secure


""""""" SuperTab
" Press Tab instead of CTRL+x CTRL+o
let g:SuperTabDefaultCompletionType = "<C-X><C-O>"

""""""" Syntastic

"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

""""""" OCaml

" ocp-indent
set rtp^="/home/paul/.opam/system/share/ocp-indent/vim"

" Vim needs to be built with Python scripting support, and must be
" able to find Merlin's executable on PATH.
let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
execute "set rtp+=" . g:opamshare . "/merlin/vim"

" Tell Syntastic about merlin
let g:syntastic_ocaml_checkers = ['merlin']
