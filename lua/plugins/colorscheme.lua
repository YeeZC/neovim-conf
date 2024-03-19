return {
	-- sonokai
	{ "sainnhe/sonokai", lazy = false },
	-- moonfly
	{ "bluz71/vim-moonfly-colors", lazy = false, name = "moonfly", priority = 1000 },
	-- melange
	{ "savq/melange-nvim", lazy = false },
	-- kanagawa
	{ "rebelot/kanagawa.nvim", lazy = false, config = function()
		require('kanagawa').setup({
			theme = "dragon",              -- Load "wave" theme when 'background' option is not set
			background = {               -- map the value of 'background' option to a theme
				dark = "dragon",           -- try "dragon" !
				light = "lotus"
			},
		})
	end },
	-- edge
	{ "sainnhe/edge", lazy = false },
	{
		"polirritmico/monokai-nightasty.nvim",
		lazy = false,
		priority = 1000,
	},
	{ "sainnhe/gruvbox-material", lazy = false },
	{ "projekt0n/github-nvim-theme", lazy = false },
	{
		"f-person/auto-dark-mode.nvim",
		lazy = false,
		config = {
			update_interval = 1000,
			set_dark_mode = function()
				require("config.theme").on_change({
					theme = "kanagawa",
					background = "dark",
				})
			end,
			set_light_mode = function()
				require("config.theme").on_change({
					theme = "kanagawa",
					background = "light",
				})
			end,
		},
	},
}
