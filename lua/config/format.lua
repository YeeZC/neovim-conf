return function()
	local null_ls = require("null-ls")
	local formatting = null_ls.builtins.formatting
	local code_actions = null_ls.builtins.code_acctions
	local completion = null_ls.builtins.completion
	null_ls.setup({
		debug = false,
		sources = { -- Formatting ---------------------
			--  brew install shfmt
			formatting.shfmt, -- StyLua
			formatting.stylua, -- frontend
			formatting.prettier.with({
				-- 比默认少了 markdown
				filetypes = {
					"javascript",
					"javascriptreact",
					"typescript",
					"typescriptreact",
					"vue",
					"css",
					"scss",
					"less",
					"html",
					"json",
					"yaml",
					"graphql",
				},
				prefer_local = "node_modules/.bin",
			}), -- rustfmt
			-- rustup component add rustfmt
			-- require("null-ls.builtins.formatting").rustfmt,
			-- Python
			-- pip install black
			-- asdf reshim python
			formatting.black.with({
				extra_args = { "--fast" },
			}), -----------------------------------------------------
			-- Ruby
			-- gem install rubocop
			-- require("null-ls.builtins.formatting").rubocop,
			-- golang
			formatting.goimports, -----------------------------------------------------
			-- require("null-ls.builtins.formatting").fixjson,
			-- Diagnostics  ---------------------
			-- diagnostics.eslint.with({
			-- 	prefer_local = "node_modules/.bin",
			-- }),
			require("none-ls.diagnostics.eslint"), -- diagnostics.markdownlint,
			-- markdownlint-cli2
			-- diagnostics.markdownlint.with({
			--   prefer_local = "node_modules/.bin",
			--   command = "markdownlint-cli2",
			--   args = { "$FILENAME", "#node_modules" },
			-- }),
			--
			-- code actions ---------------------
			code_actions.gomodifytags,
			-- code_actions.gitsigns,
			-- code_actions.eslint.with({
			-- 	prefer_local = "node_modules/.bin",
			-- }),
			require("none-ls.code_actions.eslint"),
			-- completion
			completion.vsnip
		},
		-- #{m}: message
		-- #{s}: source name (defaults to null-ls if not specified)
		-- #{c}: code (if available)
		diagnostics_format = "[#{s}] #{m}",
		on_attach = function(client, bufnr)
			local myAutoGroup = vim.api.nvim_create_augroup("lspFormatting", {
				clear = true,
			})
			local autocmd = vim.api.nvim_create_autocmd
            local clear = vim.api.nvim_clear_autocmds
			if client.supports_method("textDocument/formatting") then
				clear({
					group = myAutoGroup,
					buffer = bufnr,
				})
				autocmd("BufWritePre", {
					group = myAutoGroup,
					callback = function()
						-- vim.lsp.buf.format({ async = true })
						vim.lsp.buf.format({
                            filter =function (client)

                                return client.name  == "null-ls"
                            end,
							bufnr = bufnr,
							async = false,
						})
					end,
				})
			end

			-- vim.cmd([[ command! Format execute 'lua vim.lsp.buf.format {async = true}' ]])
			-- vim.cmd("autocmd BufWritePre,BufNewFile,BufRead <buffer> lua vim.lsp.buf.format {async = true}")
			-- if client.resolved_capabilities.document_formatting then
			--   vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.format {async = true}")
			-- end
		end,
	})
end
