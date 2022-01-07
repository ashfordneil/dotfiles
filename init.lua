-- Little helper things - put this at the top of the file so that if
-- anything breaks in the rest of the config I can still _use_ neovim
-- while I'm debugging
require('basics')

-- Our main modules, each of which should export ".install" and ".setup"
local simple_plugins = require('simple-plugins')
local buffers = require('buffers')
local colors = require('colors')
local finder = require('finder')
local tree_sitter = require('tree-sitter')
local autocomplete = require('autocomplete')
local statusline = require('statusline')

-- Packer Setup
-- This is where all of our plugins come from
local execute = vim.api.nvim_command
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  local repo = 'https://github.com/wbthomason/packer.nvim'
  execute('!git clone ' .. repo .. ' ' .. install_path)
end

local packer = require('packer')
packer.startup(function(use)
  -- Get Packer to install / manage Packer, to keep it up to date
  use 'wbthomason/packer.nvim'

  -- Install things required by our main modules
  simple_plugins.install(use)
  buffers.install(use)
  colors.install(use)
  finder.install(use)
  tree_sitter.install(use)
  autocomplete.install(use)
  statusline.install(use)
end)

-- Actually set things up now
simple_plugins.setup()
buffers.setup()
colors.setup()
finder.setup()
tree_sitter.setup()
autocomplete.setup()
statusline.setup()
