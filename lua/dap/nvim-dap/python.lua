local M = {}

function M.setup()
	local dap = require("dap")

	dap.adapters.python = function(cb, config)
		if config.request == "attach" then
			---@diagnostic disable-next-line: undefined-field
			local port = (config.connect or config).port
			---@diagnostic disable-next-line: undefined-field
			local host = (config.connect or config).host or "127.0.0.1"
			cb({
				type = "server",
				port = assert(port, "`connect.port` is required for a python `attach` configuration"),
				host = host,
				options = {
					source_filetype = "python",
				},
			})
		else
			local cmd = require("dap.install.python").get_python(true)
			cb({
				type = "executable",
				command = cmd,
				args = { "-m", "debugpy.adapter" },
				options = {
					source_filetype = "python",
				},
			})
		end
	end

	dap.configurations.python = {
		{
			-- The first three options are required by nvim-dap
			type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
			request = "launch",
			name = "Launch file",

			-- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

			program = "${file}", -- This configuration will launch the current file if used.
			pythonPath = function()
				return require("dap.install.python").get_python(true)
			end,
		},
	}
end

return M
