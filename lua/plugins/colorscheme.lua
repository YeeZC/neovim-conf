return {
	{
		"sainnhe/sonokai",
		lazy = false,
		config = function()
			vim.g.rainbow_active = 1
			vim.g.rehash256 = 1
			vim.cmd([[colorscheme sonokai]])
		end,
	},
}
