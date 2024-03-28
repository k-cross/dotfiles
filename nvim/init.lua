-- Vim Settings Before Plugins
local autocmd = vim.api.nvim_create_autocmd
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

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
		"nvim-tree/nvim-tree.lua",
		"preservim/tagbar",
		"reedes/vim-wordy",
		"tpope/vim-fugitive",
		{
			"williamboman/mason.nvim",
			cmd = "Mason",
			keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
			build = ":MasonUpdate",
			opts = {
				ensure_installed = {
					"pyright",
					"stylua",
					"shfmt",
					"typescript-language-server",
					-- "flake8",
				},
			},
			---@param opts MasonSettings | {ensure_installed: string[]}
			config = function(_, opts)
				require("mason").setup(opts)
				local mr = require("mason-registry")
				mr:on("package:install:success", function()
					vim.defer_fn(function()
						-- trigger FileType event to possibly load this newly installed LSP server
						require("lazy.core.handler.event").trigger({
							event = "FileType",
							buf = vim.api.nvim_get_current_buf(),
						})
					end, 100)
				end)
				local function ensure_installed()
					for _, tool in ipairs(opts.ensure_installed) do
						local p = mr.get_package(tool)
						if not p:is_installed() then
							p:install()
						end
					end
				end
				if mr.refresh then
					mr.refresh(ensure_installed)
				else
					ensure_installed()
				end
			end,
		},
		{
			"stevearc/conform.nvim",
			opts = {
				formatters_by_ft = {
					lua = { "stylua" },
					-- Conform will run multiple formatters sequentially
					python = { "black" },
					rust = { "rustfmt" },
					javascript = { "prettierd" },
					["*"] = { "trim_whitespace" },
				},
				format_on_save = {
					-- These options will be passed to conform.format()
					timeout_ms = 500,
					lsp_fallback = true,
				},
			},
		},
		{
			"neovim/nvim-lspconfig",
			dependencies = {},
			opts = {
				servers = {
					tsserver = {
						cmd = {
							vim.fn.stdpath("data")
								.. "/mason/packages/typescript-language-server/node_modules/typescript-language-server/lib/cli.js",
							"--stdio",
						},
						on_attach = function(client, bufnr)
							-- use null-ls & eslint_d for formatting
							client.server_capabilities.documentFormattingProvider = false
							enhance_attach(client, bufnr)
						end,
						flags = {
							debounce_text_changes = 150,
						},
						capabilities = capabilities,
					},
					pyright = {
						cmd = {
							vim.fn.stdpath("data") .. "/mason/bin/pyright-langserver",
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
					},
				},
			},
		},
		{
			"nvim-treesitter/nvim-treesitter",
			opts = function(_, opts)
				opts.ensure_installed = opts.ensure_installed or {}
				vim.list_extend(opts.ensure_installed, {
					"bash",
					"c",
					"hcl",
					"html",
					"javascript",
					"lua",
					"markdown",
					"ninja",
					"rst",
					"python",
					"ron",
					"rust",
					"terraform",
					"toml",
					"typescript",
					"vim",
					"yaml",
				})
			end,
		},
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
			version = "^4", -- Recommended
			ft = { "rust" },
			opts = {
				server = {
					on_attach = function(_, bufnr)
						vim.keymap.set("n", "<leader>cR", function()
							vim.cmd.RustLsp("codeAction")
						end, { desc = "Code Action", buffer = bufnr })
						vim.keymap.set("n", "<leader>dr", function()
							vim.cmd.RustLsp("debuggables")
						end, { desc = "Rust debuggables", buffer = bufnr })
					end,
					default_settings = {
						-- rust-analyzer language server configuration
						["rust-analyzer"] = {
							cargo = {
								allFeatures = true,
								loadOutDirsFromCheck = true,
								runBuildScripts = true,
							},
							-- Add clippy lints for Rust.
							checkOnSave = {
								allFeatures = true,
								command = "clippy",
								extraArgs = { "--no-deps" },
							},
							procMacro = {
								enable = true,
								ignored = {
									["async-trait"] = { "async_trait" },
									["napi-derive"] = { "napi" },
									["async-recursion"] = { "async_recursion" },
								},
							},
						},
					},
				},
			},
			config = function(_, opts)
				vim.g.rustaceanvim = vim.tbl_deep_extend("keep", vim.g.rustaceanvim or {}, opts or {})
			end,
		},
	},
})

vim.opt.rtp:prepend("/opt/homebrew/bin/fzf")

-- Vim Settings After Plugins
vim.cmd.colorscheme("ayu-dark")

-- Key Mappings
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")

-- Plugin Mappings
vim.keymap.set("n", "<F7>", ":NvimTreeToggle<CR>")
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

autocmd("FileType", {
	pattern = { "python", "verilog" },
	command = "setlocal ts=4 sts=4 sw=4 expandtab",
})

autocmd("FileType", {
	pattern = { "c", "lua", "tex", "html", "javascript", "java" },
	command = "setlocal ts=4 sts=4 sw=4 expandtab",
})

autocmd("FileType", { pattern = { "text" }, command = "setlocal spell" })

autocmd({ "BufNewFile", "BufReadPost" }, { pattern = "*.kdl", command = "setlocal filetype=kdl" })
autocmd({ "BufNewFile", "BufReadPost" }, { pattern = "*.lua", command = "setlocal filetype=lua" })
autocmd({ "BufNewFile", "BufReadPost" }, { pattern = "*.json", command = "setlocal filetype=javascript" })
autocmd({ "BufNewFile", "BufReadPost" }, { pattern = "*.md", command = "setlocal filetype=markdown spell" })
autocmd({ "BufNewFile", "BufReadPost" }, { pattern = "*.csv", command = "setlocal filetype=csv" })
autocmd({ "BufNewFile", "BufReadPost" }, { pattern = "*.tex", command = "setlocal filetype=tex spell" })
