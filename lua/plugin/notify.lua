-- vim.notify = require("notify")
local dap = require("dap")
local notify = require("plugin/notify_exp")

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
        notify.output_notify(message, format_title(val.title, vim.lsp.get_client_by_id(client_id).name), val.kind, client_id, result.token)
    elseif val.kind == "report" and notif_data then
        notify.output_notify(format_message(val.message, val.percentage), nil, val.kind, client_id, result.token)
    elseif val.kind == "end" and notif_data then
        notify.output_notify(val.message and format_message(val.message) or "Complete", nil, val.kind, client_id, result.token)
    end
end

-- table from lsp severity to vim severity.
local severity = {
    "error",
    "warn",
    "info",
    "info", -- map both hint and info to info?
}
vim.lsp.handlers["window/showMessage"] = function(err, method, params, client_id)
    vim.notify(method.message, severity[params.type])
end

-- DAP integration
-- Make sure to also have the snippet with the common helper functions in your config!

dap.listeners.before["event_progressStart"]["progress-notifications"] = function(session, body)
    notify.output_notify(message, format_title(body.title, session.config.type), "begin", "dap", body.progressId, "info")
end

dap.listeners.before["event_progressUpdate"]["progress-notifications"] = function(session, body)
    notify.output_notify(format_message(body.message, body.percentage), nil, "report", "dap", body.progressId, "info")
end

dap.listeners.before["event_progressEnd"]["progress-notifications"] = function(session, body)
    notify.output_notify(body.message and format_message(body.message) or "Complete", nil, "end", "dap", body.progressId, "info")
end
