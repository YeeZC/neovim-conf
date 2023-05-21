local myAutoGroup = vim.api.nvim_create_augroup("myAutoGroup", {
    clear = true,
})
local autocmd = vim.api.nvim_create_autocmd

-- nvim-tree 自动关闭
-- autocmd("BufEnter", {
--     nested = true,
--     group = myAutoGroup,
--     callback = function()
--       if #vim.api.nvim_list_wins() == 1 and vim.api.nvim_buf_get_name(0):match("NvimTree_") ~= nil then
--         vim.cmd("quit")
--       end
--     end,
--   })
-- 修改lua/plugins.lua 自动更新插件
autocmd("BufWritePost", {
    group = myAutoGroup,
    -- autocmd BufWritePost plugins.lua source <afile> | PackerSync
    callback = function()
        if vim.fn.expand("<afile>") == "lua/plugins.lua" then
            vim.api.nvim_command("source lua/plugins.lua")
            vim.api.nvim_command("PackerSync")
        end
    end,
})

-- 检查Python是否安装了debugpy，没安装就安装
autocmd("BufEnter", {
    group = myAutoGroup,
    callback = function()
        if debugpy then
            return
        end
         -- 判断file是否是python文件
         if vim.fn.expand("%:e") ~= "py" then
            return
        end
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
        -- 判断 debugpy 是否安装
        local cmd_check = cmd .. " -m pip show debugpy"
        local install_debugpy = function()
            local cmd_install = cmd .. " -m pip install -i https://pypi.tuna.tsinghua.edu.cn/simple debugpy"

            -- 异步执行 cmd_install
            vim.fn.jobstart(cmd_install, {
                on_exit = function(_, code)
                    if code == 0 then
                        vim.notify("debugpy install success", "info", { title = "debugpy" })
                    else
                        vim.notify("debugpy install fail", "error", { title = "debugpy" })
                    end
                end,
            })
        end
        -- 异步判断 debugpy 是否安装，如果没有安装则调用 install_debugpy
        vim.fn.jobstart(cmd_check, {
            on_exit = function(_, code)
                if code ~= 0 then
                    vim.notify("debugpy is not installed", "warn", { title = "debugpy" })
                    install_debugpy()
                end
            end,
        })
    end,
})