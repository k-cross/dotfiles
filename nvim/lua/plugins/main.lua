-- every spec file under the "plugins" directory will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins
return {
  "reedes/vim-wordy",
  "Shatur/neovim-ayu",
  {
    "LazyVim/LazyVim",
    import = "lazyvim.plugins",
    opts = {
      colorscheme = "ayu-dark",
    },
  },
  { import = "lazyvim.plugins.extras.dap.core" },
  { import = "lazyvim.plugins.extras.formatting.black" },
  { import = "lazyvim.plugins.extras.formatting.prettier" },
  { import = "lazyvim.plugins.extras.lang.elixir" },
  -- add jsonls and schemastore packages, and setup treesitter for json, json5 and jsonc
  { import = "lazyvim.plugins.extras.lang.json" },
  { import = "lazyvim.plugins.extras.lang.python" },
  { import = "lazyvim.plugins.extras.lang.rust" },
  { import = "lazyvim.plugins.extras.lang.terraform" },
  { import = "lazyvim.plugins.extras.lang.tex" },
  -- for typescript, LazyVim also includes extra specs to properly setup lspconfig,
  -- treesitter, mason and typescript.nvim
  { import = "lazyvim.plugins.extras.lang.typescript" },
  -- change trouble config
  {
    "folke/trouble.nvim",
    -- opts will be merged with the parent spec
    opts = { use_diagnostic_signs = true },
  },
  -- override nvim-cmp and add cmp-emoji
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-emoji" },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      table.insert(opts.sources, { name = "emoji" })
    end,
  },
  -- add more treesitter parsers
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "c",
        "elixir",
        "erlang",
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
      },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
      theme = "auto",
      options = {
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
      },
    },
  },
  -- add any tools you want to have installed below
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "shellcheck",
        "shfmt",
      },
    },
  },
}
