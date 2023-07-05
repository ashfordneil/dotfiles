local install = function(use)
  use 'peterlvilim/solarized.nvim'
end

local setup = function()
  vim.opt.termguicolors = true
  vim.cmd('colorscheme solarized')
end

return {
  install = install,
  setup = setup
}
