return {
    {
        "kevinhwang91/nvim-hlslens",
        event = "BufEnter",
        dependencies = { "petertriho/nvim-scrollbar" },
        config = function()
            require("hlslens").setup({
                override_lens = function(render, posList, nearest, idx, relIdx)
                    local sfw = vim.v.searchforward == 1
                    local indicator, text, chunks
                    local absRelIdx = math.abs(relIdx)
                    if absRelIdx > 1 then
                        indicator = ("%d%s"):format(absRelIdx, sfw ~= (relIdx > 1) and "󰁝" or "󰁅")
                    elseif absRelIdx == 1 then
                        -- indicator = sfw ~= (relIdx == 1) and '󰮽' or '󰮷'
                        indicator = ("%d%s"):format(absRelIdx, sfw ~= (relIdx == 1) and "󰁝" or "󰁅")
                    else
                        indicator = ""
                    end

                    local lnum, col = unpack(posList[idx])
                    if nearest then
                        local cnt = #posList
                        if indicator ~= "" then
                            text = ("[%s %d/%d]"):format(indicator, idx, cnt)
                        else
                            text = ("[%d/%d]"):format(idx, cnt)
                        end
                        chunks = { { " ", "Ignore" }, { text, "HlSearchLensNear" } }
                    else
                        text = ("[%s %d]"):format(indicator, idx)
                        chunks = { { " ", "Ignore" }, { text, "HlSearchLens" } }
                    end
                    render.setVirt(0, lnum - 1, col - 1, chunks, nearest)
                end,
            })
            require("scrollbar.handlers.search").setup({})
        end,
    },
    {
        "petertriho/nvim-scrollbar",
        config = function()
            require("scrollbar").setup({
                show = true,
                show_in_active_only = false,
                set_highlights = true,
                folds = 1000,    -- handle folds, set to number to disable folds if no. of lines in buffer exceeds this
                max_lines = false, -- disables if no. of lines in buffer exceeds this
                hide_if_all_visible = false, -- Hides everything if all lines are visible
                throttle_ms = 100,
                handle = {
                    text = " ",
                    blend = 30,  -- Integer between 0 and 100. 0 for fully opaque and 100 to full transparent. Defaults to 30.
                    color = nil,
                    color_nr = nil, -- cterm
                    highlight = "CursorColumn",
                    hide_if_all_visible = true, -- Hides handle if all lines are visible
                },
                marks = {
                    Cursor = {
                        text = "•",
                        -- text = "󰮹",
                        priority = 0,
                        gui = nil,
                        color = nil,
                        cterm = nil,
                        color_nr = nil, -- cterm
                        highlight = "Normal",
                    },
                    Search = {
                        text = { "-", "=" },
                        priority = 1,
                        gui = nil,
                        color = nil,
                        cterm = nil,
                        color_nr = nil, -- cterm
                        highlight = "Search",
                    },
                    Error = {
                        text = { "-", "=" },
                        priority = 2,
                        gui = nil,
                        color = nil,
                        cterm = nil,
                        color_nr = nil, -- cterm
                        highlight = "DiagnosticVirtualTextError",
                    },
                    Warn = {
                        text = { "-", "=" },
                        priority = 3,
                        gui = nil,
                        color = nil,
                        cterm = nil,
                        color_nr = nil, -- cterm
                        highlight = "DiagnosticVirtualTextWarn",
                    },
                    Info = {
                        text = { "-", "=" },
                        priority = 4,
                        gui = nil,
                        color = nil,
                        cterm = nil,
                        color_nr = nil, -- cterm
                        highlight = "DiagnosticVirtualTextInfo",
                    },
                    Hint = {
                        text = { "-", "=" },
                        priority = 5,
                        gui = nil,
                        color = nil,
                        cterm = nil,
                        color_nr = nil, -- cterm
                        highlight = "DiagnosticVirtualTextHint",
                    },
                    Misc = {
                        text = { "-", "=" },
                        priority = 6,
                        gui = nil,
                        color = nil,
                        cterm = nil,
                        color_nr = nil, -- cterm
                        highlight = "Normal",
                    },
                    GitAdd = {
                        text = "+",
                        priority = 7,
                        gui = nil,
                        color = nil,
                        cterm = nil,
                        color_nr = nil, -- cterm
                        highlight = "GitSignsAdd",
                    },
                    GitChange = {
                        text = "*",
                        priority = 7,
                        gui = nil,
                        color = nil,
                        cterm = nil,
                        color_nr = nil, -- cterm
                        highlight = "GitSignsChange",
                    },
                    GitDelete = {
                        text = "-",
                        priority = 7,
                        gui = nil,
                        color = nil,
                        cterm = nil,
                        color_nr = nil, -- cterm
                        highlight = "GitSignsDelete",
                    },
                },
                excluded_buftypes = { "terminal" },
                excluded_filetypes = { "cmp_docs", "cmp_menu", "noice", "prompt", "TelescopePrompt" },
                autocmd = {
                    render = {
                        "BufWinEnter",
                        "TabEnter",
                        "TermEnter",
                        "WinEnter",
                        "CmdwinLeave",
                        "TextChanged",
                        "VimResized",
                        "WinScrolled",
                    },
                    clear = { "BufWinLeave", "TabLeave", "TermLeave", "WinLeave" },
                },
                handlers = {
                    cursor = true,
                    diagnostic = true,
                    gitsigns = false, -- Requires gitsigns
                    handle = true,
                    search = false, -- Requires hlslens
                    ale = false, -- Requires ALE
                },
            })
        end,
    }, -- 通知
    {
        "rcarriga/nvim-notify",
        config = require("config.notify"),
    }, -- float terminal
    {
        "akinsho/toggleterm.nvim",
        version = "*",
        event = "BufEnter",
        config = function()
            require("toggleterm").setup({
                direction = "float",
            })
        end,
    },
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function()
            vim.fn["mkdp#util#install"]()
        end,
    }, -- telescope
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "kdheepak/lazygit.nvim", -- telescope extensions
            "LinArcX/telescope-env.nvim",
            "nvim-telescope/telescope-dap.nvim",
            "nvim-telescope/telescope-ui-select.nvim",
        },
        config = function()
            local telescope = require("telescope")
            telescope.setup({
                defaults = {
                    -- 打开弹窗后进入的初始模式，默认为 insert，也可以是 normal
                    initial_mode = "insert",
                    -- vertical , center , cursor
                    layout_strategy = "horizontal",
                    -- 窗口内快捷键
                    mappings = require("keys").telescope(),
                },
                pickers = {
                    find_files = {
                        -- theme = "dropdown", -- 可选参数： dropdown, cursor, ivy
                    },
                },
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown({
                            -- even more opts
                        }),
                    },
                },
            })

            pcall(telescope.load_extension, "env")
            -- To get ui-select loaded and working with telescope, you need to call
            -- load_extension, somewhere after setup function:
            pcall(telescope.load_extension, "ui-select")
            pcall(telescope.load_extension, "lazygit")
            pcall(telescope.load_extension, "fzf")
            pcall(telescope.load_extension, "dap")
        end,
    },
}
