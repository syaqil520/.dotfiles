local trigger_text = ";"

return {
    { -- Autocompletion
        "saghen/blink.cmp",
        event = "VimEnter",
        dependencies = {
            -- -- Snippet Engine
            -- {
            --     "L3MON4D3/LuaSnip",
            --     version = "2.*",
            --     build = (function()
            --         -- Build Step is needed for regex support in snippets.
            --         -- This step is not supported in many windows environments.
            --         -- Remove the below condition to re-enable on windows.
            --         if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
            --             return
            --         end
            --         return "make install_jsregexp"
            --     end)(),
            --     dependencies = {
            --         -- `friendly-snippets` contains a variety of premade snippets.
            --         --    See the README about individual language/framework/plugin snippets:
            --         --    https://github.com/rafamadriz/friendly-snippets
            --         -- {
            --         --   'rafamadriz/friendly-snippets',
            --         --   config = function()
            --         --     require('luasnip.loaders.from_vscode').lazy_load()
            --         --   end,
            --         -- },
            --     },
            --     opts = {},
            -- },
            "folke/lazydev.nvim",
        },
        --- @module 'blink.cmp'
        --- @type blink.cmp.Config
        opts = function(_, opts)
            opts.keymap = {
                -- All presets have the following mappings:
                -- <tab>/<s-tab>: move to right/left of your snippet expansion
                -- <c-space>: Open menu or open docs if already open
                -- <c-n>/<c-p> or <up>/<down>: Select next/previous item
                -- <c-e>: Hide menu
                -- <c-k>: Toggle signature help
                --
                -- See :h blink-cmp-config-keymap for defining your own keymap
                preset = "default",
                ["<CR>"] = { "accept", "fallback" },

                -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
                --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
            }

            opts.appearance = {
                -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
                -- Adjusts spacing to ensure icons are aligned
                nerd_font_variant = "mono",
            }

            opts.completion = {
                -- By default, you may press `<c-space>` to show the documentation.
                -- Optionally, set `auto_show = true` to show the documentation after a delay.
                documentation = { auto_show = true, auto_show_delay_ms = 500 },
                list = { selection = { preselect = true, auto_insert = false } },
                ghost_text = {
                    enabled = true,
                    -- Show the ghost text when an item has been selected
                    show_with_selection = false,
                    -- Show the ghost text when no item has been selected, defaulting to the first item
                    show_without_selection = false,
                    -- Show the ghost text when the menu is open
                    show_with_menu = true,
                    -- Show the ghost text when the menu is closed
                    show_without_menu = true,
                },
            }

            opts.sources = {
                default = { "lsp", "path", "lazydev", "snippets" },
                providers = {
                    lazydev = { module = "lazydev.integrations.blink", score_offset = 100 },
                    lsp = {
                        name = "lsp",
                        enabled = true,
                        module = "blink.cmp.sources.lsp",
                        kind = "LSP",
                        min_keyword_length = 2,
                        -- When linking markdown notes, I would get snippets and text in the
                        -- suggestions, I want those to show only if there are no LSP
                        -- suggestions
                        --
                        -- Enabled fallbacks as this seems to be working now
                        -- Disabling fallbacks as my snippets wouldn't show up when editing
                        -- lua files
                        -- fallbacks = { "snippets", "buffer" },
                        score_offset = 90, -- the higher the number, the higher the priority
                    },
                    path = {
                        name = "Path",
                        module = "blink.cmp.sources.path",
                        score_offset = 25,
                        -- When typing a path, I would get snippets and text in the
                        -- suggestions, I want those to show only if there are no path
                        -- suggestions
                        fallbacks = { "snippets", "buffer" },
                        -- min_keyword_length = 2,
                        opts = {
                            trailing_slash = false,
                            label_trailing_slash = true,
                            get_cwd = function(context)
                                return vim.fn.expand(("#%d:p:h"):format(context.bufnr))
                            end,
                            show_hidden_files_by_default = true,
                        },
                    },
                    snippets = {
                        name = "snippets",
                        enabled = true,
                        max_items = 15,
                        min_keyword_length = 2,
                        module = "blink.cmp.sources.snippets",
                        score_offset = 85, -- the higher the number, the higher the priority
                        -- Only show snippets if I type the trigger_text characters, so
                        -- to expand the "bash" snippet, if the trigger_text is ";" I have to
                        -- should_show_items = function()
                        --     local col = vim.api.nvim_win_get_cursor(0)[2]
                        --     local before_cursor = vim.api.nvim_get_current_line():sub(1, col)
                        --     -- NOTE: remember that `trigger_text` is modified at the top of the file
                        --     return before_cursor:match(trigger_text .. "%w*$") ~= nil
                        -- end,
                        -- -- After accepting the completion, delete the trigger_text characters
                        -- -- from the final inserted text
                        -- -- Modified transform_items function based on suggestion by `synic` so
                        -- -- that the luasnip source is not reloaded after each transformation
                        -- -- https://github.com/linkarzu/dotfiles-latest/discussions/7#discussion-7849902
                        -- -- NOTE: I also tried to add the ";" prefix to all of the snippets loaded from
                        -- -- friendly-snippets in the luasnip.lua file, but I was unable to do
                        -- -- so, so I still have to use the transform_items here
                        -- -- This removes the ";" only for the friendly-snippets snippets
                        -- transform_items = function(_, items)
                        --     local line = vim.api.nvim_get_current_line()
                        --     local col = vim.api.nvim_win_get_cursor(0)[2]
                        --     local before_cursor = line:sub(1, col)
                        --     local start_pos, end_pos = before_cursor:find(trigger_text .. "[^" .. trigger_text .. "]*$")
                        --     if start_pos then
                        --         for _, item in ipairs(items) do
                        --             if not item.trigger_text_modified then
                        --                 ---@diagnostic disable-next-line: inject-field
                        --                 item.trigger_text_modified = true
                        --                 item.textEdit = {
                        --                     newText = item.insertText or item.label,
                        --                     range = {
                        --                         start = { line = vim.fn.line(".") - 1, character = start_pos - 1 },
                        --                         ["end"] = { line = vim.fn.line(".") - 1, character = end_pos },
                        --                     },
                        --                 }
                        --             end
                        --         end
                        --     end
                        --     return items
                        -- end,
                    },
                },
            }

            -- snippets = { preset = "luasnip" },

            -- Blink.cmp includes an optional, recommended rust fuzzy matcher,
            -- which automatically downloads a prebuilt binary when enabled.
            --
            -- By default, we use the Lua implementation instead, but you may enable
            -- the rust implementation via `'prefer_rust_with_warning'`
            --
            -- See :h blink-cmp-config-fuzzy for more information
            opts.fuzzy = { implementation = "lua" }

            -- Shows a signature help window while you type arguments for a function
            -- signature = { enabled = false, window = { show_documentation = false } },

            return opts
        end,
    },
}
