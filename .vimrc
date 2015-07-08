
autocmd! bufwritepost .vimrc source %

" vim.pathogen
execute pathogen#infect()

set et
set sw=4
set ts=4
set softtabstop=4
set ai
syntax on
set hlsearch
set incsearch
set showcmd
set showmatch
set nostartofline
set ruler
set bg=light
set so=5
set number
set nowrap
set mouse=a

autocmd Filetype javascript setlocal sw=2 ts=2 sts=2
autocmd Filetype coffee setlocal sw=2 ts=2 sts=2
autocmd Filetype html setlocal sw=1 ts=1 sts=1

" disable the annoying paren matching highlighting
let loaded_matchparen = 1 

set nobackup
set nowb
set noswapfile

autocmd FileType python set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
autocmd FileType python autocmd BufWritePre <buffer> call Trim()

map <F8> Oimport ipdb; ipdb.set_trace()

:function Trim()
" remove trailing whitespace
:%s/\s\+$//ge
" Remove empty lines
":g/^$/d
:endfunction

" change cursor iterm
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

let NERDTreeIgnore=['\.pyc$']

if filereadable(".lvimrc")
    source .lvimrc
endif
