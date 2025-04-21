return {
    -- DAP Core
    {
        'mfussenegger/nvim-dap',
        config = function()
            local dap = require('dap')
            -- Optional: Manually define Delve adapter (nvim-dap-go usually handles this)
            dap.adapters.delve = {
                type = 'server',
                port = '${port}',
                executable = {
                    command = 'dlv',
                    args = { 'dap', '-l', '127.0.0.1:${port}' },
                },
            }
        end,
    },

    -- DAP-Go Integration
    {
        'leoluz/nvim-dap-go',
        dependencies = { 'mfussenegger/nvim-dap' }, -- Explicit dependency
        config = function()
            require('dap-go').setup()
        end,
    },

    -- DAP-UI
    {
        'rcarriga/nvim-dap-ui',
        dependencies = {
            'mfussenegger/nvim-dap',
            'nvim-neotest/nvim-nio'
        },
        config = function()
            local dapui = require('dapui')
            dapui.setup()

            -- Auto-open/close UI
            local dap = require('dap')
            dap.listeners.after.event_initialized['dapui'] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated['dapui'] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited['dapui'] = function()
                dapui.close()
            end
        end,
    },

    -- Telescope Integration (Optional)
    {
        'nvim-telescope/telescope-dap.nvim',
        dependencies = { 'nvim-telescope/telescope.nvim' },
        config = function()
            require('telescope').load_extension('dap')
        end,
    },

    -- Keybindings (separate config block)
    {
        'mfussenegger/nvim-dap', -- Re-declare to attach keymaps
        config = function()
            vim.keymap.set('n', '<F5>', function() require('dap').continue() end)
            vim.keymap.set('n', '<F9>', function() require('dap').toggle_breakpoint() end)
            vim.keymap.set('n', '<F10>', function() require('dap').step_over() end)
            vim.keymap.set('n', '<F11>', function() require('dap').step_into() end)
            vim.keymap.set('n', '<F12>', function() require('dap').step_out() end)
            vim.keymap.set('n', '<leader>dr', function() require('dap').repl.open() end)
            vim.keymap.set('n', '<leader>dv', function() require('dapui').eval() end)
        end,
    },
}
