return {
	on_change = function(args)
		vim.cmd("colorscheme " .. args.theme)

		vim.api.nvim_set_option("background", args.background)
		require("lualine").setup({
			options = {
				theme = args.theme,
			},
		})
	end,
}
