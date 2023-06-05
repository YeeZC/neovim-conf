local M = {}

function M.init()
	require("core.basic")
	require("core.plugins")
	require("core.theme")
	require("core.autocmd")
end

return M
