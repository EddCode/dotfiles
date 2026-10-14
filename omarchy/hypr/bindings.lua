-- Keep only your personal keybinding overrides here. Add new bindings or
-- unbind defaults before replacing them.

-- See current bindings and descriptions:
--   omarchy menu keybindings --print

-- To disable every Omarchy default binding, set this in
-- ~/.config/hypr/hyprland.lua before require("default.hypr.omarchy"), then add
-- only the bindings you want below:
--   omarchy_default_bindings = false

-- To disable all preinstalled app/webapp bindings, set:
--   omarchy_preinstalled_bindings = false

-- Add a new binding.
-- o.bind("SUPER + SHIFT + R", "SSH", "alacritty -e ssh your-server")

-- Change an existing binding by unbinding it first, then binding the key again.
-- This example changes SUPER+SPACE from the launcher to the Omarchy root menu.
-- hl.unbind("SUPER + SPACE")
-- o.bind("SUPER + SPACE", "Omarchy menu", "omarchy-menu toggle root")

-- Disable a default binding without replacing it.
-- hl.unbind("SUPER + SHIFT + B")

-- Logitech MX Keys examples:
-- o.bind("SUPER + SHIFT + S", nil, "omarchy-capture-screenshot")
-- o.bind("SUPER + H", nil, "voxtype record toggle")
-- o.bind("SUPER + PERIOD", nil, "omarchy-shell shell toggle omarchy.emojis")

-- ---------------------------------------------------------------------------
-- Window management on ALT, mirrored on macOS by ../../aerospace.toml.
-- Omarchy's own SUPER bindings are left untouched.
-- ---------------------------------------------------------------------------

local directions = { H = "l", J = "d", K = "u", L = "r" }
local direction_names = { l = "left", d = "down", u = "up", r = "right" }

local function monitor_in_direction(direction)
  local active = hl.get_active_monitor()
  local active_x = active.x + active.width / 2
  local active_y = active.y + active.height / 2
  local target, target_distance

  for _, monitor in ipairs(hl.get_monitors()) do
    if monitor.name ~= active.name then
      local dx = monitor.x + monitor.width / 2 - active_x
      local dy = monitor.y + monitor.height / 2 - active_y
      local in_direction =
        (direction == "l" and dx < 0)
        or (direction == "r" and dx > 0)
        or (direction == "u" and dy < 0)
        or (direction == "d" and dy > 0)

      if in_direction then
        local distance = dx * dx + dy * dy
        if not target_distance or distance < target_distance then
          target = monitor
          target_distance = distance
        end
      end
    end
  end

  return target
end

local function focus_monitor_direction(direction)
  local target = monitor_in_direction(direction)
  if target then hl.dispatch(hl.dsp.focus({ monitor = target.name })) end
end

local function move_window_to_monitor_direction(direction)
  local target = monitor_in_direction(direction)
  if target then hl.dispatch(hl.dsp.window.move({ monitor = target.name })) end
end

-- Note: SHIFT+ALT+L is also the "Copy URL" shortcut inside Omarchy web apps.
-- The swap binding below takes it over globally.

for key, direction in pairs(directions) do
  local name = direction_names[direction]

  -- alt - hjkl: change window focus within the workspace.
  o.bind("ALT + " .. key, "Focus window " .. name, hl.dsp.focus({ direction = direction }))

  -- shift + alt - hjkl: swap windows.
  o.bind("SHIFT + ALT + " .. key, "Swap window " .. name, hl.dsp.window.swap({ direction = direction }))

  -- ctrl + alt - hjkl: move window and split.
  o.bind("CTRL + ALT + " .. key, "Move window " .. name, hl.dsp.window.move({ direction = direction }))

  -- ctrl + shift - hjkl: focus the monitor in that direction.
  hl.unbind("SUPER + CTRL + ALT + " .. key)
  o.bind("CTRL + SHIFT + " .. key, "Focus monitor " .. name, function()
    focus_monitor_direction(direction)
  end)
end

-- Move window to the nearest display in the indicated direction and follow it.
for key, direction in pairs(directions) do
  hl.unbind("SUPER + CTRL + ALT + " .. ({ l = "LEFT", d = "DOWN", u = "UP", r = "RIGHT" })[direction])
  hl.unbind("SUPER + ALT + " .. key)
  o.bind(
    "SUPER + ALT + " .. key,
    "Move window to monitor " .. direction_names[direction],
    function() move_window_to_monitor_direction(direction) end
  )
end

-- shift + alt - r: rotate layout.
o.bind("SHIFT + ALT + R", "Rotate split", hl.dsp.layout("rotatesplit"))

-- shift + alt - y / x: dwindle cannot mirror the whole tree, so these swap the
-- two sides of the current split / change its orientation.
o.bind("SHIFT + ALT + Y", "Flip split sides", hl.dsp.layout("swapsplit"))
o.bind("SHIFT + ALT + X", "Flip split orientation", hl.dsp.layout("togglesplit"))

-- shift + alt - t: toggle float, centered at half the monitor size.
o.bind("SHIFT + ALT + T", "Toggle centered floating window", function()
  hl.dispatch(hl.dsp.window.float({ action = "toggle" }))

  local window = hl.get_active_window()
  local monitor = hl.get_active_monitor()
  if window and window.floating and monitor then
    hl.dispatch(hl.dsp.window.resize({ x = math.floor(monitor.width / 2), y = math.floor(monitor.height / 2) }))
    hl.dispatch(hl.dsp.window.center())
  end
end)

-- shift + alt - p / n: move window to previous / next workspace.
o.bind("SHIFT + ALT + P", "Move window to previous workspace", hl.dsp.window.move({ workspace = "r-1" }))
o.bind("SHIFT + ALT + N", "Move window to next workspace", hl.dsp.window.move({ workspace = "r+1" }))

-- shift + alt - 1..9: move window to workspace N.
for workspace = 1, 9 do
  o.bind(
    "SHIFT + ALT + code:" .. tostring(workspace + 9),
    "Move window to workspace " .. workspace,
    hl.dsp.window.move({ workspace = tostring(workspace) })
  )
end

-- Keep existing workspace IDs in place and assign each monitor five unique
-- IDs. New workspaces are created on whichever monitor currently has focus.
local workspace_count = 5
local monitor_workspaces = {
  ["DP-1"] = { 1, 2, 5, 6, 7 },
  ["DP-2"] = { 3, 8, 9, 10, 11 },
  ["DVI-I-1"] = { 4, 12, 13, 14, 15 },
  ["eDP-1"] = { 16, 17, 18, 19, 20 },
}

local function focused_monitor_workspaces()
  local monitor = hl.get_active_monitor()
  local workspaces = monitor and monitor_workspaces[monitor.name]
  if not workspaces then
    error("No workspace IDs configured for focused monitor " .. tostring(monitor and monitor.name or "unknown"))
  end
  return workspaces
end

local function focus_local_workspace(index)
  local workspaces = focused_monitor_workspaces()
  hl.dispatch(hl.dsp.focus({ workspace = tostring(workspaces[index]) }))
end

local function step_workspace(delta)
  return function()
    local workspaces = focused_monitor_workspaces()
    local workspace = hl.get_active_workspace()
    local current_index
    for index, workspace_id in ipairs(workspaces) do
      if workspace and workspace.id == workspace_id then
        current_index = index
        break
      end
    end

    if not current_index then
      error("Focused workspace is outside the configured range for its monitor")
    end

    local target_index = current_index + delta
    if target_index >= 1 and target_index <= workspace_count then
      focus_local_workspace(target_index)
    end
  end
end

-- SUPER+1..5 select the corresponding local workspace. Disable the remaining
-- default numeric workspace shortcuts so they cannot jump to another monitor.
for workspace = 1, 10 do
  local key = "SUPER + code:" .. tostring(workspace + 9)
  hl.unbind(key)
  if workspace <= workspace_count then
    local index = workspace
    o.bind(key, "Switch to local workspace " .. workspace, function()
      focus_local_workspace(index)
    end)
  end
end

-- Keep every built-in sequential workspace shortcut monitor-local as well.
hl.unbind("SUPER + TAB")
hl.unbind("SUPER + SHIFT + TAB")
hl.unbind("SUPER + CTRL + TAB")
hl.unbind("SUPER + mouse_down")
hl.unbind("SUPER + mouse_up")
o.bind("SUPER + TAB", "Next workspace on focused monitor", step_workspace(1))
o.bind("SUPER + SHIFT + TAB", "Previous workspace on focused monitor", step_workspace(-1))
o.bind("SUPER + CTRL + TAB", "Previous workspace on focused monitor", step_workspace(-1))
o.bind("SUPER + mouse_down", "Next workspace on focused monitor", step_workspace(1))
o.bind("SUPER + mouse_up", "Previous workspace on focused monitor", step_workspace(-1))

-- ctrl + left / right: previous / next workspace, like macOS.
o.bind("CTRL + LEFT", "Previous workspace", step_workspace(-1))
o.bind("CTRL + RIGHT", "Next workspace", step_workspace(1))

-- super + shift - a: Claude desktop instead of Omarchy's ChatGPT web app.
hl.unbind("SUPER + SHIFT + A")
o.bind("SUPER + SHIFT + A", "Claude", { launch = "claude-desktop", focus = "^com\\.anthropic\\.Claude$" })

-- ctrl + alt - r: reload Hyprland.
o.bind("CTRL + ALT + R", "Reload Hyprland", "hyprctl reload")
