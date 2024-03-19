local fn = vim.fn
local install_path = fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(install_path) then
	fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		install_path,
	})
end

vim.opt.rtp:prepend(install_path)

require("lazy").setup({
	spec = { {
		import = "plugins",
	} },
	defaults = {
		lazy = false,
	},
	checker = {
		enabled = true,
	},
	performance = {
		cache = {
			enabled = true,
			-- disable_events = {},
		},
		rtp = {
			-- disable some rtp plugins
			disabled_plugins = { "gzip", "netrwPlugin", "rplugin", "tarPlugin", "tohtml", "tutor", "zipPlugin" },
		},
	},
})

require("keys").global()
