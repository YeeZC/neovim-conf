local M = {}

-- 获取 python 所在位置
-- @param venv 是否使用虚拟环境
-- @return python 所在位置
function M.get_python(venv)
	-- 判断是否是 windows 系统
	if vim.fn.has("win32") == 1 then
		return M.get_win_python(venv)
	end
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

function M.get_win_python(venv)
	if venv and venv == true then
		local cwd = vim.fn.getcwd()
		if vim.fn.executable(cwd .. "/venv/Scripts/python.exe") == 1 then
			return cwd .. "/venv/Scripts/python.exe"
		elseif vim.fn.executable(cwd .. "/.venv/Scripts/python.exe") == 1 then
			return cwd .. "/.venv/Scripts/python.exe"
		end
	end
	-- 调用 Get-Command 读取 python.exe 所在位置
	local cmd = [[powershell -Command "Get-Command python.exe | Select-Object -ExpandProperty Definition"]]
	local handle = io.popen(cmd)
	local result = handle:read("*a")
	handle:close()
	if result ~= nil then
		return result
	end
	return "C:/Python39/python.exe"
end

function M.setup()
	local deps = {
		[M.get_python(true)] = { "debugpy" },
		[M.get_python(false)] = { "pyright", "black" },
	}

	local notify = require("plugin.notify")
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
