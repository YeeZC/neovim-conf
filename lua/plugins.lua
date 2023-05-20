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
		use("wbthomason/packer.nvim")
		-- use 'tpope/vim-fugitive'
		use("rcarriga/nvim-notify")
		use("luochen1990/rainbow")
		use("vim-airline/vim-airline")
		use("vim-airline/vim-airline-themes")
		-- use {'fatih/vim-go',  run= ':GoUpdateBinaries' }
		-- use 'majutsushi/tagbar'
		-- use 'nvim-tree/nvim-web-devicons'
		use({ "nvim-tree/nvim-tree.lua", requires = {
			"nvim-tree/nvim-web-devicons",
		} })
		use("scrooloose/nerdcommenter")
		use("tpope/vim-commentary")
		use("spf13/vim-autoclose")
		use("tpope/vim-endwise")
		use("haya14busa/incsearch.vim")
		use("junegunn/vim-slash")
		use("Shougo/echodoc.vim")
		-- use 'dense-analysis/ale'
		use("junegunn/vim-easy-align")
		use("easymotion/vim-easymotion")
		use("flazz/vim-colorschemes")
		use({ "junegunn/fzf", dir = "~/.fzf", run = "./install --all" })
		use("junegunn/fzf.vim")
		-- use 'fatih/molokai'
		use("voldikss/vim-floaterm")
		-- use {'neoclide/coc.nvim', branch = 'release'}
		use("mileszs/ack.vim")
		-- use 'nathanaelkane/vim-indent-guides'
		-- use 'APZelos/blamer.nvim'
		use("MattesGroeger/vim-bookmarks")
		-- use 'scrooloose/vim-slumlord'
		use("pseewald/vim-anyfold")
		use("mhinz/vim-startify")
		use("tpope/vim-surround")
		use("machakann/vim-sandwich")
		use("github/copilot.vim")
		use("sainnhe/sonokai")
		use({
			"neovim/nvim-lspconfig",
			"williamboman/nvim-lsp-installer",
		})
		-- TypeScript 增强
		use({ "jose-elias-alvarez/nvim-lsp-ts-utils", requires = "nvim-lua/plenary.nvim" })
		-- JSON 增强
		-- 补全引擎
		use("hrsh7th/nvim-cmp")
		-- Snippet 引擎
		use("hrsh7th/vim-vsnip")
		-- 补全源
		use("hrsh7th/cmp-vsnip")
		use("hrsh7th/cmp-nvim-lsp") -- { name = nvim_lsp }
		use("hrsh7th/cmp-buffer") -- { name = 'buffer' },
		use("hrsh7th/cmp-path") -- { name = 'path' }
		use("hrsh7th/cmp-cmdline") -- { name = 'cmdline' }
		use("hrsh7th/cmp-nvim-lsp-signature-help") -- { name = 'nvim_lsp_signature_help' }
		use("hrsh7th/cmp-copilot")
		-- 常见编程语言代码段
		use("rafamadriz/friendly-snippets")
		use("b0o/schemastore.nvim")
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
		use("onsails/lspkind-nvim")
		use("tami5/lspsaga.nvim")
		-- 代码格式化
		-- use("mhartington/formatter.nvim")
		use({ "jose-elias-alvarez/null-ls.nvim", requires = "nvim-lua/plenary.nvim" })
		-- use({
		-- 	"mrded/nvim-lsp-notify",
		-- 	requires = { "rcarriga/nvim-notify" },
		-- 	config = function()
		-- 		require("lsp-notify").setup({
		-- 			notify = require("notify"),
		-- 		})
		-- 	end,
		-- })
		use("lewis6991/gitsigns.nvim")
		-- vimspector
		-- use "puremourning/vimspector"
		----------------------------------------------
		use("mfussenegger/nvim-dap")
		use("theHamsta/nvim-dap-virtual-text")
		use("rcarriga/nvim-dap-ui")
		-- use {'leoluz/nvim-dap-go'}
		-- treesitter
		use({
			"nvim-treesitter/nvim-treesitter",
			run = ":TSUpdate",
		})
		use("kdheepak/lazygit.nvim")
		if paccker_bootstrap then
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
