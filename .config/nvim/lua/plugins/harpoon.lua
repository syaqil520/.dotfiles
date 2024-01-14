return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
        {
            "<Leader>ha",
            function()
                require("harpoon"):list():append()
            end,
            desc = "Append file to harpoon",
        },
        {
            "<C-e>",
            function()
                local harpoon = require("harpoon")
                harpoon.ui:toggle_quick_menu(harpoon:list())
            end,
            desc = "toggle harpoon ui",
        },
        {
            "<Leader>hp",
            function()
                require("harpoon"):list():prev()
            end,
            desc = "previous harpoon",
        },
        {
            "<Leader>hn",
            function()
                require("harpoon"):list():next()
            end,
            desc = "next harpoon",
        },
    },
}
