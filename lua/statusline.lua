local install = function(use)
  use 'nvim-lualine/lualine.nvim'
end

local setup = function()
  local lualine = require('lualine')
  lualine.setup {
    options = {
      icons_enabled = true,
      component_separators = { right = '' }
    },

    sections = {
      lualine_a = { 'mode' },
      lualine_b = { 'branch' },
      lualine_c = { 'filename' },

      lualine_x = {},
      lualine_y = { 'filetype', 'fileformat' },
      lualine_z = { 'location' }
    },

    extensions = {
      'fugitive',
      'nvim-tree'
    }
  }
end

return {
  install = install,
  setup = setup
}
