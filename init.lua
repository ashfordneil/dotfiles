-- Plugin Setup
local execute = vim.api.nvim_command
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
end

local use = require('packer').use
require('packer').startup(function()
  use 'wbthomason/packer.nvim'
  -- Actual plugins here
  use 'tpope/vim-fugitive'
  use 'hrsh7th/nvim-compe'
  use 'neovim/nvim-lspconfig'
  use 'nvim-treesitter/nvim-treesitter'
  use {
    'hoob3rt/lualine.nvim',
    requires = 'kyazdani42/nvim-web-devicons'
  }
  use 'ishan9299/nvim-solarized-lua'
  use 'cormacrelf/dark-notify'
  use {
    'akinsho/nvim-bufferline.lua',
    requires = 'kyazdani42/nvim-web-devicons'
  }
  use {
    'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}, {'nvim-telescope/telescope-fzy-native.nvim'}}
  }
  use {
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons'
  }
  use 'b3nj5m1n/kommentary'
  use 'editorconfig/editorconfig-vim'
end)

-- Autocompletion
vim.opt.completeopt = 'menuone,noselect'
require('compe').setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_tieout = 200;
  resolve_timeout = 800;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    nvim_lsp = true;
    nvim_lua = true;
  };
}

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t '<C-n>'
  elseif check_back_space() then
    return t '<Tab>'
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  else
    return t "<S-Tab>"
  end
end
vim.api.nvim_set_keymap('i', '<Tab>', 'v:lua.tab_complete()', {expr = true})
vim.api.nvim_set_keymap('s', '<Tab>', 'v:lua.tab_complete()', {expr = true})
vim.api.nvim_set_keymap('i', '<S-Tab>', 'v:lua.s_tab_complete()', {expr = true})
vim.api.nvim_set_keymap('s', '<S-Tab>', 'v:lua.s_tab_complete()', {expr = true})

-- Language servers
local nvim_lsp = require('lspconfig')
local on_attach = function(_client, bufnr)
  local opts = { noremap=true, silent=true }
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>g', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>r', '<Cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>l', '<Cmd>Telescope lsp_references<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'v', '<leader>f', '<Cmd>lua vim.lsp.buf.range_formatting()<CR>', opts)
end
local servers = { 'hls', 'rust_analyzer', 'tsserver' }

for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup { on_attach = on_attach }
end

-- Tree sitter
require('nvim-treesitter.configs').setup {
  ensure_installed = 'maintained',
  highlight = {
    enable = true
  }
}
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
vim.opt.foldlevel = 10000000

-- Status line
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'solarized_light'
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'filetype'},
    lualine_y = {},
    lualine_z = {'location'}
  },
  extensions = {
    'fugitive'
  }
}

-- Buffer line
require('bufferline').setup {
  options = {
    numbers = "ordinal",
    number_style = 'none',
    separator_style = 'slant',
    always_show_bufferline = true,
    show_close_icon = false,
    show_buffer_close_icons = false
  }
}
for i = 1, 9 do
  vim.api.nvim_set_keymap('n', '<leader>' .. i,
    ':lua require(\'bufferline\').go_to_buffer(' .. i .. ')<CR>',
    { noremap = true }
  )
end
vim.api.nvim_set_keymap('n', '<leader>q', ':bdelete!<CR>', { noremap = true })

-- Fuzzy
local telescope = require('telescope')
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
vim.api.nvim_set_keymap('n', '<leader>t', ':Telescope find_files<CR>', {})

-- Tree view
vim.api.nvim_set_keymap('n', '<leader>o', ':NvimTreeToggle<CR>', {})

-- Other Keymaps
vim.api.nvim_set_keymap('i', 'jk', '<Esc>', {})
vim.api.nvim_set_keymap('i', 'kj', '<Esc>', {})

-- Minor settings
vim.opt.shiftwidth=2
vim.opt.hlsearch = false
vim.opt.mouse = 'n'
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.diffopt = 'vertical'
vim.opt.hidden = true

-- Color
vim.opt.termguicolors = true
vim.opt.background = 'light'
vim.cmd('colorscheme solarized')
require('dark_notify').run()
require('dark_notify').update()
