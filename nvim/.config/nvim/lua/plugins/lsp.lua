vim.pack.add({
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/mason-org/mason.nvim",
    "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
})

local mason = require("mason")
mason.setup()

local tool_installer = require("mason-tool-installer")
tool_installer.setup({
    ensure_installed = {
        "lua-language-server",
        "gopls",
        "vtsls",
        "eslint-lsp",
        "taplo",
        "bash-language-server",
        "json-lsp",
        "yaml-language-server",
        "golangci-lint",
        "eslint_d",
        "pylint",
        "yamllint",
    },
    run_on_start = true,
    debounce_hours = 24,
})

vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = "Go to definition" })

vim.diagnostic.config({
    virtual_text = false,
    virtual_lines = { current_line = true },
    float = { border = "rounded", source = true },
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
local blink = require("blink.cmp")
capabilities = vim.tbl_deep_extend("force", capabilities, blink.get_lsp_capabilities())

vim.lsp.config("*", { capabilities = capabilities })

vim.lsp.config("gopls", {
    settings = {
        gopls = {
            staticcheck = false,
        },
    },
})

vim.lsp.enable({
    "lua_ls",
    "gopls",
    "vtsls",
    "eslint",
    "taplo",
    "bashls",
    "jsonls",
    "yamlls",
})
