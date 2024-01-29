local status, null_ls = pcall(require, "null-ls")
if not status then
	vim.notify("没有找到 null-ls")
	return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

null_ls.setup({
	debug = false,
	sources = {
		-- Formatting ---------------------
		--  brew install shfmt
		formatting.shfmt,
		-- StyLua
		formatting.stylua,
		-- frontend
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
		}),
		-- rustfmt
		-- rustup component add rustfmt
		formatting.rustfmt,
		-- Python
		-- pip install black
		-- asdf reshim python
		formatting.black.with({ extra_args = { "--fast" } }),
		-----------------------------------------------------
		-- Ruby
		-- gem install rubocop
		-- formatting.rubocop,
		-- golang
		formatting.goimports,
		-----------------------------------------------------
		-- formatting.fixjson,
		-- Diagnostics  ---------------------
		diagnostics.eslint.with({
			prefer_local = "node_modules/.bin",
		}),
		-- diagnostics.markdownlint,
		-- markdownlint-cli2
		-- diagnostics.markdownlint.with({
		--   prefer_local = "node_modules/.bin",
		--   command = "markdownlint-cli2",
		--   args = { "$FILENAME", "#node_modules" },
		-- }),
		--
		-- code actions ---------------------
		-- code_actions.gitsigns,
		code_actions.eslint.with({
			prefer_local = "node_modules/.bin",
		}),
	},
	-- #{m}: message
	-- #{s}: source name (defaults to null-ls if not specified)
	-- #{c}: code (if available)
	diagnostics_format = "[#{s}] #{m}",
	on_attach = function(client, bufnr)
		local myAutoGroup = vim.api.nvim_create_augroup("fmt", {
			clear = true,
		})
		local autocmd = vim.api.nvim_create_autocmd
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = myAutoGroup, buffer = bufnr })
			autocmd("BufWritePre", {
				group = myAutoGroup,
				callback = function()
					-- vim.lsp.buf.format({ async = true })
					vim.lsp.buf.format({ bufnr = bufnr, async = false })
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
