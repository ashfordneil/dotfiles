local install = function(use)
  use 'catppuccin/nvim'
  use 'f-person/auto-dark-mode.nvim'
end

local setup = function()
  vim.opt.termguicolors = true

  local auto_dark_mode = require('auto-dark-mode')
  vim.cmd('colorscheme catppuccin')
  auto_dark_mode.setup({
    set_dark_mode = function()
      vim.api.nvim_set_option('background', 'dark')
      vim.cmd('colorscheme catppuccin-frappe')
    end,
    set_light_mode = function()
      vim.api.nvim_set_option('background', 'light')
      vim.cmd('colorscheme catppuccin-latte')
    end,
  })

end

return {
  install = install,
  setup = setup
}
