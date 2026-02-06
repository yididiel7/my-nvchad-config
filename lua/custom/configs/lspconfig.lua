local base = require("plugins.configs.lspconfig")
local on_attach = base.on_attach
local capabilities = base.capabilities

-- Use vim.lsp.config instead of deprecated require('lspconfig')
vim.lsp.config.gopls = {
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = {"gopls"},
    filetypes = { "go", "gomod", "gowork", "gotmpl" },
    root_dir = function(bufnr, on_dir)
        on_dir(vim.fs.root(bufnr, {"go.work", "go.mod", ".git"}))
    end,
    settings = {
        gopls = {
            completeUnimported = true,
            usePlaceholders = true,
            analyses = {
                unusedparams = true,
            },
        },
    },
}

vim.lsp.config.rust_analyzer = {
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { "rust" },
    root_dir = function(bufnr, on_dir)
        on_dir(vim.fs.root(bufnr, {"Cargo.toml"}))
    end,
}

vim.lsp.config.marksman = {
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { "markdown", "md" },
}

vim.lsp.config.pyright = {
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { "python" },
    root_dir = function(bufnr, on_dir)
        on_dir(vim.fs.root(bufnr, {"pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", ".git"}))
    end,
    settings = {
        python = {
            analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = "workspace",
                typeCheckingMode = "basic",
            },
        },
    },
}

vim.lsp.config.clangd = {
    on_attach = function(client, bufnr)
        client.server_capabilities.signatureHelpProvider = false
        on_attach(client, bufnr)
    end,
    capabilities = capabilities,
}
