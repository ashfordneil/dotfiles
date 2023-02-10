
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
    'nvim-tree/nvim-tree.lua',
    requires = 'nvim-tree/nvim-web-devicons'
  }
end

function setup()
  local telescope = require('telescope')
  local telescope_actions = require('telescope.actions')
  local telescope_builtin = require('telescope.builtin')
  local nvim_tree = require('nvim-tree')

  local dropdown_theme = require('telescope.themes').get_dropdown({
    result_height = 20;
    winblend = 20;
    width = 0.8;
    prompt_title = '';
    previewer = false;
    borderchars = {
      prompt = {'▀', '▐', '▄', '▌', '▛', '▜', '▟', '▙' };
      results = {' ', '▐', '▄', '▌', '▌', '▐', '▟', '▙' };
      preview = {'▀', '▐', '▄', '▌', '▛', '▜', '▟', '▙' };
    };
  })

  telescope.setup {
    defaults = {
      mappings = {
	i = {
	  ['<Esc>'] = telescope_actions.close
	}
      },
      path_display = { 'smart' },
    },

    pickers = {
      find_files = {
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

  vim.keymap.set('n', '<leader>t', function() telescope_builtin.find_files(dropdown_theme) end, { noremap = true })
  vim.api.nvim_set_keymap('n', '<leader>o', ':NvimTreeToggle<CR>', { noremap = true })
end

return {
  install = install,
  setup = setup
}
