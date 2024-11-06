require("plugins")
require("Settings")
require("Keybindings")
require("highlight")
require("autocmd")

local plugin_dir = vim.fn.stdpath('config') .. "/lua/Configs"

local function load_plugins()
  local files = vim.fn.globpath(plugin_dir, "*.lua", false, true)

  for _, file in ipairs(files) do
    local plugin_name = file:match(".*/(.*).lua$")
    require("Configs." .. plugin_name)
  end
end

load_plugins()
