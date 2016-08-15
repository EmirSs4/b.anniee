if GetObjectName(GetMyHero()) ~= "Annie" then return end


require("OpenPredict")	

local AnnieMenu = Menu("Annie", "Annie")
AnnieMenu:SubMenu("Combo", "Combo")	
AnnieMenu.Combo:Boolean("Q", "Use Q", true)
AnnieMenu.Combo:Boolean("W", "Use W", true)
AnnieMenu.Combo:Boolean("E", "Use E ", true)	
AnnieMenu.Combo:Boolean("R", "Use R", true)	
AnnieMenu.Combo:Boolean("KSQ", "Killsteal with Q", true)
AnnieMenu.Combo:Boolean("UOP", "Use OpenPredict for R", true)	
AnnieMenu.Combo:Boolean("stun", "LaneClear while StunUP", true)
AnnieMenu:SubMenu("draw", "Draws")
AnnieMenu.draw:Slider("cwidth", "Circle Width", 1, 1, 10, 1)
AnnieMenu.draw:Slider("cquality", "Circle Quality", 1, 0, 8, 1)
AnnieMenu.draw:Boolean("qdraw", "Draw Q", true)
AnnieMenu.draw:ColorPick("qcirclecol", "Q Circle color", {255, 134, 26, 217}) 
AnnieMenu.draw:Boolean("rdraw", "Draw R", true)
AnnieMenu.draw:ColorPick("rcirclecol", "R Circle color", {255, 134, 26, 217})



local AnnieR = {delay =  0.25, range = 625, width = 0, speed = math.huge}

local AnnieW = {delay =  0.1, range = 600, width = 300, speed = math.huge}

OnTick(function()

		
local target = GetCurrentTarget()

if IOW:Mode() == "Combo" then	

if AnnieMenu.Combo.Q:Value() and Ready(_Q) and ValidTarget(target, 625) then	
			
                         CastTargetSpell(target , _Q)

                     end	

                     
		     if AnnieMenu.Combo.W:Value() and Ready(_W) and ValidTarget(target, 625) then

                     local targetPos = GetOrigin(target)	

                     CastSkillShot(_W , targetPos)

                     end
 
                     if AnnieMenu.Combo.R:Value() and Ready(_R) and ValidTarget(target, 600) then			


                 if not AnnieMenu.Combo.UOP:Value() then	
       
                     local RPred = GetPredictionForPlayer(GetOrigin(myHero), target, GetMoveSpeed(target), math.huge, 75, 600, 150, false, true)
                     if RPred.HitChance == 2 then
                     CastSkillShot(_R,RPred.PredPos)
                     end
	
                 else

                     local RPred = GetCircularAOEPrediction(target,AnnieR)
                     if RPred.hitChance < 0.2 then

                         CastSkillShot(_R,RPred.castPos)		
                     end

                 end

end

end

for _, enemy in pairs(GetEnemyHeroes()) do

if AnnieMenu.Combo.Q:Value() and AnnieMenu.Combo.KSQ:Value() and Ready(_Q) and ValidTarget(enemy, 625) then


if GetCurrentHP(enemy) < CalcDamage(myHero, enemy, 0, 45 + 35 * GetCastLevel(myHero,_Q) + GetBonusAP(myHero) * 0.8) then	

CastTargetSpell(enemy , _Q)
   end
  end	
 end
end)

OnProcessSpell(function(unit,spellProc)	

if GetTeam(unit) ~= GetTeam(myHero) and GetObjectType(unit) == Obj_AI_Hero and spellProc.name:lower():find("attack") then

if AnnieMenu.Combo.E:Value() and Ready(_E) then

CastSpell(_E)
        end

   end

end)

OnDraw (function()
 if not IsDead(myHero) then
  if AnnieMenu.draw.qdraw:Value() and IsReady(_Q) then
   DrawCircle(GetOrigin(myHero), 625, AnnieMenu.draw.cwidth:Value(), AnnieMenu.draw.cquality:Value(), AnnieMenu.draw.qcirclecol:Value())
  end
  if AnnieMenu.draw.rdraw:Value() and IsReady(_R) then 
   DrawCircle(GetOrigin(myHero), 600, AnnieMenu.draw.cwidth:Value(), AnnieMenu.draw.cquality:Value(), AnnieMenu.draw.rcirclecol:Value())
end
end
end)

print("Annie loaded lyý oyunlar Good Game")