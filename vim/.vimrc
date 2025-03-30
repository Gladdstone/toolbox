set number
set cursorline
set splitright
set showcmd
set noshowmode
set whichwrap+=<,>,h,l,[,]
set conceallevel=1
set nowrap
set sidescroll=1
set sidescrolloff=5
set shortmess-=S
highlight clear SignColumn

vnoremap <C-c> "+y
nnoremap <C-c> "+yy

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
" fix mouse in WSL
" set ttymouse=sgr

set runtimepath+=$GOROOT/misc/vim
syntax enable
syntax sync minlines=256
filetype plugin on

" autocmd FileType yaml setlocal ts=4 sts=4 sw=4 expandtab
" autocmd FileType yml setlocal ts=4 sts=4 sw=4 expandtab
autocmd FileType cs setlocal ts=4 sts=4 sw=4 expandtab
autocmd FileType svg setlocal syntax=OFF
autocmd FileType python setlocal ts=2 sts=2 sw=2 expandtab

autocmd CursorMoved * silent! exe printf('match IncSearch /\<%s\>/', expand('<cword>'))

" grep
if executable('rg')
  set grepprg=rg\ -H\ --no-heading\ --vimgrep
  set grepformat=%f:%l:%c:%m
endif

" disable system chime
set belloff=all

" key remappings
noremap! <silent> <C-l> <Esc>
vnoremap <silent> <C-l> <Esc>
onoremap <silent> <C-l> <Esc>
noremap <silent> <leader>t :ter<CR>
noremap <leader>w :wa<CR>
noremap <leader>q :qa<CR>
noremap <leader>wq :wqa<CR>
noremap <leader>h <C-w>h
noremap <leader>j <C-w>j
noremap <leader>k <C-w>k
noremap <leader>l <C-w>l
for i in range(1,9)
  exec 'nnoremap <Leader>' . i . ' :tabn ' . i . '<CR>'
endfor

" fix scroll
function! AdjustScrolloff()
    let l:winheight = winheight(0)
    let l:ideal_scrolloff = l:winheight / 3
    execute 'set scrolloff=' . l:ideal_scrolloff
endfunction

augroup DynamicScrolloff
    autocmd!
    autocmd VimResized,WinEnter * call AdjustScrolloff()
augroup END

" vim-plug configuration
" Installation:
" Unix
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" Windows
" iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |`
"    ni $HOME/vimfiles/autoload/plug.vim -Force
" Neovim
" sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
"    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
call plug#begin()

" List your plugins here

Plug 'ryanoasis/vim-devicons'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
if has("gui_macvim")
  Plug 'crusoexia/vim-monokai'
endif

call plug#end()

" coc configuration
" Dependencies: ripgrep
" coc-pyright
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
\ "diagnostic.enableMessage": "always",
\ "diagnostic.virtualText": "true",
\ "diagnostic.virtualTextPrefix": "● ",
\ "suggest.enablePreview": "true",
\ }

autocmd BufReadPre,BufNewFile * if line('$') > 2000 | let g:coc_enable_highlight = 0 | endif
autocmd BufReadPre,BufNewFile * if line('$') > 1000 | let b:coc_diagnostic_enable = 0 | endif
autocmd BufReadPre,BufNewFile * if line('$') > 1000 | let g:coc_enable_completions = 0 | endif

" airline configuration
let g:airline_powerline_fonts = 1

" nerdtree configuration
nnoremap <C-t> : NERDTreeToggle<CR>
let NERDTreeShowHidden = 1
autocmd VimEnter * NERDTree
autocmd VimEnter * if len(argv()) > 0 | wincmd p | endif

" devicon configuration
" can't get it working with nerdtree for now so easier to just disable it
let g:webdevicons_enable_nerdtree = 1

" MacVim settings
if has("gui_macvim")
  set background=dark
  set guifont=hack_nerd_font:h12

  set termguicolors
  colorscheme monokai
endif

