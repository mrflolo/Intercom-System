print(" ")
print("-------------------------------------------")
print("|      Loading Intercom System Files      |")
print("|           Created by mr_flolo           |")
print("-------------------------------------------")
print(" ")

-- game.MaxPlayers()

if SERVER then
  include("intercom_system/sv_intercom_system_init.lua")

	AddCSLuaFile("intercom_system/cl_intercom_system.lua")
	resource.AddFile("sound/alarm.wav")
	resource.AddFile("sound/intercom.wav")
elseif CLIENT then
	include("intercom_system/cl_intercom_system.lua")
end
