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

  -- Displays live on SUPER+CTRL+ALT: shift+ctrl - hjkl belongs to apps on
  -- Linux (word selection, browser devtools).
  o.bind("SUPER + CTRL + ALT + " .. key, "Focus monitor " .. name, hl.dsp.focus({ monitor = direction }))
end

-- Move window to the display on the left/right/top/bottom and follow it.
for key, direction in pairs({ LEFT = "l", DOWN = "d", UP = "u", RIGHT = "r" }) do
  o.bind(
    "SUPER + CTRL + ALT + " .. key,
    "Move window to monitor " .. direction_names[direction],
    hl.dsp.window.move({ monitor = direction })
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

-- ctrl + alt - r: reload Hyprland.
o.bind("CTRL + ALT + R", "Reload Hyprland", "hyprctl reload")
