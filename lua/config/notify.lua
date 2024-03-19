local M = {
    client_notifs = {},
    spinner_frames = {"⣾", "⣽", "⣻", "⢿", "⡿", "⣟", "⣯", "⣷"}
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
            replace = notif_data.notification
        })

        vim.defer_fn(function()
            M.update_spinner(client_id, token)
        end, 80)
    end
end

function M.output_notify(message, title, kind, cli, token, level)
    level = level or "info"
	if level == "warn" then
		return
	end
    cli = cli or "Notify"
    kind = kind or "report"
    token = token or "this_is_a_token"
    local notif_data = M.get_notif_data(cli, token)
    if kind == "begin" then
        notif_data.notification = vim.notify(message, level, {
            title = title,
            icon = M.spinner_frames[1],
            timeout = false,
            hide_from_history = false
        })

        notif_data.spinner = 1
        M.update_spinner(cli, token)
    elseif kind == "report" then
        notif_data.notification = vim.notify(message, level, {
            title = title,
            replace = notif_data.notification,
            hide_from_history = false
        })
    else
        notif_data.notification = vim.notify(message or "Complete", level, {
            title = title,
            icon = "",
            replace = notif_data.notification,
            timeout = 500
        })

        notif_data.spinner = nil
    end
end

return M
