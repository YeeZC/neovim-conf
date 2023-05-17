require("keybindings").mapVimspector()

vim.cmd([[ "let g:vimspector_install_gadgets = [ 'debugpy', 'vscode-cpptools', 'CodeLLDB' ]" ]])