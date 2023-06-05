local M = {}

function M.init()
    require("plugin.cmp")
	require("plugin.notify").setup()
	require("plugin.nvim-tree")
	require("plugin.telescope")
	require("plugin.cmp")
	require("plugin.gitsigns")
	require("plugin.nvim-treesitter")
end

return M
