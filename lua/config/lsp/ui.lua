-- 自定义图标
vim.diagnostic.config({
	virtual_text = true,
	signs = true,
	update_in_insert = false,
})
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- lspkind
local lspkind = require("lspkind")
lspkind.init({
	-- default: true
	-- with_text = true,
	-- defines how annotations are shown
	-- default: symbol
	-- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
	mode = "symbol_text",
	-- default symbol map
	-- can be either 'default' (requires nerd-fonts font) or
	-- 'codicons' for codicon preset (requires vscode-codicons font)
	--
	-- default: 'default'
	preset = "codicons",
	-- override preset symbols
	--
	-- default: {}
	symbol_map = {
		Array = "󰅨",
		Package = "",
		Text = "󰅳",
		Method = "",
		Function = "󰡱",
		Constructor = "",
		Field = "",
		Class = "",
		Interface = "",
		Module = "",
		Property = "",
		Unit = "󰊱",
		Value = "",
		Enum = "",
		Keyword = "",
		Snippet = "",
		Color = "",
		File = "",
		Reference = "",
		Folder = "",
		EnumMember = "",
		Constant = "",
		Struct = "",
		Event = "",
		Operator = "",
		TypeParameter = "",
		Variable = "",
		Fragment = "",
	},
})

require("lspsaga").setup({
	finder = {
		max_height = 0.5,
		min_width = 30,
		force_max_height = false,
		keys = {
			jump_to = "p",
			expand_or_jump = "<cr>",
			vsplit = "s",
			split = "i",
			tabe = "t",
			tabnew = "r",
			quit = { "q", "<ESC>" },
			close_in_preview = "<ESC>",
		},
	},
	code_action = {
		num_shortcut = true,
		show_server_name = true,
		extend_gitsigns = true,
		keys = {
			-- string | table type
			quit = "q",
			exec = "<CR>",
		},
	},
	lightbulb = {
		enable = true,
		enable_in_insert = false,
		sign = false,
		sign_priority = 40,
		virtual_text = true,
	},
	outline = {
		win_position = "right",
		win_with = "",
		win_width = 40,
		preview_width = 0.4,
		show_detail = true,
		auto_preview = true,
		auto_refresh = true,
		auto_close = true,
		auto_resize = true,
		custom_sort = nil,
		keys = {
			expand_or_jump = "<cr>",
			quit = "q",
		},
	},
	symbol_in_winbar = {
		enable = true,
		separator = " ⏵ ",
		ignore_patterns = {},
		hide_keyword = true,
		show_file = true,
		folder_level = 2,
		respect_root = false,
		color_mode = true,
	},
	hover = {
		max_width = 0.6,
		open_link = "gx",
		open_browser = "!chrome",
	},
	rename = {
		quit = "<C-q>",
		exec = "<CR>",
		mark = "x",
		confirm = "<CR>",
		in_select = true,
	},
	ui = {
		title = true,
		border = "single",
		winblend = 0,
		expand = "⏵",
		collapse = "⏷",
		code_action = "💡",
		incoming = " ",
		outgoing = " ",
		hover = " ",
		kind = {
			["Folder"] = { " ", "@comment" },
		},
	},
})

local M = {}
-- 为 cmp.lua 提供参数格式
M.formatting = {
	format = lspkind.cmp_format({
		mode = "symbol_text",
		--mode = 'symbol', -- show only symbol annotations

		maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
		-- The function below will be called before any actual modifications from lspkind
		-- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
		before = function(entry, vim_item)
			-- Source 显示提示来源
			vim_item.menu = "[" .. string.upper(entry.source.name) .. "]"
			return vim_item
		end,
	}),
}

return M
