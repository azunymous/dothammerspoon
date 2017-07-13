local suika = {}

-- hs.alert("「" .. string .. "」")

-- Alert / Notification System
suika.log = {}
suika.timer = hs.timer.new(1, function() end)
suika.timer:stop()

function suika.show(string, suikon)
	string = string or ""
	suikon = suikon or "standard.png"

	bg = hs.drawing.image(hs.geometry.rect(0, -75, 1280, 800), os.getenv("HOME") .. "/.hammerspoon/img/bg.png") 
	suikaico = hs.drawing.image(hs.geometry.rect(0, -75, 1280, 800), os.getenv("HOME") .. "/.hammerspoon/img/" .. suikon )
	text = hs.drawing.text(hs.geometry.rect(440, 45, 470, 40), "「" .. string .. "」")
	text:setTextFont("tewi")
	text:setTextSize(12) 

	bg:show()
	suikaico:show() 
	text:show()
end

function suika.hide()
	bg:hide(0.15)
	suikaico:hide(0.15)
	text:hide(0.15)
end

function suika.delete()
	suika.hide()
	hs.timer.doAfter(0.15, function()
		text:delete()
	end)
end

function suika.drunk(units)
	rand = units or math.random(20);
	suikon = "standard.png"
	if rand <= 12 then 
		suikon = "standard.png"
	elseif rand > 12 and rand <= 17 then
		suikon = "drool.png"
	elseif rand > 17 and rand <= 19 then
		suikon = "maxdrool.png"
	elseif rand == 20 then
		suikon = "fainted.png"
	end
	return suikon
end

function suika.alert(string, suikon)
	if suika.time ~= nil or suika.timer:running() then
		-- print("Alert up already")
		suika_timer = hs.timer.doAfter(suika.timer:nextTrigger()+2.01, function()
			suika.alert(string, suikon)
		end)

	else
		suika.show(string, suikon)
		os.execute("echo " .. string .. " >> " .. os.getenv("HOME") .. "/.hammerspoon/suikalog.txt")
		suika.timer = hs.timer.doAfter(2, suika.delete) 
	end
end

function suika.nowplaying()
	local playing = hs.execute("mpc current", true)
	if string.len(playing) == 0 then
		suika.alert("Nothing Playing~")
	else
		playing = playing:sub(1, -2)
		suika.alert(playing)
	end
end

-- END

-- Logic


-- END


-- Hotkey Binds
-- hs.hotkey.bind({"cmd", "alt", "ctrl", "shift"}, "H", function()
-- 	suikon = suika.drunk()
-- 	suika.alert("hello 名無し", suikon)
--   -- hs.notify.new({title="Hammerspoon", informativeText="Hello World"}):send()
-- end)

-- END

-- URL Binds
hs.urlevent.bind("nowplaying", function(eventName, params)
  suika.nowplaying()
end)

-- URL Binds
hs.urlevent.bind("suika", function(eventName, params)
	if params["string"] or params["suikon"] then
		suika.alert(params["string"], params["suikon"])
	elseif params["string"] then
		suika.alert(params["string"])
	end
end)

return suika