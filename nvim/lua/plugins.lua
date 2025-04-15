local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Load the plugins
local plugin_dir = vim.fn.stdpath('config') .. "/lua/Plugins"

-- This function loads all the Lua files from the 'Plugins' directory
local function load_plugins()
  local files = vim.fn.globpath(plugin_dir, "*.lua", false, true)
  local plugins = {}

  for _, file in ipairs(files) do
    local plugin_name = file:match(".*/(.*).lua$")
    local plugin_config = require("Plugins." .. plugin_name)

    -- Ensure plugin config is a table before adding
    if type(plugin_config) == "table" then
      table.insert(plugins, plugin_config)
    else
      vim.api.nvim_err_writeln("Invalid plugin config in " .. file .. ": " .. tostring(plugin_config))
    end
  end

  return plugins
end

-- Set up lazy.nvim with the loaded plugins
require('lazy').setup(load_plugins())
