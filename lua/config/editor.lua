return {
    hlslens = function()
        require("hlslens").setup({
            override_lens = function(render, posList, nearest, idx, relIdx)
                local sfw = vim.v.searchforward == 1
                local indicator, text, chunks
                local absRelIdx = math.abs(relIdx)
                if absRelIdx > 1 then
                    indicator = ("%d%s"):format(absRelIdx, sfw ~= (relIdx > 1) and "󰁝" or "󰁅")
                elseif absRelIdx == 1 then
                    -- indicator = sfw ~= (relIdx == 1) and '󰮽' or '󰮷'
                    indicator = ("%d%s"):format(absRelIdx, sfw ~= (relIdx == 1) and "󰁝" or "󰁅")
                else
                    indicator = ""
                end

                local lnum, col = unpack(posList[idx])
                if nearest then
                    local cnt = #posList
                    if indicator ~= "" then
                        text = ("[%s %d/%d]"):format(indicator, idx, cnt)
                    else
                        text = ("[%d/%d]"):format(idx, cnt)
                    end
                    chunks = {{" ", "Ignore"}, {text, "HlSearchLensNear"}}
                else
                    text = ("[%s %d]"):format(indicator, idx)
                    chunks = {{" ", "Ignore"}, {text, "HlSearchLens"}}
                end
                render.setVirt(0, lnum - 1, col - 1, chunks, nearest)
            end
        })
        require("scrollbar.handlers.search").setup({})
    end,
    scrollbar = function()
        require("scrollbar").setup({
            show = true,
            show_in_active_only = false,
            set_highlights = true,
            folds = 1000, -- handle folds, set to number to disable folds if no. of lines in buffer exceeds this
            max_lines = false, -- disables if no. of lines in buffer exceeds this
            hide_if_all_visible = false, -- Hides everything if all lines are visible
            throttle_ms = 100,
            handle = {
                text = " ",
                blend = 30, -- Integer between 0 and 100. 0 for fully opaque and 100 to full transparent. Defaults to 30.
                color = nil,
                color_nr = nil, -- cterm
                highlight = "CursorColumn",
                hide_if_all_visible = true -- Hides handle if all lines are visible
            },
            marks = {
                Cursor = {
                    text = "•",
                    -- text = "󰮹",
                    priority = 0,
                    gui = nil,
                    color = nil,
                    cterm = nil,
                    color_nr = nil, -- cterm
                    highlight = "Normal"
                },
                Search = {
                    text = {"-", "="},
                    priority = 1,
                    gui = nil,
                    color = nil,
                    cterm = nil,
                    color_nr = nil, -- cterm
                    highlight = "Search"
                },
                Error = {
                    text = {"-", "="},
                    priority = 2,
                    gui = nil,
                    color = nil,
                    cterm = nil,
                    color_nr = nil, -- cterm
                    highlight = "DiagnosticVirtualTextError"
                },
                Warn = {
                    text = {"-", "="},
                    priority = 3,
                    gui = nil,
                    color = nil,
                    cterm = nil,
                    color_nr = nil, -- cterm
                    highlight = "DiagnosticVirtualTextWarn"
                },
                Info = {
                    text = {"-", "="},
                    priority = 4,
                    gui = nil,
                    color = nil,
                    cterm = nil,
                    color_nr = nil, -- cterm
                    highlight = "DiagnosticVirtualTextInfo"
                },
                Hint = {
                    text = {"-", "="},
                    priority = 5,
                    gui = nil,
                    color = nil,
                    cterm = nil,
                    color_nr = nil, -- cterm
                    highlight = "DiagnosticVirtualTextHint"
                },
                Misc = {
                    text = {"-", "="},
                    priority = 6,
                    gui = nil,
                    color = nil,
                    cterm = nil,
                    color_nr = nil, -- cterm
                    highlight = "Normal"
                },
                GitAdd = {
                    text = "+",
                    priority = 7,
                    gui = nil,
                    color = nil,
                    cterm = nil,
                    color_nr = nil, -- cterm
                    highlight = "GitSignsAdd"
                },
                GitChange = {
                    text = "*",
                    priority = 7,
                    gui = nil,
                    color = nil,
                    cterm = nil,
                    color_nr = nil, -- cterm
                    highlight = "GitSignsChange"
                },
                GitDelete = {
                    text = "-",
                    priority = 7,
                    gui = nil,
                    color = nil,
                    cterm = nil,
                    color_nr = nil, -- cterm
                    highlight = "GitSignsDelete"
                }
            },
            excluded_buftypes = {"terminal"},
            excluded_filetypes = {"cmp_docs", "cmp_menu", "noice", "prompt", "TelescopePrompt"},
            autocmd = {
                render = {"BufWinEnter", "TabEnter", "TermEnter", "WinEnter", "CmdwinLeave", "TextChanged",
                          "VimResized", "WinScrolled"},
                clear = {"BufWinLeave", "TabLeave", "TermLeave", "WinLeave"}
            },
            handlers = {
                cursor = true,
                diagnostic = true,
                gitsigns = false, -- Requires gitsigns
                handle = true,
                search = false, -- Requires hlslens
                ale = false -- Requires ALE
            }
        })
    end,
    notify = function()
        vim.notify = require("notify")
        local dap = require("dap")
        local notify = require("config.notify")
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
                notify.output_notify(message, format_title(val.title, vim.lsp.get_client_by_id(client_id).name),
                    val.kind, client_id, result.token)
            elseif val.kind == "report" and notif_data then
                notify.output_notify(format_message(val.message, val.percentage), nil, val.kind, client_id, result.token)
            elseif val.kind == "end" and notif_data then
                notify.output_notify(val.message and format_message(val.message) or "Complete", nil, val.kind,
                    client_id, result.token)
            end
        end

        -- table from lsp severity to vim severity.
        local severity = {"error", "warn", "info", "info" -- map both hint and info to info?
        }
        vim.lsp.handlers["window/showMessage"] = function(_, method, params, _)
            vim.notify(method.message, severity[params.type])
        end

        -- DAP integration
        -- Make sure to also have the snippet with the common helper functions in your config!

        dap.listeners.before["event_progressStart"]["progress-notifications"] = function(session, body)
            notify.output_notify(body.message, format_title(body.title, session.config.type), "begin", "dap",
                body.progressId, "info")
        end

        dap.listeners.before["event_progressUpdate"]["progress-notifications"] = function(_, body)
            notify.output_notify(format_message(body.message, body.percentage), nil, "report", "dap", body.progressId,
                "info")
        end

        dap.listeners.before["event_progressEnd"]["progress-notifications"] = function(_, body)
            notify.output_notify(body.message and format_message(body.message) or "Complete", nil, "end", "dap",
                body.progressId, "info")
        end
    end,
    telescope = function()
        local telescope = require("telescope")
        telescope.setup({
            defaults = {
                -- 打开弹窗后进入的初始模式，默认为 insert，也可以是 normal
                initial_mode = "insert",
                -- vertical , center , cursor
                layout_strategy = "horizontal",
                -- 窗口内快捷键
                mappings = require("keys").telescope()
            },
            pickers = {
                find_files = {
                    -- theme = "dropdown", -- 可选参数： dropdown, cursor, ivy
                }
            },
            extensions = {
                ["ui-select"] = {require("telescope.themes").get_dropdown({
                    -- even more opts
                })}
            }
        })

        pcall(telescope.load_extension, "env")
        -- To get ui-select loaded and working with telescope, you need to call
        -- load_extension, somewhere after setup function:
        pcall(telescope.load_extension, "ui-select")
        pcall(telescope.load_extension, "lazygit")
        pcall(telescope.load_extension, "fzf")
        pcall(telescope.load_extension, "dap")
    end
}
