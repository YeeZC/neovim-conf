local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
        vim.cmd([[packadd packer.nvim]])
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

return require("packer").startup({
    function()
        -- 包管理
        use("wbthomason/packer.nvim")
        -- 通知
        use("rcarriga/nvim-notify")
        -- 美化
        -- 括号颜色
        use("luochen1990/rainbow")
        -- 状态栏
        use("vim-airline/vim-airline")
        use("vim-airline/vim-airline-themes")
        -- 目录树
        use({
            "nvim-tree/nvim-tree.lua",
            requires = {
                "nvim-tree/nvim-web-devicons",
            },
        })
        -- 主题管理
        use("flazz/vim-colorschemes")
        -- 启动器
        use("mhinz/vim-startify")
        -- 主题颜色
        use("sainnhe/sonokai")
        -- use 'fatih/molokai'

        -- 注释
        -- use("scrooloose/nerdcommenter")
        use("tpope/vim-commentary")
        -- 自动闭合
        use("spf13/vim-autoclose")
        use("tpope/vim-endwise")
        -- search
        -- use("osyo-manga/vim-anzu")
        -- use("haya14busa/is.vim")
        use({
            "haya14busa/incsearch-fuzzy.vim",
            requires = "haya14busa/incsearch.vim",
            config = "require('plugin.incsearch').setup()",
        })
        use("junegunn/vim-slash")
        use({ "junegunn/fzf", dir = "~/.fzf", run = "./install --all" })
        use("junegunn/fzf.vim")

        -- use("Shougo/echodoc.vim")
        -- 对齐插件，有format以后不需要了
        -- use("junegunn/vim-easy-align")
        -- 快速移动插件，没怎么用过
        -- use("easymotion/vim-easymotion")

        use("voldikss/vim-floaterm")

        use("tpope/vim-surround")
        use("machakann/vim-sandwich")
        use("github/copilot.vim")

        use({
            "neovim/nvim-lspconfig",
            "williamboman/nvim-lsp-installer",
        })
        -- lua 增强
        use("folke/neodev.nvim")
        -- TypeScript 增强
        use({ "jose-elias-alvarez/nvim-lsp-ts-utils", requires = "nvim-lua/plenary.nvim" })
        -- 补全引擎
        use("hrsh7th/nvim-cmp")
        -- Snippet 引擎
        use("hrsh7th/vim-vsnip")
        -- 补全源
        use("hrsh7th/cmp-vsnip")
        use("hrsh7th/cmp-nvim-lsp")          -- { name = nvim_lsp }
        use("hrsh7th/cmp-buffer")            -- { name = 'buffer' },
        use("hrsh7th/cmp-path")              -- { name = 'path' }
        use("hrsh7th/cmp-cmdline")           -- { name = 'cmdline' }
        use("hrsh7th/cmp-nvim-lsp-signature-help") -- { name = 'nvim_lsp_signature_help' }
        use("hrsh7th/cmp-copilot")
        -- 常见编程语言代码段
        use("rafamadriz/friendly-snippets")
        use("b0o/schemastore.nvim")
        -- outline
        use({ "simrat39/symbols-outline.nvim" })
        -- telescope
        use({
            "nvim-telescope/telescope.nvim",
            requires = { "nvim-lua/plenary.nvim", "kdheepak/lazygit.nvim" },
        })

        -- telescope extensions
        use("LinArcX/telescope-env.nvim")
        use("nvim-telescope/telescope-dap.nvim")
        use("nvim-telescope/telescope-ui-select.nvim")
        use("nvim-telescope/telescope-packer.nvim")
        use("onsails/lspkind-nvim")
        use("tami5/lspsaga.nvim")
        -- 代码格式化
        -- use("mhartington/formatter.nvim")
        use({ "jose-elias-alvarez/null-ls.nvim", requires = "nvim-lua/plenary.nvim" })

        -- git
        use("lewis6991/gitsigns.nvim")
        use("kdheepak/lazygit.nvim")
        -- debug
        use("mfussenegger/nvim-dap")
        use("theHamsta/nvim-dap-virtual-text")
        use("rcarriga/nvim-dap-ui")

        -- treesitter
        use({
            "nvim-treesitter/nvim-treesitter",
            run = ":TSUpdate",
        })

        -- vscode-go 当插件安装
        use({ "golang/vscode-go", branch = "release", run = "npm install && npm run compile" })
        if packer_bootstrap then
            packer.sync()
        end
    end,
    config = {
        ensure_dependencies = true,
        plugin_package = "packer",
        max_jobs = 10,
        auto_clean = true,
        compile_on_sync = true,
        disable_commands = false,
        opt_default = false,
        transitive_opt = true,
        transitive_disable = true,
        auto_reload_compiled = true,
        git = {
            cmd = "git",
            subcommands = {
                update = "pull --ff-only --progress --rebase=false",
                install = "clone --depth %i --no-single-branch --progress",
                fetch = "fetch --depth 999999 --progress",
                checkout = "checkout %s --",
                update_branch = "merge --ff-only @{u}",
                current_branch = "branch --show-current",
                diff = "log --color=never --pretty=format:FMT --no-show-signature HEAD@{1}...HEAD",
                diff_fmt = "%%h %%s (%%cr)",
                get_rev = "rev-parse --short HEAD",
                get_msg = "log --color=never --pretty=format:FMT --no-show-signature HEAD -n 1",
                submodules = "submodule update --init --recursive --progress",
            },
            depth = 1,
            clone_timeout = 3600,
            default_url_format = "https://github.com/%s",
        },
        display = {
            non_interactive = false,
            open_fn = nil,
            open_cmd = "65vnew \\[packer\\]",
            working_sym = "⟳",
            error_sym = "✗",
            done_sym = "✓",
            removed_sym = "-",
            moved_sym = "→",
            header_sym = "━",
            show_all_info = true,
            prompt_border = "double",
            keybindings = {
                quit = "q",
                toggle_info = "<CR>",
                diff = "d",
                prompt_revert = "r",
            },
        },
        luarocks = { python_cmd = "python" },
        log = { level = "warn" },
        profile = { enable = false, threshold = 1 },
    },
})
