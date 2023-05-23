local M = {}
function M.setup()
    -- 判断file是否是python文件
    local ext = vim.fn.expand("%:e")
    if ext == "py" then
        require("dap.install.python").setup()
    elseif ext == "go" then
        require("dap.install.go").setup()
    else
    end
end

return M