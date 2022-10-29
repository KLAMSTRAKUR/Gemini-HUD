if string.sub((text),1,3) == 'tag' then
   setTag(text)
   transponder.deactivate()
   unit.setTimer('tr',2)
end

if shield.getResistancesCooldown() == 0 then
   if text == "l" then
      system.print("LASER PROFILE: 50/50%")
      shield.setResistances(0,resMAX/2,0,resMAX/2)
      local res = {0,1,0,1}
      actionRes(res)
   end
   if text == "c" then
      system.print("CANNON PROFILE: 50/50%")
      shield.setResistances(0,0,resMAX/2,resMAX/2)
      local res = {0,0,1,1}
      actionRes(res)
   end
   if text == "m" then
      system.print("MISSILE PROFILE: 50/50%")
      shield.setResistances(resMAX/2,0,resMAX/2,0)
      local res = {1,0,1,0}
      actionRes(res)
   end
   if text == "r" then
      system.print("RAILGUN PROFILE: 50/50%")
      shield.setResistances(resMAX/2,resMAX/2,0,0)
      local res = {1,1,0,0}
      actionRes(res)
   end
end
if text =="drop" then
   local listships = core.getDockedConstructs()
   for i=1, #listships do
      core.forceUndock(listships[i])
   end
   system.print("All ships were successfully undocked")
end

if string.find (text,'m::pos') then
   coratinka=1
   asteroidcoord = zeroConvertToWorldCoordinates(asteroidPOS)
   asteroidPOS = text:sub(2)
   databank_1.setStringValue(15,asteroidPOS)
   system.print("The marker was added to the map and saved to the databank")
   function ct()
      while true do
         local i=0
         local ClosestPlanet={}
         destination_bm=asteroidPOS
         destination_wp=zeroConvertToWorldCoordinates(destination_bm,system)
         ClosestPlanet.globalpipedistance=999999999999

         ClosestPlanet.name, ClosestPlanet.distance = getClosestPlanet1(destination_wp)
         for BodyId in pairs(atlas[0]) do
            i=i+1
            local startLocation=atlas[0][BodyId]
            ClosestPlanet.pipename, ClosestPlanet.pipedistance=getClosestPipe1(destination_wp, startLocation)
            if ClosestPlanet.pipedistance<ClosestPlanet.globalpipedistance then
               ClosestPlanet.globalpipedistance=ClosestPlanet.pipedistance
               ClosestPlanet.globalpipestart=startLocation.name[1]
               ClosestPlanet.globalpipestop=ClosestPlanet.pipename
            end
            if i > 5 then
               i = 0
               coroutine.yield()
            end
         end
         local SafeZoneDistance=getSafeZoneDistance(destination_wp)
         if SafeZoneDistance < 0 then
            ClosestDSafeZoneMessage="in safe-zone!"
         else
            ClosestDSafeZoneMessage=customDistance(SafeZoneDistance).. " to safe-zone"

         end
         posmessage="Closest pipe: "..ClosestPlanet.globalpipestart.." - "..ClosestPlanet.globalpipestop.." ("..customDistance(ClosestPlanet.globalpipedistance).."), closest planet: "..ClosestPlanet.name.." ("..customDistance(ClosestPlanet.distance).."), "..ClosestDSafeZoneMessage
         system.print(posmessage)

         coroutine.yield()
         coratinka=0
      end


   end
   ck = coroutine.create(ct)
end