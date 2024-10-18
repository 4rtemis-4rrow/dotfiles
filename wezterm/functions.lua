local wezterm   = require("wezterm")
local action    = wezterm.action
local F = {}

-- Check if file exists
function F.file_exists(name)
  local file = io.open(name,"r")
  if file ~= nil then
    io.close(file)
    return true
  else
    return false
  end
end

-- Match the appearance to the system's style
function F.scheme_for_appearance(appearance, dark, light)
  if appearance:find "Dark" then
    return dark
  else
    return dark
  end
end

-- Get basename of path
function F.basename(string)
  return string.gsub(string, "(.*[/\\])(.*)", "%2")
end

-- Define window title
function F.tab_title(tab_info)
  local title = tab_info.tab_title
  -- if the tab title is explicitly set, take that
  if title and #title > 0 then
    return title
  end
  -- Otherwise, use the title from the active pane in that tab
  return F.basename(tab_info.active_pane.title)
end

F.switch_workspace = function(window, pane, workspace)
  local current_workspace = window:active_workspace()
  if current_workspace == workspace then
    return
  end

  window:perform_action(
    action.SwitchToWorkspace({
      name = workspace,
    }),
    pane
  )
  wezterm.GLOBAL.previous_workspace = current_workspace
end

F.switch_previous_workspace = function(window, pane)
  local current_workspace = window:active_workspace()
  local workspace = wezterm.GLOBAL.previous_workspace

  if current_workspace == workspace or wezterm.GLOBAL.previous_workspace == nil then
    return
  end

  F.switch_workspace(window, pane, workspace)
end

return F
