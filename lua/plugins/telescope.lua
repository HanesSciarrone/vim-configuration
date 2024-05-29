return {
    "nvim-telescope/telescope.nvim",
    dependencies = {  "nvim-lua/plenary.nvim" },

    config = function()
        local builtin = require('telescope.builtin')

        -- =========================== Shortkey configuration ===========================

        -- Find files using Telescope command-line sugar.
        vim.keymap.set("n", "<leader>ff", builtin.find_files, {silent = true})
        vim.keymap.set("n", "<leader>fg", builtin.live_grep,  {silent = true})
    end
}
