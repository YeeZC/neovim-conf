return {
    setup = function()
        local map = vim.api.nvim_set_keymap
        local opts = {
            noremap = true,
            silent = true,
        }

        -- nvim tree
        map("n", "<leader>v", ":NvimTreeFindFile<cr>", opts)
        map("n", "<leader>g", ":NvimTreeToggle<cr>", opts)
        map("n", "<S-g>", ":LazyGit<cr>", opts)

        -- outline
        map("n", "<leader>t", ":Lspsaga outline<cr>", opts)

        -- Buffers
        map("n", "<C-n>", ":bn<cr>", opts)
        map("n", "<C-m>", ":bp<cr>", opts)
        map("n", "<C-d>", ":bd<cr>", opts)
        map("n", "<leader>a", ":cclose<cr>", opts)

        -- Floarerm
        map("n", "<C-p>", ":ToggleTerm<cr>", opts)

        -- tabs
        map("n", "[t", ":tabprevious<cr>", opts)
        map("n", "]t", ":tabnext<cr>", opts)

        map("i", "<C-j>", "<down>", opts)
        map("i", "<C-k>", "<up>", opts)
        map("i", "<C-h>", "<left>", opts)
        map("i", "<C-l>", "<right>", opts)

        map("n", "gc", ":ComComment<cr>", opts)
        map("x", "gc", ":ComComment<cr>", opts)
        map("n", "<leader>c", ":ComAnnotation<cr>", opts)

        vim.cmd("let g:fzf_action = { 'ctrl-e': 'edit' }")
    end,
}
