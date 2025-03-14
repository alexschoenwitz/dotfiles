local hotkey = require("hs.hotkey")

-- hyper key
local hyper = { "alt", "ctrl", "cmd", "shift" }

-- disable anymations
hs.window.animationDuration = 0

hotkey.bind(hyper, ";", function()
  hs.reload()
end)

hs.alert.show("Config loaded")

-- middle left
hs.hotkey.bind(hyper, "Left", function()
  hs.window.focusedWindow():moveToUnit({ 0, 0, 0.5, 1 })
end)

-- middle right
hs.hotkey.bind(hyper, "Right", function()
  hs.window.focusedWindow():moveToUnit({ 0.5, 0, 0.5, 1 })
end)

-- centralize at 80% screen size
hotkey.bind(hyper, "Down", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local max = win:screen():frame()

  f.x = max.x * 0.8
  f.y = max.y * 0.8
  f.w = max.w * 0.8
  f.h = max.h * 0.8

  win:setFrame(f)
  win:centerOnScreen()
end)

-- maximize
hotkey.bind(hyper, "Up", function()
  hs.window.focusedWindow():moveToUnit({ 0, 0, 1, 1 })
end)

hotkey.bind(hyper, "I", function()
  hs.application.launchOrFocus("Safari")
end)


local function handleAppLaunch(app, appName)
  local screen = hs.screen:primaryScreen():getUUID()
  local spaces = hs.spaces.allSpaces()[screen]
  while #spaces < 3 do
    hs.spaces.addSpaceToScreen(screen)
    spaces = hs.spaces.allSpaces()[screen]
  end

  local apps = {
    ["Safari"] = 1,
    ["Ghostty"] = 1,
  }

  print(appName)

  if apps[appName] then
    local space = spaces[apps[appName]]
    local window = app:mainWindow()
    hs.spaces.moveWindowToSpace(window, space)
    window:focus()
    -- if space ~= hs.spaces.activeSpaceOnScreen(hs.screen.primaryScreen()) then
    --   hs.spaces.gotoSpace(spaces[space])
    -- end
  end
end

---needs to be a global var otherwise it gets garbage collected apparently
---@diagnostic disable-next-line: lowercase-global
appwatcher = hs.application.watcher
  .new(function(appName, event, app)
    if event == hs.application.watcher.launched then
      handleAppLaunch(app, appName)
    end
  end)
  :start()
