local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup({
    function()
        use 'wbthomason/packer.nvim'
	use 'rcarriga/nvim-notify'
        use 'luochen1990/rainbow'
        use 'vim-airline/vim-airline'
        use 'vim-airline/vim-airline-themes'
        use {'fatih/vim-go',  run= ':GoUpdateBinaries' }
        use 'majutsushi/tagbar'
        use 'nvim-tree/nvim-web-devicons'
        use {'nvim-tree/nvim-tree.lua',requires = {
            'nvim-tree/nvim-web-devicons',
          }}
        use 'scrooloose/nerdcommenter'
        use 'tpope/vim-commentary'
        use 'spf13/vim-autoclose'
        use 'tpope/vim-endwise'
        use 'haya14busa/incsearch.vim'
        use 'junegunn/vim-slash'
        use 'Shougo/echodoc.vim'
        use 'dense-analysis/ale'
        use 'junegunn/vim-easy-align'
        use 'easymotion/vim-easymotion'
        use 'flazz/vim-colorschemes'
        use {'junegunn/fzf', dir='~/.fzf', run = './install --all' }
        use 'junegunn/fzf.vim'
        use 'fatih/molokai'
        use 'voldikss/vim-floaterm'
        use {'neoclide/coc.nvim', branch = 'release'}
        use 'mileszs/ack.vim'
        use 'nathanaelkane/vim-indent-guides'
        use 'APZelos/blamer.nvim'
        use 'MattesGroeger/vim-bookmarks'
        use 'scrooloose/vim-slumlord'
        use 'pseewald/vim-anyfold'
        use 'mhinz/vim-startify'
        use 'tpope/vim-surround'
        use 'machakann/vim-sandwich'
    end,
    config = {
        ensure_dependencies = true,
        plugin_package = 'packer',
        max_jobs = nil,
        auto_clean = true,
        compile_on_sync = true,
        disable_commands = false,
        opt_default = false,
        transitive_opt = true,
        transitive_disable = true,
        auto_reload_compiled = true,
        git = {
            cmd = 'git',
            subcommands = {
                update = 'pull --ff-only --progress --rebase=false',
                install = 'clone --depth %i --no-single-branch --progress',
                fetch = 'fetch --depth 999999 --progress',
                checkout = 'checkout %s --',
                update_branch = 'merge --ff-only @{u}',
                current_branch = 'branch --show-current',
                diff = 'log --color=never --pretty=format:FMT --no-show-signature HEAD@{1}...HEAD',
                diff_fmt = '%%h %%s (%%cr)',
                get_rev = 'rev-parse --short HEAD',
                get_msg = 'log --color=never --pretty=format:FMT --no-show-signature HEAD -n 1',
                submodules = 'submodule update --init --recursive --progress'
            },
            depth = 1,
            clone_timeout = 60,
            default_url_format = 'https://github.com/%s'
        },
        display = {
            non_interactive = false,
            open_fn = nil,
            open_cmd = '65vnew \\[packer\\]',
            working_sym = '⟳',
            error_sym = '✗',
            done_sym = '✓',
            removed_sym = '-',
            moved_sym = '→',
            header_sym = '━',
            show_all_info = true,
            prompt_border = 'double',
            keybindings = {
                quit = 'q',
                toggle_info = '<CR>',
                diff = 'd',
                prompt_revert = 'r'
            }
        },
        luarocks = {python_cmd = 'python'},
        log = {level = 'warn'},
        profile = {enable = false, threshold = 1}
    }
})

