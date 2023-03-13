vim.cmd([[
    map <leader>f :Files<CR>
    map <leader>b :Buffers<CR>
    let g:fzf_action = { 'ctrl-e': 'edit' }
    " 用 leader+ag 搜索当前 cursor 下单词 see: https://github.com/junegunn/fzf.vim/issues/50
    nnoremap <silent> <Leader>q :Ag <C-R><C-W><CR>
    lua require("plugin/nvim-tree")
    nnoremap <leader>v :NvimTreeFocus<cr>
    nnoremap <leader>g :NvimTreeToggle<cr>

    nnoremap <leader>t :TagbarToggle<cr>
    nmap ss <Plug>(easymotion-s2)

    "buffer
    map <C-n> :bn<CR>
    map <C-m> :bp<CR>
    map <c-d> :bd<cr>

    " Jump to next error with Ctrl-n and previous error with Ctrl-m. Close the
    " quickfix window with <leader>a
    nnoremap <leader>a :cclose<CR>
    " incsearch
    map / <Plug>(incsearch-forward)
    map ? <Plug>(incsearch-backward)
    map g/ <Plug>(incsearch-stay)

    " floaterm
    map <silent><C-p> :FloatermToggle<cr>
    map <leader>sc :FloatermNew<cr>
    map <leader>sd :FloatermKill<cr>
    map <leader>sn :FloatermNext<cr>
    map <leader>sp :FloatermPrev<cr>

    map! <c-h> <left>
    map! <c-j> <down>
    map! <c-k> <up>
    map! <c-l> <right>
]])