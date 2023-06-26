local M = {}

function M.init()
	require("config.lsp.setup")
	require("config.lsp.ui")
	require("config.lsp.null-ls")
end

return M
