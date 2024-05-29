return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",

    config = function()
        require("nvim-treesitter.configs").setup({
            -- A list of parser names, or "all"
            ensure_installed = { "c", "cpp", "cmake", "lua", "vim", "json", "go", "python" },
            -- Install parsers synchronously (only applied to `ensure_installed`)
            sync_install = false,
            -- List of parsers to ignore installing (or "all")
            ignore_install = { "" },
            highlight = {
                enable = true,
                disable  = { "" }
            },
            indent = {
                enable = false
            }
        })
    end
}
