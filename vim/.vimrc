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
set signcolumn=auto
highlight SignColumn guibg=NONE ctermbg=NONE

" adjusting this lower can affect performance
set updatetime=4000

vnoremap <C-c> "+y
nnoremap <C-c> "+yy

set encoding=UTF-8

" sometimes required to fix backspace on Windows
set backspace=indent,eol,start

" spaces instead of tabs
set tabstop=4 softtabstop=4 shiftwidth=4
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
autocmd FileType svg setlocal syntax=OFF
autocmd FileType python setlocal ts=2 sts=2 sw=2 expandtab
" tabs are a hard requirement for Makefiles
autocmd FileType make setlocal noexpandtab tabstop=8 shiftwidth=8 softtabstop=0

" highlight on hover
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
if !has('nvim')
  noremap <silent> <leader>t :ter<CR>
endif
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
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/nerdtree'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
if !has('nvim')
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
endif
if has('nvim')
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'nvim-treesitter/nvim-treesitter-textobjects'
endif
if has("gui_macvim")
  Plug 'crusoexia/vim-monokai'
endif

call plug#end()

" disable some plugins for large files
let g:line_threshold = 5000

augroup LargeFilePluginDisabler
  autocmd!
  autocmd BufReadPost * call s:disable_plugins_for_large_files()
augroup END

function! s:disable_plugins_for_large_files()
  if line('$') > g:line_threshold

    if exists('*coc#rpc#stop_server')
      " Disable CoC for this buffer
      call coc#rpc#stop_server()
    endif

    echom "Large file detected (" . line('$') . " lines) — disabling some plugins."
  endif
endfunction

if !has('nvim')
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
  \ "rust-analyzer.cargo.cfgs": [],
  \ }
endif
" display docs with 'K' on cursor hover
nmap <silent> K :call CocActionAsync('doHover')<CR>

let g:coc_disable_startup_warning = 1

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

" Neovim settings
if has('nvim')
noremap <silent> <leader>t :vert split +term<CR>

lua << EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "c" },

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },

  rainbow = {
    enable = true,
    extended_mode = true, -- highlight more than just brackets
    max_file_lines = nil, -- disable on very large files
  },

  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- jump to next text object automatically

      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
  },

  move = {
    enable = true,
    set_jumps = true,

    goto_next_start = {
      ["<leader>f"] = "@function.outer",
      ["]]"] = "@class.outer",
    },
    goto_previous_start = {
      ["<leader>F"] = "@function.outer",
      ["[["] = "@class.outer",
    },
  },
}
EOF
endif
