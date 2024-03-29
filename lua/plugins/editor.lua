return {
	{
		"kevinhwang91/nvim-hlslens",
		event = "BufEnter",
		dependencies = { "petertriho/nvim-scrollbar" },
		config = require("config.editor").hlslens,
	},
	{
		"petertriho/nvim-scrollbar",
		config = require("config.editor").scrollbar,
	}, -- 通知
	{
		"rcarriga/nvim-notify",
		event = "BufEnter",
		config = require("config.editor").notify,
	}, -- float terminal
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		event = "BufEnter",
		config = function()
			require("toggleterm").setup({
				direction = "float",
			})
		end,
	},
	-- 括号颜色
	{ "luochen1990/rainbow", event = "BufEnter" },
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
	}, -- telescope
	{
		"nvim-telescope/telescope.nvim",
		event = "BufEnter",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"kdheepak/lazygit.nvim", -- telescope extensions
			"LinArcX/telescope-env.nvim",
			"nvim-telescope/telescope-dap.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
		},
		config = require("config.editor").telescope,
	},
}
