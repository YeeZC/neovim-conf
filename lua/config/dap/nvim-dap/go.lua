local M = {}

function M.setup()
    -- require('dap-go').setup()
    local dap = require("dap")
    local fn = vim.fn
    local install_path = fn.stdpath("data") .. "/lazy/vscode-go/dist/debugAdapter.js"
    dap.adapters.go = {
        type = "executable",
        command = "node",
        args = { install_path },
    }
    dap.configurations.go = {
        {
            type = "go",
            name = "Debug (VSCode)",
            request = "launch",
            showLog = false,
            program = "${file}",
            dlvToolPath = vim.fn.exepath("dlv"), -- Adjust to where delve is installed
        },
        {
            type = "go",
            name = "Test (VSCode)",
            request = "launch",
            showLog = false,
            mode = "test",
            program = "${file}",
            dlvToolPath = vim.fn.exepath("dlv"), -- Adjust to where delve is installed
        },
        {
            type = "go",
            name = "Test Dir (VSCode)",
            request = "launch",
            showLog = false,
            mode = "test",
            program = "./${relativeFileDirname}",
            dlvToolPath = vim.fn.exepath("dlv"), -- Adjust to where delve is installed
        },
    }
end

return M
