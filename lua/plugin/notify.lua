vim.notify = require("notify")

local M = {
	client_notifs = {},
	spinner_frames = { "⣾", "⣽", "⣻", "⢿", "⡿", "⣟", "⣯", "⣷" },
	-- spinner_frames = { "", "󰪞","󰪟","󰪠","󰪡","󰪢","󰪣","󰪤","󰪥"},
}

function M.get_notif_data(client_id, token)
	if not M.client_notifs[client_id] then
		M.client_notifs[client_id] = {}
	end

	if not M.client_notifs[client_id][token] then
		M.client_notifs[client_id][token] = {}
	end

	return M.client_notifs[client_id][token]
end

function M.update_spinner(client_id, token)
	local notif_data = M.get_notif_data(client_id, token)

	if notif_data.spinner then
		local new_spinner = (notif_data.spinner + 1) % #M.spinner_frames
		notif_data.spinner = new_spinner

		notif_data.notification = vim.notify(nil, nil, {
			hide_from_history = true,
			icon = M.spinner_frames[new_spinner],
			replace = notif_data.notification,
		})

		vim.defer_fn(function()
			M.update_spinner(client_id, token)
		end, 80)
	end
end

function M.output_notify(message, title, kind, cli, token, level)
	level = level or "info"
	cli = cli or "Notify"
	kind = kind or "report"
	token = token or "this_is_a_token"
	local notif_data = M.get_notif_data(cli, token)
	if kind == "begin" then
		notif_data.notification = vim.notify(message, level, {
			title = title,
			icon = M.spinner_frames[1],
			timeout = false,
			hide_from_history = false,
		})

		notif_data.spinner = 1
		M.update_spinner(cli, token)
	elseif kind == "report" then
		notif_data.notification = vim.notify(message, level, {
			title = title,
			replace = notif_data.notification,
			hide_from_history = false,
		})
	else
		notif_data.notification = vim.notify(message or "Complete", level, {
			title = title,
			icon = "",
			replace = notif_data.notification,
			timeout = 1000,
		})

		notif_data.spinner = nil
	end
end

function M.setup()
	local dap = require("dap")
	local notify = M
	local function format_title(title, client_name)
		return client_name .. (#title > 0 and ": " .. title or "")
	end

	local function format_message(message, percentage)
		return (percentage and percentage .. "%\t" or "") .. (message or "")
	end

	-- LSP integration
	-- Make sure to also have the snippet with the common helper functions in your config!

	vim.lsp.handlers["$/progress"] = function(_, result, ctx)
		local client_id = ctx.client_id

		local val = result.value

		if not val.kind then
			return
		end

		local notif_data = notify.get_notif_data(client_id, result.token)

		if val.kind == "begin" then
			local message = format_message(val.message, val.percentage)
			notify.output_notify(
				message,
				format_title(val.title, vim.lsp.get_client_by_id(client_id).name),
				val.kind,
				client_id,
				result.token
			)
		elseif val.kind == "report" and notif_data then
			notify.output_notify(format_message(val.message, val.percentage), nil, val.kind, client_id, result.token)
		elseif val.kind == "end" and notif_data then
			notify.output_notify(
				val.message and format_message(val.message) or "Complete",
				nil,
				val.kind,
				client_id,
				result.token
			)
		end
	end

	-- table from lsp severity to vim severity.
	local severity = {
		"error",
		"warn",
		"info",
		"info", -- map both hint and info to info?
	}
	vim.lsp.handlers["window/showMessage"] = function(_, method, params, _)
		vim.notify(method.message, severity[params.type])
	end

	-- DAP integration
	-- Make sure to also have the snippet with the common helper functions in your config!

	dap.listeners.before["event_progressStart"]["progress-notifications"] = function(session, body)
		notify.output_notify(
			body.message,
			format_title(body.title, session.config.type),
			"begin",
			"dap",
			body.progressId,
			"info"
		)
	end

	dap.listeners.before["event_progressUpdate"]["progress-notifications"] = function(_, body)
		notify.output_notify(
			format_message(body.message, body.percentage),
			nil,
			"report",
			"dap",
			body.progressId,
			"info"
		)
	end

	dap.listeners.before["event_progressEnd"]["progress-notifications"] = function(_, body)
		notify.output_notify(
			body.message and format_message(body.message) or "Complete",
			nil,
			"end",
			"dap",
			body.progressId,
			"info"
		)
	end
end

return M
