return {
    "nvim-telescope/telescope.nvim",

    tag = "0.1.6",

    dependencies = {
        "nvim-lua/plenary.nvim"
    },

    config = function()
        require('telescope').setup({})

        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
        vim.keymap.set('n', '<C-p>', builtin.git_files, {})
        vim.keymap.set('n', '<leader>pws', function()
            local word = vim.fn.expand("<cword>")
            builtin.grep_string({ search = word })
        end)
        vim.keymap.set('n', '<leader>pWs', function()
            local word = vim.fn.expand("<cWORD>")
            builtin.grep_string({ search = word })
        end)
        vim.keymap.set('n', '<leader>ps', builtin.live_grep, { desc = "Project Search (Live Grep)" })
        vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})
        vim.keymap.set('n', '<leader>pb', builtin.buffers, { desc = "Project Buffers" })
        vim.keymap.set('n', '<leader>po', builtin.oldfiles, { desc = "Project Old Files" })
        vim.keymap.set('n', '<leader>lr', builtin.lsp_references, { desc = "LSP Find References" })
        vim.keymap.set('n', '<leader>fs', builtin.current_buffer_fuzzy_find, { desc = "Find String in Buffer" })
    end
}
