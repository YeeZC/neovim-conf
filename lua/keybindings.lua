-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- leader key 为空
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- 本地变量
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- nvim tree
map("n", "<leader>v", ":NvimTreeFindFile<cr>", opts)
map("n", "<leader>g", ":NvimTreeToggle<cr>", opts)
map("n", "<S-g>", ":LazyGit<cr>", opts)

-- fzf
-- map('n', '<leader>f', ':Files<cr>', opts)
map("n", "<leader>b", ":Buffers<cr>", opts)
-- map('n', '<leader>q', ':Ag <C-R><C-W><cr>', opts)
map("n", "ss", "<Plug>(easymotion-s2)", { noremap = false, silent = true })
-- outline
map("n", "<leader>t", ":SymbolsOutline<cr>", opts)

-- Buffers
map("n", "<C-n>", ":bn<cr>", opts)
map("n", "<C-m>", ":bp<cr>", opts)
map("n", "<C-d>", ":bd<cr>", opts)
map("n", "<leader>a", ":cclose<cr>", opts)

-- incsearch
map("n", "/", "<Plug>(incsearch-forward)", opts)
map("n", "?", "<Plug>(incsearch-backward)", opts)
map("n", "g/", "<Plug>(incsearch-stay)", opts)

-- Floarerm
map("n", "<C-p>", ":FloatermToggle<cr>", opts)
map("n", "<leader>sc", ":FloatermNew<cr>", opts)
map("n", "<leader>sd", ":FloatermKill<cr>", opts)
map("n", "<leader>sn", ":FloatermNext<cr>", opts)
map("n", "<leader>sp", ":FloatermPrev<cr>", opts)

-- ale
-- map('n', 'sp', '<Plug>(ale_previous_wrap)', opts)
-- map('n', 'sn', '<Plug>(ale_next_wrap)', opts)
-- map('n', '<leader>d', ':ALEDetail<cr>', opts)
-- map('n', '<leader>l', ':ALEToggle<cr>', opts)

-- tabs
map("n", "[t", ":tabprevious<cr>", opts)
map("n", "]t", ":tabnext<cr>", opts)

vim.cmd([[
    let g:fzf_action = { 'ctrl-e': 'edit' }
]])

--------------------------------------------------------------------
-- 插件快捷键
local pluginKeys = {}

-- lsp 回调函数快捷键设置
pluginKeys.mapLSP = function(mapbuf)
	-- -- rename
	-- --[[
	-- Lspsaga 替换 rn
	-- mapbuf("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts)
	-- --]]
	-- mapbuf("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	-- -- code action
	-- --[[
	-- Lspsaga 替换 ca
	-- mapbuf("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts)
	-- --]]
	-- mapbuf("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	-- -- go xx
	-- --[[
	--   mapbuf('n', 'gd', '<cmd>Lspsaga preview_definition<CR>', opts)
	-- mapbuf("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	-- --]]
	-- mapbuf("n", "gd", "<cmd>lua require'telescope.builtin'.lsp_definitions({ initial_mode = 'normal', })<CR>", opts)
	-- --[[
	-- mapbuf("n", "gh", "<cmd>Lspsaga hover_doc<cr>", opts)
	-- Lspsaga 替换 gh
	-- --]]
	-- mapbuf("n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	-- --[[
	-- Lspsaga 替换 gr
	-- mapbuf("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	-- --]]
	-- mapbuf("n", "gr", "<cmd>Lspsaga lsp_finder<CR>", opts)
	-- --[[
	-- Lspsaga 替换 gp, gj, gk
	-- mapbuf("n", "gp", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
	-- mapbuf("n", "gj", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
	-- mapbuf("n", "gk", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
	-- --]]
	-- -- diagnostic
	-- mapbuf("n", "gp", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)
	-- mapbuf("n", "gj", "<cmd>Lspsaga diagnostic_jump_next<cr>", opts)
	-- mapbuf("n", "gk", "<cmd>Lspsaga diagnostic_jump_prev<cr>", opts)
	-- mapbuf("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
	-- -- 未用
	-- -- mapbuf("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	-- -- mapbuf("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	-- -- mapbuf('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
	-- -- mapbuf("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	-- -- mapbuf('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
	-- -- mapbuf('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
	-- -- mapbuf('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
	-- -- mapbuf('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
end

-- typescript 快捷键
pluginKeys.mapTsLSP = function(mapbuf)
	mapbuf("n", "gs", ":TSLspOrganize<CR>", opts)
	mapbuf("n", "gR", ":TSLspRenameFile<CR>", opts)
	mapbuf("n", "gi", ":TSLspImportAll<CR>", opts)
end

-- nvim-dap
pluginKeys.mapDAP = function()
	-- 开始、继续、下一步、进入、跳出
	map("n", "<F5>", ":DapContinue<CR>", opts)
	map("n", "<F6>", ":DapStepOver<CR>", opts)
	map("n", "<F7>", ":DapStepInto<CR>", opts)
	map("n", "<F8>", ":DapStepOut<CR>", opts)
	map("n", "<F9>", ":DapTerminate<CR>", opts)
	-- 设置断点
	map("n", "<S-b>", ":DapToggleBreakpoint<CR>", opts)
	-- 弹窗
	map("n", "<S-e>", ":lua require'dapui'.eval()<CR>", opts)
end

-- nvim-cmp 自动补全
pluginKeys.cmp = function(cmp)
	local feedkey = function(key, mode)
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
	end
	local has_words_before = function()
		local line, col = unpack(vim.api.nvim_win_get_cursor(0))
		return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
	end

	return {
		-- 上一个
		["<C-k>"] = cmp.mapping.select_prev_item(),
		-- 下一个
		["<C-j>"] = cmp.mapping.select_next_item(),
		-- 出现补全
		["<A-.>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
		-- 取消
		["<A-,>"] = cmp.mapping({
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		}),
		-- 确认
		-- Accept currently selected item. If none selected, `select` first item.
		-- Set `select` to `false` to only confirm explicitly selected items.
		["<CR>"] = cmp.mapping.confirm({
			select = true,
			behavior = cmp.ConfirmBehavior.Replace,
		}),
		-- ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
		-- 如果窗口内容太多，可以滚动
		["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
		["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
		-- snippets 跳转
		["<C-l>"] = cmp.mapping(function(_)
			if vim.fn["vsnip#available"](1) == 1 then
				feedkey("<Plug>(vsnip-expand-or-jump)", "")
			end
		end, { "i", "s" }),
		["<C-h>"] = cmp.mapping(function()
			if vim.fn["vsnip#jumpable"](-1) == 1 then
				feedkey("<Plug>(vsnip-jump-prev)", "")
			end
		end, { "i", "s" }),

		-- super Tab
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif vim.fn["vsnip#available"](1) == 1 then
				feedkey("<Plug>(vsnip-expand-or-jump)", "")
			elseif has_words_before() then
				cmp.complete()
			else
				fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
			end
		end, { "i", "s" }),

		["<S-Tab>"] = cmp.mapping(function()
			if cmp.visible() then
				cmp.select_prev_item()
			elseif vim.fn["vsnip#jumpable"](-1) == 1 then
				feedkey("<Plug>(vsnip-jump-prev)", "")
			end
		end, { "i", "s" }),
		-- end of super Tab
	}
end

-- Telescope
map("n", "<leader>f", ":Telescope find_files<CR>", opts)
map("n", "<leader>b", ":Telescope buffers<CR>", opts)
map("n", "<C-f>", ":Telescope live_grep<CR>", opts)
-- Telescope 列表中 插入模式快捷键
pluginKeys.telescopeList = {
	i = {
		-- 上下移动
		["<C-j>"] = "move_selection_next",
		["<C-k>"] = "move_selection_previous",
		["<C-n>"] = "move_selection_next",
		["<C-p>"] = "move_selection_previous",
		-- 历史记录
		["<Down>"] = "cycle_history_next",
		["<Up>"] = "cycle_history_prev",
		-- 关闭窗口
		-- ["<esc>"] = actions.close,
		["<C-c>"] = "close",
		-- 预览窗口上下滚动
		["<C-u>"] = "preview_scrolling_up",
		["<C-d>"] = "preview_scrolling_down",
	},
}

-- gitsigns
pluginKeys.gitsigns_on_attach = function(bufnr)
	local gs = package.loaded.gitsigns

	local function map(mode, l, r, opts)
		opts = opts or {}
		opts.buffer = bufnr
		vim.keymap.set(mode, l, r, opts)
	end

	-- Navigation
	map("n", "<leader>gj", function()
		if vim.wo.diff then
			return "]c"
		end
		vim.schedule(function()
			gs.next_hunk()
		end)
		return "<Ignore>"
	end, { expr = true })

	map("n", "<leader>gk", function()
		if vim.wo.diff then
			return "[c"
		end
		vim.schedule(function()
			gs.prev_hunk()
		end)
		return "<Ignore>"
	end, { expr = true })

	map("n", "<leader>gS", gs.stage_buffer)
	map("n", "<leader>gu", gs.undo_stage_hunk)
	map({ "n", "v" }, "<leader>gr", ":Gitsigns reset_hunk<CR>")
	map("n", "<leader>gR", gs.reset_buffer)
	map("n", "<leader>gp", gs.preview_hunk)
	map("n", "<leader>gb", function()
		gs.blame_line({ full = true })
	end)
	map("n", "<leader>gd", gs.diffthis)
	map("n", "<leader>gD", function()
		gs.diffthis("~")
	end)
	-- toggle
	map("n", "<leader>gtd", gs.toggle_deleted)
	map("n", "<leader>d", ":Gitsigns toggel_word_diff<CR>")
	map("n", "<leader>l", gs.toggle_current_line_blame)
	-- Text object
	map({ "o", "x" }, "ig", ":<C-U>Gitsigns select_hunk<CR>")
end

return pluginKeys
