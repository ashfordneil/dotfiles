local install = function(use)
  -- Super useful git things
  use 'tpope/vim-fugitive'
  use 'f-person/git-blame.nvim'
  use 'b3nj5m1n/kommentary'
  use 'editorconfig/editorconfig-vim'
end

return {
  install = install,
  setup = function() end
}
