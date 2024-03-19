return {
	setup = function(bufnr)
		local gs = package.loaded.gitsigns
		local keymap = function(mode, l, r, opt)
			opt = opt or {}
			opt.buffer = bufnr
			vim.keymap.set(mode, l, r, opt)
		end

		-- Navigation
		keymap("n", "<leader>gj", function()
			if vim.wo.diff then
				return "]c"
			end
			vim.schedule(function()
				gs.next_hunk()
			end)
			return "<Ignore>"
		end, {
			expr = true,
		})

		keymap("n", "<leader>gk", function()
			if vim.wo.diff then
				return "[c"
			end
			vim.schedule(function()
				gs.prev_hunk()
			end)
			return "<Ignore>"
		end, {
			expr = true,
		})

		keymap("n", "<leader>gS", gs.stage_buffer)
		keymap("n", "<leader>gu", gs.undo_stage_hunk)
		keymap({ "n", "v" }, "<leader>gr", ":Gitsigns reset_hunk<CR>")
		keymap("n", "<leader>gR", gs.reset_buffer)
		keymap("n", "<leader>gp", gs.preview_hunk)
		keymap("n", "<leader>gb", function()
			gs.blame_line({
				full = true,
			})
		end)
		keymap("n", "<leader>gd", gs.diffthis)
		keymap("n", "D", function()
			gs.diffthis("~")
		end)
		-- toggle
		keymap("n", "<leader>gtd", gs.toggle_deleted)
		keymap("n", "<leader>d", ":Gitsigns toggel_word_diff<CR>")
		keymap("n", "<leader>l", gs.toggle_current_line_blame)
		-- Text object
		keymap({ "o", "x" }, "ig", ":<C-U>Gitsigns select_hunk<CR>")
	end,
}
