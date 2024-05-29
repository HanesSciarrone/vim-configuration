return {
    "hrsh7th/nvim-cmp",                 -- Autocompleation (Autocompletion engine)
    dependencies = {
        "neovim/nvim-lspconfig",        -- LSP server for navigation code
        "williamboman/mason.nvim",      -- LSP servers installation automaticaly,
        "hrsh7th/cmp-nvim-lsp",         -- Autocompleation (LSP source for nvim-cmp)
        "L3MON4D3/LuaSnip",             -- Autocompleation (Snippets plugin)
        "saadparwaiz1/cmp_luasnip"      -- Autocompleation (Snippets source for nvim-cmp)
    },
    config = function()
        ---------- Configuration autocompleation ---------
        local cmp = require("cmp")
        local luasnip = require("luasnip")

        local function next_item(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end

        local function previous_item(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end

        cmp.setup({
            -- Specify the snippet engine
            snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },

            mapping = cmp.mapping.preset.insert({
                ["<C-Space>"]   = cmp.mapping.complete(),
                ["<CR>"]        = cmp.mapping.confirm({behavior = cmp.ConfirmBehavior.Replace, select = true}),
                ["<Tab>"]       = cmp.mapping(next_item,     {"i", "s"}),
                ["<S-Tab>"]     = cmp.mapping(previous_item, {"i", "s"}),
            }),

            source = cmp.config.sources({
                {
                    { name = "nvim_lsp" },
                    { name = "luasnip" }
                },
                {
                    { name = "buffer" }
                }
            })
        })
        --------------------------------------------------

        ------------ Configuration LSP-server ------------
        require("mason").setup()

        local capability = vim.lsp.protocol.make_client_capabilities()
        lsp_capabilities = require("cmp_nvim_lsp").default_capabilities(capability)

        require("lspconfig").clangd.setup{capabilities = lsp_capabilities}  -- C/C++ lsp server configuration
        require("lspconfig").cmake.setup{capabilities = lsp_capabilities}   -- CMacke lsp server configuration
        require("lspconfig").lua_ls.setup{}                                -- Lua lsp server configuration

        capability.textDocument.completion.completionItem.snippetSupport = true
        require("lspconfig").jsonls.setup{capabilities = capability}       -- JSON lsp server configuration
        --------------------------------------------------
    end
}
