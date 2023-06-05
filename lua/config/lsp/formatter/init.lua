local status, formatter = pcall(require, "formatter")
if not status then
    vim.notify("没有找到 formatter")
    return
end

local util = formatter.util

formatter.setup({
    -- Enable or disable logging
    logging = true,
    
    -- Set the log level
    log_level = vim.log.levels.WARN,
    -- All formatter configurations are opt-in
    filetype = require("config.lsp.formatter.formatting").format(),
})
