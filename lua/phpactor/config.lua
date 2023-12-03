local config = {}

config.options = {}

local default_values = {
  install = {
    branch = "master",
    bin = "phpactor",
    php_bin = "php",
    composer_bin = "composer",
  },
  lspconfig = {
    enabled = true,
    options = {},
  },
}

function config.setup(options)
  config.options = vim.tbl_deep_extend("force", default_values, options or {})
end

return config
