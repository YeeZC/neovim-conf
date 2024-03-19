return function()
	local cmp = require("cmp")
	local compare = require("cmp.config.compare")
	local uc = require("cmp-under-comparator")

	cmp.setup({
		sorting = {
			comparators = {
				compare.score,
				uc.under,
				compare.recently_used,
				compare.offset,
				compare.exact,
				compare.locality,
				compare.kind,
				-- compare.sort_text,
				compare.length,
				compare.order,
			},
		},
		-- 指定 snippet 引擎
		snippet = {
			expand = function(args)
				-- For `vsnip` users.
				vim.fn["vsnip#anonymous"](args.body)

				-- For `luasnip` users.
				-- require('luasnip').lsp_expand(args.body)

				-- For `ultisnips` users.
				-- vim.fn["UltiSnips#Anon"](args.body)

				-- For `snippy` users.
				-- require'snippy'.expand_snippet(args.body)
			end,
		},
		-- 来源
		sources = cmp.config.sources({
			{ name = "nvim_lsp" },
			{ name = "nvim_lsp_signature_help" },
			-- For vsnip users.
			{ name = "vsnip" },
			{ name = "buffer" },
			{ name = "copilot" },
			{ name = "emoji" },

			-- For luasnip users.
			-- { name = 'luasnip' },
			--For ultisnips users.
			-- { name = 'ultisnips' },
			-- -- For snippy users.
			-- { name = 'snippy' },
		}, { { name = "path" } }),

		-- 快捷键
		mapping = require("keys").cmp(cmp),
		-- 使用lspkind-nvim显示类型图标
		formatting = {
			format = require("lspkind").cmp_format({
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
		},
	})

	-- Use buffer source for `/`.
	cmp.setup.cmdline("/", {
		sources = {
			{ name = "buffer" },
		},
	})

	-- Use cmdline & path source for ':'.
	cmp.setup.cmdline(":", {
		mapping = cmp.mapping.preset.cmdline(),
		sources = cmp.config.sources({
			{ name = "path" },
		}, {
			{ name = "cmdline" },
		}),
	})
end
