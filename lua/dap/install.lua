local M = {}
local notify = require("plugin/notify_exp")

function M.install_debugpy()
    local get_python = function()
        local cwd = vim.fn.getcwd()
        if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
            cwd = cwd .. "/venv/bin/python"
        elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
            cwd = cwd .. "/.venv/bin/python"
        else
            cwd = "/usr/bin/python3"
        end
        return cwd
    end
    local cmd = get_python()

    local debugpy_client_id = "debugpy_cli"
    local debugpy_token = "debugpy_token"
    -- 判断 debugpy 是否安装
    local cmd_check = cmd .. " -m pip show debugpy"
    local install_debugpy = function()
        local cmd_install = cmd .. " -m pip install -i https://pypi.tuna.tsinghua.edu.cn/simple debugpy"

        -- 异步执行 cmd_install
        vim.fn.jobstart(cmd_install, {
            on_exit = function(_, code)
                if code == 0 then
                    notify.output_notify("debugpy install success", nil, "end", debugpy_client_id, debugpy_token, "success")
                else
                    notify.output_notify("debugpy install fail", nil, "end", debugpy_client_id, debugpy_token, "error")
                end
            end,
        })
    end
    -- 异步判断 debugpy 是否安装，如果没有安装则调用 install_debugpy
    vim.fn.jobstart(cmd_check, {
        on_exit = function(_, code)
            if code ~= 0 then
                notify.output_notify("debugpy is not installed", "debugpy", "begin", debugpy_client_id, debugpy_token, "warn")
                install_debugpy()
            end
        end,
    })
end

function M.install_gopls()
    local gopath = os.getenv("GOPATH")
    if gopath == "" {
        notify.output_notify("Golang enviroment not found", "gopls", "report", "gopls_cli", "token", "warn")
    }
    local comands = {}
    local count = 0
    if vim.fn.executable(gopath .. "/bin/gopls") ~= 1 then
        comands["gopls"] = "go install golang.org/x/tools/gopls@latest"
        count = count + 1
    end
    if vim.fn.executable(cwd .. "/bin/goimports") == 1 then
        comands["goimports"] = "go install golang.org/x/tools/cmd/goimports@latest"
        count = count + 1
    end
    if vim.fn.executable(cwd .. "/bin/dlv") == 1 then
        comands["goimports"] = "go install github.com/go-delve/delve/cmd/dlv@latest"
        count = count + 1
    end
    if count > 0 then 
        notify.output_notify("Install Golang dev tools", "gopls", "begin", "gopls_cli", "token", "warn")
        -- 遍历 commands 执行 value 命令 安装对应的工具
        
    end
end

function M.install()
    -- 判断file是否是python文件
    local ext = vim.fn.expand("%:e")
    if ext == "py" then
        M.install_debugpy()
    elseif ext == "go" then
        M.install_gopls()
    else
    end
end

return M