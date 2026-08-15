vim.pack.add({
    "https://github.com/stevearc/conform.nvim",
})

local conform = require("conform")

conform.setup({
    formatters = {
        prettier = { require_cwd = true },
    },
    formatters_by_ft = {
        javascript = { "prettier", "eslint_d", stop_after_first = true },
        typescript = { "prettier", "eslint_d", stop_after_first = true },
        javascriptreact = { "prettier", "eslint_d", stop_after_first = true },
        typescriptreact = { "prettier", "eslint_d", stop_after_first = true },
        lua = { "stylua" },
    },
})

vim.keymap.set({ "n", "v" }, "<leader>f", function()
    conform.format({
        lsp_format = "fallback",
        async = false,
        timeout_ms = 3000,
    })
end, { desc = "Format whole file or range in visual mode" })
