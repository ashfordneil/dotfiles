" Plugins
call plug#begin('~/.config/nvim/plugged')
" aesthetic
Plug 'https://github.com/altercation/vim-colors-solarized'
Plug 'godlygeek/tabular'
" airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" files
Plug 'airblade/vim-rooter'
Plug 'cloudhead/neovim-fuzzy'
" git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
" commenting
Plug 'scrooloose/nerdcommenter'
Plug 'vim-scripts/DoxygenToolkit.vim'
" completion and intelligent plugins
Plug 'autozimu/LanguageClient-neovim'
Plug 'roxma/nvim-Completion-Manager'
" language specific
Plug 'rust-lang/rust.vim'
call plug#end()

" aesthetic
set background=light
color solarized
set nohlsearch

" airline
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_idx_mode = 2
let g:airline_powerline_fonts = 1

" rules and margins and spelling
set relativenumber
set number
autocmd FileType c,h,cpp,hpp,python,sh,mysql setlocal cc=80
autocmd FileType rust setlocal cc=100
autocmd FileType java setlocal cc=100
autocmd FileType tex,markdown set spell

" folding and indentation
set foldmethod=syntax
set smarttab
set expandtab
set softtabstop=4
set shiftwidth=4
set tabstop=4
set cino=N-s

" quick maps
imap jk <Esc>
imap kj <Esc>
nmap <leader>w :w<CR>
nmap ZA :xa<CR>

" buffers
set hidden
nmap <leader>e :e<space>
nmap <leader>n :enew<CR>
nmap <leader>q :bp<space><BAR><space>bd<space>#<CR>
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
nmap <leader>0 <Plug>AirlineSelectTab10

" windows
set splitright
set splitbelow
nmap <leader>v :vs<CR>
nmap <leader>s :sp<CR>
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

" fuzzy
nmap <C-p> :FuzzyOpen<CR>
nmap <leader>p :FuzzyGrep<CR>

" nerdcommenter
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDDefaultAlign = 'left'
let g:NERDTrimTrailingWhitespace = 1

" doxygen
let g:DoxygenToolkit_authorName="Neil Ashford"
nmap <leader>d :Dox<CR>

" tabular
vmap <leader>t :Tab<space>/
vmap <leader><space> :Tab<space>/=<CR>

" autoformat
autocmd FileType c,h,cpp,hpp nmap <leader>f :pyf /usr/local/share/clang/clang-format.py<CR>
autocmd FileType c,h,cpp,hpp vmap <leader>f :pyf /usr/local/share/clang/clang-format.py<CR>
let g:clang_format#detect_style_file = 1
autocmd FileType rust nmap <leader>f :RustFmt<CR>

" language servers
let g:LanguageClient_serverCommands = {
    \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
    \ }
let g:LanguageClient_autoStart = 1
nmap <silent> K :call LanguageClient_textDocument_hover()<CR>
nmap <leader>r :call LanguageClient_textDocument_rename()<CR>
nmap <leader>g :call LanguageClient_textDocument_definition()<CR>

" completion
imap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"