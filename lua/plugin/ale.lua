vim.g.ale_set_highlights=1
vim.g.ale_set_quickfix=1
vim.g.ale_sign_error='✗'
vim.g.ale_sign_warning='⚡'
vim.g.ale_echo_msg_error_str='E'
vim.g.ale_echo_msg_warning_str='W'
vim.g.ale_echo_msg_format='[%linter%] %s [%severity%]'
vim.g.ale_lint_on_enter=1

vim.cmd([[
    let g:ale_statusline_format = ['✗ %d', '⚡ %d', '✔ OK']
    let g:ale_linters = {
        \ 'go': ['golint', 'go vet', 'go fmt'],
        \ 'python': ['flake8', 'pylint'],
        \ 'rust': ['cargo'],
        \ }
]])
