local lspconfig = require("lspconfig")

require("nvim-lsp-installer").setup({
    -- 自动安装 Language Servers
    automatic_installation = true,
  })

local servers = {
    pyright = require("lsp.config.pyright"),
    jsonls = require("lsp.config.json"),
    tsserver = require("lsp.config.ts"),
    bashls = require("lsp.config.bash"),
    html = require("lsp.config.html"),
    cssls = require("lsp.config.css"),
    emmet_ls = require("lsp.config.emmet"),
    yamlls = require("lsp.config.yamlls"),
    gopls = require("lsp.config.go"),
    sqlls = require("lsp.config.sqlls"),
}

for name, config in pairs(servers) do
    if config ~= nil and type(config) == "table" then
      -- 自定义初始化配置文件必须实现on_setup 方法
      config.on_setup(lspconfig[name])
    else
      -- 使用默认参数
      lspconfig[name].setup({})
    end
  end

  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
      -- Enable completion triggered by <c-x><c-o>
      vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
  
      -- Buffer local mappings.
      -- See `:help vim.lsp.*` for documentation on any of the below functions
      local opts = { buffer = ev.buf }
      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
      vim.keymap.set('n', 'gm', vim.lsp.buf.implementation, opts)
      vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
      vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
      vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
      vim.keymap.set('n', '<space>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, opts)
      vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
      vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
      vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
      vim.keymap.set('n', '<space>f', function()
        vim.lsp.buf.format { async = true }
      end, opts)
    end,
  })