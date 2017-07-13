settings = require("settings");
local utilities={}

-- functions go here
function utilities.nowplaying()
	-- local nowplaying = hs.execute("/usr/local/bin/mpc status | awk 'NR==2' | grep -Eq 'playing|paused' && /usr/local/bin/mpc current", true)
	-- if string.len(nowplaying) == 0 then
	-- 	nowplaying = "Nothing Playing~"
	-- else
	-- 	nowplaying = nowplaying:sub(1, -2)
	-- end
	-- return nowplaying;
end

function utilities.setup()
	hs.hints.fontName = settings.font
	hs.hints.fontSize = 11
	hs.hints.style = "vimperator"
	utilities.currentwindow = hs.window.focusedWindow()
end

function utilities.checkwinchange()
	local currentwindow = hs.window.focusedWindow()
	if(utilities.currentwindow == currentwindow) then
		return false
	else 
		utilities.currentwindow = currentwindow
		return true
	end
end

function utilities.bar(color)
	local color = "\""..color.."\""
	hs.osascript.applescript("tell application \"AnyBar\" to set image name to "..color.."")
end

-- AZUSTICK Connect
function azustick( usb )
	if(usb.eventType == "added" and usb.productName == settings.usbname and usb.productID == settings.usbproductid ) then
		suika.alert(usb.productName .. " " .. usb.productID .. " connected. \n Starting Sync")
		hs.timer.doAfter(10, function()
			os.execute( settings.usbcommand )
			suika.alert("Sync Complete")
		end)
	end
	azuwatcher:stop()
	azuwatcher:start()
end

azuwatcher = hs.usb.watcher.new(azustick):start()

return utilities