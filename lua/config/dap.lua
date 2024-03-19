vim.fn.sign_define("DapBreakpoint", {
    text = "",
    texthl = "LspDiagnosticsSignError",
    linehl = "",
    numhl = ""
})

vim.fn.sign_define("DapStopped", {
    text = "",
    texthl = "LspDiagnosticsSignInformation",
    linehl = "DiagnosticUnderlineInfo",
    numhl = "LspDiagnosticsSignInformation"
})

vim.fn.sign_define("DapBreakpointRejected", {
    text = "",
    texthl = "LspDiagnosticsSignHint",
    linehl = "",
    numhl = ""
})

local fn = vim.fn

local dap_go = function(dap)
    local install_path = fn.stdpath("data") .. "/lazy/vscode-go/extension/dist/debugAdapter.js"
    dap.adapters.go = {
        type = "executable",
        command = "node",
        args = {install_path}
    }
    dap.configurations.go = {{
        type = "go",
        name = "Debug (VSCode)",
        request = "launch",
        showLog = false,
        program = "${file}",
        dlvToolPath = vim.fn.exepath("dlv") -- Adjust to where delve is installed
    }, {
        type = "go",
        name = "Test (VSCode)",
        request = "launch",
        showLog = false,
        mode = "test",
        program = "${file}",
        dlvToolPath = vim.fn.exepath("dlv") -- Adjust to where delve is installed
    }, {
        type = "go",
        name = "Test Dir (VSCode)",
        request = "launch",
        showLog = false,
        mode = "test",
        program = "./${relativeFileDirname}",
        dlvToolPath = vim.fn.exepath("dlv") -- Adjust to where delve is installed
    }}
end

local dap_python = function(dap)
    local get_python = function()
        if vim.fn.executable("/usr/local/bin/python3") == 1 then
            return "/usr/local/bin/python3"
        else
            return "/usr/bin/python3"
        end
    end
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
                    source_filetype = "python"
                }
            })
        else
            local cmd = get_python()
            cb({
                type = "executable",
                command = cmd,
                args = {"-m", "debugpy.adapter"},
                options = {
                    source_filetype = "python"
                }
            })
        end
    end

    dap.configurations.python = {{
        -- The first three options are required by nvim-dap
        type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
        request = "launch",
        name = "Launch file",

        -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

        program = "${file}", -- This configuration will launch the current file if used.
        pythonPath = function()
            return get_python()
        end
    }}
end

return function()
    local dap = require("dap")
    local dapui = require("dapui")
    dap.set_log_level("ERROR")

    require("nvim-dap-virtual-text").setup({
        commented = true
    })

    dapui.setup({
        icons = {
            expanded = "▾",
            collapsed = "▸",
            current_frame = "▸"
        },
        mappings = {
            -- Use a table to apply multiple mappings
            expand = {"o", "<CR>", "<2-LeftMouse>"},
            open = "o",
            remove = "d",
            edit = "e",
            repl = "r",
            toggle = "t"
        },
        layouts = {{
            elements = { -- Provide as ID strings or tables with "id" and "size" keys
            {
                id = "scopes",
                size = 0.25
            }, {
                id = "breakpoints",
                size = 0.25
            }, {
                id = "stacks",
                size = 0.25
            }, {
                id = "watches",
                size = 0.25
            }},
            size = 40,
            position = "left" -- Can be "left", "right", "top", "bottom"
        }, {
            elements = {{
                id = "repl",
                size = 0.5
            }, {
                id = "console",
                size = 0.5
            }},
            size = 10,
            position = "bottom" -- Can be "left", "right", "top", "bottom"
        }},
        floating = {
            max_height = nil, -- These can be integers or a float between 0 and 1.
            max_width = nil, -- Floats will be treated as percentage of your screen.
            border = "single", -- Border style. Can be "single", "double" or "rounded"
            mappings = {
                close = {"q", "<Esc>"}
            }
        },
        render = {
            indent = 1,
            max_value_lines = 100
        }
    }) -- use default

    dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
    end
    require("neodev").setup({
        library = {
            plugins = {"nvim-dap-ui"},
            types = true
        }
    })

    dap_go(dap)
    dap_python(dap)
    require("keys").dap(dap)
end
