-- The LSP servers we want to support
local servers = {
  'rust_analyzer',
  'tsserver'
}

function install(use)
  -- Use the Language Server for all the smarts
  use 'neovim/nvim-lspconfig'

  -- Snippet Support (I think this works, I'm not really sure)
  use 'L3MON4D3/LuaSnip'

  -- Actual autocompletion
  use 'hrsh7th/nvim-cmp'

  -- Things to make the autocompletion work
  use 'hrsh7th/cmp-nvim-lsp'
  use 'saadparwaiz1/cmp_luasnip'

  -- Status
  use 'j-hui/fidget.nvim'
end

function setup()
  local nvim_lsp = require('lspconfig')
  local luasnip = require('luasnip')
  local cmp = require('cmp')
  local cmp_nvim = require('cmp_nvim_lsp')

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
	  cmp.select_next_item()
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
    map(bufnr, 'n', '<leader><Space>', '<Cmd>Telescope lsp_code_actions<CR>', opts)
  end

  -- Tell LSP about our completions
  local snip_capabilities = cmp_nvim.update_capabilities(
    vim.lsp.protocol.make_client_capabilities()
  )

  -- Set up the language servers
  for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
      capabilities = snip_capabilities,
      on_attach = on_attach
    }
  end

  require('fidget').setup {}
end

return {
  install = install,
  setup = setup
}
