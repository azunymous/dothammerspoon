utilities = require("utilities");
suika = require("suika.main");
settings = require("settings");

-- Setup utilities
utilities.setup()
-- Update menubar 
-- hs.timer.doEvery(20, function()
--     utilities.menuplaying:setTitle(utilities.nowplaying())
-- end) 
local hyper = {"cmd", "ctrl", "alt", "shift"}

hs.hotkey.bind({"cmd", "alt", "ctrl", "shift"}, "H", function()
  suikon = suika.drunk()
  suika.alert("hello 名無し", suikon)
end)

-- Turn off Window animation
hs.window.animationDuration = 0.2

-- Open Applications
-- iTerm
hs.hotkey.bind(hyper, 'return', function() 
	if hs.application.find('com.googlecode.iterm2') or hs.application.find('/Applications/Terminal.app') then
		suika.alert('New Terminal window opened')
    hs.osascript.applescript([[
      tell application "iTerm2"
        create window with default profile
      end tell
    ]])
  else
    suika.alert('Terminal launched')
    hs.application.launchOrFocus('/Applications/Terminal.app')
	end
end)

-- -- Finder (not needed - Alfred used instead)
-- hs.hotkey.bind(hyper, 'delete', function() 
--   if hs.application.find('Finder') then
--     suika.alert('New Finder window opened')
--     hs.applescript.applescript([[
--       tell application "Finder" to make new Finder window
--     ]])
--     hs.application.launchOrFocus('Finder')  
--   else
--     suika.alert('Finder launched')
--     hs.application.launchOrFocus('Finder')
--   end
-- end)

-- Switch applications

-- Hint Switch
-- hs.hotkey.bind(hyper, 'tab', function()

-- end 
-- )

hs.hotkey.bind(hyper, '1', function()
  -- if hs.application.frontmostApplication():path() == '/Applications/Terminal.app' then
  --   hs.application.frontmostApplication():hide()
  -- else
  if hs.application.find('iTerm') then
    hs.application.launchOrFocus('/Applications/Terminal.app')
   end
end 
)

hs.hotkey.bind(hyper, '2', function() 
  -- if hs.application.frontmostApplication():name() == 'Firefox' then
  --   hs.application.frontmostApplication():hide()
  -- else
  if hs.application.find('Firefox') then
    hs.application.launchOrFocus('/Applications/Firefox.app')
  end
end 
)

hs.hotkey.bind(hyper, '3', function() 
  -- if hs.application.frontmostApplication():name() == 'Sublime Text' then
  --   hs.application.frontmostApplication():hide()
  -- else
  if hs.application.find('Sublime Text') then
    hs.application.launchOrFocus('Sublime Text')
  end
end 
)

hs.hotkey.bind(hyper, '4', function() 
  -- if hs.application.frontmostApplication():name() == 'Sublime Text' then
  --   hs.application.frontmostApplication():hide()
  -- else
  if hs.application.find('Adium') then
    hs.application.launchOrFocus('Adium')
  end
end 
)

hs.hotkey.bind(hyper, '5', function() 
  -- if hs.application.frontmostApplication():name() == 'Dash' then
  --   hs.application.frontmostApplication():hide()
  -- else
  if hs.application.find('TaskPaper') then
    hs.application.launchOrFocus('TaskPaper')
  end
end 
)

hs.hotkey.bind(hyper, '8', function() 
  -- if hs.application.frontmostApplication():name() == 'Dash' then
  --   hs.application.frontmostApplication():hide()
  -- else
  if hs.application.find('Dash') then
    hs.application.launchOrFocus('Dash')
  end
end 
)

hs.hotkey.bind(hyper, '9', function() 
  -- if hs.application.frontmostApplication():name() == 'Finder' then
  --   hs.application.frontmostApplication():hide()
  -- else
  if hs.application.find('Finder') then
    hs.application.launchOrFocus('Finder')
  end
end 
)

-- Layouts
hs.hotkey.bind(hyper, 'F1', function()
    local laptopScreen = "Color LCD"
    local windowLayout = {
        {"Firefox",  nil,          laptopScreen, hs.layout.left50,    nil, nil},
        {"Sublime Text",    nil,    laptopScreen, hs.layout.right50,   nil, nil},
        {"iTerm2",  nil, laptopScreen, hs.geometry.rect(0, 0.5, 0.5, 0.5), nil, nil}
        --{"iTunes",  "MiniPlayer", laptopScreen, nil, nil, hs.geometry.rect(0, -48, 400, 48)},
    }
    hs.layout.apply(windowLayout)
end)

-- Reset positioning vars on win change
function updatevars()
  if(utilities.checkwinchange() == true) then
    sizecount = 0
    esmall = false
    qsmall = false
    zsmall = false
    csmall = false
  end
end

function resetvars(key)
  if(key ~= 'q') then
    qsmall = false
  end
  if(key ~= 'e') then
    esmall = false
  end
  if(key ~= 'z') then
    zsmall = false
  end
  if(key ~= 'c') then
    csmall = false
  end
  if(key ~= 'a' and key ~= 'd') then
    sizecount = 0
  end
end

-- Window Sizing/Positioning (WASD) (QEZC/F)
hs.hotkey.bind(hyper, "W", function()
  updatevars()
  resetvars('w')
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()
  f.x = max.x
  f.y = max.y
  f.w = max.w
  f.h = max.h / 2
  win:setFrame(f)
end)

hs.hotkey.bind(hyper, "A", function()
  updatevars()
  resetvars('a')
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  if(sizecount == nil or sizecount > 2 or sizecount < 0 ) then
  	sizecount = 0;
  end
  sizecount = sizecount + 1

  if sizecount == 1 then
  	multiplier = 1/2
  elseif sizecount == 2 then
  	multiplier = 2/3
  else
  	multiplier = 1/3
  end

  f.x = max.x
  f.y = max.y
  f.w = max.w * multiplier
  f.h = max.h
  win:setFrame(f)
end)

hs.hotkey.bind(hyper, "S", function()
  updatevars()
  resetvars('s')
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()
  f.x = max.x 
  f.y = max.y + (max.h / 2)
  f.w = max.w
  f.h = max.h / 2
  win:setFrame(f)
end)

hs.hotkey.bind(hyper, "D", function()
  updatevars()
  resetvars('d')
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()


  if(sizecount == nil or sizecount > 0 or sizecount < -2 ) then
  	sizecount = 0;
  end
  sizecount = sizecount - 1

  if sizecount == -1 then
  		multiplier = 1/2
  		f.x = max.x + (max.w / 2)
  elseif sizecount == -2 then
  		multiplier = 2/3
  		f.x = max.x + (max.w * (1/3))
  else
  		multiplier = 1/3
  		f.x = max.x + (max.w * (2/3))
  end

  f.y = max.y
  f.w = max.w * multiplier
  f.h = max.h
  win:setFrame(f)
end)

---- Corners

hs.hotkey.bind(hyper, "Q", function()
  updatevars()
  resetvars('q')
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()
  qsmall = qsmall or false

  if(qsmall == false) then
    f.x = max.x
    f.y = max.y
    f.w = max.w / 2
    f.h = max.h / 2
    win:setFrame(f)
  else
    f.x = max.x
    f.y = max.y
    f.w = max.w / 3
    f.h = max.h / 3
    win:setFrame(f)
  end
  qsmall = not qsmall
end)

hs.hotkey.bind(hyper, "E", function()
  updatevars()
  resetvars('e')
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()
  esmall = esmall or false

  if(esmall == false) then
    f.x = max.x + (max.w / 2)
    f.y = max.y
    f.w = max.w / 2
    f.h = max.h / 2
  else
    f.x = max.x + (max.w * (2/3))
    f.y = max.y
    f.w = max.w / 3
    f.h = max.h / 3
  end
  win:setFrame(f)
  esmall = not esmall
end)

hs.hotkey.bind(hyper, "Z", function()
  updatevars()
  resetvars('z')
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()
  zsmall = zsmall or false

  if(zsmall == false) then
    f.x = max.x 
    f.y = max.y + (max.h / 2)
    f.w = max.w / 2
    f.h = max.h / 2
  else
    f.x = max.x 
    f.y = max.y + (max.h * 2/3)
    f.w = max.w / 3
    f.h = max.h / 3
  end
  win:setFrame(f)
  zsmall = not zsmall
end)

hs.hotkey.bind(hyper, "C", function()
  updatevars()
  resetvars('c')
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()
  csmall = csmall or false

  if(csmall == false) then
    f.x = max.x + (max.w / 2)
    f.y = max.y + (max.h / 2)
    f.w = max.w / 2
    f.h = max.h / 2
  else
    f.x = max.x + (max.w * 2/3)
    f.y = max.y + (max.h * 2/3)
    f.w = max.w / 3
    f.h = max.h / 3
  end
  win:setFrame(f)
  csmall = not csmall
end)


hs.hotkey.bind(hyper, "N", function()
  updatevars()
  resetvars('n')
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()
  f.x = max.x + (max.w * 5/8)
  f.y = max.y + (max.h * 6.4/8)
  f.w = max.w * 3/8
  f.h = max.h * 1.6/8

  f.y = f.y - 12

  win:setFrame(f)
end)

---- Full Screen & Centre

hs.hotkey.bind(hyper, "F", function()
  updatevars()
  resetvars('f')
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()
  f.x = max.x
  f.y = max.y
  f.w = max.w
  f.h = max.h
  win:setFrame(f)
end)

hs.hotkey.bind(hyper, "R", function()
  updatevars()
  resetvars('r')
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()
  sizecount = 0;
  win:centerOnScreen()
end)

-- END

-- -- Window manual resizing (YUOP)
shrinkfright = function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()
  sizecount = 0;
  f.w = f.w - 5
  f.h = f.h
  win:setFrame(f)
end
hs.hotkey.bind(hyper, "O", shrinkfright, nil, shrinkfright )

-- expandfright = function()
--   local win = hs.window.focusedWindow()
--   local f = win:frame()
--   local screen = win:screen()
--   local max = screen:frame()
--   sizecount = 0;
--   f.w = f.w +5
--   f.h = f.h
--   win:setFrame(f)
-- end
-- hs.hotkey.bind(hyper, "P", expandfright, nil, expandfright )

shrinkfleft = function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()
  sizecount = 0;
  f.x = f.x + 5
  f.w = f.w - 5
  f.h = f.h
  win:setFrame(f)
end
hs.hotkey.bind(hyper, "U", shrinkfleft, nil, shrinkfright )

expandfleft = function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()
  sizecount = 0;
  f.x = f.x - 5
  f.w = f.w + 5
  f.h = f.h
  win:setFrame(f)
end
hs.hotkey.bind(hyper, "Y", expandfleft, nil, expandfright )

-- -- END

-- Window Shifting (IJKL)
hs.hotkey.bind(hyper, "J", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  sizecount = 0;
  f.x = f.x - 10
  win:setFrame(f)
end)

hs.hotkey.bind(hyper, "L", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  sizecount = 0;
  f.x = f.x + 10
  win:setFrame(f)
end)

hs.hotkey.bind(hyper, "I", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  sizecount = 0;
  f.y = f.y - 10
  win:setFrame(f)
end)

hs.hotkey.bind(hyper, "K", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  sizecount = 0;
  f.y = f.y + 10
  win:setFrame(f)
end)

-- END

-- Now Playing
hs.hotkey.bind(hyper, "P", function()
  suikon = suika.drunk()
  suika.nowplaying()
  -- suika.alert("Now Playing: " .. utilities.nowplaying(), suikon)
end)



-- Reload config when it changes
function reloadConfig(files)
    doReload = false
    for _,file in pairs(files) do
        if file:sub(-4) == ".lua" then
            doReload = true
        end
    end
    if doReload then
        hs.reload()
    end
end
hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()

hs.hotkey.bind(hyper, "f11", function()
  hs.application.launchOrFocus("Hammerspoon")
end)
hs.hotkey.bind(hyper, "f12", function()
  hs.reload()
end)

geassgif=hs.drawing.image(hs.geometry.rect(640-256/2, 360-192, 256, 192), os.getenv("HOME") .. "/.hammerspoon/img/geass.gif") 
geassgif:show()
hs.timer.doAfter(0.95, function()
  geassgif:delete()
end) 
suika.alert("Config loaded")

