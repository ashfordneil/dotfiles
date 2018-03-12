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
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-eunuch'
" git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'Xuyuanp/nerdtree-git-plugin'
" commenting
Plug 'scrooloose/nerdcommenter'
Plug 'vim-scripts/DoxygenToolkit.vim'
" make it an IDE now
Plug 'autozimu/LanguageClient-neovim', {
            \ 'branch': 'next',
            \ 'do': 'bash install.sh',
            \ }
Plug 'roxma/nvim-Completion-Manager'
Plug 'ashfordneil/vim-polyglot'
" quality of life
Plug 'tpope/vim-abolish'
call plug#end()

" aesthetic
set background=light
color solarized
set nohlsearch
set im!

" airline
let g:airline#extensions#tabline#enabled = 1 " turn it on
let g:airline_powerline_fonts = 1 " make it look nice

let g:airline#extensions#tabline#fnamemod = ':.' " buffer name format
let g:airline#extensions#tabline#show_buffers = 1 " buffers always shown
let g:airline#extensions#tabline#buffer_idx_mode = 2 " buffer numbers always shown

" rules and margins and spelling
set relativenumber
set number
autocmd FileType c,h,cpp,hpp,python,sh,mysql,javascript,typescript setlocal cc=80
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

" quick things
imap jk <Esc>
imap kj <Esc>
nmap <leader>w :w<CR>
nmap ZA :xa<CR>
set mouse=n

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
nmap <leader>- <Plug>AirlineSelectPrevTab
nmap <leader>+ <Plug>AirlineSelectNextTab

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

" rooter
let g:rooter_patterns = ['package.json', '.git/']

" nerdtree
nmap <leader>o :NERDTreeToggle<CR>
autocmd StdinReadPre * let s:std_in=1
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let NERDTreeShowLineNumbers=1
autocmd FileType nerdtree setlocal relativenumber

" tabular
vmap <leader>t :Tab<space>/
vmap <leader><space> :Tab<space>/=<CR>

" language servers
let g:LanguageClient_serverCommands = {
    \ 'rust': ['rls'],
    \ 'go': ['go-langserver'],
    \ 'java': ['java', '-cp', '/usr/opt/jls.jar', 'org.javacs.Main'],
    \ 'typescript': ['tsserver'],
    \ 'javascript.jsx': ['javascript-typescript-stdio'],
    \ 'css': ['css-languageserver', '--stdio'],
    \ 'json': ['json-languageserver', '--stdio'],
    \ 'html': ['html-languageserver', '--stdio'],
    \ 'elixir': ['bash', '-c', 'ERL_LIBS=/usr/opt/lsp mix elixir_ls.language_server'],
    \ 'c': ['/usr/local/opt/llvm/bin/clangd'],
    \ 'objc': ['/usr/local/opt/llvm/bin/clangd'],
    \ 'python': ['pyls'],
    \ }
let g:LanguageClient_autoStart = 1
nmap <silent> K :call LanguageClient_textDocument_hover()<CR>
nmap <leader>r :call LanguageClient_textDocument_rename()<CR>
nmap <leader>g :call LanguageClient_textDocument_definition()<CR>
nmap <leader>d :call LanguageClient_textDocument_codeAction()<CR>
nmap <leader>f :call LanguageClient_textDocument_formatting()<CR>
vmap <leader>f :call LanguageClient_textDocument_rangeFormatting()<CR>
nmap <leader>l :call LanguageClient_textDocument_references()<CR>
nmap <leader>a :call LanguageClient_workspace_symbol()<CR>

" completion
imap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
imap <expr><S-tab> pumvisible() ? "\<c-p>" : "\<tab>"

" marking
autocmd BufRead,BufNewFile *.styled set filetype=c
autocmd BufEnter,WinEnter *.styled call matchadd("SpecialComment", "^\[[A-Za-z\-]*\].*$", -1)
autocmd BufEnter,WinEnter *.styled syn match cComment "^\[[A-Za-z\-]*\].*$"
