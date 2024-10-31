set number
set cursorline
set scrolloff=50
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
Plug 'dense-analysis/ale'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-commentary'
Plug 'ryanoasis/vim-devicons'
Plug 'scrooloose/nerdtree'

call plug#end()

" ale configuration
let g:ale_sign_error = '❌'
let g:ale_sign_warning = '⚠️'

" let g:ale_hover_cursor = 1
" let g:ale_floating_preview = 1
" let g:ale_hover_to_floating_preview = 1
" let g:ale_hover_cursor = 1
" let g:ale_completion_enabled = 1
" let g:airline#extensions#ale#enabled = 1
let g:ale_linters = {'python': ['flake8']}

highlight clear ALEErrorSign
highlight clear ALEWarningSign

" airline configuration
let g:airline_powerline_fonts = 1

" nerdtree configuration
nnoremap <C-t> : NERDTreeToggle<CR>
let NERDTreeShowHidden = 1

" devicon configuration
" let g:WebDevIconsOS = 'Darwin'
" let g:webdevicons_enable = 1
" let g:webdevicons_enable_nerdtree = 1
" let g:webdevicons_enable_airline_tabline = 1
" let g:webdevicons_enable_airline_statusline = 1
