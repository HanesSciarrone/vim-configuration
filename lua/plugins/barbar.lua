return {
    -- Allow have a lot bar file on top
    "romgrk/barbar.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    init = function() vim.g.barbar_auto_setup = false end,
    config = function()
        require("barbar").setup({
            icon = {
                filetype = {
                    enabled = true
                },
                separator = { left = '| ', right = '' },
                separator_at_end = true
            }
        })

        local NvimTreeEvents = require("nvim-tree.events")
        local BufferlineAPI = require("bufferline.api")

        local function get_tree_size()
            return require("nvim-tree.view").View.width
        end

        NvimTreeEvents.subscribe("TreeOpen", function() BufferlineAPI.set_offset(get_tree_size()) end)
        NvimTreeEvents.subscribe("Resize", function() BufferlineAPI.set_offset(get_tree_size()) end)
        NvimTreeEvents.subscribe("TreeClose", function() BufferlineAPI.set_offset(0) end)

        -- =========================== Shortkey configuration ===========================

        -- Mapping for barbar
        vim.keymap.set("n", "<Tab>"    , "<cmd>BufferNext<CR>"    , {silent = true})
        vim.keymap.set("n", "<S-Tab>"  , "<cmd>BufferPrevious<CR>", {silent = true})
        vim.keymap.set("n", "<leader>c", "<cmd>BufferClose<CR>"   , {silent = true})
    end
}
