vim.api.nvim_create_autocmd("BufWritePre", {
    buffer = 0,
    callback = function()
        local clients = vim.lsp.get_clients({ bufnr = 0, name = "gopls" })
        if #clients == 0 then
            return
        end

        local encoding = clients[1].offset_encoding
        local params = vim.lsp.util.make_range_params(0, encoding)
        params.context = { only = { "source.organizeImports" } }

        local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
        for _, response in pairs(result or {}) do
            for _, action in pairs(response.result or {}) do
                if action.edit then
                    vim.lsp.util.apply_workspace_edit(action.edit, encoding)
                end
            end
        end

        vim.lsp.buf.format({ async = false })
    end,
})
