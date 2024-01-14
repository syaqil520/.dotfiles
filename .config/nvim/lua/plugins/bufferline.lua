return {
    "akinsho/bufferline.nvim",
    -- event = "VeryLazy",
    -- keys = {
    --     { "<Tab>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next tab" },
    --     { "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev tab" },
    -- },
    lazy = false,
    opts = {
        options = {
            underline_indicator = true,
            separator_style = "thick",
            show_buffer_close_icons = true,
            show_close_icon = false,
            diagnostic = "nvim_lsp",
            always_show_bufferline = true,
            middle_mouse_command = "bdelete! %d",
            indicator = {
                style = "underline",
            },
        },
    },
}
