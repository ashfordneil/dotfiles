local install = function(use)
  use 'EdenEast/nightfox.nvim'
end

local setup = function()
  vim.opt.termguicolors = true
  vim.cmd('colorscheme dawnfox')
end

return {
  install = install,
  setup = setup
}
