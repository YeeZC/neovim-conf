local M = {}
local defaults = require("formatter.defaults")
local util = require("formatter.util")

function M.format()
    local prettiers = {
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "vue",
        "css",
        "html",
        "json",
        "yaml",
        "graphql",
    }
    local result = {
        go = require("formatter.filetypes.go").goimports,
        python = require("formatter.filetypes.python").black,
        lua = require("formatter.filetypes.lua").stylua,
        scss = util.withl(defaults.prettier, "scss"),
        less = util.withl(defaults.prettier, "less"),
        sh = require("formatter.filetypes.sh").shfmt,
        ["*"] = require("formatter.filetypes.any").remove_trailing_whitespace,
    }
    for _, type in pairs(prettiers) do
        result[type] = require("formatter.filetypes." .. type).prettier
    end
    return result
end

return M
