return {
    -- Show the name of branch on the statusline
    "tpope/vim-fugitive",
    -- Show information of commiteer, date and commit per line
    "APZelos/blamer.nvim",
    init = function()
        vim.g.blamer_enabled = 1
        vim.g.blamer_delay = 1000
        vim.g.blamer_show_in_visual_mode = 0
        vim.g.blamer_show_in_insert_mode = 0
        vim.g.blamer_date_format = "%d/%m/%y"
    end
}
