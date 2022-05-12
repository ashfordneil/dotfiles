local install = function(use)
  use 'EdenEast/nightfox.nvim'
end

local setup = function()
  vim.opt.termguicolors = true
  vim.cmd('colorscheme duskfox')
end

return {
  install = install,
  setup = setup
}
