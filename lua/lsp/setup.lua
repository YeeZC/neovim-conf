local lspconfig = require("lspconfig")

require("nvim-lsp-installer").setup({
    -- 自动安装 Language Servers
    automatic_installation = true,
})

local servers = {
    pyright = require("lsp.config.pyright"),
    jsonls = require("lsp.config.json"),
    tsserver = require("lsp.config.ts"),
    bashls = require("lsp.config.bash"),
    html = require("lsp.config.html"),
    cssls = require("lsp.config.css"),
    emmet_ls = require("lsp.config.common"),
    yamlls = require("lsp.config.yamlls"),
    gopls = require("lsp.config.go"),
    sqlls = require("lsp.config.sqlls"),
    lua_ls = require("lsp.config.lua"),
    kotlin_language_server = require("lsp.config.common"),
}

for name, config in pairs(servers) do
    if config ~= nil and type(config) == "table" then
        -- 自定义初始化配置文件必须实现on_setup 方法
        config.on_setup(lspconfig[name])
    else
        -- 使用默认参数
        lspconfig[name].setup({})
    end
end

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf,  silent = true}
        vim.keymap.set("n", "gd", ":Lspsaga goto_definition<CR>", opts)
        vim.keymap.set("n", "K", ":Lspsaga hover_doc<CR>", opts)
        vim.keymap.set("n", "gt", ":Lspsaga goto_type_definition<CR>", opts)
        vim.keymap.set({ "n", "v" }, "<leader>/", ":Lspsaga code_action<CR>", opts)
        vim.keymap.set("n", "gr", ":Lspsaga lsp_finder<cr>", opts)
        vim.keymap.set("n", "<S-f>", function()
            vim.lsp.buf.format({ async = true })
        end, opts)
    end,
})
