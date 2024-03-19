return { -- lsp
	{
		"neovim/nvim-lspconfig",
		dependencies = { "williamboman/nvim-lsp-installer" },
		config = require("config.lsp").lspconfig,
	},
	{
		"williamboman/nvim-lsp-installer",
		opts = {
			automatic_installation = true,
		},
	},
	{
		"onsails/lspkind.nvim",
		event = "BufEnter",
		config = require("config.lsp").lspkind,
	}, -- lua 增强
	{
		"folke/neodev.nvim",
		event = "BufEnter",
	},
	{
		"nvimdev/lspsaga.nvim",
		branch = "main",
		event = "BufEnter",
		dependencies = { "nvim-tree/nvim-web-devicons", "nvim-treesitter/nvim-treesitter" },
		config = require("config.lsp").lspsaga,
	},
}
