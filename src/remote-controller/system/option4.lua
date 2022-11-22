start:
if upB == true and shield.getResistancesCooldown() == 0 then
   local resistance = shield.getResistances()
   local res = {0,0,resMAX,0}
   if resistance[1] ~= res[1] or
   resistance[2] ~= res[2] or
   resistance[3] ~= res[3] or
   resistance[4] ~= res[4] then
      if shield.setResistances(0,0,resMAX,0) == 1 then
         system.print("KINETIC POWER 100%")
         actionRes(res)
         system.playSound('shieldNewResists.mp3')
      else
         system.print("ERR6")
         system.playSound('shieldResistError.mp3')
      end
   else
      system.print("ERR7")
      system.playSound('shieldResistError.mp3')
   end
end

if downB == true and shield.getResistancesCooldown() == 0 then
   local resistance = shield.getResistances()
   local res = {resMAX/4,resMAX/4,resMAX/4,resMAX/4}
   if resistance[1] ~= res[1] or
   resistance[2] ~= res[2] or
   resistance[3] ~= res[3] or
   resistance[4] ~= res[4] then
      if shield.setResistances(resMAX/4,resMAX/4,resMAX/4,resMAX/4) == 1 then
         system.print("UNIVERSAL PROFILE 25/25/25/25%")
         actionRes(res)
         system.playSound('shieldNewResists.mp3')
      else
         system.print("ERR6")
         system.playSound('shieldResistError.mp3')
      end
   else
      system.print("ERR7")
      system.playSound('shieldResistError.mp3')
   end
end