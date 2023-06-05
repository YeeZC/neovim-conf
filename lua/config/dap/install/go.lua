local M = {}

function M.setup()
	M.check_deps()
end

function M.check_deps()
	local notify = require("plugin/notify")
	local commands = {
		gopls = "golang.org/x/tools/gopls@latest",
		goimports = "golang.org/x/tools/cmd/goimports@latest",
		dlv = "github.com/go-delve/delve/cmd/dlv@latest",
	}
	local async = require("utils.async")
	for key, value in pairs(commands) do
		if vim.fn.executable(key) ~= 1 then
			async.run({
				command = "go",
				args = { "install", value },
				on_exit = function(_, code)
					if code == 0 then
						notify.output_notify(
							"Install " .. key .. " success",
							"GoDeps",
							"report",
							"gopls_cli",
							key,
							"success"
						)
						if key == "gopls" then
							require("config.dap.nvim-dap.go").setup()
						end
						return
					end
					notify.output_notify("Install " .. key .. " fail", "GoDeps", "report", "gopls_cli", key, "error")
				end,
			})
		end
	end
end

return M
