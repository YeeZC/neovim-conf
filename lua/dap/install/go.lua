local M = {}

function M.setup()
    M.check_gopls()
end

function M.check_gopls()
    local notify = require("plugin/notify")
    local gopath = os.getenv("GOPATH")
    if gopath == "" then
        notify.output_notify("Golang enviroment not found", "GolangTools", "report", "gopls_cli", "token", "warn")
        return
    end
    local commands = {}
    local notfounds = {}
    commands["gopls"] = "golang.org/x/tools/gopls@latest"
    commands["goimports"] = "golang.org/x/tools/cmd/goimports@latest"
    commands["dlv"] = "github.com/go-delve/delve/cmd/dlv@latest"
    local count = 0
    for key, value in pairs(commands) do
        if vim.fn.executable(gopath .. "/bin/" .. key) ~= 1 then
            notfounds[key] = value
            count = count + 1
        end
    end
    if count > 0 then
        -- notify.output_notify("Install Golang dev tools", "GolangTools", "begin", "gopls_cli", "token", "info")
        -- 遍历 commands 执行 value 命令 安装对应的工具
        local current = 0
        local failed = 0
        for key, value in pairs(notfounds) do
            current = current + 1
            local index = current
            notify.output_notify(
                "Install " .. key .. " success",
                "[" .. index .. "/" .. count .. "]GolangTools",
                "begin",
                "gopls_cli",
                key,
                "info"
            )
            vim.fn.jobstart("go install " .. value, {
                on_exit = function(_, code)
                    if code == 0 then
                        notify.output_notify("Install " .. key .. " success", nil, "end", "gopls_cli", key, "success")
                        if key == "gopls" then
                            require("dap.nvim-dap.go").setup()
                        end
                    else
                        notify.output_notify("Install " .. key .. " fail", nil, "end", "gopls_cli", key, "error")
                        failed = failed + 1
                    end
                end,
            })
        end
    end
end

return M

