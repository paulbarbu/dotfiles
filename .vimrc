execute pathogen#infect()

syntax on
filetype plugin indent on


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
"if executable('ocamlmerlin') && has('python')
"  let s:ocamlmerlin = substitute(system('opam config var share'), '\n$', '', '''') . "/ocamlmerlin"
"  execute "set rtp+=".s:ocamlmerlin."/vim"
"  execute "set rtp+=".s:ocamlmerlin."/vimbufsync"
"endif

let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
execute "set rtp+=" . g:opamshare . "/merlin/vim"



" Tell Syntastic about merlin
let g:syntastic_ocaml_checkers = ['merlin']
