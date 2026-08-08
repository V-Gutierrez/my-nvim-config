-- Suppress known LSP noise — vtsls "setContext", Node warnings
return {
  {
    -- Handle vtsls commands that don't exist on the server side
    -- "setContext: command not found" appears when VS Code extensions
    -- request context that vtsls doesn't support
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        vtsls = {
          handlers = {
            -- Suppress "setContext" commands that vtsls doesn't implement
            ["$/setContext"] = function() end,
          },
        },
      },
    },
  },
}
