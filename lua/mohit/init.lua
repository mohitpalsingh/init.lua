require("mohit.set")
require("mohit.remap")
require("mohit.lazy_init")

local augroup = vim.api.nvim_create_augroup
local MohitGroup = augroup('Mohit', {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})

function R(name)
    require("plenary.reload").reload_module(name)
end

-- to flash yanked text
autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

-- to remove trailing whitespace on save
autocmd({"BufWritePre"}, {
    group = MohitGroup,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

local lsp_keymaps_group = vim.api.nvim_create_augroup('MohitLSPKeymaps', { clear = true })

-- LSP keymaps
-- This will set up buffer-local keymaps when an LSP server attaches to a buffer
vim.api.nvim_create_autocmd('LspAttach', {
    group = lsp_keymaps_group,
    callback = function(event)
        -- Buffer-local options
        local opts = { buffer = event.buf }

        -- Navigation
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts) -- Go to definition
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts) -- Go to declaration
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts) -- Show references
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts) -- Go to implementation

        -- Documentation
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts) -- Hover documentation
        vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, opts) -- Signature help (insert mode)

        -- Workspace & Diagnostics
        vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts) -- Add workspace folder
        vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts) -- Remove workspace folder
        vim.keymap.set('n', '<leader>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, opts) -- List workspace folders

        -- Code Actions
        vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts) -- Code actions (normal/visual mode)

        -- Diagnostics
        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts) -- Previous diagnostic
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts) -- Next diagnostic
        vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, opts) -- Show diagnostic

        -- Advanced
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts) -- Rename symbol
        vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, opts) -- Format buffer
    end
})

-- Netrw settings
vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
