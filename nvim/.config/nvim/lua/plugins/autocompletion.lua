return {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    -- event = 'InsertEnter',
    dependencies = {
        -- Snippet Engine & its associated nvim-cmp source
        {
            'L3MON4D3/LuaSnip',
            build = (function()
                -- Build Step is needed for regex support in snippets
                -- This step is not supported in many windows environments
                -- Remove the below condition to re-enable on windows
                if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
                    return
                end
                return 'make install_jsregexp'
            end)(),
        },
        'saadparwaiz1/cmp_luasnip',

        -- Adds other completion capabilities.
        --  nvim-cmp does not ship with all sources by default. They are split
        --  into multiple repos for maintenance purposes.
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',

        -- Adds a number of user-friendly snippets
        'rafamadriz/friendly-snippets',
    },
    config = function()
        local cmp = require 'cmp'
        require('luasnip.loaders.from_vscode').lazy_load()
        local luasnip = require 'luasnip'
        luasnip.config.setup {}

        local kind_icons = {
            Text = '󰉿',
            Method = 'm',
            Function = '󰊕',
            Constructor = '',
            Field = '',
            Variable = '󰆧',
            Class = '󰌗',
            Interface = '',
            Module = '',
            Property = '',
            Unit = '',
            Value = '󰎠',
            Enum = '',
            Keyword = '󰌋',
            Snippet = '',
            Color = '󰏘',
            File = '󰈙',
            Reference = '',
            Folder = '󰉋',
            EnumMember = '',
            Constant = '󰇽',
            Struct = '',
            Event = '',
            Operator = '󰆕',
            TypeParameter = '󰊄',
        }

        cmp.setup {
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            completion = { completeopt = 'menu,menuone,noinsert' },
            -- window = {
            --     completion = cmp.config.window.bordered(),
            --     documentation = cmp.config.window.bordered(),
            -- },
            mapping = cmp.mapping.preset.insert {
                ['<C-j>'] = cmp.mapping.select_next_item(),       -- Select the [n]ext item
                ['<C-k>'] = cmp.mapping.select_prev_item(),       -- Select the [p]revious item
                ['<CR>'] = cmp.mapping.confirm { select = true }, -- Accept the completion with Enter.
                ['<C-c>'] = cmp.mapping.complete {},              -- Manually trigger a completion from nvim-cmp.

                -- Think of <c-l> as moving to the right of your snippet expansion.
                --  So if you have a snippet that's like:
                --  function $name($args)
                --    $body
                --  end
                --
                -- <c-l> will move you to the right of each of the expansion locations.
                -- <c-h> is similar, except moving you backwards.
                ['<C-l>'] = cmp.mapping(function()
                    if luasnip.expand_or_locally_jumpable() then
                        luasnip.expand_or_jump()
                    end
                end, { 'i', 's' }),
                ['<C-h>'] = cmp.mapping(function()
                    if luasnip.locally_jumpable(-1) then
                        luasnip.jump(-1)
                    end
                end, { 'i', 's' }),

                -- Select next/previous item with Tab / Shift + Tab
                ['<Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.expand_or_locally_jumpable() then
                        luasnip.expand_or_jump()
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
                ['<S-Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.locally_jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
            },
            sources = {
                { name = 'nvim_lsp' },
                { name = 'luasnip' },
                { name = 'buffer' },
                { name = 'path' },
            },
            formatting = {
                fields = { 'kind', 'abbr', 'menu' },
                format = function(entry, vim_item)
                    -- Kind icons
                    vim_item.kind = string.format('%s', kind_icons[vim_item.kind])
                    -- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
                    vim_item.menu = ({
                        nvim_lsp = '[LSP]',
                        luasnip = '[Snippet]',
                        buffer = '[Buffer]',
                        path = '[Path]',
                    })[entry.source.name]
                    return vim_item
                end,
            },
        }
    end,
}
-- return {
--     -- Autocompletion
--     'saghen/blink.cmp',
--     event = 'VimEnter',
--     version = '1.*',
--     dependencies = {
--         -- Snippet Engine
--         {
--             'L3MON4D3/LuaSnip',
--             version = '2.*',
--             build = (function()
--                 -- Build Step is needed for regex support in snippets.
--                 -- This step is not supported in many windows environments.
--                 -- Remove the below condition to re-enable on windows.
--                 if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
--                     return
--                 end
--                 return 'make install_jsregexp'
--             end)(),
--             dependencies = {
--                 -- `friendly-snippets` contains a variety of premade snippets.
--                 --    See the README about individual language/framework/plugin snippets:
--                 --    https://github.com/rafamadriz/friendly-snippets
--                 {
--                   'rafamadriz/friendly-snippets',
--                   config = function()
--                     require('luasnip.loaders.from_vscode').lazy_load()
--                   end,
--                 },
--             },
--             opts = {},
--         },
--         'folke/lazydev.nvim',
--     },
--     --- @module 'blink.cmp'
--     --- @type blink.cmp.Config
--     opts = {
--         keymap = {
--             -- 'default' (recommended) for mappings similar to built-in completions
--             --   <c-y> to accept ([y]es) the completion.
--             --    This will auto-import if your LSP supports it.
--             --    This will expand snippets if the LSP sent a snippet.
--             -- 'super-tab' for tab to accept
--             -- 'enter' for enter to accept
--             -- 'none' for no mappings
--             --
--             -- For an understanding of why the 'default' preset is recommended,
--             -- you will need to read `:help ins-completion`
--             --
--             -- No, but seriously. Please read `:help ins-completion`, it is really good!
--             --
--             -- All presets have the following mappings:
--             -- <tab>/<s-tab>: move to right/left of your snippet expansion
--             -- <c-space>: Open menu or open docs if already open
--             -- <c-n>/<c-p> or <up>/<down>: Select next/previous item
--             -- <c-e>: Hide menu
--             -- <c-k>: Toggle signature help
--             --
--             -- See :h blink-cmp-config-keymap for defining your own keymap
--             preset = 'default',
--
--             -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
--             --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
--         },
--
--         appearance = {
--             -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
--             -- Adjusts spacing to ensure icons are aligned
--             nerd_font_variant = 'mono',
--         },
--
--         completion = {
--             -- By default, you may press `<c-space>` to show the documentation.
--             -- Optionally, set `auto_show = true` to show the documentation after a delay.
--             documentation = { auto_show = false, auto_show_delay_ms = 500 },
--         },
--
--         sources = {
--             default = { 'lsp', 'path', 'snippets', 'lazydev' },
--             providers = {
--                 lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
--             },
--         },
--
--         snippets = { preset = 'luasnip' },
--
--         -- Blink.cmp includes an optional, recommended rust fuzzy matcher,
--         -- which automatically downloads a prebuilt binary when enabled.
--         --
--         -- By default, we use the Lua implementation instead, but you may enable
--         -- the rust implementation via `'prefer_rust_with_warning'`
--         --
--         -- See :h blink-cmp-config-fuzzy for more information
--         fuzzy = { implementation = 'lua' },
--
--         -- Shows a signature help window while you type arguments for a function
--         signature = { enabled = true },
--     },
-- }
 
