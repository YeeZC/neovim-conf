local opts = { noremap = true, silent = true }

-- nvim tree
vim.api.nvim_set_keymap('n', '<leader>v', ':NvimTreeFindFile<cr>', opts)
vim.api.nvim_set_keymap('n', '<leader>g', ':NvimTreeToggle<cr>', opts)

-- fzf
vim.api.nvim_set_keymap('n', '<leader>f', ':Files<cr>', opts)
vim.api.nvim_set_keymap('n', '<leader>b', ':Buffers<cr>', opts)
vim.api.nvim_set_keymap('n', '<leader>q', ':Ag <C-R><C-W><cr>', opts)
vim.api.nvim_set_keymap('n', '<leader>t', ':TagbarToggle<cr>', opts)
vim.api.nvim_set_keymap('n', 'ss', '<Plug>(easymotion-s2)', {noremap=false, silent=true})

-- Buffers
vim.api.nvim_set_keymap('n', '<C-n>', ':bn<cr>', opts)
vim.api.nvim_set_keymap('n', '<C-m>', ':bp<cr>', opts)
vim.api.nvim_set_keymap('n', '<C-d>', ':bd<cr>', opts)
vim.api.nvim_set_keymap('n', '<leader>a', ':cclose<cr>', opts)

-- incsearch
vim.api.nvim_set_keymap('n', '/', '<Plug>(incsearch-forward)', opts)
vim.api.nvim_set_keymap('n', '?', '<Plug>(incsearch-backward)', opts)
vim.api.nvim_set_keymap('n', 'g/', '<Plug>(incsearch-stay)', opts)

-- Floarerm
vim.api.nvim_set_keymap('n', '<C-p>', ':FloatermToggle<cr>', opts)
vim.api.nvim_set_keymap('n', '<leader>sc', ':FloatermNew<cr>', opts)
vim.api.nvim_set_keymap('n', '<leader>sd', ':FloatermKill<cr>', opts)
vim.api.nvim_set_keymap('n', '<leader>sn', ':FloatermNext<cr>', opts)
vim.api.nvim_set_keymap('n', '<leader>sp', ':FloatermPrev<cr>', opts)

-- direction
vim.api.nvim_set_keymap('i', '<C-h>', '<left>', opts)
vim.api.nvim_set_keymap('i', '<C-j>', '<down>', opts)
vim.api.nvim_set_keymap('i', '<C-k>', '<up>', opts)
vim.api.nvim_set_keymap('i', '<C-l>', '<right>', opts)

-- vim-go
vim.api.nvim_set_keymap('i', '<C-g>', '<esc>:<C-u>:GoDeclsDir<cr>', opts)
vim.api.nvim_set_keymap('n', '<C-g>', ':GoDeclsDir<cr>', opts)

-- coc
vim.api.nvim_set_keymap('n', '[g', '<Plug>(coc-diagnostic-prev)', opts)
vim.api.nvim_set_keymap('n', 'g]', '<Plug>(coc-diagnostic-next)', opts)
vim.api.nvim_set_keymap('n', 'gd', '<Plug>(coc-definition)', opts)
vim.api.nvim_set_keymap('n', 'gy', '<Plug>(coc-type-definition)', opts)
vim.api.nvim_set_keymap('n', 'gm', '<Plug>(coc-implementation)', opts)
vim.api.nvim_set_keymap('n', 'gr', '<Plug>(coc-references)', opts)

-- ale
vim.api.nvim_set_keymap('n', 'sp', '<Plug>(ale_previous_wrap)', opts)
vim.api.nvim_set_keymap('n', 'sn', '<Plug>(ale_next_wrap)', opts)
vim.api.nvim_set_keymap('n', '<leader>d', ':ALEDetail<cr>', opts)
vim.api.nvim_set_keymap('n', '<leader>l', ':ALEToggle<cr>', opts)

-- tabs
vim.api.nvim_set_keymap('n', '[t', ':tabprevious<cr>', opts)
vim.api.nvim_set_keymap('n', ']t', ':tabnext<cr>', opts)

vim.cmd([[
    let g:fzf_action = { 'ctrl-e': 'edit' }
]])
