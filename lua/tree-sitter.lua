function install(use)
  use 'nvim-treesitter/nvim-treesitter'
  use 'windwp/nvim-ts-autotag'
end

function setup()
  require('nvim-treesitter.install').prefer_git = true
  require('nvim-treesitter.configs').setup {
    autotag = {
      enable = true
    },
    ensure_installed = 'maintained',
    highlight = {
      enable = true
    }
  }

  vim.opt.foldmethod = 'expr'
  vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
  vim.opt.foldlevel = 10000000
end

return {
  install = install,
  setup = setup
}
