vim.cmd("filetype plugin indent on")
vim.g.python3_host_prog = require("config.dap.install.python").get_python(false)
vim.o.termguicolors = true
vim.o.t_Co = 256
-- vim.o.backspace = 2
vim.opt.compatible = false
vim.opt.eb = false
vim.opt.cmdheight = 2
vim.opt.showcmd = true
vim.opt.ruler = true
vim.opt.laststatus = 2
vim.opt.number = true
vim.opt.cursorline = true
vim.opt.whichwrap = "b,s,<,>,h,l"
vim.opt.ttimeoutlen = 0
vim.opt.virtualedit = "block,onemore"
vim.opt.autoindent = true
vim.opt.cindent = true
vim.opt.cinoptions = "g0,:0,N-s,(0"
vim.opt.smartindent = true
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.smarttab = true
vim.opt.wrap = true
vim.opt.sidescroll = 10
vim.opt.foldenable = false
vim.opt.wildmenu = true
vim.opt.completeopt = "menu"
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.autoread = true
vim.opt.autowrite = true
vim.opt.confirm = true
vim.opt.encoding = "utf-8"
vim.opt.scrolljump = 5
vim.opt.scrolloff = 3
vim.opt.modifiable = true
vim.opt.termguicolors = true

function get_config_dir()
	local runtimepath = vim.api.nvim_get_option("runtimepath")
	local config_dir = runtimepath:match("^.-,?(%S+)/.-$")
	local comma_pos = string.find(config_dir, ",")
	if comma_pos then
		return string.sub(config_dir, 1, comma_pos - 1)
	else
		return config_dir
	end
end

vim.api.nvim_create_user_command("ConfigUpdate", function()
	-- Get the config directory
	local config_dir = get_config_dir()
	-- Check if git is installed
	local git_installed = vim.fn.executable("git") == 1
	if not git_installed then
		print("Error: Git is not installed!")
		return
	end

	-- Update the config directory
	local command = string.format("cd %s && git checkout main && git pull", config_dir)
	require("utils.async").run({
		command = "sh",
		args = { "-c", command },
		on_exit = function(_, code)
			if code == 0 then
				vim.notify("Update neovim config success", "success", {
					title = "ConfigUpdate",
				})
				vim.api.nvim_command("source " .. config_dir .. "/lua/core/plugins.lua")
				vim.api.nvim_command("Lazy sync")
				vim.api.nvim_command("source " .. config_dir .. "/init.lua")
				return
			end
			vim.notify("Update neovim config failed", "wran", {
				title = "ConfigUpdate",
			})
		end,
	})
end, {})

vim.api.nvim_create_user_command("LazySync", ":Lazy sync<cr>", {})
