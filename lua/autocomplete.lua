-- The LSP servers we want to support
local servers = {
  'rust_analyzer',
  'tsserver'
}

function install(use)
  -- Use the Language Server for all the smarts
  use 'neovim/nvim-lspconfig'
  use { 'j-hui/fidget.nvim', tag = 'legacy' }

  -- Snippet Support (I think this works, I'm not really sure)
  use 'L3MON4D3/LuaSnip'

  -- Actual autocompletion
  use 'hrsh7th/nvim-cmp'

  -- Things to make the autocompletion work
  use 'hrsh7th/cmp-nvim-lsp'
  use 'saadparwaiz1/cmp_luasnip'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-cmdline'
end

function setup()
  local nvim_lsp = require('lspconfig')
  local luasnip = require('luasnip')
  local cmp = require('cmp')
  local cmp_nvim = require('cmp_nvim_lsp')
  local fidget = require('fidget')

  -- Update the status line
  fidget.setup {
    window = {
      blend = 0
    }
  }

  -- Setup completions
  cmp.setup {
    snippet = {
      expand = function(args)
	luasnip.lsp_expand(args.body)
      end
    },

    mapping = {
      ['<Tab>'] = cmp.mapping(function(fallback)
	if cmp.visible() then
	  local entry = cmp.get_selected_entry()
	  cmp.select_next_item()
	  if not entry then
	    cmp.complete()
	  end
	elseif luasnip.expand_or_jumpable() then
	  luasnip.expand_or_jump()
	else
	  fallback()
	end
      end, { 'i', 's' }),

      ['<S-Tab>'] = cmp.mapping(function(fallback)
	if cmp.visible() then
	  cmp.select_prev_item()
	elseif luasnip.jumpable(-1) then
	  luasnip.jump(-1)
	else
	  fallback()
	end
      end, { 'i', 's' }),
    },

    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'luasnip' }
    }, {
      { name = 'buffer' },
    })
  }

  -- Use cmp for areas other than text
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- Setup function each time we attach an LSP to a buffer
  local on_attach = function(client, bufnr)
    -- Do a whole bunch of mappings for that buffer
    local opts = { noremap = true, silent = true }
    local map = vim.api.nvim_buf_set_keymap;
    map(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    map(bufnr, 'n', '<leader>g', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    map(bufnr, 'n', '<leader>r', '<Cmd>lua vim.lsp.buf.rename()<CR>', opts)
    map(bufnr, 'v', '<leader>f', '<Cmd>lua vim.lsp.buf.range_formatting()<CR>', opts)

    -- Telescope mappings
    map(bufnr, 'n', '<leader>l', '<Cmd>Telescope lsp_references<CR>', opts)
    map(bufnr, 'n', '<leader><Space>', '<Cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  end

  -- Tell LSP about our completions
  local snip_capabilities = cmp_nvim.default_capabilities()

  -- Set up the language servers
  for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
      capabilities = snip_capabilities,
      on_attach = on_attach
    }
  end
end

return {
  install = install,
  setup = setup
}
