function install(use)
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'windwp/nvim-ts-autotag'
end

function setup()
  local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
  parser_config.wgsl = {
    install_info = {
      url = 'https://github.com/szebniok/tree-sitter-wgsl',
      files = {'src/parser.c'}
    },
  }
  vim.cmd[[au BufRead,BufNewFile *.wgsl	set filetype=wgsl]]

  require('nvim-treesitter.install').prefer_git = true
  require('nvim-treesitter.configs').setup {
    autotag = {
      enable = true
    },
    ensure_installed = 'all',
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
