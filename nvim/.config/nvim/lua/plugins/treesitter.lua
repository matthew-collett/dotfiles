vim.pack.add({
    { src = "https://github.com/nvim-treesitter/nvim-treesitter", branch = "main" },
})

local treesitter = require("nvim-treesitter")

local ensure_installed = {
    "go", "gomod", "gosum",
    "javascript", "typescript", "tsx",
    "graphql", "python", "sql",
    "css", "html", "json",
    "dockerfile", "http", "toml", "yaml",
    "bash", "regex", "vimdoc",
    "gitcommit", "gitignore",
}

treesitter.install(ensure_installed)

vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    callback = function(args)
        local buf = args.buf
        local ft = vim.bo[buf].filetype
        local lang = vim.treesitter.language.get_lang(ft)
        if not lang then
            return
        end
        local ok_add = pcall(vim.treesitter.language.add, lang)
        if not ok_add then
            return
        end
        pcall(vim.treesitter.start, buf, lang)
    end,
})
