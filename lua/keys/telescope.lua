-- 本地变量
local map = vim.api.nvim_set_keymap
local opts = {
	noremap = true,
	silent = true,
}
-- Telescope
map("n", "<leader>f", ":Telescope find_files<CR>", opts)
map("n", "<leader>b", ":Telescope buffers<CR>", opts)
map("n", "<C-f>", ":Telescope live_grep<CR>", opts)

return {
	setup = function()
		return {
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
	end,
}
