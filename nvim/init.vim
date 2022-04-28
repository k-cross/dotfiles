" Vim Settings Before Plugins

map <C-k> <C-w>k 
map <C-l> <C-w>l
map <C-h> <C-w>h
map <C-j> <C-w>j 
tmap <C-a><C-a> <C-\><C-n>

set tabstop=4 shiftwidth=4 softtabstop=4 scrolloff=2 expandtab
set mouse=a
set cursorline
set number
set wildignore+=**/node_modules/**,*/target/*,*/_build/*

let g:python3_host_prog = '/usr/local/bin/python3'

filetype plugin indent on
autocmd FileType python setlocal ts=4 sts=4 sw=4 expandtab
autocmd FileType verilog setlocal ts=4 sts=4 sw=4 expandtab
autocmd FileType text setlocal spell
autocmd FileType c setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType rust setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType tex setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType java setlocal ts=2 sts=2 sw=4 expandtab
autocmd FileType javascript setlocal ts=2 sts=2 sw=2 expandtab
autocmd BufNewFile,BufReadPost *.v setlocal filetype=verilog
autocmd BufNewFile,BufReadPost *.json setlocal filetype=javascript
autocmd BufNewFile,BufReadPost *.md setlocal filetype=markdown spell 
autocmd BufNewFile,BufReadPost *.csv setlocal filetype=csv
autocmd BufNewFile,BufReadPost *.tex setlocal filetype=tex spell

" Plugin Settings
set rtp+=~/.config/nvim/infections/repos/github.com/Shougo/dein.vim
set rtp+=/usr/local/opt/fzf

if dein#load_state(expand('~/.config/nvim/infections'))
    call dein#begin(expand('~/.config/nvim/infections'))
    call dein#add('Shatur/neovim-ayu')
    call dein#add('Shougo/dein.vim')
    call dein#add('SirVer/ultisnips')
    call dein#add('elixir-editors/vim-elixir')
    call dein#add('junegunn/fzf.vim')
    call dein#add('pangloss/vim-javascript')
    call dein#add('preservim/tagbar')
    call dein#add('reedes/vim-wordy')
    call dein#add('rust-lang/rust.vim')
    call dein#add('scrooloose/nerdtree')
    call dein#add('sheerun/vim-polyglot')
    call dein#add('tpope/vim-fugitive')
    call dein#add('vim-airline/vim-airline')
    call dein#add('vim-erlang/vim-erlang')
    call dein#add('w0rp/ale')
    call dein#end()
    call dein#save_state()
endif

let g:airline#extensions#ale#enabled = 1
let g:UltiSnipsExpandTrigger="<C-e>"
let g:tagbar_type_elixir = {
    \ 'ctagstype' : 'elixir',
    \ 'kinds' : [
        \ 'p:protocols',
        \ 'm:modules',
        \ 'e:exceptions',
        \ 'y:types',
        \ 'd:delegates',
        \ 'f:functions',
        \ 'c:callbacks',
        \ 'a:macros',
        \ 't:tests',
        \ 'i:implementations',
        \ 'o:operators',
        \ 'r:records'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 'p' : 'protocol',
        \ 'm' : 'module'
    \ },
    \ 'scope2kind' : {
        \ 'protocol' : 'p',
        \ 'module' : 'm'
    \ },
    \ 'sort' : 0
\ }

" ALE plugin setup
let g:ale_completion_enabled = 1
let g:ale_completion_autoimport = 1
let g:ale_fix_on_save = 1
let g:ale_linters = {'rust': ['rust-analyzer'], 'yaml': ['yamllint']}
let g:ale_fixers = {'rust': ['rustfmt'], 'javascript': ['prettier'], 'elixir': ['mix_format']}

nmap <F7> :NERDTreeToggle<CR>
nmap <F8> :NextWordy<CR>
nmap ;w :NextWordy<CR>

" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
            \ quit | endif

let NERDTreeQuitOnOpen = 1
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

" Vim Settings After Plugins
colorscheme ayu-dark
