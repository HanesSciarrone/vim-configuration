return {
    -- Custom statusline and statusbar
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("lualine").setup({option = {icons_enabled = true, theme = "vscode"}})
    end
}
