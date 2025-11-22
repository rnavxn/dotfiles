-- return {
--   'shaunsingh/nord.nvim',
--   lazy = false,
--   priority = 1000,
--   config = function()
--     -- Example config in lua
--     vim.g.nord_contrast = true
--     vim.g.nord_borders = false
--     vim.g.nord_disable_background = true
--     vim.g.nord_italic = true
--     vim.g.nord_uniform_diff_background = true
--     vim.g.nord_bold = true
--
--     -- Load the colorscheme
--     require('nord').set()
--
--     -- Toggle background transparency
--     local bg_transparent = true
--
--     local toggle_transparency = function()
--       bg_transparent = not bg_transparent
--       vim.g.nord_disable_background = bg_transparent
--       vim.cmd [[colorscheme nord]]
--     end
--
--     vim.keymap.set('n', '<leader>bg', toggle_transparency, { noremap = true, silent = true })
--   end,
-- }
--
--
-- return {
--   'folke/tokyonight.nvim',
--   lazy = false,
--   priority = 1000,
--   config = function()
--     require('tokyonight').setup {
--       style = 'night', -- storm, night, day
--       transparent = true,
--       terminal_colors = true,
--       styles = {
--         comments = { italic = false },
--         keywords = { italic = false },
--         functions = { bold = true },
--         variables = { bold = false },
--         sidebars = "transparent", -- Makes sidebar transparent
--         floats = "transparent",   -- Makes floating windows transparent
--       },
--     }
--     vim.cmd.colorscheme 'tokyonight'
--   end,
-- }
--
--
return {
  'catppuccin/nvim',
  name = 'catppuccin',
  lazy = false,
  priority = 1000,
  config = function()
    require('catppuccin').setup {
      flavour = 'frappe', -- latte, frappe, macchiato, mocha
      transparent_background = true,
      no_italic = true,
      integrations = {
        treesitter = true,
      },
    }
    vim.cmd.colorscheme 'catppuccin'
  end,
}
--
-- return {
--   'rebelot/kanagawa.nvim',
--   lazy = false,
--   priority = 1000,
--   config = function()
--     require('kanagawa').setup {
--       transparent = true,
--       colors = {
--         theme = {
--           all = {
--             ui = {
--               bg_gutter = 'none',
--             },
--           },
--         },
--       },
--     }
--     vim.cmd.colorscheme 'kanagawa-wave'
--   end,
-- }
