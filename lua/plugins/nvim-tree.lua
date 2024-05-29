return {
    -- Show tree of project directory
    "nvim-tree/nvim-tree.lua",
    init = function()
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1
    end,
    config = function()
        require("nvim-tree").setup({
            view = {
                adaptive_size = false,
                centralize_selection = false,
                width = 31,
                side = "left",
                preserve_window_proportions = false,
                number = false,
                relativenumber = false,
                signcolumn = "yes",
            }
        })

        -- Function to open nvim-tree when neovim open directory
        local function open_nvim_tree(data)
            -- buffer is a [No Name]
            local no_name = data.file == "" and vim.bo[data.buf].buftype == ""

            -- buffer is a directory
            local directory = vim.fn.isdirectory(data.file) == 1

            if not no_name and not directory then
                return
            end

            -- change to the directory
            if directory then
                vim.cmd.cd(data.file)
            end

            -- open the tree
            require("nvim-tree.api").tree.open()
        end

        -- Register event
        vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })

        -- =========================== Shortkey configuration ===========================

        -- Open Nvim-tree
        vim.keymap.set("n", "<leader>nt", ":NvimTreeToggle<CR>", {silent = true})
    end
}
