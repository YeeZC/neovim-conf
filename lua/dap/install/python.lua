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

function M.check_debugpy()
    local notify = require("plugin/notify")
    local cmd = M.get_python(true)
    local cmd_check = cmd .. " -m pip show debugpy"
    -- 异步判断 debugpy 是否安装，如果没有安装则调用 install_debugpy
    vim.fn.jobstart(cmd_check, {
        on_exit = function(_, code)
            if code ~= 0 then
                notify.output_notify(
                    "debugpy is not installed",
                    "Python Tools",
                    "begin",
                    "debugpy_cli",
                    "debugpy",
                    "warn"
                )
                local cmd_install = cmd .. " -m pip install -i https://pypi.tuna.tsinghua.edu.cn/simple debugpy"
                -- 异步执行 cmd_install
                vim.fn.jobstart(cmd_install, {
                    on_exit = function(_, code)
                        if code == 0 then
                            notify.output_notify(
                                "debugpy install success",
                                nil,
                                "end",
                                "debugpy_cli",
                                "debugpy",
                                "success"
                            )
                        else
                            notify.output_notify("debugpy install fail", nil, "end", "debugpy_cli", "debugpy", "error")
                        end
                    end,
                })
            end
        end,
    })
end

function M.check_pyright()
    local notify = require("plugin/notify")
    local cmd = M.get_python(false)
    local commands = { "pyright", "black" }
    for i = 1, #commands do
        -- 异步判断 debugpy 是否安装，如果没有安装则调用 install_debugpy
        vim.fn.jobstart(cmd .. " -m pip show " .. commands[i], {
            on_exit = function(_, code)
                if code ~= 0 then
                    notify.output_notify(
                        commands[i] .. " is not installed",
                        "Python Tools",
                        "begin",
                        "debugpy_cli",
                        commands[i],
                        "warn"
                    )
                    local cmd_install = cmd .. " -m pip install -i https://pypi.tuna.tsinghua.edu.cn/simple pyright"
                    -- 异步执行 cmd_install
                    vim.fn.jobstart(cmd_install, {
                        on_exit = function(_, code)
                            if code == 0 then
                                notify.output_notify(
                                    commands[i] .. " install success",
                                    nil,
                                    "end",
                                    "debugpy_cli",
                                    commands[i],
                                    "success"
                                )
                                if commands[i] == "pyright" then
                                    require("dap.nvim-dap.python").setup()
                                end
                            else
                                notify.output_notify(
                                    commands[i] .. " install fail",
                                    nil,
                                    "end",
                                    "debugpy_cli",
                                    commands[i],
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

function M.setup()
    M.check_debugpy()
    M.check_pyright()
end

return M
