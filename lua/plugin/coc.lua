vim.cmd([[
    " coc
    let g:coc_global_extensions = ['coc-git', 'coc-go', 'coc-json', 'coc-yaml', 'coc-python']
    " use <tab> to trigger completion and navigate to the next complete item
    function! CheckBackspace() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
    endfunction
    inoremap <silent><expr> <Tab> coc#pum#visible() ? coc#pum#next(1) : CheckBackspace() ? "\<Tab>" : coc#refresh()
    inoremap <expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"

    inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

    function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
    endfunction

    " notify
    function! s:DiagnosticNotify() abort
    let l:info = get(b:, 'coc_diagnostic_info', {})
    if empty(l:info) | return '' | endif
    let l:msgs = []
    let l:level = 'info'
    if get(l:info, 'warning', 0)
        let l:level = 'warn'
    endif
    if get(l:info, 'error', 0)
        let l:level = 'error'
    endif

    if get(l:info, 'error', 0)
        call add(l:msgs, ' ✖ Errors: ' . l:info['error'])
    endif
    if get(l:info, 'warning', 0)
        call add(l:msgs, ' ! Warnings: ' . l:info['warning'])
    endif
    if get(l:info, 'information', 0)
        call add(l:msgs, ' ⓘ Infos: ' . l:info['information'])
    endif
    if get(l:info, 'hint', 0)
        call add(l:msgs, 'ⓘ Hints: ' . l:info['hint'])
    endif
    "  let l:msg = join(l:msgs, "\n")
    "  if empty(l:msg) | let l:msg = ' ✔︎ All OK' | endif
    "  call v:lua.coc_diag_notify(l:msg, l:level)
    "
    endfunction

    function! s:StatusNotify() abort
    let l:status = get(g:, 'coc_status', '')
    let l:level = 'info'
    if empty(l:status) | return '' | endif
    call v:lua.coc_status_notify(l:status, l:level)
    endfunction

    function! s:InitCoc() abort
    runtime! autoload/coc/ui.vim
    execute "lua vim.notify('Initialized coc.nvim for LSP support', 'info', { title = 'LSP Status', icon = 'ⓘ' })"
    endfunction


    highlight NotifyERRORBorder guifg=#8A1F1F
    highlight NotifyWARNBorder guifg=#79491D
    highlight NotifyINFOBorder guifg=#4F6752
    highlight NotifyDEBUGBorder guifg=#8B8B8B
    highlight NotifyTRACEBorder guifg=#4F3552
    highlight NotifyERRORIcon guifg=#F70067
    highlight NotifyWARNIcon guifg=#F79000
    highlight NotifyINFOIcon guifg=#A9FF68
    highlight NotifyDEBUGIcon guifg=#8B8B8B
    highlight NotifyTRACEIcon guifg=#D484FF
    highlight NotifyERRORTitle  guifg=#F70067
    highlight NotifyWARNTitle guifg=#F79000
    highlight NotifyINFOTitle guifg=#A9FF68
    highlight NotifyDEBUGTitle  guifg=#8B8B8B
    highlight NotifyTRACETitle  guifg=#D484FF
    highlight link NotifyERRORBody Normal
    highlight link NotifyWARNBody Normal
    highlight link NotifyINFOBody Normal
    highlight link NotifyDEBUGBody Normal
    highlight link NotifyTRACEBody Normal

    autocmd User CocNvimInit call s:InitCoc()
    autocmd User CocDiagnosticChange call s:DiagnosticNotify()
    autocmd User CocStatusChange call s:StatusNotify()

]])
