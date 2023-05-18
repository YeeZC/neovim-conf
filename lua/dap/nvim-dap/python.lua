local M = {}

function M.setup()
    local dap = require('dap')

    dap.adapters.python = {
    type = "executable";
    command = '/usr/bin/python3';
    args = { '-m', 'debugpy.adapter' };
    }

    local get_args = function()
    -- 获取输入命令行参数
    local cmd_args = vim.fn.input('CommandLine Args:')
    local params = {}
    -- 定义分隔符(%s在lua内表示任何空白符号)
    local sep = "%s"
    for param in string.gmatch(cmd_args, "[^%s]+") do
        table.insert(params, param)
    end
    return params
    end;

    dap.configurations.python = {
    {
        type = 'python';
        request = 'launch';
        name = 'launch file';
        -- 此处指向当前文件
        program = '${file}';
        args = get_args;
        pythonpath = function()
        return '/usr/bin/python3'
        end;
    },
    }
end

return M