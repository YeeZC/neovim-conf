return {
    on_setup = function(server)
        server.setup({
            cmd = { "gopls", "serve" },
            filetypes = { "go", "gomod" },
            -- root_dir = root_pattern("go.work", "go.mod", ".git"),
            settings = {
                gopls = {
                    analyses = {
                        unusedparams = true,
                    },
                    staticcheck = true,
                },
            },
        })
    end,
}
