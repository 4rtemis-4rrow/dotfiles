local wezterm   = require("wezterm")
local action    = wezterm.action
local nerdfonts = wezterm.nerdfonts
local mux       = wezterm.mux

local F = require("functions")

local colors   = {}
local config   = {}
local custom   = {}
local projects = {}

-- Custom
custom = {
  color_scheme = {
    dark  = "Catppuccin Mocha",
    light = "Catppuccin Mocha",
  },
  hostname = {
    current = string.lower(wezterm.hostname()),
    work = "pc-xxxxxx",
  },
  timeout = {
    key = 3000,
    leader = 1000
  },
}

projects = {
  default_workspace = "default",
  repositories      = {
    { type = "personal", workspace = "default",  name = "home",     path = os.getenv("HOME")},
  }
}

config.bidi_enabled = true
config.bidi_direction = 'AutoLeftToRight'
config.enable_wayland=true
config.enable_kitty_graphics=true

-- Path
config.set_environment_variables = {
  PATH = wezterm.home_dir .. ":" .. os.getenv("PATH") .. ":" .. os.getenv("HOME") .. "/.nix-profile/bin"
}

-- Lauching
config.default_prog = { "zsh" }
config.automatically_reload_config = true

-- Colorscheme
config.color_scheme = F.scheme_for_appearance(
  wezterm.gui.get_appearance(),
  custom.color_scheme.dark,
  custom.color_scheme.light
)
colors = wezterm.get_builtin_color_schemes()[config.color_scheme]

config.colors = {
  compose_cursor = colors.ansi[2],
  cursor_bg = colors.indexed[10],
  split = colors.indexed[16],
  tab_bar = { background = colors.background }
}

-- Cursor
config.xcursor_theme = "Adwaita"

-- Pane
config.inactive_pane_hsb = {
  saturation = 0.6,
  brightness = 0.6
}

-- IME
config.use_ime = false

-- Keys Mapping
config.disable_default_key_bindings = true
config.leader = { key = " ", mods = "CTRL", timeout_milliseconds = custom.timeout.leader }
config.keys = {
  { key = "o", mods = "LEADER",
      action = action.ActivateKeyTable {
        name = "open",
        one_shot = false,
        until_unknown = true,
        timeout_milliseconds = custom.timeout.key
      }
  },
  {
      key = "P",
      mods = "CTRL",
      action = wezterm.action {
          QuickSelectArgs = {
              patterns = {
                  "https?://\\S+"
              },
              action = wezterm.action_callback(function(window, pane)
                  local url = window:get_selection_text_for_pane(pane)
                  wezterm.log_info("opening: " .. url)
                  wezterm.open_with(url)
              end)
          }
      }
  },
  { key = "m", mods = "LEADER",
      action = action.ActivateKeyTable {
        name = "move",
        one_shot = false,
        until_unknown = false,
        timeout_milliseconds = custom.timeout.key
      }
  },
  { key = "r", mods = "LEADER",
      action = action.ActivateKeyTable {
        name = "resize",
        one_shot = false,
        until_unknown = true,
        timeout_milliseconds = custom.timeout.key
      }
  },

  { key = "c",          mods = "LEADER",       action = action.ShowLauncherArgs { flags = "FUZZY|LAUNCH_MENU_ITEMS" } },
  { key = "h",          mods = "LEADER",       action = action.ActivateCommandPalette                                 },
  { key = "l",          mods = "LEADER",       action = action.Multiple {
                                                          wezterm.action_callback(function(window,pane)
                                                            F.switch_previous_workspace(window,pane)
                                                          end),
                                                          action.EmitEvent 'set-previous-workspace'
                                                }
  },
  { key = "p",          mods = "LEADER",       action = action.PasteFrom("Clipboard")                                 },
  { key = "q",          mods = "LEADER",       action = action.QuitApplication                                        },
  { key = "s",          mods = "LEADER",       action = action.Multiple {
                                                          action.ShowLauncherArgs { flags = "FUZZY|WORKSPACES" },
                                                          action.EmitEvent 'set-previous-workspace'
                                                }
  },
  { key = "t",          mods = "CTRL",         action = action.SpawnTab("DefaultDomain")                              },
  { key = "v",          mods = "LEADER",       action = action.ActivateCopyMode                                       },
  { key = "w",          mods = "LEADER",       action = action.ShowLauncherArgs { flags = "TABS" }                    },
  { key = "y",          mods = "LEADER",       action = action.Multiple {
                                                          action.CopyTo("ClipboardAndPrimarySelection"),
                                                          action.ClearSelection
                                                        }
  },
  { key = "z",          mods = "LEADER",       action = action.TogglePaneZoomState,                                   },
  { key = "DownArrow",  mods = "ALT",          action = action.ActivatePaneDirection("Down")                          },
  { key = "DownArrow",  mods = "SHIFT",        action = action.ScrollByLine(1)                                        },
  { key = "End",        mods = "SHIFT",        action = action.ScrollToBottom                                         },
  { key = "Home",       mods = "SHIFT",        action = action.ScrollToTop                                            },
  { key = "LeftArrow",  mods = "ALT",          action = action.ActivatePaneDirection("Left")                          },
  { key = "PageDown",   mods = "SHIFT",        action = action.ScrollByPage(1)                                        },
  { key = "PageUp",     mods = "SHIFT",        action = action.ScrollByPage(-1)                                       },
  { key = "RightArrow", mods = "ALT",          action = action.ActivatePaneDirection("Right")                         },
  { key = "UpArrow",    mods = "ALT",          action = action.ActivatePaneDirection("Up")                            },
  { key = "UpArrow",    mods = "SHIFT",        action = action.ScrollByLine(-1)                                       },
  { key = "0",          mods = "ALT",          action = action.EmitEvent 'toggle-opacity-reset'                       },
  { key = "0",          mods = "CTRL",         action = action.ResetFontSize                                          },
  { key = "-",          mods = "ALT",          action = action.EmitEvent 'toggle-opacity-minus'                       },
  { key = "-",          mods = "CTRL",         action = action.DecreaseFontSize                                       },
  { key = "=",          mods = "ALT",          action = action.EmitEvent 'toggle-opacity-plus'                        },
  { key = "=",          mods = "CTRL",         action = action.IncreaseFontSize                                       },
  { key = "[",          mods = "ALT",          action = action.ActivateTabRelative(-1)                                },
  { key = "[",          mods = "CTRL",         action = action.Multiple {
                                                          action.SwitchWorkspaceRelative(-1),
                                                          action.EmitEvent 'set-previous-workspace'
                                                        }
  },
  { key = "]",          mods = "ALT",          action = action.ActivateTabRelative(1)                                 },
  { key = "]",          mods = "CTRL",         action = action.Multiple {
                                                          action.SwitchWorkspaceRelative(1),
                                                          action.EmitEvent 'set-previous-workspace'
                                                        }
  },
  { key = "/",          mods = "LEADER",       action = action.Search { CaseInSensitiveString = "" }                  },
  { key = "-",          mods = "LEADER",       action = action.SplitVertical   { domain = "CurrentPaneDomain" }       },
  { key = "|",          mods = "LEADER|SHIFT", action = action.SplitHorizontal { domain = "CurrentPaneDomain" }       },
  { key = ",",          mods = "LEADER",       action = action.PromptInputLine
     {
      description = wezterm.format {
        { Attribute  = { Intensity = "Bold" }},
        { Foreground = { Color = colors.indexed[16] }},
        { Text = "Renaming tab title:"      }},
      action = wezterm.action_callback(function(window, _, line)
        if line then
          window:active_tab():set_title(line)
        end
      end),
    }
  },
  { key = "$", mods = "LEADER|SHIFT", action = action.PromptInputLine
    {
      description = wezterm.format {
        { Attribute  = { Intensity = "Bold"    }},
        { Foreground = { Color = colors.indexed[16] }},
        { Text = "Renaming session/workspace:" }},
      action = wezterm.action_callback(function(_, _, line)
        if line then
          mux.rename_workspace(mux.get_active_workspace(),line)
        end
      end),
    }
  },
}

-- Active tab by index
for i = 1, 9 do
  table.insert(config.keys, { key = tostring(i), mods = "ALT", action = action.ActivateTab(i - 1) })
end

config.key_tables = {
  move = {
    { key = 'r',                          action = action.RotatePanes 'CounterClockwise' },
    { key = 's',                          action = action.PaneSelect                     },
    { key = 'Enter',                      action = 'PopKeyTable'                         },
    { key = 'Escape',                     action = 'PopKeyTable'                         },
    { key = 'LeftArrow',  mods = 'SHIFT', action = action.MoveTabRelative(-1)            },
    { key = 'RightArrow', mods = 'SHIFT', action = action.MoveTabRelative(1)             },
  },

  resize = {
    { key = 'DownArrow',  action = action.AdjustPaneSize { 'Down',  1 } },
    { key = 'LeftArrow',  action = action.AdjustPaneSize { 'Left',  1 } },
    { key = 'RightArrow', action = action.AdjustPaneSize { 'Right', 1 } },
    { key = 'UpArrow',    action = action.AdjustPaneSize { 'Up',    1 } },
    { key = 'Enter',      action = 'PopKeyTable'                        },
    { key = 'Escape',     action = 'PopKeyTable'                        },
  },

  open = {
    { key = "g", action = action {
        QuickSelectArgs = {
          label = "execute 'gcloud auth login --remote-bootstrap'",
          patterns = { "gcloud auth login --remote-bootstrap=\".*\"" },
          scope_lines = 30,
          action = action.EmitEvent "trigger-gcloud-auth"
        }
      },
    },
    { key = "p", action = action.SpawnCommandInNewWindow {
          label = "open current path on file manager",
          args = { "xdg-open", "." },
      }
    },
    { key = "u", action = action {
        QuickSelectArgs = {
          label = "open URL on browser",
          patterns = { "https?://\\S+" },
          scope_lines = 30,
          action = wezterm.action_callback(function(window, pane)
            local url = window:get_selection_text_for_pane(pane)
            wezterm.log_info("opening: " .. url)
            wezterm.open_with(url)
          end)
        }
      },
    },
  }
}

-- Window
config.bold_brightens_ansi_colors = true
config.initial_cols = 200
config.initial_rows = 50
config.text_background_opacity = 0.90
config.window_background_opacity = 0.90
config.window_decorations = "NONE"
config.window_padding = {
  left   = 3,
  right  = 3,
  top    = 10,
  bottom = 3,
}

-- Graphics
config.front_end = "WebGpu"

-- Cursor
config.bypass_mouse_reporting_modifiers = "SHIFT"
config.default_cursor_style = "SteadyBar"
config.hide_mouse_cursor_when_typing = true

config.mouse_bindings = {
  { event = { Down = { streak = 1, button = 'Middle' }}, mods = 'NONE', action = action.PasteFrom("Clipboard") },
  { event = { Down = { streak = 1, button = "Left"   }}, mods = "NONE", action = action.Multiple { action.ClearSelection }},
  { event = { Up   = { streak = 1, button = "Left"   }}, mods = "NONE", action = action.Nop },
  { event = { Up   = { streak = 2, button = "Left"   }}, mods = "NONE", action = action.Multiple { action.CopyTo "ClipboardAndPrimarySelection", action.ClearSelection }},
  { event = { Up   = { streak = 3, button = "Left"   }}, mods = "NONE", action = action.Multiple { action.CopyTo "ClipboardAndPrimarySelection", action.ClearSelection }},
  { event = { Up   = { streak = 1, button = "Left"   }}, mods = "CTRL", action = action.OpenLinkAtMouseCursor  },
}

-- Font
config.font = wezterm.font("JetBrainsMono Nerd Font")
config.font_size = 9

-- Hyperlink
config.hyperlink_rules = wezterm.default_hyperlink_rules()
-- e-mail fulano-ciclano@example.com fulano_ciclano@example.com
table.insert(config.hyperlink_rules,{
  regex = "\\b[A-Z-a-z0-9-_\\.]+@[\\w-]+(\\.[\\w-]+)+\\b",
  format = "mailto:$0",
})

-- Scrolling
config.enable_scroll_bar = false
config.scrollback_lines = 10000
config.alternate_buffer_wheel_scroll_speed = 5

-- Tab
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = false
config.show_new_tab_button_in_tab_bar = false
config.show_tab_index_in_tab_bar = true
config.status_update_interval = 1000
config.tab_bar_at_bottom = false
config.tab_max_width = 64
config.use_fancy_tab_bar = false

-- Launch commands
config.launch_menu = {
  {
    label = "HTTP  8080 - Open URL http://localhost:8080",
    args = { "zen-browser", "--private-window", "http://localhost:8080" },
  },
  {
    label = "HTTPS 8080 - Open URL https://localhost:8080",
    args = { "zen-browser", "--private-window", "https://localhost:8080" },
  },
  {
    label = "HTTPS 8433 - Open URL https://localhost:8433",
    args = { "zen-browser", "--private-window", "https://localhost:8433" },
  }
}

-- Events update status
wezterm.on("update-status", function(window, pane)

  -- Workspace name
  local stat = window:active_workspace()
  local workspace_color = colors.ansi[3]
  local time = wezterm.strftime("%Y-%m-%d %H:%M")

  if window:active_key_table() then
    stat = window:active_key_table()
    workspace_color = colors.ansi[4]
  elseif window:leader_is_active() then
    stat = 'leader'
    workspace_color = colors.ansi[2]
  end

-- Get the home directory path
local home = os.getenv("HOME")

-- Current working directory
local cwd = pane:get_current_working_dir()
if cwd then
  if type(cwd) == "userdata" then
    -- Wezterm introduced the URL object in 20240127-113634-bbcac864
    cwd = cwd.path:gsub("%%20", " ") -- Replace '%20' with a space

    -- Replace home path with "~"
    if home and cwd:sub(1, #home) == home then
      cwd = "~" .. cwd:sub(#home + 1)
    end

    -- Shorten long paths to 32 characters
    if string.len(cwd) > 32 then
      cwd = ".." .. string.sub(cwd, -32, -1)
    end
  end
else
  cwd = ""
end
--
  -- Left status (left of the tab line)
  window:set_left_status(wezterm.format({
    { Background = { Color = colors.background }                },
    { Text       = " "                                          },
    { Background = { Color = colors.background }                },
    { Foreground = { Color = workspace_color }                  },
    { Text       = nerdfonts.ple_left_half_circle_thick         },
    { Background = { Color = workspace_color }                  },
    { Foreground = { Color = colors.ansi[1] }                   },
    { Text       = nerdfonts.cod_terminal_tmux .. " "           },
    { Background = { Color = colors.ansi[1] }                   },
    { Foreground = { Color = colors.foreground }                },
    { Text       = " " .. stat                                  },
    { Background = { Color = colors.background }                },
    { Foreground = { Color = colors.ansi[1] }                   },
    { Text       = nerdfonts.ple_right_half_circle_thick .. " " },
  }))

  -- Right status
  window:set_right_status(wezterm.format({
    -- Wezterm has a built-in nerd fonts
    -- https://wezfurlong.org/wezterm/config/lua/wezterm/nerdfonts.html
    --
    { Text       = " "                                   },
    { Background = { Color = colors.background }         },
    { Foreground = { Color = colors.ansi[5] }            },
    { Text       = nerdfonts.ple_left_half_circle_thick  },
    { Background = { Color = colors.ansi[5] }            },
    { Foreground = { Color = colors.background }         },
    { Text       = nerdfonts.md_folder .. " "            },
    { Background = { Color = colors.ansi[1] }            },
    { Foreground = { Color = colors.foreground }         },
    { Text       = " " .. cwd                            },
    { Background = { Color = colors.background }         },
    { Foreground = { Color = colors.ansi[1] }            },
    { Text       = nerdfonts.ple_right_half_circle_thick },
  }))

end)

-- Events define tab title
wezterm.on("format-tab-title", function(tab)

    local pane = tab.active_pane
    local title = F.tab_title(tab) .. " "
    local tab_number = " " .. tostring(tab.tab_index + 1)

    -- Default tab title
    local icon = nerdfonts.dev_terminal .. " " .. title

    -- Add zoom icon
    if pane.is_zoomed then
      icon = nerdfonts.cod_zoom_in .. " " .. icon
    end

    -- Add copy icon
    if string.find(pane.title,"^Copy mode:") then
      icon = nerdfonts.md_content_copy .. " " .. icon
    end

    if tab.is_active then
      return {
        { Background = { Color = colors.background }                },
        { Foreground = { Color = colors.indexed[16]}                },
        { Text       = icon                                         },
        { Background = { Color = colors.indexed[16]}                },
        { Foreground = { Color = colors.background }                },
        { Text       = tab_number                                   },
        { Background = { Color = colors.background }                },
        { Foreground = { Color = colors.indexed[16]}                },
        { Text       = nerdfonts.ple_right_half_circle_thick .. " " },
      }
    else
      return {
        { Background = { Color = colors.background }                },
        { Foreground = { Color = colors.ansi[1] }                   },
        { Text       = nerdfonts.ple_left_half_circle_thick         },
        { Background = { Color = colors.ansi[1] }                   },
        { Foreground = { Color = colors.foreground }                },
        { Text       = title                                        },
        { Background = { Color = colors.ansi[5] }                   },
        { Foreground = { Color = colors.background }                },
        { Text       = tab_number                                   },
        { Background = { Color = colors.background }                },
        { Foreground = { Color = colors.ansi[5] }                   },
        { Text       = nerdfonts.ple_right_half_circle_thick .. " " },
      }
    end

end)

-- Events when wezterm is started
wezterm.on("gui-startup", function()

    -- Iterate projects
    for _, project in pairs(projects.repositories) do

      -- Create personal's projects
      if project.type == "personal" then
        local _, _, window = mux.spawn_window { workspace = project.workspace, cwd = project.path }
        window:active_tab():set_title(project.name)
        wezterm.log_info('Creating workspace: ' .. project.workspace )
      end

      -- Create work's projects
      if project.type == "work" and custom.hostname.current == custom.hostname.work then

        -- Create workspace and tab
        if project.tabs then

          local _, _, window = mux.spawn_window { workspace = project.workspace, cwd = project.path .. '/' .. project.tabs[1]  }
          window:active_tab():set_title(project.name)
          wezterm.log_info('Creating workspace: ' .. project.workspace )

          for tab = 2, #project.tabs do
            window:spawn_tab { cwd = project.path .. '/' .. project.tabs[tab] }
            wezterm.log_info('Creating tab ' .. project.tabs[tab] .. ' on workspace ' .. project.workspace )
          end

        else

          -- Create workspace
          local _, _, window = mux.spawn_window { workspace = project.workspace, cwd = project.path }
          window:active_tab():set_title(project.name)
          wezterm.log_info('Creating workspace: ' .. project.workspace )

        end

      end

    end

    -- Default workspace
    mux.set_active_workspace(projects.default_workspace)
    wezterm.log_info('Setting default workspace: ' .. projects.default_workspace )

end)

-- Open a new pane and execute gcloud auth login --remote-bootstrap
wezterm.on('trigger-gcloud-auth', function(window, pane)

  -- Get command and url from gcloud
  local cmd = window:get_selection_text_for_pane(pane)
  -- Append command sleep to have some time to copy content
  cmd = cmd .. " " .. "<<< y 2>&1 | grep -E '^https:\\S+' | wl-copy -n"

  -- Open new pane and execute command
  -- Execute
  window:perform_action(
    pane:split {
      direction = 'Bottom',
      label = 'execute gcloud auth --remote-bootstrap',
      args = { 'bash', '-c', cmd }
    },
    pane
  )

end)

wezterm.on('toggle-compose', function(window, pane)
  local overrides = window:get_config_overrides() or {}

  overrides.colors = config.colors

  if window:active_key_table() then
    overrides.colors.cursor_bg = colors.ansi[4]
  else
    overrides.colors.cursor_bg = colors.ansi[3]
  end

  window:set_config_overrides(overrides)

end)

wezterm.on('toggle-opacity-minus', function(window, pane)
  local overrides = window:get_config_overrides() or {}

  if window:get_config_overrides() then
    overrides.text_background_opacity   = tonumber(string.format("%.2f",window:get_config_overrides().text_background_opacity))
    overrides.window_background_opacity = tonumber(string.format("%.2f",window:get_config_overrides().window_background_opacity))
  else
    overrides.text_background_opacity   = config.text_background_opacity
    overrides.window_background_opacity = config.window_background_opacity
  end

  if overrides.window_background_opacity > 0 and overrides.window_background_opacity <= 1 then
    overrides.text_background_opacity   = overrides.text_background_opacity   - 0.10
    overrides.window_background_opacity = overrides.window_background_opacity - 0.10
    window:set_config_overrides(overrides)
  end
end)

wezterm.on('toggle-opacity-plus', function(window, pane)
  local overrides = window:get_config_overrides() or {}

  if window:get_config_overrides() then
    overrides.text_background_opacity   = tonumber(string.format("%.2f",window:get_config_overrides().text_background_opacity))
    overrides.window_background_opacity = tonumber(string.format("%.2f",window:get_config_overrides().window_background_opacity))
  else
    overrides.text_background_opacity   = config.text_background_opacity
    overrides.window_background_opacity = config.window_background_opacity
  end

  if overrides.window_background_opacity >= 0 and overrides.window_background_opacity < 1 then
    overrides.text_background_opacity   = overrides.text_background_opacity   + 0.10
    overrides.window_background_opacity = overrides.window_background_opacity + 0.10
    window:set_config_overrides(overrides)
  end
end)

wezterm.on('toggle-opacity-reset', function(window, pane)
  local overrides = window:get_config_overrides() or {}

  overrides.text_background_opacity   = config.text_background_opacity
  overrides.window_background_opacity = config.window_background_opacity
  window:set_config_overrides(overrides)

end)

wezterm.on('set-previous-workspace', function(window, pane)
  local current_workspace = window:active_workspace()

  if wezterm.GLOBAL.previous_workspace ~= current_workspace then
    wezterm.GLOBAL.previous_workspace = current_workspace
  end

end)

config.color_scheme = 'Tokyo Night'

return config

