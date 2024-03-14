-- Vim Settings Before Plugins
local autocmd = vim.api.nvim_create_autocmd
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')

-- Plugin Mappings
vim.keymap.set('n', '<F7>', ':NERDTreeToggle<CR>')
vim.keymap.set('n', '<F8>', ':TagbarToggle<CR>')
vim.keymap.set('n', ';w', ':NextWordy<CR>')

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.scrolloff = 2
vim.opt.expandtab = true
vim.opt.mouse = 'a'
vim.opt.cursorline = true
vim.opt.number = true
vim.opt.wildignore = { '*/tmp/*', '*/target/*' , '*.so', '*.swp', '*.zip', '*/_build/*', '*/node_modules/*', '*/.git/*', '*/deps/*' }
vim.g.python3_host_prog = '/usr/bin/env python3'

autocmd('FileType', {
   pattern = { 'python', 'verilog' },
   command = 'setlocal ts=4 sts=4 sw=4 expandtab' 
})

autocmd('FileType', {
   pattern = { 'c', 'tex', 'html', 'javascript', 'java' },
   command = 'setlocal ts=4 sts=4 sw=4 expandtab' 
})

autocmd('FileType', {pattern = { 'text' }, command = 'setlocal spell'})

autocmd({'BufNewFile', 'BufReadPost'}, {pattern = '*.kdl', command = 'setlocal filetype=kdl'})
autocmd({'BufNewFile', 'BufReadPost'}, {pattern = '*.json', command = 'setlocal filetype=javascript'})
autocmd({'BufNewFile', 'BufReadPost'}, {pattern = '*.md', command = 'setlocal filetype=markdown spell'})
autocmd({'BufNewFile', 'BufReadPost'}, {pattern = '*.csv', command = 'setlocal filetype=csv'})
autocmd({'BufNewFile', 'BufReadPost'}, {pattern = '*.tex', command = 'setlocal filetype=tex spell'})

-- Plugin Settings
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
   'Shatur/neovim-ayu',
   'elixir-editors/vim-elixir',
   'hashivim/vim-terraform',
   'imsnif/kdl.vim',
   'junegunn/fzf.vim',
   'pangloss/vim-javascript',
   'preservim/tagbar',
   'reedes/vim-wordy',
   'rodjek/vim-puppet',
   'rust-lang/rust.vim',
   'scrooloose/nerdtree',
   'sheerun/vim-polyglot',
   'tpope/vim-fugitive',
   'vim-erlang/vim-erlang',
   'w0rp/ale',
   'f-person/git-blame.nvim',
   --{
   --  'nvim-lualine/lualine.nvim',
   --  options = {},
   --  -- Show git blame info in the status line
   --  sections = {
   --      lualine_c = { { gitblame.get_current_blame_text, cond = gitblame.is_blame_text_available } }
   --  }
   --},
})

vim.opt.rtp:prepend('/usr/local/opt/fzf')

-- This disables showing of the blame text next to the cursor
vim.g.gitblame_display_virtual_text = 0

-- ALE plugin setup
vim.g.ale_completion_enabled = 1
vim.g.ale_completion_autoimport = 1
vim.g.ale_fix_on_save = 1
--vim.g.ale_linters = {'rust': ['analyzer', 'clippy'], 'yaml': ['yamllint']}
--vim.g.ale_fixers = {'rust': ['rustfmt'], 'elixir': ['mix_format'], 'python': ['black'], 'javascript': ['prettier']}

-- Vim Settings After Plugins
vim.cmd.colorscheme('ayu-dark')
