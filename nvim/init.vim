"<AUTHOR> k-cross

let g:python3_host_prog = '/usr/local/bin/python3'

set runtimepath+=~/.config/nvim/infections/repos/github.com/Shougo/dein.vim

if dein#load_state(expand('~/.config/nvim/infections'))
    call dein#begin(expand('~/.config/nvim/infections'))
    call dein#add('w0rp/ale')
    call dein#add('Shougo/dein.vim')
    call dein#add('Shougo/deoplete.nvim')
    call dein#add('vim-airline/vim-airline')
    call dein#add('mileszs/ack.vim')
    call dein#add('tpope/vim-fugitive')
    call dein#add('godlygeek/tabular')
    call dein#add('SirVer/ultisnips')
    call dein#add('ctrlpvim/ctrlp.vim')
    call dein#add('scrooloose/nerdtree')
    call dein#add('ludovicchabant/vim-gutentags')
    call dein#add('majutsushi/tagbar')
    call dein#add('slashmili/alchemist.vim')
    call dein#add('sheerun/vim-polyglot')
    call dein#add('elixir-editors/vim-elixir')
    call dein#add('rust-lang/rust.vim')
    call dein#add('prettier/vim-prettier')
    call dein#add('pangloss/vim-javascript')
    call dein#end()
    call dein#save_state()
endif

syntax on
colorscheme jellyx

nmap <F7> :NERDTreeToggle<CR>
nmap <F8> :TagbarToggle<CR>
nmap ;p :Prettier<CR>

let g:gutentags_cache_dir = '~/.tags_cache'
let g:gutentags_ctags_exclude = ['*.css', '*node_modules']
let g:alchemist_tag_disable = 1
let g:airline#extensions#ale#enabled = 1
if executable('ag')
    let g:ctrlp_user_command = 
        \ 'ag %s --files-with-matches -g "" --ignore "\.git$\|\.hg$\|\.svn$|node_modules$"'
    let g:ctrlp_use_cacheing = 0
else
  let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$|node_modules$'
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others']
endif

map <C-k> <C-w>k 
map <C-l> <C-w>l
map <C-h> <C-w>h
map <C-j> <C-w>j 
tmap <C-a><C-a> <C-\><C-n>

set tabstop=4 shiftwidth=4 softtabstop=4 scrolloff=2 expandtab
set mouse=a
set relativenumber
set hidden
set background=dark

if executable('ag')
    let g:ackprg = 'ag --vimgrep'
endif

let g:deoplete#enable_at_startup = 1
let g:UltiSnipsExpandTrigger="<C-e>"

filetype plugin indent on
autocmd FileType python setlocal ts=4 sts=4 sw=4 expandtab
autocmd FileType verilog setlocal ts=4 sts=4 sw=4 expandtab
autocmd FileType text setlocal spell
autocmd FileType c setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType tex setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType java setlocal ts=2 sts=2 sw=4 expandtab
autocmd BufNewFile,BufReadPost *.v setlocal filetype=verilog
autocmd BufNewFile,BufReadPost *.json setlocal filetype=javascript
autocmd BufNewFile,BufReadPost *.md setlocal filetype=markdown spell 
autocmd BufNewFile,BufReadPost *.csv setlocal filetype=csv
autocmd BufNewFile,BufReadPost *.tex setlocal filetype=tex spell
