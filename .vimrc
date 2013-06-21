set bg=dark
set ts=2
set sw=2
set noet
set hlsearch
set ruler
set scrolloff=10
set sidescrolloff=10
set showcmd
set showmatch
set ai
set number

set nobackup
set nowb
set noswapfile

source $VIMRUNTIME/mswin.vim
behave mswin

autocmd BufWritePost .vimrc source %

if has('mouse')
	set mouse=a
endif
