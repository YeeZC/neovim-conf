return function()
    require("gitsigns").setup({
        -- 字母图标 A 增加，C修改，D 删除
        signs = {
            add = {
                hl = "GitSignsAdd",
                text = "+",
                numhl = "GitSignsAddNr",
                linehl = "GitSignsAddLn"
            },
            change = {
                hl = "GitSignsChange",
                text = "*",
                numhl = "GitSignsChangeNr",
                linehl = "GitSignsChangeLn"
            },
            delete = {
                hl = "GitSignsDelete",
                text = "-",
                numhl = "GitSignsDeleteNr",
                linehl = "GitSignsDeleteLn"
            },
            topdelete = {
                hl = "GitSignsDelete",
                text = "-",
                numhl = "GitSignsDeleteNr",
                linehl = "GitSignsDeleteLn"
            },
            changedelete = {
                hl = "GitSignsChange",
                text = "-",
                numhl = "GitSignsChangeNr",
                linehl = "GitSignsChangeLn"
            }
        },
        -- 显示图标
        signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
        -- 行数高亮
        numhl = true, -- Toggle with `:Gitsigns toggle_numhl`
        linehl = true, -- Toggle with `:Gitsigns toggle_linehl`
        word_diff = true, -- Toggle with `:Gitsigns toggle_word_diff`
        --	keymaps = require("keybindings").gitsigns,
        watch_gitdir = {
            interval = 1000,
            follow_files = true
        },
        attach_to_untracked = true,
        current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame_opts = {
            virt_text = true,
            virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
            delay = 1000,
            ignore_whitespace = false
        },
        current_line_blame_formatter_opts = {
            relative_time = false
        },
        sign_priority = 6,
        update_debounce = 100,
        status_formatter = nil, -- Use default
        max_file_length = 40000,
        preview_config = {
            -- Options passed to nvim_open_win
            border = "single",
            style = "minimal",
            relative = "cursor",
            row = 0,
            col = 1
        },
        yadm = {
            enable = false
        },
        on_attach = require("keys").gitsigns
    })
    require("scrollbar.handlers.gitsigns").setup()

end
