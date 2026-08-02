vim.pack.add({
    "https://github.com/nvim-mini/mini.nvim",
    "https://github.com/rafamadriz/friendly-snippets",
})

-- notifications
local MiniNotify = require("mini.notify")
MiniNotify.setup({
    content = {
        format = function(notif)
            return notif.msg
        end,
    },
})

--  surroundings
local MiniSurround = require("mini.surround")
MiniSurround.setup()

-- autopairs
local MiniPairs = require("mini.pairs")
MiniPairs.setup()

-- trailing whitespace
local MiniTrailspace = require("mini.trailspace")
MiniTrailspace.setup({
    only_in_normal_buffers = true,
})
vim.keymap.set("n", "<leader>cw", function() MiniTrailspace.trim() end, { desc = "Erase whitespace" })

vim.api.nvim_create_autocmd("CursorMoved", {
    callback = function() MiniTrailspace.unhighlight() end,
})

-- split/join arguments
local MiniSplitjoin = require("mini.splitjoin")
MiniSplitjoin.setup({
    mappings = { toggle = "" },
})
vim.keymap.set({ "n", "x" }, "sj", function() MiniSplitjoin.join() end, { desc = "Join arguments" })
vim.keymap.set({ "n", "x" }, "sk", function() MiniSplitjoin.split() end, { desc = "Split arguments" })

-- diff (hunks)
local MiniDiff = require("mini.diff")
MiniDiff.setup({
    source = MiniDiff.gen_source.git(),
})
vim.api.nvim_set_hl(0, "MiniDiffSignAdd", { link = "GitSignsAdd" })
vim.api.nvim_set_hl(0, "MiniDiffSignChange", { link = "GitSignsChange" })
vim.api.nvim_set_hl(0, "MiniDiffSignDelete", { link = "GitSignsDelete" })

-- icons
local MiniIcons = require("mini.icons")
MiniIcons.setup()
MiniIcons.mock_nvim_web_devicons()

-- snippets
local MiniSnippets = require("mini.snippets")
MiniSnippets.setup({
    snippets = {
        MiniSnippets.gen_loader.from_lang(),
    },
})
MiniSnippets.start_lsp_server({ match = false })
