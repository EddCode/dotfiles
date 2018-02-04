"==================
" GENERIC SETTINGS
"==================

set nocompatible


"================
" VUNDLE PLUGINS
"================
"Init vundle
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

"Actually needs to manage vundle
Plugin 'gmarik/vundle.vim'

" Plugins
Plugin 'scrooloose/nerdtree'
Plugin 'Valloric/YouCompleteMe'
Plugin 'majutsushi/tagbar'
Plugin 'ap/vim-buftabline'

"language support
Plugin 'jQuery'
Plugin 'tpope/vim-rails'
Plugin 'alvan/vim-closetag'

" Colors Theme
Plugin 'tomasr/molokai'
Plugin 'chriskempson/tomorrow-theme'
Plugin 'vim-scripts/Wombat'

" Finish Vundle initialization
call vundle#end()
filetype plugin indent on "Restore filetype

"==============
" FILE SETTINGS
"==============
set noswapfile
set nobackup

" Modify indent setting
set autoindent
set expandtab
set shiftwidth=4
set softtabstop=4

"HTML CSS JS gets 2 space indenting
autocmd FileType html, css, javascript \ setlocal shiftwidth=2 softtabstop=2

"================
" COLORS AND GUI
" ===============
syntax on
color molokai

set laststatus=2
set wildmenu
set nowrap
set number
"set cursorline
set showmatch "matching parentheses and brackets

"=======
" MAPS
"=======
let mapleader=","

"buftabline
set hidden
nnoremap <C-N> :bprev<CR>
nnoremap <C-M> :bnext<CR>

"Windows navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

"NERDTree: map ,nt for toggle nerdtree
"Tagbar: map F8 for toogle tagbar 
nmap <Leader>nt :NERDTreeToggle<cr>
nmap <F8> :TagbarToggle<cr>
:let g:NERDTreeWinZise=15
:let g:tagbar_width=15
