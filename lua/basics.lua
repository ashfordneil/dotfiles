-- Basic Qualit of Life keymaps
vim.api.nvim_set_keymap('i', 'jk', '<Esc>', { noremap = true })
vim.api.nvim_set_keymap('i', 'kj', '<Esc>', { noremap = true })

-- Minor settings
vim.opt.shiftwidth=2
vim.opt.softtabstop=2
vim.opt.hlsearch=false
vim.opt.mouse = 'n'
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.diffopt = 'vertical'
vim.opt.hidden = true
