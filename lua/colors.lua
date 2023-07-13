local install = function(use)
  use 'maxmx03/solarized.nvim'
end

local setup = function()
  vim.opt.termguicolors = true
  vim.cmd('colorscheme solarized')
end

return {
  install = install,
  setup = setup
}
