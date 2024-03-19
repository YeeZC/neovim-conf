return {
	{
		"hrsh7th/nvim-cmp",
		lazy = false,
		dependencies = { -- 排序优化
			"lukas-reineke/cmp-under-comparator", -- Snippet 引擎
			"hrsh7th/vim-vsnip", -- 补全源
			"hrsh7th/cmp-vsnip",
			"hrsh7th/cmp-nvim-lsp", -- { name = nvim_lsp }
			"hrsh7th/cmp-buffer", -- { name = 'buffer' },
			"hrsh7th/cmp-path", -- { name = 'path' }
			"hrsh7th/cmp-nvim-lsp-signature-help", -- { name = 'nvim_lsp_signature_help' }
			"hrsh7th/cmp-copilot",
			"hrsh7th/cmp-emoji", -- 常见编程语言代码段
			"rafamadriz/friendly-snippets",
			"b0o/schemastore.nvim",
			"github/copilot.vim",
			{
				"hrsh7th/cmp-cmdline",
				lazy = false,
			}, -- { name = 'cmdline' }
		},
		config = require("config.cmp"),
	}, -- 注释
	{
		"nvimdev/coman.nvim",
		event = "BufEnter",
	}, -- 自动闭合
	{
		"spf13/vim-autoclose",
		event = "BufEnter",
	},
	{
		"tpope/vim-endwise",
		event = "BufEnter",
	},
	{
		"nvim-pack/nvim-spectre",
		event = "BufEnter",
	},
	{
		"junegunn/vim-slash",
		event = "BufEnter",
	},
	{
		"tpope/vim-surround",
		event = "BufEnter",
	},
	{
		"machakann/vim-sandwich",
		event = "BufEnter",
	}, -- 代码格式化
	{
		"nvimtools/none-ls.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "nvimtools/none-ls-extras.nvim" },
		config = require("config.format"),
	}, -- git
	{
		"lewis6991/gitsigns.nvim",
		event = "BufEnter",
		dependencies = { "petertriho/nvim-scrollbar" },
		config = require("config.gitsigns"),
	},
	"kdheepak/lazygit.nvim", -- debug
	{

		"mfussenegger/nvim-dap",
		dependencies = { "theHamsta/nvim-dap-virtual-text", "rcarriga/nvim-dap-ui", "nvim-neotest/nvim-nio" },
		config = require("config.dap"),
	},
	{
		"norcalli/nvim-colorizer.lua",
		event = "BufEnter",
		config = function()
			require("colorizer").setup()
		end,
	}, -- vscode-go 当插件安装
	{
		"golang/vscode-go",
		branch = "release",
		build = "cd extension && npm install && npm run compile",
	},
	{
		"rbong/vim-flog",
		lazy = true,
		cmd = { "Flog", "Flogsplit", "Floggit" },
		dependencies = { "tpope/vim-fugitive" },
	},
}
