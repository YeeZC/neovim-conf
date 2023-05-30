# neovim-conf
## 使用配置
***配置使用 link 的方式，将文件链接创建到 ${HOME}/.config/nvim 目录下***
```shell
https://github.com/YeeZC/neovim-conf.git
cd neovim-conf && sh install.sh
```

## 插件说明
### 插件管理器 [lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
-- lua/plugins.lua
local fn = vim.fn
-- Linux / Mac 安装地址为 ${HOME}/.local/share/nvim/lazy/lazy.nvim
-- 插件列表中的插件也将安装到 ${HOME}/.local/share/nvim/lazy 中
local install_path = fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(install_path) then
	fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		install_path,
	})
end

vim.opt.rtp:prepend(install_path)
require("lazy").setup({
	-- 插件列表
}, {
	defaults = { lazy = true },
	install = { colorscheme = { "sonokai" } },
	checker = { enabled = true },
	performance = {
		rtp = {
			disabled_plugins = {
				"gzip",
				"matchit",
				"matchparen",
				"netrwPlugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
	-- debug = true,
})

```
### 美化插件
|  插件   | 用途  |
|  ----  | ----  |
| [rcarriga/nvim-notify](https://github.com/rcarriga/nvim-notify) | 通知 |
| [luochen1990/rainbow](https://github.com/luochen1990/rainbow) | 括号美化 |
| [vim-airline/vim-airline](https://github.com/vim-airline/vim-airline) | 状态栏 |
| [vim-airline/vim-airline-themes](https://github.com/vim-airline/vim-airline-themes) | 状态栏主题 |
| [nvim-tree/nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua) | 文件树 |
| [nvim-tree/nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons) | 图标 |
| [flazz/vim-colorschemes](https://github.com/flazz/vim-colorschemes) | 主题颜色 |
| [mhinz/vim-startify](https://github.com/mhinz/vim-startify) | 启动器 |
| [sainnhe/sonokai](https://github.com/sainnhe/sonokai) | 主题 |
| [onsails/lspkind.nvim](https://github.com/onsails/lspkind.nvim) | ui |

### 工具
|  插件   | 用途  |
|  ----  | ----  |
| [tpope/vim-commentary](https://github.com/tpope/vim-commentary) | 注释插件 |
| [spf13/vim-autoclose](https://github.com/spf13/vim-autoclose) | 自动闭合括号 |
| [tpope/vim-endwise](https://github.com/tpope/vim-endwise) | if-else 自动闭合 |
| [haya14busa/incsearch-fuzzy.vim](https://github.com/haya14busa/incsearch-fuzzy.vim) | 模糊搜索 |
| [haya14busa/incsearch.vim](https://github.com/haya14busa/incsearch.vim) | 搜索 |
| [junegunn/vim-slash](https://github.com/junegunn/vim-slash) | 搜索增强 |
| [junegunn/fzf](https://github.com/junegunn/fzf) | 模糊查找 |
| [junegunn/fzf.vim](https://github.com/junegunn/fzf.vim) | 模糊查找 |
| [tpope/vim-surround](https://github.com/tpope/vim-surround) | 包裹（括号，引号） |
| [github/copilot.vim](https://github.com/github/copilot.vim) | copilot插件 |
| [jose-elias-alvarez/null-ls.nvim](https://github.com/jose-elias-alvarez/null-ls.nvim) | 代码格式化 |
| [lewis6991/gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | git插件 |
| [kdheepak/lazygit.nvim](https://github.com/kdheepak/lazygit.nvim) | lazygit插件 |

### lsp
|  插件   | 用途  |
|  ----  | ----  |
| [neovim/nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | nvim lsp 插件 |
| [williamboman/nvim-lsp-installer](https://github.com/williamboman/nvim-lsp-installer) | 自动安装lsp-server |
| [nvimdev/lspsaga.nvim](https://github.com/nvimdev/lspsaga.nvim) | lsp跳转查找 |
| [folke/neodev.nvim](https://github.com/folke/neodev.nvim) | lua增强 |
| [jose-elias-alvarez/nvim-lsp-ts-utils](https://github.com/jose-elias-alvarez/nvim-lsp-ts-utils) | ts增强 |

### 自动补全
|  插件   | 用途  |
|  ----  | ----  |
| [hrsh7th/nvim-cmp](https://github.com/hrsh7th/nvim-cmp) | 自动补全 |
| [hrsh7th/vim-vsnip](https://github.com/hrsh7th/vim-vsnip) | Snippet 引擎 |
| [hrsh7th/cmp-vsnip](https://github.com/hrsh7th/cmp-vsnip) | 补全源 |
| [hrsh7th/cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp) | 补全源 |
| [hrsh7th/cmp-buffer](https://github.com/hrsh7th/cmp-buffer) | 补全源 |
| [hrsh7th/cmp-path](https://github.com/hrsh7th/cmp-path) | 补全源 |
| [hrsh7th/cmp-nvim-lsp-signature-help](https://github.com/hrsh7th/cmp-nvim-lsp-signature-help) | 补全源 |
| [hrsh7th/cmp-copilot](https://github.com/hrsh7th/cmp-copilot) | copilot补全源 |
| [hrsh7th/cmp-emoji](https://github.com/hrsh7th/cmp-emoji) | 补全源 |
| [rafamadriz/friendly-snippets](https://github.com/rafamadriz/friendly-snippets) | 常见编程语言代码段 |
| [b0o/schemastore.nvim](https://github.com/b0o/schemastore.nvim) | JSON/YAML等 shcema 源 |
| [hrsh7th/cmp-cmdline](https://github.com/hrsh7th/cmp-cmdline) | 补全源 |


### telescope
|  插件   | 用途  |
|  ----  | ----  |
| [nvim-telescope/telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) | 高度可扩展的列表模糊查找器 |
| [LinArcX/telescope-env.nvim](https://github.com/LinArcX/telescope-env.nvim) | telescope env 扩展 |
| [nvim-telescope/telescope-dap.nvim](https://github.com/nvim-telescope/telescope-dap.nvim) | telescope dap 扩展 |
| [nvim-telescope/telescope-ui-select.nvim](https://github.com/nvim-telescope/telescope-ui-select.nvim) | telescope ui 扩展 |

### 代码高亮
|  插件   | 用途  |
|  ----  | ----  |
| [nvim-treesitter/nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | 高亮 |

### Debug 插件
|  插件   | 用途  |
|  ----  | ----  |
| [mfussenegger/nvim-dap](https://github.com/mfussenegger/nvim-dap) | debug 插件 |
| [theHamsta/nvim-dap-virtual-text](https://github.com/theHamsta/nvim-dap-virtual-text) | debug 插件 |
| [rcarriga/nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui) | debug ui 界面 |
| [golang/vscode-go](https://github.com/golang/vscode-go) | go 语言 debug |
