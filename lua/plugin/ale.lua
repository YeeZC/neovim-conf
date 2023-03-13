vim.cmd([[
    " ale-setting {{{
    let g:ale_set_highlights = 1
    let g:ale_set_quickfix = 1
    "自定义error和warning图标
    let g:ale_sign_error = '✗'
    let g:ale_sign_warning = '⚡'
    "在vim自带的状态栏中整合ale
    let g:ale_statusline_format = ['✗ %d', '⚡ %d', '✔ OK']
    "显示Linter名称,出错或警告等相关信息
    let g:ale_echo_msg_error_str = 'E'
    let g:ale_echo_msg_warning_str = 'W'
    let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
    "打开文件时不进行检查
    let g:ale_lint_on_enter = 1
    
    let g:ale_linters = {
        \ 'go': ['golint', 'go vet', 'go fmt'],
        \ 'python': ['flake8', 'pylint'],
        \ 'rust': ['cargo'],
        \ }
]])
