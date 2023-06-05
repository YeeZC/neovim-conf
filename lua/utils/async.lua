local status, Job = pcall(require, "plenary.job")

local M = {}

function M.run(opts)
	opts = opts or {
		command = nil,
		args = {},
		on_data = function(data) end,
		on_exit = function(_, code) end,
	}
	if opts.command == nil then
		return
	end
	local json = ""
	opts.on_data = opts.on_data or function(data) end
	opts.on_exit = opts.on_exit or function(_, code) end
	opts.args = opts.args or {}
	if status and opts.mode ~= "buildin" then
		Job:new({
			command = opts.command,
			args = opts.args,
			on_stdout = function(_, data)
				json = json .. data
			end,
			on_exit = function(j, code)
				vim.schedule(function()
					if code == 0 then
						opts.on_data(json)
					end
					opts.on_exit(j, code)
				end)
			end,
		}):start()
		return
	end

	local cmdStr = opts.command
	if #opts.args > 0 then
		for _, v in pairs(opts.args) do
			cmdStr = cmdStr .. " " .. v
		end
	end
	vim.fn.jobstart(cmdStr, {
		on_stdout = function(_, data)
			json = json .. table.concat(data, "")
		end,
		on_exit = function(j, code)
			vim.schedule(function()
				if code == 0 then
					opts.on_data(json)
				end
				opts.on_exit(j, code)
			end)
		end,
	})
end

return M
