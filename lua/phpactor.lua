local config = require("phpactor.config")

local phpactor = {}

phpactor.AVAILABLE_RPC = {
  "cache_clear",
  "class_inflect",
  "config",
  "context_menu",
  "copy_class",
  "expand_class",
  "generate_accessor",
  "change_visibility",
  "import_class",
  "import_missing_classes",
  "move_class",
  "navigate",
  "new_class",
  "status",
  "transform",
  "lsp/status",
  "lsp/reindex",
  "lsp/debug/config",
  "lsp/debug/workspace",
  "blackfire/start",
  "blackfire/finish",
}

function phpactor.setup(options)
  config.setup(options)

  if config.options.lspconfig.enabled then
    require("lspconfig").phpactor.setup(vim.tbl_deep_extend("force", {
      cmd = {
        config.options.install.bin,
        "language-server",
      },
    }, config.options.lspconfig.options))
  end
end

function phpactor.rpc(name, options)
  options = options or {}

  if not vim.tbl_contains(phpactor.AVAILABLE_RPC, name) then
    name = "context_menu"
  end

  local handler = require("phpactor.handler." .. name)

  handler(options)
end

return phpactor
