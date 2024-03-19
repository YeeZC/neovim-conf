vim.cmd("filetype plugin indent on")
-- vim.g.python3_host_prog = require("config.dap.install.python").get_python(false)
vim.o.termguicolors = true
-- vim.o.t_Co = 256
-- vim.o.backspace = 2
vim.g.mapleader = ","
vim.g.maplocalleader = ","
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

vim.api.nvim_create_user_command("Sync", function()
	vim.api.nvim_command("Lazy sync")
end, {})

return function()
	local map = vim.keymap.set

	local api = require("nvim-tree.api")
	local function on_attach(bufnr)
		local function opts(desc)
			return {
				desc = "nvim-tree: " .. desc,
				buffer = bufnr,
				noremap = true,
				silent = true,
				nowait = true,
			}
		end

		-- Default mappings. Feel free to modify or remove as you wish.
		--
		-- BEGIN_DEFAULT_ON_ATTACH
		map("n", "<C-]>", api.tree.change_root_to_node, opts("CD"))
		map("n", "<C-e>", api.node.open.replace_tree_buffer, opts("Open: In Place"))
		map("n", "<C-k>", api.node.show_info_popup, opts("Info"))
		map("n", "<C-r>", api.fs.rename_sub, opts("Rename: Omit Filename"))
		--  map('n', '<C-t>', api.node.open.tab,                     opts('Open: New Tab'))
		--  map('n', '<C-v>', api.node.open.vertical,                opts('Open: Vertical Split'))
		--  map('n', '<C-x>', api.node.open.horizontal,              opts('Open: Horizontal Split'))
		map("n", "<BS>", api.node.navigate.parent_close, opts("Close Directory"))
		map("n", "<CR>", api.node.open.edit, opts("Open"))
		--  map('n', '<Tab>', api.node.open.preview,                 opts('Open Preview'))
		map("n", ">", api.node.navigate.sibling.next, opts("Next Sibling"))
		map("n", "<", api.node.navigate.sibling.prev, opts("Previous Sibling"))
		map("n", ".", api.node.run.cmd, opts("Run Command"))
		map("n", "-", api.tree.change_root_to_parent, opts("Up"))
		map("n", "a", api.fs.create, opts("Create"))
		map("n", "bmv", api.marks.bulk.move, opts("Move Bookmarked"))
		map("n", "B", api.tree.toggle_no_buffer_filter, opts("Toggle No Buffer"))
		--  map('n', 'c',     api.fs.copy.node,                      opts('Copy'))
		map("n", "C", api.tree.toggle_git_clean_filter, opts("Toggle Git Clean"))
		map("n", "[c", api.node.navigate.git.prev, opts("Prev Git"))
		map("n", "]c", api.node.navigate.git.next, opts("Next Git"))
		map("n", "d", api.fs.remove, opts("Delete"))
		map("n", "D", api.fs.trash, opts("Trash"))
		map("n", "E", api.tree.expand_all, opts("Expand All"))
		map("n", "e", api.fs.rename_basename, opts("Rename: Basename"))
		map("n", "]e", api.node.navigate.diagnostics.next, opts("Next Diagnostic"))
		map("n", "[e", api.node.navigate.diagnostics.prev, opts("Prev Diagnostic"))
		map("n", "F", api.live_filter.clear, opts("Clean Filter"))
		map("n", "f", api.live_filter.start, opts("Filter"))
		map("n", "g?", api.tree.toggle_help, opts("Help"))
		map("n", "gy", api.fs.copy.absolute_path, opts("Copy Absolute Path"))
		map("n", "H", api.tree.toggle_hidden_filter, opts("Toggle Dotfiles"))
		map("n", "I", api.tree.toggle_gitignore_filter, opts("Toggle Git Ignore"))
		map("n", "J", api.node.navigate.sibling.last, opts("Last Sibling"))
		map("n", "K", api.node.navigate.sibling.first, opts("First Sibling"))
		map("n", "m", api.marks.toggle, opts("Toggle Bookmark"))
		map("n", "o", api.node.open.edit, opts("Open"))
		map("n", "O", api.node.open.no_window_picker, opts("Open: No Window Picker"))
		map("n", "p", api.fs.paste, opts("Paste"))
		map("n", "P", api.node.navigate.parent, opts("Parent Directory"))
		map("n", "q", api.tree.close, opts("Close"))
		map("n", "r", api.fs.rename, opts("Rename"))
		map("n", "R", api.tree.reload, opts("Refresh"))
		map("n", "s", api.node.run.system, opts("Run System"))
		map("n", "S", api.tree.search_node, opts("Search"))
		map("n", "U", api.tree.toggle_custom_filter, opts("Toggle Hidden"))
		map("n", "W", api.tree.collapse_all, opts("Collapse"))
		map("n", "x", api.fs.cut, opts("Cut"))
		map("n", "y", api.fs.copy.filename, opts("Copy Name"))
		map("n", "Y", api.fs.copy.relative_path, opts("Copy Relative Path"))
		map("n", "<2-LeftMouse>", api.node.open.edit, opts("Open"))
		map("n", "<2-RightMouse>", api.tree.change_root_to_node, opts("CD"))
		map("n", "<2-Tab>", api.node.open.preview, opts("Open Preview"))
		map("n", "V", api.node.open.vertical, opts("Open: Vertical Split"))
		map("n", "X", api.node.open.horizontal, opts("Open: Horizontal Split"))
		map("n", "T", api.node.open.tab, opts("Open: New Tab"))

		-- END_DEFAULT_ON_ATTACH

		-- Mappings migrated from view.mappings.list
		--
		-- You will need to insert "your code goes here" for any mappings with a custom action_cb
		map("n", "c", function()
			local node = api.tree.get_node_under_cursor()
			-- your code goes here
			local file_src = node["absolute_path"]
			-- The args of input are {prompt}, {default}, {completion}
			-- Read in the new file path using the existing file's path as the baseline.
			local file_out = vim.fn.input("COPY TO: ", file_src, "file")
			-- Create any parent dirs as required
			local dir = vim.fn.fnamemodify(file_out, ":h")
			vim.fn.system({ "mkdir", "-p", dir })
			-- Copy the file
			vim.fn.system({ "cp", "-R", file_src, file_out })
		end, opts("copy_file_to"))
		map("n", "<2-Tab>", api.node.open.preview, opts("Open Preview"))
		map("n", "V", api.node.open.vertical, opts("Open: Vertical Split"))
		map("n", "T", api.node.open.tab, opts("Open: New Tab"))

		map("n", "Z", api.node.run.system, opts("Run System"))
	end

	local function open_nvim_tree(data)
		if data.file == "" then
			api.tree.open()
			return
		end
		-- buffer is a directory
		local directory = vim.fn.isdirectory(data.file) == 1

		if not directory then
			return
		end

		-- change to the directory
		vim.cmd.cd(data.file)

		-- open the tree
		api.tree.open()
	end

	vim.api.nvim_create_autocmd({ "VimEnter" }, {
		callback = open_nvim_tree,
	})

	api.events.subscribe(api.events.Event.FileCreated, function(file)
		vim.cmd("edit " .. file.fname)
	end)
	-- OR setup with some options
	require("nvim-tree").setup({
		on_attach = on_attach,
		sort_by = "case_sensitive",
		sync_root_with_cwd = true,
		hijack_cursor = true,
		renderer = {
			full_name = true,
			group_empty = true,
			indent_markers = {
				enable = true,
			},
			icons = {
				-- git_placement = "signcolumn",
				show = {
					file = true,
					folder = true,
					folder_arrow = true,
					git = true,
				},
				glyphs = {
					folder = {
						arrow_closed = "⏵",
						arrow_open = "⏷",
					},
					git = {
						unstaged = "✗",
						staged = "✓",
						unmerged = "⌥",
						renamed = "➜",
						untracked = "★",
						deleted = "⊖",
						ignored = "◌",
					},
				},
			},
		},
		filters = {
			dotfiles = false,
		},
		diagnostics = {
			enable = true,
			show_on_dirs = true,
		},
		view = {
			width = 30,
			adaptive_size = false,
		},
	})
end
