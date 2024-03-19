return {
	{
		"hrsh7th/nvim-cmp",
		lazy = false,
		event = "InsertEnter",
		dependencies = { -- 排序优化
			"lukas-reineke/cmp-under-comparator", -- Snippet 引擎
			"hrsh7th/vim-vsnip", -- 补全源
			"hrsh7th/cmp-vsnip",
			"hrsh7th/cmp-nvim-lsp", -- { name = nvim_lsp }
			"hrsh7th/cmp-buffer", -- { name = 'buffer' },
			"hrsh7th/cmp-path", -- { name = 'path' }
			"hrsh7th/cmp-nvim-lsp-signature-help", -- { name = 'nvim_lsp_signature_help' }
			"hrsh7th/cmp-emoji", -- 常见编程语言代码段
			"rafamadriz/friendly-snippets",
			"b0o/schemastore.nvim",
			{
				"zbirenbaum/copilot.lua",
				cmd = "Copilot",
				event = "InsertEnter",
				config = function()
					require("copilot").setup({
						suggestion = { enabled = false },
						panel = { enabled = false },
					})
				end,
			},
			{
				"zbirenbaum/copilot-cmp",
				config = function()
					require("copilot_cmp").setup()
				end,
			},
			{
				"hrsh7th/cmp-cmdline",
				event = "InsertEnter",
			}, -- { name = 'cmdline' }
		},
		config = require("config.cmp"),
	}, -- 注释
	{
		"nvimdev/coman.nvim",
		event = "BufEnter",
	},
	{
		"danymat/neogen",
		event = "BufEnter",
		config = true,
		-- Uncomment next line if you want to follow only stable versions
		-- version = "*"
	},

	{
		"folke/todo-comments.nvim",
		event = "BufEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			signs = true, -- show icons in the signs column
			sign_priority = 8, -- sign priority
			-- keywords recognized as todo comments
			keywords = {
				FIX = {
					icon = " ", -- icon used for the sign, and in search results
					color = "error", -- can be a hex color, or a named color (see below)
					alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
					-- signs = false, -- configure signs for some keywords individually
				},
				TODO = { icon = " ", color = "info" },
				HACK = { icon = " ", color = "warning" },
				WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
				PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
				NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
				TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
			},
		},
	},
	-- 自动闭合
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
	-- 	{
	-- 		"nvimtools/none-ls.nvim",
	-- 		dependencies = { "nvim-lua/plenary.nvim", "nvimtools/none-ls-extras.nvim" },
	-- 		config = require("config.format"),
	-- 	}, -- git
	{
		"stevearc/conform.nvim",
		event = "BufEnter",
		opts = {},
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					lua = { "stylua" },
					go = { "goimports", "gofmt" },
					javascript = { { "prettierd", "prettier" } },
					python = { "black" },
					["*"] = { "codespell" },
					["_"] = { "trim_whitespace" },
				},
				format_on_save = {
					lsp_fallback = true,
					timeout_ms = 500,
				},
				format_after_save = {
					lsp_fallback = true,
				},
				log_level = vim.log.levels.ERROR,
				notify_on_error = true,
			})
		end,
	},
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
