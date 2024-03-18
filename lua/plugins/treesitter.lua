return { -- treesitter
{
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        -- 开启 Folding 模块
        vim.opt.foldmethod = "expr"
        vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
        -- 默认不要折叠
        -- https://stackoverflow.com/questions/8316139/how-to-set-the-default-to-unfolded-when-you-open-a-file
        vim.opt.foldlevel = 99
    end,
    opts = {
        ensure_installed = {"yaml", "json", "html", "css", "vim", "lua", "javascript", "typescript", "tsx", "go",
                            "python", "markdown", "markdown_inline"},
        -- 启用代码高亮模块
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false
        },
        -- 启用增量选择模块
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "<CR>",
                node_incremental = "<CR>",
                node_decremental = "<BS>",
                scope_incremental = "<TAB>"
            }
        },
        -- https://github.com/nvim-treesitter/playground#query-linter
        query_linter = {
            enable = true,
            use_virtual_text = true,
            lint_events = {"BufWrite", "CursorHold"}
        },
        -- 启用代码缩进模块 (=)
        indent = {
            enable = true
        },
        playground = {
            enable = true,
            disable = {},
            updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
            persist_queries = true, -- Whether the query persists across vim sessions
            keybindings = {
                toggle_query_editor = "o",
                toggle_hl_groups = "i",
                toggle_injected_languages = "t",
                toggle_anonymous_nodes = "a",
                toggle_language_display = "I",
                focus_language = "f",
                unfocus_language = "F",
                update = "R",
                goto_node = "<cr>",
                show_help = "?"
            }
        }
    }
}, {
    "nvim-treesitter/playground",
    cmd = "TSPlaygroundToggle"
}, {
    "nvim-treesitter/nvim-treesitter-context",
    event = "BufEnter",
    dependencies = {"nvim-treesitter/nvim-treesitter"},
    config = function()
        require("treesitter-context").setup()
    end
}}
