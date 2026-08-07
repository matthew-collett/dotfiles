vim.pack.add({
    "https://github.com/mfussenegger/nvim-lint",
})

local lint = require("lint")

lint.linters_by_ft = {
    go = { "golangcilint" },
    javascript = { "eslint_d" },
    typescript = { "eslint_d" },
    javascriptreact = { "eslint_d" },
    typescriptreact = { "eslint_d" },
    python = { "pylint" },
    yaml = { "yamllint" },
}

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
    callback = function()
        -- golangci-lint resolves the module from its working directory, not from the target path
        if vim.bo.filetype == "go" then
            lint.linters.golangcilint.cwd = vim.fs.root(0, { "go.work", "go.mod" })
        end
        lint.try_lint()
    end,
})

vim.keymap.set("n", "<leader>l", function()
    lint.try_lint()
end, { desc = "Trigger linting for current file" })
