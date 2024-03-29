return { -- 状态栏
	{
		"nvim-lualine/lualine.nvim",
		event = "BufEnter",
		dependencies = "nvim-tree/nvim-web-devicons",
	}, -- tab 栏
	{
		"akinsho/bufferline.nvim",
		version = "*",
		event = "BufEnter",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("bufferline").setup({
				options = {
					themable = true,
					offsets = {
						{
							filetype = "NvimTree",
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
		lazy = false,
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = require("config.ui"),
	}, -- 启动器
	{
		"mhinz/vim-startify",
		lazy = false,
	},
	{
		"sontungexpt/stcursorword",
		event = "VeryLazy",
		config = true,
	},
}
