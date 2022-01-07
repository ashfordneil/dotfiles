
function install(use)
  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      { 'nvim-lua/popup.nvim' },
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope-fzy-native.nvim' }
    }
  }

  use {
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons'
  }
end

function setup()
  local telescope = require('telescope')
  local nvim_tree = require('nvim-tree')

  telescope.setup {
    defaults = {
      theme = 'dropdown'
    },

    pickers = {
      find_files = {
	layout_strategy = 'vertical',
	previewer = false,
      }
    },

    extensions = {
      fzy_native = {
	override_generic_sorter = true,
	override_file_sorter = true
      }
    }
  }

  telescope.load_extension('fzy_native')
  nvim_tree.setup {}

  vim.api.nvim_set_keymap('n', '<leader>t', ':Telescope find_files<CR>', { noremap = true })
  vim.api.nvim_set_keymap('n', '<leader>o', ':NvimTreeToggle<CR>', { noremap = true })
end

return {
  install = install,
  setup = setup
}
