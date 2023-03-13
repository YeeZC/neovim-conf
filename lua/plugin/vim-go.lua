vim.cmd([[
    let g:go_fmt_command = 'goimports'
    let g:go_autodetect_gopath = 1    
    let g:go_highlight_types = 1
    let g:go_highlight_fields = 1
    let g:go_highlight_functions = 1
    let g:go_highlight_function_calls = 1
    let g:go_highlight_extra_types = 1
    let g:go_highlight_generate_tags = 1
    nmap <C-g> :GoDeclsDir<cr>
    imap <C-g> <esc>:<C-u>GoDeclsDir<cr>
    augroup go
      autocmd!
      autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4
    augroup END
    function! s:build_go_files()
      let l:file = expand('%')
      if l:file =~# '^\f\+_test\.go$'
        call go#test#Test(0, 1)
      elseif l:file =~# '^\f\+\.go$'
        call go#cmd#Build(0)
      endif
    endfunction
]])