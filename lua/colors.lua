local install = function(use)
  use 'ishan9299/nvim-solarized-lua'
  use 'cormacrelf/dark-notify'
end

local setup = function()
  vim.opt.termguicolors = true
  vim.cmd('colorscheme solarized')

  local dark_notify = require('dark_notify')
  dark_notify.run({
    onchange = function(mode)
      local theme = 'solarized_light'
      if mode == 'dark' then
	theme = 'solarized_dark'
      end
    end
  })

  dark_notify.update()
end

return {
  install = install,
  setup = setup
}
