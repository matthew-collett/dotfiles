vim.pack.add({
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/mason-org/mason.nvim",
})

local mason = require("mason")
mason.setup()

vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = "Go to definition" })

vim.diagnostic.config({ virtual_text = true })

local capabilities = vim.lsp.protocol.make_client_capabilities()
local blink = require("blink.cmp")
capabilities = vim.tbl_deep_extend("force", capabilities, blink.get_lsp_capabilities())

vim.lsp.config("*", { capabilities = capabilities })

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
