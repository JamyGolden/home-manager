local cmd = vim.cmd
local lspconfig = require('lspconfig')
local keymaps = require 'jamygolden/utils/keymaps'
local nmap = keymaps.nmap

-----------------------------------------------------------------------
-- Setup
-----------------------------------------------------------------------
require('nvim-lsp-installer').setup({
  automatic_installation = true, -- automatically detect which servers to install (based on which servers are set up via lspconfig)
  ui = {
    icons = {
      server_installed = '✓',
      server_pending = '➜',
      server_uninstalled = '✗'
    }
  }
})

-- Code completion setup
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<Leader>lwa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<Leader>lwr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<Leader>lwl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<Leader>lD', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<Leader>lrn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<Leader>lca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<Leader>lf', vim.lsp.buf.formatting, bufopts)
end

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}

-- lua
lspconfig.sumneko_lua.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  flags = lsp_flags,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file('', true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}

-- kotlin
lspconfig.kotlin_language_server.setup{
  capabilities = capabilities,
  on_attach = on_attach,
  flags = lsp_flags,
}

-- rust
lspconfig.rust_analyzer.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  flags = lsp_flags,
}

-- kotlin
lspconfig.kotlin_language_server.setup{}

-- tsserver
lspconfig.tsserver.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  flags = lsp_flags,
}

-- stylelint
vim.cmd([[autocmd BufWritePre *.css lua vim.lsp.buf.formatting_sync()]])
lspconfig.stylelint_lsp.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  flags = lsp_flags,
  filetypes = { 'css' },
  settings = {
    stylelintplus = {
      autoFixOnSave = true,
      autoFixOnFormat = true
   }
  }
}

-- eslint
cmd([[autocmd BufWritePre *.tsx,*.ts,*.jsx,*.js EslintFixAll]])
lspconfig.eslint.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  flags = lsp_flags,
  settings = {
    filetypes = { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx', 'vue' },
    eslint = {
      alwaysShowStatus = true,
      autoFixOnSave = true,
      debug = true,
      format = {
        enable = true,
      },
      packageManager = 'yarn',
      run = 'onSave',
      trace = {
        server = 'verbose',
      },
      validate = {
        'javascript',
        'javascriptreact',
        'typescript',
        'typescriptreact',
      },
    }
  }
}

-- json
lspconfig.jsonls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  flags = lsp_flags,
}

-----------------------------------------------------------------------
-- Keymaps
-----------------------------------------------------------------------
nmap('<Leader>n', ':lua vim.diagnostic.goto_next()<cr>')
nmap('<Leader>N', ':lua vim.diagnostic.goto_prev()<cr>')