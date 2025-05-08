-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {


    {
        'stevearc/oil.nvim',
        ---@module 'oil'
        ---@type oil.SetupOpts
        opts = {},
        -- Optional dependencies
        dependencies = { { "nvim-tree/nvim-web-devicons", opts = {} } },
        -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
        -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
        lazy = false,
        keys = {
            { '-', '<cmd>Oil<cr>', desc = 'Open parent dir' },
        },
    },
    {
        'mfussenegger/nvim-lint',

        config = function()
            local lint         = require('lint')

            lint.linters_by_ft = {

                elixir = {
                    'credo'
                }
            }

            local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })


            vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
                group = lint_augroup,
                callback = function()
                    lint.try_lint()
                end,
            })
        end

    },

    {
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = {
                lua = { "lua_ls" },
                javascript = { { "prettierd", "prettier" }, { "eslint_d", "eslint" } },
                typescript = { { "prettierd", "prettier" }, { "eslint_d", "eslint" } },
            },
            format_on_save = {
                -- These options will be passed to conform. format()
                timeout_ms = 500,
                Isp_fallback = true,
            },
        }
    },

    {
        'nvim-lualine/lualine.nvim',
        opts = {
            options = {
                icons_enabled = true,
                theme = 'onedark',
                component_separators = '|',
                section_separators = '',
            },
            tabline = {
                lualine_a = { 'buffers' },
                lualine_z = { 'tabs' },
            },
        },
        dependencies = { 'nvim-tree/nvim-web-devicons' }

    },
    {
        "elixir-tools/elixir-tools.nvim",
        version = "*",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            local elixir = require("elixir")
            local elixirls = require("elixir.elixirls")

            elixir.setup {
                nextls = { enable = true },
                elixirls = {
                    enable = true,
                    settings = elixirls.settings {
                        dialyzerEnabled = false,
                        enableTestLenses = false,
                    },
                    on_attach = function(client, bufnr)
                        vim.keymap.set("n", "<space>fp", ":ElixirFromPipe<cr>", { buffer = true, noremap = true })
                        vim.keymap.set("n", "<space>tp", ":ElixirToPipe<cr>", { buffer = true, noremap = true })
                        vim.keymap.set("v", "<space>em", ":ElixirExpandMacro<cr>", { buffer = true, noremap = true })
                    end,
                },
                projectionist = {
                    enable = true
                }
            }
        end,
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
    },
}
