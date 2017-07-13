local settings={}

settings.usbname = ""
settings.usbproductid = 0000
settings.usbcommand = "echo Hello Suika" .. os.getenv("HOME") .. "/.hammerspoon/suikalog.txt"

settings.font = 'Tewimedium'
return settings