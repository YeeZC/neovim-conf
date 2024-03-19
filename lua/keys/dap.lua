return {
    setup = function(dap)
        -- 本地变量
        local map = vim.api.nvim_set_keymap
        local opts = {
            noremap = true,
            silent = true
        }
        -- 开始、继续、下一步、进入、跳出
        vim.keymap.set("n", "<F5>", function()
            vim.cmd(":wall")
            local api = require("nvim-tree.api")
            api.tree.close()
            local dap = require("dap")
            dap.continue()
        end, opts)
        -- map("n", "<F5>", ":DapContinue<CR>", opts)
        map("n", "<F6>", ":DapStepOver<CR>", opts)
        map("n", "<F7>", ":DapStepInto<CR>", opts)
        map("n", "<F8>", ":DapStepOut<CR>", opts)
        -- map("n", "<F9>", ":DapTerminate<CR>", opts)
        vim.keymap.set("n", "<F9>", function()
            local dap = require("dap")
            dap.terminate()
            local api = require("nvim-tree.api")
            api.tree.open()
        end, opts)
        -- 设置断点
        map("n", "<S-b>", ":DapToggleBreakpoint<CR>", opts)
        -- 弹窗
        map("n", "<S-e>", ":lua require'dapui'.eval()<CR>", opts)

    end
}
