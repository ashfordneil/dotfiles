function install(use)
  use {
    'akinsho/bufferline.nvim',
    requires = 'nvim-tree/nvim-web-devicons'
  }
end

function setup()
  local bufferline = require('bufferline')
  bufferline.setup {
    highlights = require('catppuccin.groups.integrations.bufferline').get(),
    options = {
      numbers = 'ordinal',
      separator_style = 'slant',
      always_show_bufferline = true,
      show_close_icon = false,
      show_buffer_close_icons = false
    }
  }

  for i = 1, 9 do
    vim.api.nvim_set_keymap('n', '<leader>' .. i,
      '<Cmd>BufferLineGoToBuffer ' .. i .. '<CR>',
      { noremap = true }
    )
  end

  vim.api.nvim_set_keymap('n', '<leader>q', '<Cmd>bdelete!<CR>', { noremap = true })
end

return {
  install = install,
  setup = setup
}
