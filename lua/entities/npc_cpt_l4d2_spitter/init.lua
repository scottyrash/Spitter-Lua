if !CPTBase then return end
AddCSLuaFile('shared.lua')
include('shared.lua')

ENT.ModelTable = {"models/infected/spitter.mdl"}
ENT.StartHealth = 315
ENT.CanMutate = false
ENT.CollisionBounds = Vector(18,18,70)

ENT.Faction = "FACTION_ZOMBIE"

ENT.MeleeAttackDistance = 40
ENT.MeleeAttackDamageDistance = 60
ENT.MeleeAttackType = DMG_SLASH
ENT.MeleeAttackDamage = 5
ENT.AttackablePropNames = {"prop_physics","func_breakable","prop_physics_multiplayer","func_physbox"}

ENT.RangeAttackDistance = 450
ENT.RangeAttackMinimalDistance = 300

ENT.BloodEffect = {"blood_impact_red"}

ENT.tbl_Animations = {
        ["Idle"] = {ACT_IDLE},
	["Walk"] = {ACT_WALK},
	["Run"] = {ACT_RUN},
	["Attack"] = {"cptges_spitter_melee_02"},
        ["RangeAttack"] = {ACT_RANGE_ATTACK1},
}

ENT.tbl_Sounds = {
	["Alert"] = {
            "cpt_l4d2/spitter/voice/alert/spitter_alert_01.wav",
            "cpt_l4d2/spitter/voice/alert/spitter_alert_02.wav",
            "cpt_l4d2/spitter/voice/warn/spitter_warn_01.wav",
            "cpt_l4d2/spitter/voice/warn/spitter_warn_02.wav", 
            "cpt_l4d2/spitter/voice/warn/spitter_warn_03.wav",
        },
        ["Death"] = {
            "cpt_l4d2/spitter/voice/die/spitter_death_01.wav",
            "cpt_l4d2/spitter/voice/die/spitter_death_02.wav",
        },
        ["Idle"] = {
            "cpt_l4d2/spitter/voice/idle/spitter_lurk_01.wav",
            "cpt_l4d2/spitter/voice/idle/spitter_lurk_02.wav",
            "cpt_l4d2/spitter/voice/idle/spitter_lurk_03.wav",
            "cpt_l4d2/spitter/voice/idle/spitter_lurk_04.wav",
            "cpt_l4d2/spitter/voice/idle/spitter_lurk_05.wav",
            "cpt_l4d2/spitter/voice/idle/spitter_lurk_06.wav",
            "cpt_l4d2/spitter/voice/idle/spitter_lurk_07.wav",
            "cpt_l4d2/spitter/voice/idle/spitter_lurk_08.wav",
            "cpt_l4d2/spitter/voice/idle/spitter_lurk_09.wav",
            "cpt_l4d2/spitter/voice/idle/spitter_lurk_10.wav",
            "cpt_l4d2/spitter/voice/idle/spitter_lurk_11.wav",
            "cpt_l4d2/spitter/voice/idle/spitter_lurk_12.wav",
            "cpt_l4d2/spitter/voice/idle/spitter_lurk_13.wav",
            "cpt_l4d2/spitter/voice/idle/spitter_lurk_14.wav",
            "cpt_l4d2/spitter/voice/idle/spitter_lurk_15.wav",
            "cpt_l4d2/spitter/voice/idle/spitter_lurk_16.wav",
            "cpt_l4d2/spitter/voice/idle/spitter_lurk_17.wav",
            "cpt_l4d2/spitter/voice/idle/spitter_lurk_18.wav",
            "cpt_l4d2/spitter/voice/idle/spitter_lurk_19.wav",
            "cpt_l4d2/spitter/voice/idle/spitter_lurk_20.wav",
            "bacteria/spitterbacteria.wav",
            "bacteria/spitterbacterias.wav",
        },
        ["Pain"] = {
            "cpt_l4d2/spitter/voice/pain/spitter_pain_01.wav",
            "cpt_l4d2/spitter/voice/pain/spitter_pain_02.wav",
            "cpt_l4d2/spitter/voice/pain/spitter_pain_03.wav",
        },
        ["Bacteria"] = {
            "bacteria/spitterbacteria.wav",
            "bacteria/spitterbacterias.wav",
        },
        ["Hit"] = {
            "cpt_l4d2/hit/claw_hit_flesh_1.wav",
            "cpt_l4d2/hit/claw_hit_flesh_2.wav",
            "cpt_l4d2/hit/claw_hit_flesh_3.wav",
            "cpt_l4d2/hit/claw_hit_flesh_4.wav",
        },
        ["Killed"] = {
            "cpt_l4d2/survival_medal.wav",
            "cpt_l4d2/survival_playerrec.wav",
            "cpt_l4d2/survival_teamrec.wav", 
        },
        ["RangeAttack"] = {
            "cpt_l4d2/spitter/voice/warn/spitter_spit_01.wav",
            "cpt_l4d2/spitter/voice/warn/spitter_spit_02.wav",
        }
}          

ENT.tbl_Capabilities = {CAP_OPEN_DOORS,CAP_USE,CAP_MOVE_CLIMB,CAP_MOVE_JUMP}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SetInit()
	self:SetHullType(HULL_HUMAN)
	self:SetMovementType(MOVETYPE_STEP)
	self.IsAttacking = false
	self.IsRangeAttacking = false
	self.NextRangeAttackT = 0
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Possess_OnPossessed(possessor)
	possessor:ChatPrint("Possessor Controls:")
	possessor:ChatPrint("LMB - Melee Attack")
	possessor:ChatPrint("RMB - Special Attack")
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:HandleEvents(...)
	local event = select(1,...)
	local arg1 = select(2,...)
	if(event == "mattack") then
		if arg1 == "power" then
                        self:PlaySound("Attack")

			self:DoDamage(self.MeleeAttackDamageDistance *1.5,self.MeleeAttackDamage,self.MeleeAttackType)
		else
			self:DoDamage(self.MeleeAttackDamageDistance,self.MeleeAttackDamage,self.MeleeAttackType)
                end     
		return true
	end
        if(event == "rattack") then
	       	local spit = ents.Create("obj_cpt_antlionspit")
		local bonepos,boneang = self:GetBonePosition(19)
                local att = self:GetAttachment(self:LookupAttachment("mouth"))
		spit:SetPos(bonepos)
		spit:SetAngles(boneang)
		spit:SetOwner(self)
		spit:Spawn()
		spit:Activate()
                spit:SetDamage(50,DMG_ACID)
		spit.HasBeenThrown = true
		local phys = spit:GetPhysicsObject()
		if IsValid(phys) then
			if !self.IsPossessed then
				if IsValid(self:GetEnemy()) then
					if self:GetEnemy():IsPlayer() then
						phys:SetVelocity(self:SetUpRangeAttackTarget() *10 +self:GetUp() *-4000 +self:GetRight() *-800)
					else
						phys:SetVelocity(self:SetUpRangeAttackTarget() *10 +self:GetUp() *-2000 +self:GetRight() *-800)
					end
				else
					phys:SetVelocity(((self:GetPos() +self:GetForward() *1000) -self:GetPos()) *10 +self:GetUp() *-2000 +self:GetRight() *-800)
				end
			else
				phys:SetVelocity((self:Possess_AimTarget() -self:GetPos()) *10 +self:GetUp() *-3000 +self:GetRight() *-800)
			end
		end 
        end
	if(event == "emit") then
		if arg1 == "Idle" then
			self:PlaySound("Idle",95,95,105,true)
		end
                if arg1 == "Alert" then
			self:PlaySound("Alert",95,95,105,true)
		end 
                if arg1 == "Pain" then
			self:PlaySound("Pain",95,95,105,true)
		end
                if arg1 == "Attack" then
			self:PlaySound("Attack",95,95,105,true)
		end 
                if arg1 == "Hit" then
			self:PlaySound("Hit",95,95,105,true)
		end
                if arg1 == "Death" then
			self:PlaySound("Death",95,95,105,true)
		end
		return true
	end
end  
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:DoAttack()
	if self:CanPerformProcess() == false then return end
	if (!self.IsPossessed && IsValid(self:GetEnemy()) && !self:GetEnemy():Visible(self)) then return end
	self:StopCompletely()
        self:PlayAnimation("Attack")
	self.IsAttacking = true
	self:AttackFinish()
        timer.Simple(0.6,function()
	        if self:IsValid() then
			self:DoDamage(self.MeleeAttackDamageDistance,self.MeleeAttackDamage,self.MeleeAttackType)
		end
	end)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:DoRangeAttack()
	if self:CanPerformProcess() == false then return end
	if (!self.IsPossessed && IsValid(self:GetEnemy()) && !self:GetEnemy():Visible(self)) then return end
	if CurTime() > self.NextRangeAttackT then
		self:PlaySound("RangeAttack")
		self:PlayAnimation("RangeAttack")
		self.IsRangeAttacking = true
		self.NextRangeAttackT = CurTime() +math.Rand(4,6) 
                self:AttackFinish()
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnDeath(dmg,dmginfo,hitbox)
	if (!self.IsPossessed && IsValid(self:GetEnemy()) && !self:GetEnemy():Visible(self)) then return end
	self:StopCompletely()
        self:PlaySound("Death")
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:HandleSchedules(enemy,dist,nearest,disp)
	if self.IsPossessed then return end
	if(disp == D_HT) then
		if nearest <= self.MeleeAttackDistance && self:FindInCone(enemy,self.MeleeAngle) then
			self:DoAttack()
		end
                if nearest <= self.RangeAttackDistance && nearest > self.RangeAttackMinimalDistance && self:FindInCone(enemy,self.MeleeAngle) then
			self:DoRangeAttack()
		end
		if self:CanPerformProcess() then
			self:ChaseEnemy()
		end
	end
end