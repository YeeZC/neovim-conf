-- 自定义图标
vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    update_in_insert = false
})
local signs = {
    Error = " ",
    Warn = " ",
    Hint = " ",
    Info = " "
}
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, {
        text = icon,
        texthl = hl,
        numhl = hl
    })
end

return { -- lsp
{
    "neovim/nvim-lspconfig",
    opts = {
        servers = {
            pyright = {},
            jsonls = {},
            tsserver = {},
            bashls = {},
            html = {},
            cssls = {},
            emmet_ls = {},
            yamlls = {},
            gopls = {},
            sqlls = {},
            lua_ls = {},
            kotlin_language_server = {}
        }
    },
    config = function()
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", {}),
            callback = function(ev)
                -- Enable completion triggered by <c-x><c-o>
                vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
        
                -- Buffer local mappings.
                -- See `:help vim.lsp.*` for documentation on any of the below functions
                local opts = { buffer = ev.buf, silent = true }
                vim.keymap.set("n", "gd", ":Lspsaga goto_definition<CR>", opts)
                vim.keymap.set("n", "K", ":Lspsaga hover_doc<CR>", opts)
                vim.keymap.set("n", "gt", ":Lspsaga goto_type_definition<CR>", opts)
                vim.keymap.set({ "n", "v" }, "<leader>/", ":Lspsaga code_action<CR>", opts)
                vim.keymap.set("n", "gr", ":Lspsaga finder<cr>", opts)
                -- vim.keymap.set("n", "<S-f>", function()
                --     vim.lsp.buf.format({ async = true })
                -- end, opts)
            end,
        })
    end
}, {
    "williamboman/nvim-lsp-installer",
    opts = {
        automatic_installation = true
    }
}, {
    "onsails/lspkind.nvim",
    config = function()
        require("lspkind").init({
            -- default: true
            -- with_text = true,
            -- defines how annotations are shown
            -- default: symbol
            -- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
            mode = "symbol_text",
            -- default symbol map
            -- can be either 'default' (requires nerd-fonts font) or
            -- 'codicons' for codicon preset (requires vscode-codicons font)
            --
            -- default: 'default'
            preset = "codicons",
            -- override preset symbols
            --
            -- default: {}
            symbol_map = {
                Array = "󰅨",
                Package = "",
                Text = "󰅳",
                Method = "",
                Function = "󰡱",
                Constructor = "",
                Field = "",
                Class = "",
                Interface = "",
                Module = "",
                Property = "",
                Unit = "󰊱",
                Value = "",
                Enum = "",
                Keyword = "",
                Snippet = "",
                Color = "",
                File = "",
                Reference = "",
                Folder = "",
                EnumMember = "",
                Constant = "",
                Struct = "",
                Event = "",
                Operator = "",
                TypeParameter = "",
                Variable = "",
                Fragment = ""
            }
        })
    end
}, 
-- lua 增强
	{ "folke/neodev.nvim", event = "BufEnter" },
{
    "nvimdev/lspsaga.nvim",
    branch = "main",
    event = "BufEnter",
    dependencies = {"nvim-tree/nvim-web-devicons", "nvim-treesitter/nvim-treesitter"},
    config = function()
        require("lspsaga").setup({
            finder = {
                max_height = 0.5,
                min_width = 30,
                force_max_height = false,
                keys = {
                    jump_to = "p",
                    toggle_or_open = "<cr>",
                    vsplit = "s",
                    split = "i",
                    tabe = "t",
                    tabnew = "r",
                    quit = { "q", "<ESC>" },
                    close_in_preview = "<ESC>",
                },
            },
            code_action = {
                num_shortcut = true,
                show_server_name = true,
                extend_gitsigns = true,
                keys = {
                    -- string | table type
                    quit = "q",
                    exec = "<CR>",
                },
            },
            lightbulb = {
                enable = true,
                enable_in_insert = false,
                sign = false,
                sign_priority = 40,
                virtual_text = true,
            },
            outline = {
                win_position = "right",
                win_width = 40,
                preview_width = 0.4,
                show_detail = true,
                auto_preview = true,
                auto_refresh = true,
                auto_close = true,
                auto_resize = true,
                custom_sort = nil,
                keys = {
                    toggle_or_open = "<cr>",
                    quit = "q",
                },
            },
            symbol_in_winbar = {
                enable = true,
                separator = " ⏵ ",
                ignore_patterns = {},
                hide_keyword = true,
                show_file = true,
                folder_level = 2,
                respect_root = false,
                color_mode = true,
            },
            hover = {
                max_width = 0.6,
                open_link = "gx",
                open_browser = "!chrome",
            },
            rename = {
                quit = "<C-q>",
                exec = "<CR>",
                mark = "x",
                confirm = "<CR>",
                in_select = true,
            },
            ui = {
                title = true,
                border = "single",
                winblend = 0,
                expand = "⏵",
                collapse = "⏷",
                code_action = "💡",
                incoming = " ",
                outgoing = " ",
                hover = " ",
                actionfix = "",
                imp_sign = "󰳛",
                kind = {
                    ["Folder"] = { " ", "@comment" },
                },
            },
        })
    end
}}
