return {
    {
        "nvim-tree/nvim-tree.lua",
        cmd = { "NvimTreeToggle", "NvimTreeFocus" },
        lazy = false,
        opts = {
            filters = { dotfiles = false },
            disable_netrw = true,
            hijack_cursor = true,
            sync_root_with_cwd = true,
            update_focused_file = {
                enable = true,
                update_root = false,
            },
            view = {
                width = 50,
                preserve_window_proportions = true,
            },
            renderer = {
                root_folder_label = false,
                highlight_git = true,
                indent_markers = { enable = true },
                icons = {
                    glyphs = {
                        default = "󰈚",
                        folder = {
                            default = "",
                            empty = "",
                            empty_open = "",
                            open = "",
                            symlink = "",
                        },
                        git = { unmerged = "" },
                    },
                },
            },
            actions = {
                open_file = {
                    quit_on_open = true,
                    window_picker = { enable = false },
                },
            },
            trash = {
                -- WARNING: Mac = trash | Arch = trash-put (need to have trash-cli installed)
                cmd = "trash",
            },
        },
        config = function(_, opts)
            vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle nvim-tree" })
            require("nvim-tree").setup(opts)
        end,
    },
    {
        "otavioschwanck/arrow.nvim",
        dependencies = {
            { "nvim-tree/nvim-web-devicons" },
        },
        config = function()
            vim.keymap.set("n", "<tab>", require("arrow.persist").previous, { desc = "Move to next arrow persist" })
            vim.keymap.set("n", "<S-tab>", require("arrow.persist").next, { desc = "Move to previous arrow persist" })
            require("arrow").setup({

                show_icons = true,
                leader_key = "m", -- Recommended to be a single key
                buffer_leader_key = "M", -- Per Buffer Mappings
            })
        end,
    },
    {
        "stevearc/oil.nvim",
        ---@module 'oil'
        ---@type oil.SetupOpts
        dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
        config = function()
            vim.keymap.set("n", "<leader>E", "<CMD>Oil --float<CR>", { desc = "Open Oil editor" })
            require("oil").setup({
                default_file_explorer = false,
                delete_to_trash = true,
                skip_confirm_for_simple_edits = true,
                view_options = {
                    show_hidden = true,
                },
            })
        end,
    },
    {
        "rachartier/tiny-inline-diagnostic.nvim",
        event = "VeryLazy",
        priority = 1000,
        enabled = true,
        config = function()
            vim.diagnostic.config({ virtual_text = false })
            -- Default configuration
            require("tiny-inline-diagnostic").setup({
                preset = "modern",
                options = {
                    -- If multiple diagnostics are under the cursor, display all of them.
                    multiple_diag_under_cursor = true,
                    multilines = true,
                    show_source = {
                        enabled = false,
                        if_many = false,
                    },
                },
            })
        end,
    },
    {
        "nmac427/guess-indent.nvim",
        opts = {
            auto_cmd = true, -- Set to false to disable automatic execution
            override_editorconfig = false, -- Set to true to override settings set by .editorconfig
            filetype_exclude = { -- A list of filetypes for which the auto command gets disabled
                "netrw",
                "tutor",
            },
            buftype_exclude = { -- A list of buffer types for which the auto command gets disabled
                "help",
                "nofile",
                "terminal",
                "prompt",
            },
            on_tab_options = { -- A table of vim options when tabs are detected
                ["expandtab"] = false,
            },
            on_space_options = { -- A table of vim options when spaces are detected
                ["expandtab"] = true,
                ["tabstop"] = "detected", -- If the option value is 'detected', The value is set to the automatically detected indent size.
                ["softtabstop"] = "detected",
                ["shiftwidth"] = "detected",
            },
        },
    },
}
