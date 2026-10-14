-- Language servers. A server starts only when its program is on PATH.
-- nvim-lspconfig has the defaults; this file only sets what differs.
local M = {}

vim.diagnostic.config({
  severity_sort = true,
  virtual_text = true,
  float = { source = true },
})

vim.lsp.config('*', { capabilities = require('blink.cmp').get_lsp_capabilities() })

local ts_hints = {
  parameterNames = { enabled = 'all' },
  parameterTypes = { enabled = true },
  variableTypes = { enabled = true },
  propertyDeclarationTypes = { enabled = true },
  functionLikeReturnTypes = { enabled = true },
  enumMemberValues = { enabled = true },
}

-- TypeScript in .vue files goes through vtsls and Vue's TypeScript plugin.
-- Home Manager sets VUE_LANGUAGE_SERVER_PATH to the @vue/language-server package.
local vue = vim.env.VUE_LANGUAGE_SERVER_PATH

vim.lsp.config('vtsls', {
  filetypes = vue and { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'vue' },
  settings = {
    typescript = { inlayHints = ts_hints },
    javascript = { inlayHints = ts_hints },
    vtsls = vue and {
      tsserver = {
        globalPlugins = {
          {
            name = '@vue/typescript-plugin',
            location = vue,
            languages = { 'vue' },
            configNamespace = 'typescript',
          },
        },
      },
    },
  },
})

vim.lsp.config('basedpyright', {
  settings = { basedpyright = { analysis = { typeCheckingMode = 'standard' } } },
})

vim.lsp.config('hls', {
  settings = { haskell = { formattingProvider = 'fourmolu' } },
})

vim.lsp.config('metals', {
  settings = {
    metals = {
      inlayHints = {
        inferredTypes = { enable = true },
        implicitArguments = { enable = true },
        implicitConversions = { enable = true },
        typeParameters = { enable = true },
        hintsInPatternMatch = { enable = true },
      },
    },
  },
})

vim.lsp.config('nixd', {
  settings = { nixd = { formatting = { command = { 'nixfmt' } } } },
})

vim.lsp.config('rust_analyzer', {
  settings = { ['rust-analyzer'] = { check = { command = 'clippy' } } },
})

local servers = {
  'basedpyright', 'bashls', 'clangd', 'cssls', 'elixirls', 'eslint', 'gopls', 'hls',
  'html', 'jsonls', 'lua_ls', 'metals', 'nixd', 'ruff', 'rust_analyzer', 'tailwindcss',
  'vtsls', 'vue_ls', 'yamlls',
}

local function installed(name)
  local cmd = vim.lsp.config[name].cmd
  return type(cmd) ~= 'table' or vim.fn.executable(cmd[1]) == 1
end

vim.lsp.enable(vim.tbl_filter(installed, servers))

-- ESLint formats JavaScript, TypeScript and Vue, as in Zed. Every other server formats its own files.
local function formats(client)
  return client.name ~= 'vtsls' and client.name ~= 'vue_ls'
end

function M.format(buf)
  vim.lsp.buf.format({ bufnr = buf, filter = formats, timeout_ms = 3000 })
end

-- Format on save, as in Zed.
vim.api.nvim_create_autocmd('BufWritePre', {
  group = vim.api.nvim_create_augroup('config.format', {}),
  callback = function(ev)
    local clients = vim.lsp.get_clients({ bufnr = ev.buf, method = 'textDocument/formatting' })
    if #vim.tbl_filter(formats, clients) > 0 then
      M.format(ev.buf)
    end
  end,
})

return M
