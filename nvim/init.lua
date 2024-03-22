-- Vim Settings Before Plugins
local autocmd = vim.api.nvim_create_autocmd
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")

-- Plugin Mappings
vim.keymap.set("n", "<F7>", ":NERDTreeToggle<CR>")
vim.keymap.set("n", "<F8>", ":TagbarToggle<CR>")
vim.keymap.set("n", ";w", ":NextWordy<CR>")

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.scrolloff = 2
vim.opt.expandtab = true
vim.opt.mouse = "a"
vim.opt.cursorline = true
vim.opt.number = true
vim.opt.wildignore =
	{ "*/tmp/*", "*/target/*", "*.so", "*.swp", "*.zip", "*/_build/*", "*/node_modules/*", "*/.git/*", "*/deps/*" }
vim.g.python3_host_prog = "/usr/bin/env python3"

autocmd("FileType", {
	pattern = { "python", "verilog" },
	command = "setlocal ts=4 sts=4 sw=4 expandtab",
})

autocmd("FileType", {
	pattern = { "c", "tex", "html", "javascript", "java" },
	command = "setlocal ts=4 sts=4 sw=4 expandtab",
})

autocmd("FileType", { pattern = { "text" }, command = "setlocal spell" })

autocmd({ "BufNewFile", "BufReadPost" }, { pattern = "*.kdl", command = "setlocal filetype=kdl" })
autocmd({ "BufNewFile", "BufReadPost" }, { pattern = "*.json", command = "setlocal filetype=javascript" })
autocmd({ "BufNewFile", "BufReadPost" }, { pattern = "*.md", command = "setlocal filetype=markdown spell" })
autocmd({ "BufNewFile", "BufReadPost" }, { pattern = "*.csv", command = "setlocal filetype=csv" })
autocmd({ "BufNewFile", "BufReadPost" }, { pattern = "*.tex", command = "setlocal filetype=tex spell" })

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
	spec = {
		"Shatur/neovim-ayu",
		"elixir-editors/vim-elixir",
		"imsnif/kdl.vim",
		"junegunn/fzf.vim",
		"neovim/nvim-lspconfig",
		"nvim-treesitter/nvim-treesitter",
		"preservim/tagbar",
		"reedes/vim-wordy",
		"scrooloose/nerdtree",
		"sheerun/vim-polyglot",
		"tpope/vim-fugitive",
		{
			"hashivim/vim-terraform",
			ft = { "terraform" },
		},
		{
			"pangloss/vim-javascript",
			ft = { "javascript" },
		},
		{
			"rust-lang/rust.vim",
			ft = { "rust" },
		},
		{
			"nvim-lualine/lualine.nvim",
			dependencies = {
				"nvim-tree/nvim-web-devicons",
			},
			opts = {
				options = {
					icons_enabled = true,
					theme = "auto",
					component_separators = { left = "", right = "" },
					section_separators = { left = "", right = "" },
					disabled_filetypes = {
						statusline = {},
						winbar = {},
					},
					ignore_focus = {},
					always_divide_middle = true,
					globalstatus = false,
					refresh = {
						statusline = 1000,
						tabline = 1000,
						winbar = 1000,
					},
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch", "diff", "diagnostics" },
					lualine_c = { "filename" },
					lualine_x = { "encoding", "fileformat", "filetype" },
					lualine_y = { "progress" },
					lualine_z = { "location" },
				},
				tabline = {},
				winbar = {},
				inactive_winbar = {},
				extensions = { "nvim-tree" },
			},
		},
		{
			"mrcjkb/rustaceanvim",
			ft = { "rust" },
		},
	},
})

local lspconfig = require("lspconfig")
lspconfig.tsserver.setup({})
lspconfig.rust_analyzer.setup({
	-- Server-specific settings. See `:help lspconfig-setup`
	settings = {
		["rust-analyzer"] = {},
	},
})
lspconfig.pyright.setup({
	cmd = {
		vim.fn.stdpath("data") .. "/lsp_servers/python/node_modules/.bin/pyright-langserver",
		"--stdio",
	},
	on_attach = enhance_attach,
	capabilities = capabilities,
	settings = {
		python = {
			analysis = {
				typeCheckingMode = "off",
				autoSearchPaths = true,
				useLibraryCodeForTypes = false,
				diagnosticMode = "openFilesOnly",
				autoImportCompletions = true,
			},
		},
	},
})

vim.opt.rtp:prepend("/usr/local/opt/fzf")

-- Vim Settings After Plugins
vim.cmd.colorscheme("ayu-dark")
