local fn = vim.fn
local install_path = fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(install_path) then
	fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		install_path,
	})
end

vim.opt.rtp:prepend(install_path)
require("lazy").setup({
	-- 通知
	"rcarriga/nvim-notify",
	-- 美化
	-- 括号颜色
	{ "luochen1990/rainbow", event = "BufEnter" },
	-- 状态栏
	{
		"nvim-lualine/lualine.nvim",
		event = "BufEnter",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("lualine").setup({
				theme = "sonokai",
			})
		end,
	},
	{
		"akinsho/bufferline.nvim",
		version = "*",
		event = "BufEnter",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			vim.opt.termguicolors = true
			require("bufferline").setup({
				options = {
					offsets = {
						{
							filetype = "NvimTree",
							text = "File Explorer",
							text_align = "center",
							separator = true,
						},
					},
					diagnostics = "nvim_lsp",
				},
			})
		end,
	},
	-- 目录树
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
	},
	-- 主题管理
	-- "flazz/vim-colorschemes",
	-- 启动器
	{ "mhinz/vim-startify", lazy = false },
	-- 主题颜色
	{ "sainnhe/sonokai", event = "BufEnter" },
	-- 注释
	{ "nvimdev/coman.nvim", event = "BufEnter" },
	-- 自动闭合
	{ "spf13/vim-autoclose", event = "BufEnter" },
	{ "tpope/vim-endwise", event = "BufEnter" },
	-- search
	{
		"haya14busa/incsearch-fuzzy.vim",
		lazy = false,
		dependencies = "haya14busa/incsearch.vim",
		config = function()
			require("plugin.incsearch").setup()
		end,
	},
	{ "junegunn/vim-slash", event = "BufEnter" },
	{ "tpope/vim-surround", event = "BufEnter" },
	{ "machakann/vim-sandwich", event = "BufEnter" },

	{
		"neovim/nvim-lspconfig",
		"williamboman/nvim-lsp-installer",
	},
	-- lua 增强
	{ "folke/neodev.nvim", event = "BufEnter" },
	-- TypeScript 增强
	{ "jose-elias-alvarez/nvim-lsp-ts-utils", dependencies = "nvim-lua/plenary.nvim" },
	-- 补全引擎
	{
		"hrsh7th/nvim-cmp",
		lazy = false,
		dependencies = {
			-- 排序优化
			"lukas-reineke/cmp-under-comparator",
			-- Snippet 引擎
			"hrsh7th/vim-vsnip",
			-- 补全源
			"hrsh7th/cmp-vsnip",
			"hrsh7th/cmp-nvim-lsp", -- { name = nvim_lsp }
			"hrsh7th/cmp-buffer", -- { name = 'buffer' },
			"hrsh7th/cmp-path", -- { name = 'path' }
			"hrsh7th/cmp-nvim-lsp-signature-help", -- { name = 'nvim_lsp_signature_help' }
			"hrsh7th/cmp-copilot",
			"hrsh7th/cmp-emoji",
			-- 常见编程语言代码段
			"rafamadriz/friendly-snippets",
			"b0o/schemastore.nvim",
			"github/copilot.vim",
			{ "hrsh7th/cmp-cmdline", lazy = false }, -- { name = 'cmdline' }
		},
	},

	-- telescope
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "kdheepak/lazygit.nvim" },
	},

	-- telescope extensions
	"LinArcX/telescope-env.nvim",
	"nvim-telescope/telescope-dap.nvim",
	"nvim-telescope/telescope-ui-select.nvim",
	"onsails/lspkind.nvim",
	{
		"nvimdev/lspsaga.nvim",
		branch = "main",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"nvim-treesitter/nvim-treesitter",
		},
	},
	-- 代码格式化
	{ "jose-elias-alvarez/null-ls.nvim", dependencies = "nvim-lua/plenary.nvim" },

	-- git
	"lewis6991/gitsigns.nvim",
	"kdheepak/lazygit.nvim",
	-- debug
	"mfussenegger/nvim-dap",
	"theHamsta/nvim-dap-virtual-text",
	"rcarriga/nvim-dap-ui",

	-- treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
	},

	-- vscode-go 当插件安装
	{
		"golang/vscode-go",
		branch = "release",
		build = "npm install && npm run compile",
	},
	{'akinsho/toggleterm.nvim', version = "*", event="BufEnter", config = function()
		require("toggleterm").setup({
			direction = "float",
		})
	end}
}, {
	defaults = { lazy = true },
	install = { colorscheme = { "sonokai" } },
	checker = { enabled = true },
	performance = {
		rtp = {
			disabled_plugins = {
				"gzip",
				"matchit",
				"matchparen",
				"netrwPlugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
	-- debug = true,
})
