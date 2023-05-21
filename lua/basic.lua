function pythonPath()
    if vim.fn.executable("/usr/local/bin/python3") == 1 then
        return "/usr/local/bin/python3"
    elseif vim.fn.executable("/usr/bin/python3") == 1 then
        return "/usr/bin/python3"
    else
        local cwd = vim.fn.getcwd()
        if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
            return cwd .. "/venv/bin/python"
        elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
            return cwd .. "/.venv/bin/python"
        else
            return "/usr/bin/python3"
        end
    end
end
vim.cmd([[
    set t_Co=256
    set backspace=2
    filetype on
    filetype plugin on
    filetype indent on
    let g:python3_host_prog = "]] .. pythonPath() .. [["
]])
vim.opt.compatible = false
vim.opt.eb = false
vim.opt.cmdheight = 2
vim.opt.showcmd = true
vim.opt.ruler = true
vim.opt.laststatus = 2
vim.opt.number = true
vim.opt.cursorline = true
vim.opt.whichwrap = "b,s,<,>,h,l"
vim.opt.ttimeoutlen = 0
vim.opt.virtualedit = "block,onemore"
vim.opt.autoindent = true
vim.opt.cindent = true
vim.opt.cinoptions = "g0,:0,N-s,(0"
vim.opt.smartindent = true
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.smarttab = true
vim.opt.wrap = true
vim.opt.sidescroll = 10
vim.opt.foldenable = false
vim.opt.wildmenu = true
vim.opt.completeopt = "menu"
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.autoread = true
vim.opt.autowrite = true
vim.opt.confirm = true
vim.opt.encoding = "utf-8"
vim.opt.scrolljump = 5
vim.opt.scrolloff = 3
vim.opt.modifiable = true
vim.opt.termguicolors = true
