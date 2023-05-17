require('basic')
require('plugins')
-- require('keymaps')
require('theme')
require('plugin/vim-go')
require('plugin/ale')
-- require('plugin/coc')
-- require('plugin/notify')
require('plugin/airline')
require('plugin/nvim-tree')
require('plugin/telescope')
-- require('keymaps')
require('lsp/setup')
require('lsp/ui')
require('plugin/cmp')
require('plugin/outline')
require('plugin/gitsigns')
require('autocmd')
require("dap/nvim-dap")
require("plugin.nvim-treesitter")
-- require("dap.vimspector")
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])
