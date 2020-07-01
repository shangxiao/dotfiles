set nomodeline
set modelines=0

let mapleader = ','

autocmd! bufwritepost .vimrc source %
" map <leader>, to open .vimrc (analogous to using command-, for preferences)
nnoremap <leader>, :vsplit $MYVIMRC<cr>

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
" This can be annoying when typing on the laptop as bumping the trackpad accidentally can shift the cursor, so leave out "i" (insert mode)
" set mouse=a
set mouse=nvc
set backspace=2
set nf=alpha
set belloff=esc
set cursorline  " useful for terminals that don't have a cursor line like putty

" nice default, as this works well for a lot of things: python, json ...
set foldmethod=indent
set foldlevel=99

set tags=./tags;$HOME

autocmd Filetype javascript setlocal sw=2 ts=2 sts=2
autocmd Filetype coffee setlocal sw=2 ts=2 sts=2
autocmd Filetype html setlocal sw=1 ts=1 sts=1

autocmd! BufRead *.nc setfiletype netcdf
autocmd! Filetype netcdf silent :%!ncdump %

autocmd Filetype javascript setlocal makeprg=npx\ eslint\ --format\ unix
autocmd Filetype python setlocal makeprg=flake8
autocmd QuickFixCmdPost [^l]* cwindow
map <F6> :make %<CR>

" disable the annoying paren matching highlighting
let loaded_matchparen = 1 

set nobackup
set nowb
set noswapfile

map <F2> :NERDTreeToggle<CR>
map <leader><F2> :NERDTreeFind<CR>
set pastetoggle=<F3>
map <F4> :set nonumber!<CR>
map <F9> :au! TextChanged,TextChangedI <buffer> write<CR>
map <F10> :au! TextChanged,TextChangedI <buffer><CR>
map <leader><F9> :au! BufWritePost <buffer> silent! Black<CR>
map <leader><F10> :au! BufWritePost <buffer><CR>
map <script> <silent> <F11> :call ToggleQuickfixList()<CR>
map <C-D> :q<CR>
map <leader>t :tabe<CR>
map <leader>y "*y
map <leader>g :grep -rw <cword> *<CR>
map <leader>G :grep -r
map <leader>s <esc>:w<CR>
map <leader>f :FZF<CR>
map <leader>/ r✓
map <leader>x r✗

nnoremap <space> za
vnoremap <space> zf

" Use CR in preference to ESC to avoid interference with escaping to command mode
" https://stackoverflow.com/a/662914/739106
nnoremap <cr> :noh<return><cr>

function! PythonSetup() 
    map <F5> :%!isort -<CR>:w<CR>
    "map <F6> :Shell flake8 %<CR>
    "map <F7> :Shell ./manage.py test %<CR>
    map <F7> :call Pymodule()<CR>
    map <F8> Oimport ipdb; ipdb.set_trace()<ESC>:w<CR>
    map <F12> :Black<CR>:w<CR>
    map <leader><F9> :au! BufWritePost <buffer> silent! Black<CR>
    map <leader><F10> :au! BufWritePost <buffer><CR>
    map <leader>i :ImportName<CR> "requires https://github.com/mgedmin/python-imports.vim

    set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class,with,async
    inoremap # X#
    autocmd BufWritePre <buffer> call Trim()
    set foldmethod=indent
endfunction

autocmd FileType python call PythonSetup()

function! SqlSetup()
    " Requires brew install sqlparse
    map <F5> :%!sqlformat --reindent --keywords upper --identifiers lower -<CR>
endfunction

autocmd FileType sql call SqlSetup()

" previously term=standout ctermfg=4 ctermbg=7 guifg=DarkBlue guibg=LightGrey
hi Folded ctermfg=none ctermbg=none


function! Trim()
" remove trailing whitespace
:%s/\s\+$//ge
" Remove empty lines
":g/^$/d
endfunction

" change cursor iterm
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

let NERDTreeIgnore=['\.pyc$']
let NERDTreeHighlightCursorline=0  " not needed if using iterm line highlighting

if filereadable(".lvimrc")
    source .lvimrc
endif

command! -complete=shellcmd -nargs=+ Shell call s:RunShellCommand(<q-args>)
function! s:RunShellCommand(cmdline)
  echo a:cmdline
  let expanded_cmdline = a:cmdline
  for part in split(a:cmdline, ' ')
     if part[0] =~ '\v[%#<]'
        let expanded_part = fnameescape(expand(part))
        let expanded_cmdline = substitute(expanded_cmdline, part, expanded_part, '')
     endif
  endfor
  botright new
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
  call setline(1, 'You entered:    ' . a:cmdline)
  call setline(2, 'Expanded Form:  ' .expanded_cmdline)
  call setline(3,substitute(getline(2),'.','=','g'))
  execute '$read !'. expanded_cmdline
  setlocal nomodifiable
  1
endfunction

function! Pymodule()
  let module_name = substitute(substitute(@%, "/", ".", "g"), ".py", "", "g")
  let function_name =  expand("<cword>")
  execute "normal! ?class\<cr>W"
  let class_name = expand("<cword>")
  execute "normal! \<C-O>"
  echom module_name . "." . class_name . "." . function_name
endfunction

" Change cursor shape between insert and normal mode in iTerm2.app
if $TERM_PROGRAM =~ "iTerm"
    let &t_SI = "\<Esc>]50;CursorShape=1\x7" " Vertical bar in insert mode
    let &t_EI = "\<Esc>]50;CursorShape=0\x7" " Block in normal mode
endif
