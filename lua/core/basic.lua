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
-- examples for your init.lua

-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true


vim.api.nvim_create_user_command("LazySync",function() vim.api.nvim_command("Lazy sync") end, {})
