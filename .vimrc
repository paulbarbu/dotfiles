"Environment
set nocompatible
set term=$TERM
set autochdir
scriptencoding utf-8

"Directories
set backup
set backupdir=$HOME/.vim/tmp/backup/
set directory=$HOME/.vim/tmp/swap/
set viewdir=$HOME/.vim/tmp/view/
silent execute '!mkdir -p $HOME/.vim/tmp/{backup,swap,view}'

let mapleader = ','

"Plugins
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'tpope/vim-fugitive'
Bundle 'Valloric/YouCompleteMe'
Bundle 'sessionman.vim'
Bundle 'scrooloose/syntastic'
Bundle 'tpope/vim-repeat'
Bundle 'SirVer/ultisnips'
Bundle 'sjl/gundo.vim'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/nerdtree'
Bundle 'tpope/vim-surround'
Bundle 'godlygeek/csapprox'
Bundle 'flazz/vim-colorschemes'
"Bundle 'mattn/zencoding-vim'

set sessionoptions=blank,buffers,curdir,folds,tabpages,winsize
nmap <leader>sl :SessionList<CR>
nmap <leader>ss :SessionSave<CR>
nmap <leader>sa :SessionOpenLast<CR>

"vim-fugitive
nmap <leader>gs :Gstatus<CR>
nmap <leader>gc :Gcommit<CR>
nmap <leader>gl :Glog
nmap <leader>gw :Gwrite<CR>
nmap <leader>gd :Gvdiff<CR>

"NerdTree
map <C-e> :NERDTreeToggle<CR>:NERDTreeMirror<CR>
map <leader>e :NERDTreeFind<CR>
nmap <leader>nt :NERDTreeFind<CR>
let NERDTreeShowBookmarks=1
let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
let NERDTreeIgnore+=['\.lo', '\.la']
let NERDTreeChDirMode=0
let NERDTreeQuitOnOpen=1
let NERDTreeShowHidden=1
let NERDTreeKeepTreeInNewTab=1

"Gundo
map <Leader>uu :GundoToggle<CR>
map <Leader>ur :GundoRenderGraph<CR>

"syntastic
let g:syntastic_auto_loc_list=1
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['tex'] }

"CSAprox
let g:CSApprox_attr_map = { 'bold' : 'bold', 'italic' : '', 'sp' : '' }

"ultiSnips
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

"YouCompleteMe
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_global_ycm_extra_conf = '/home/paullik/.vim/ycm_extra_conf.py'

"Visual
color settlemyer
"color wombat
filetype indent plugin on | syn on
set number
set background=dark
set mouse=a
au BufWinLeave * silent! mkview "make vim save view (state) (folds, cursor, etc)
au BufWinEnter * silent! loadview "make vim load view (state) (folds, cursor, etc)
set tabpagemax=40 "only show 15 tabs
set showmode "display the current mode
set guioptions-=T

"IMPORTANT: Uncomment one of the following lines to force
"using 256 colors (or 88 colors) if your terminal supports it,
"but does not automatically use 256 colors by default.
set t_Co=256
"set t_Co=88

if has('cmdline_info')
    set ruler "show the ruler
    set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) "a ruler on steroids
    set showcmd "show partial commands in status line and
endif

if has("gui_running")
  if has("gui_gtk2")
    set guifont=Dejavu\ Sans\ Mono\ Book\ 11
  elseif has("gui_win32")
    set guifont=Consolas:h11:cANSI
  endif
endif

if has('statusline')
    set laststatus=2
    "Broken down into easily includeable segments
    set statusline=%<%f\  "filename
    set statusline+=%w%h%m%r "options
    set statusline+=%{fugitive#statusline()} "git hotness
    set statusline+=\ [%{&ff}/%Y] "filetype
    set statusline+=\ [%{getcwd()}] "current dir
    "set statusline+=\ [A=\%03.3b/H=\%02.2B] "ASCII / Hexadecimal value of char
    set statusline+=%=%-14.(%l,%c%V%)\ %p%% "right aligned file nav info
    " Root settings only
    "hi StatusLine guifg=red
    "hi StatusLine ctermfg=red
endif

set backspace=indent,eol,start "backspace for dummies
set linespace=0 "No extra spaces between rows
set showmatch "show matching brackets/parenthesis
set incsearch "find as you type search
set hlsearch "highlight search terms
set winminheight=1 "windows can be x lines high
set ignorecase "case insensitive search
set smartcase "case sensitive when uc present
set wildmenu "show list instead of just completing
set wildmode=list:longest,full "command <Tab> completion, list matches, then longest common part, then all.
set whichwrap=b,s,h,l,<,>,[,] "backspace and cursor keys wrap to
set scrolljump=5 "lines to scroll when cursor leaves screen
set scrolloff=3 "minimum lines to keep above and below cursor
set foldenable "auto fold code
set gdefault "the /g flag on :s substitutions by default
set list

"Formatting
set nowrap " wrap long lines
set autoindent "indent at the same level of the previous line
set shiftwidth=4 "use indents of 4 spaces
set expandtab "tabs are spaces, not tabs
set tabstop=4 "an indentation every four columns
set softtabstop=4 "let backspace delete indent
set matchpairs+=<:> "match, to be used with %
set pastetoggle=<F12> "pastetoggle (sane indentation on pastes)

"Remove trailing whitespaces and ^M chars
autocmd FileType c,cpp,java,php,js,python,twig,xml,yml autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))

set listchars=tab:>.,trail:.,extends:#,nbsp:. "highlight problematic whitespace

"Misc
set nospell
set hidden
set shortmess+=filmnrxoOtT "abbrev. of messages (avoids 'hit enter')
set viewoptions=folds,options,cursor,unix,slash "better unix/windows compatibility
set virtualedit=onemore "allow for cursor beyond last character
set history=1000
set colorcolumn=80 "highlight colum #80
set textwidth=80 "maximum width of text that is being inserted. A longer line
"will be broken after white space to get this width.

"Maps
"Tab Control (others)
map <A-1> 1gt
map <A-2> 2gt
map <A-3> 3gt
map <A-4> 4gt
map <A-5> 5gt
map <A-6> 6gt
map <A-7> 7gt
map <A-8> 8gt
map <A-9> 9gt
map <A-Right> <ESC>:tabnext<CR>
map <A-Left> <ESC>:tabprev<CR>
map <C-t> <ESC>:tabnew<CR>
map <C-q> <ESC>:tabclose<CR>
noremap \c :e ~/.vimrc<cr>
nnoremap ; :

"wrap movements
nnoremap j gj
nnoremap k gk
cmap W w
cmap WQ wq
cmap wQ wq
cmap Q q
cmap Tabe tabe
nnoremap Y y$

"change working directory to that of the current file
cmap cwd lcd %:p:h
cmap cd. lcd %:p:h

"visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

":nohlsearch on space
noremap <silent> <Space> :silent noh<CR>
noremap <silent> <Leader>s :setlocal spell!<CR>

"for when you forget to sudo.. Really Write the file.
cmap w!! w !sudo tee % >/dev/null

"Printing
set printoptions=paper:A4,syntax:y,wrap:y

"Append modeline after last line in buffer
"use substitute() instead of printf() to handle '%%s' modeline in LaTeX
"files.
function! AppendModeline()
  let l:modeline = printf(" vim: set ts=%d sw=%d tw=%d sts=%d fdm=marker nowrap et :",
        \ &tabstop, &shiftwidth, &textwidth, &softtabstop)
  let l:modeline = substitute(&commentstring, "%s", l:modeline, "")
  call append(line("$"), l:modeline)
endfunction
nnoremap <silent> <Leader>ml :call AppendModeline()<CR>
