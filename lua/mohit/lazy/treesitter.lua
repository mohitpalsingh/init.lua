return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter").setup({
            ensure_installed = {
                "vimdoc", "javascript", "typescript", "c", "cpp", "lua", "rust",
                "jsdoc", "bash", "go", "gomod", "gosum", "java", "kotlin",
                "python", "scala", "json", "yaml", "toml", "dockerfile", "proto",
                "markdown", "markdown_inline",
            },
            sync_install = false,
            auto_install = false,
            indent = {
                enable = true,
                disable = { "c", "cpp" },
            },
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = { "markdown" },
            },
        })

        vim.treesitter.language.register("templ", "templ")
    end
}
