local myAutoGroup = vim.api.nvim_create_augroup("myAutoGroup", {
	clear = true,
})
local autocmd = vim.api.nvim_create_autocmd

-- 修改lua/plugins.lua 自动更新插件
autocmd("BufWritePost", {
	group = myAutoGroup,
	-- autocmd BufWritePost plugins.lua source <afile> | PackerSync
	callback = function()
		if vim.fn.expand("<afile>") == "lua/plugins.lua" then
			vim.api.nvim_command("source lua/plugins.lua")
			vim.api.nvim_command("Lazy sync")
		end
	end,
})

-- 自动安装
autocmd("BufEnter", {
	group = myAutoGroup,
	callback = function()
		require("config.dap.install").setup()
	end,
})
