start:
buttonSpace=true
if buttonC==true then mRadar:stopC() end
if shift == true then altUP(unit,system,text) end
if gearB == true then
    helper = not helper
    system.setScreen(helpHTML)
end
stop:
buttonSpace = false
helper = not helper