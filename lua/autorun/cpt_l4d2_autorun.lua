/*--------------------------------------------------
	Copyright (c) 2018 by Cpt. Hazama, All rights reserved.
	Nothing in these files or/and code may be reproduced, adapted, merged or
	modified without prior written consent of the original author, Cpt. Hazama
--------------------------------------------------*/
include('server/cpt_utilities.lua')

local category = "Left 4 Dead 2"
CPTBase.RegisterMod(category .. "Left 4 Dead 2 SNPCs","0.1.0")CPTBase.AddNPC("Smoker","npc_cpt_l4d2_smoker",category)CPTBase.AddNPC("Hunter","npc_cpt_l4d2_hunter",category)CPTBase.AddNPC("Tank","npc_cpt_l4d2_tank",category)CPTBase.AddParticleSystem("particles/smoker_fx.pcf",{"smoker_fx"})CPTBase.AddParticleSystem("particles/mrfriendly.pcf",{"mrfriendly"})CPTBase.AddParticleSystem("particles/cpt_mutation.pcf",{"cpt_mutation"})CPTBase.AddNPC("Jockey","npc_cpt_l4d2_jockey",category)CPTBase.AddNPC("Spitter","npc_cpt_l4d2_spitter",category)CPTBase.AddNPC("Charger","npc_cpt_l4d2_charger",category)CPTBase.AddNPC("Boomer","npc_cpt_l4d2_boomer",category)CPTBase.AddNPC("Boomette","npc_cpt_l4d2_boomette",category)CPTBase.AddNPC("Witch","npc_cpt_l4d2_witch",category)
CPTBase.AddConVar("cpt_l4d_usemusic","1")-- CPTBase.AddNPC("Tank Football","npc_cpt_l4d2_tank_football",category)-- CPTBase.AddNPC("Tank Clown","npc_cpt_l4d2_tank_clown",category)              
