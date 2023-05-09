require('basic')
require('plugins')
-- require('keymaps')
require('theme')
require('plugin/vim-go')
require('plugin/ale')
require('plugin/coc')
require('plugin/notify')
require('plugin/airline')
require('plugin/nvim-tree')
require('keymaps')
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])
