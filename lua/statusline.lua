local install = function(use)
  use 'nvim-lualine/lualine.nvim'
end

local setup = function()
  local lualine = require('lualine')
  local lsp_status = require('lsp-status')
  lualine.setup {
    options = {
      icons_enabled = true,
      theme = 'solarized_light',
      component_separators = { right = '' }
    },

    sections = {
      lualine_a = { 'mode' },
      lualine_b = { 'branch' },
      lualine_c = { 'filename' },

      lualine_x = { 'require("lsp-status").status()' },
      lualine_y = { 'filetype', 'fileformat' },
      lualine_z = { 'location' }
    },

    extensions = {
      'fugitive'
    }
  }
end

return {
  install = install,
  setup = setup
}
