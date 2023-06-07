local M = {}

function M.get_python(venv)
	if venv and venv == true then
		local cwd = vim.fn.getcwd()
		if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
			return cwd .. "/venv/bin/python"
		elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
			return cwd .. "/.venv/bin/python"
		elseif vim.fn.executable("/usr/local/bin/python3") == 1 then
			return "/usr/local/bin/python3"
		else
			return "/usr/bin/python3"
		end
	end
	if vim.fn.executable("/usr/local/bin/python3") == 1 then
		return "/usr/local/bin/python3"
	else
		return "/usr/bin/python3"
	end
end

function M.setup()
	local deps = {
		[M.get_python(true)] = { "debugpy" },
		[M.get_python(false)] = { "pyright", "black" },
	}

	local notify = require("plugin/notify")
	local async = require("utils.async")
	for cmd, items in pairs(deps) do
		for _, dep in pairs(items) do
			async.run({
				command = cmd,
				args = { "-m", "pip", "show", dep },
				on_exit = function(_, code)
					if code ~= 0 then
						async.run({
							command = cmd,
							args = { "-m", "pip", "install", "-i", "https://pypi.tuna.tsinghua.edu.cn/simple", dep },
							on_exit = function(_, c)
								if c == 0 then
									notify.output_notify(
										dep .. " install success",
										"PythonCheck",
										"report",
										"debugpy_cli",
										dep,
										"success"
									)
								else
									notify.output_notify(
										dep .. " install fail",
										"PythonCheck",
										"report",
										"debugpy_cli",
										dep,
										"error"
									)
								end
							end,
						})
					end
				end,
			})
		end
	end
end

return M
