set number
set cursorline
set scrolloff=50
set splitright
set showcmd
set noshowmode
set conceallevel=1
highlight clear SignColumn

set encoding=UTF-8

" sometimes required to fix backspace on Windows
set backspace=indent,eol,start

" spaces instead of tabs
set tabstop=2 softtabstop=2 shiftwidth=2
set expandtab
set autoindent
set smartindent

" search settings
set ignorecase
set smartcase
set incsearch
set hlsearch
nnoremap <CR> :noh<CR><CR>:<backspace> " when in normal mode, enter returns :noh

set mouse=a
set mousemodel=popup_setpos

set runtimepath+=$GOROOT/misc/vim
syntax enable
filetype plugin on

autocmd FileType yaml setlocal ts=4 sts=4 sw=4 expandtab
autocmd FileType yml setlocal ts=4 sts=4 sw=4 expandtab

" disable system chime
set belloff=all

" vim-plug configuration
" Installation:
" Unix
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" Windows
" iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |`
"    ni $HOME/vimfiles/autoload/plug.vim -Force
call plug#begin()

" List your plugins here

Plug 'ryanoasis/vim-devicons'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-commentary'
Plug 'scrooloose/nerdtree'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

call plug#end()

" coc configuration
" Dependencies: ripgrep
" coc-python
" coc-rust-analyzer
" coc-go
" coc-java
" coc-tsserver
" coc-omnisharp (dotnet)
let g:coc_user_config = {
\ "diagnostic.errorSign": "❌",
\ "diagnostic.warningSign": "⚠️ ",
\ "diagnostic.infoSign": "ℹ",
\ "diagnostic.hintSign": "➤",
\ "diagnostic.virtualTextPrefix": "● ",
\ }

" airline configuration
let g:airline_powerline_fonts = 1

" nerdtree configuration
nnoremap <C-t> : NERDTreeToggle<CR>
let NERDTreeShowHidden = 1

" devicon configuration
" can't get it working with nerdtree for now so easier to just disable it
let g:webdevicons_enable_nerdtree = 0
