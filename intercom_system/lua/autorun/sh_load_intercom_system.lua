print(" ")
print("-------------------------------------------")
print("|      Loading Intercom System Files      |")
print("|           Created by mr_flolo           |")
print("-------------------------------------------")
print(" ")

-- game.MaxPlayers()

if SERVER then

	util.AddNetworkString("ChangeIntercomSaveTeams")

	net.Receive( "ChangeIntercomSaveTeams", function( len, ply )

		if !ply:IsSuperAdmin() then if !ply:IsAdmin() then print("ERROR ! Player has no acces") return end end

		sql.Query("DELETE FROM sv_intercom_system_saved_teams")

		for j, k in pairs(net.ReadTable()) do
				sql.Query("INSERT INTO sv_intercom_system_saved_teams (`name`) VALUES ('"..k.."')")
		end

		logcount = sql.QueryValue("SELECT COUNT(name) FROM sv_intercom_system_saved_teams")

		local b2 = tonumber( logcount, 10 )

		local DataBaseOutput = {}

		for o=1, b2 do

			table.insert( DataBaseOutput, sql.QueryRow("SELECT name FROM sv_intercom_system_saved_teams", o ))

		end

		print("NOTE ! Intercom access jobs were changed by: " .. ply:Nick() .. ", new Jobs: ")

		if table.IsEmpty(DataBaseOutput) then
			print(" ")
			print("none")
			print(" ")
		else
			print(" ")
			PrintTable( DataBaseOutput )
			print(" ")
		end

	end)
end

if CLIENT then

	hook.Add( "PopulateToolMenu", "mr_flolo_config_tool_populate_intercom", function()

	  spawnmenu.AddToolMenuOption( "Utilities", "Intercom Addon-Config", "Intercom_config_allwd_jbs", "Allowed jobs", "", "", function(panel)

	    local chkbxs = {}
	    local trues = {}

	    panel:ControlHelp( "Choose jobs that are allowed to use the intercom")
			panel:ControlHelp(" ")
			panel:ControlHelp( "! Only superadmin / admin can change this !")

	    for g, h in pairs(team.GetAllTeams()) do
	      if h.Name == "Joining/Connecting" then
	      elseif h.Name == "Spectator" then
	      elseif h.Name == "Unassigned" then
	      else
	        local chkbx = panel:CheckBox( h.Name )
	        table.insert( chkbxs, chkbx )
	      end
	    end

			panel:ControlHelp(" ")

	    local Button = panel:Button( "Save" )
	    Button.DoClick = function()

	      if !LocalPlayer():IsSuperAdmin() then if !LocalPlayer():IsAdmin() then print("ERROR ! Player has no acces") return end end

	      table.Empty( trues )

	      for u, i in pairs(chkbxs) do
	        if i:GetChecked() == true then
	          table.insert( trues, i:GetText())
	        end
	      end

				notification.AddLegacy( "Intercom-System: Allowed Jobs Saved", 2, 4 )

	      net.Start( "ChangeIntercomSaveTeams" )
	      net.WriteTable( trues )
	    	net.SendToServer()

	    end
	  end)

		spawnmenu.AddToolMenuOption( "Utilities", "Intercom Addon-Config", "Intercom_config_cnfg", "Configure Intercom", "", "",function(panel)

			local Button = panel:Button( "Reload Zones" )
			Button.DoClick = function()

				if !LocalPlayer():IsSuperAdmin() then if !LocalPlayer():IsAdmin() then print("ERROR ! Player has no acces") return end end

				notification.AddLegacy( "Intercom-System: Zones Reloaded", 2, 4 )

				hook.Remove( "HUDPaint", "IntercomCustomDrawBoxLolRofl" )

				hook.Add( "HUDPaint", "IntercomCustomDrawBoxLolRofl",function()
					cam.Start3D()
						render.DrawWireframeBox( Vector(0, 0, 0),Angle( 0, 0, 0 ), Vector(8095.897461, -2623.414307, -851.979187), Vector(4570.666504, 1554.973877, 883.979797), Color( 255, 255, 255))
						render.DrawWireframeBox( Vector(0, 0, 0),Angle( 0, 0, 0 ), Vector(1958.499268, -2882.740967, -866.897339), Vector(4570.666504, 1554.973877, 883.979797), Color( 255, 255, 255))
						render.DrawWireframeBox( Vector(0, 0, 0),Angle( 0, 0, 0 ), Vector(1958.499268, -2882.740967, -866.897339), Vector(-155.749695, 1483.531128, 505.995087), Color( 255, 255, 255))
						render.DrawWireframeBox( Vector(0, 0, 0),Angle( 0, 0, 0 ), Vector(-2458.412598, -2320.785645, -262.593933), Vector(-155.749695, 1483.531128, 505.995087), Color( 255, 255, 255))
						render.DrawWireframeBox( Vector(0, 0, 0),Angle( 0, 0, 0 ), Vector(4594.784180, 2140.836426, -1025.721436), Vector(-2459.576172, 1015.339722, 606.321045), Color( 255, 255, 255))
						render.DrawWireframeBox( Vector(0, 0, 0),Angle( 0, 0, 0 ), Vector(4594.784180, 2140.836426, -1025.721436), Vector(-2325.258057, 2867.767822, 625.538391), Color( 255, 255, 255))
						render.DrawWireframeBox( Vector(0, 0, 0),Angle( 0, 0, 0 ), Vector(4594.784180, 2140.836426, -1025.721436), Vector(-2325.258057, 2867.767822, 625.538391), Color( 255, 255, 255))
						render.DrawWireframeBox( Vector(0, 0, 0),Angle( 0, 0, 0 ), Vector(4679.416992, 4760.559570, -620.735901), Vector(-2325.258057, 2867.767822, 625.538391), Color( 255, 255, 255))
						render.DrawWireframeBox( Vector(0, 0, 0),Angle( 0, 0, 0 ), Vector(4679.416992, 4760.559570, -620.735901), Vector(-3481.643311, 6412.885742, 2247.709473), Color( 255, 255, 255))
						render.DrawWireframeBox( Vector(0, 0, 0),Angle( 0, 0, 0 ), Vector(1429.870972, 8615.100586, -827.024231), Vector(-3481.643311, 6412.885742, 2247.709473), Color( 255, 255, 255))
					cam.End3D()
				end)
			end

			local Button = panel:Button( "Show Zones" )
			Button.DoClick = function()

				if !LocalPlayer():IsSuperAdmin() then if !LocalPlayer():IsAdmin() then print("ERROR ! Player has no acces") return end end

				notification.AddLegacy( "Intercom-System: Zones Shown", 3, 4 )

				hook.Add( "HUDPaint", "IntercomCustomDrawBoxLolRofl",function()
					cam.Start3D()
						render.DrawWireframeBox( Vector(0, 0, 0),Angle( 0, 0, 0 ), Vector(8095.897461, -2623.414307, -851.979187), Vector(4570.666504, 1554.973877, 883.979797), Color( 255, 255, 255))
						render.DrawWireframeBox( Vector(0, 0, 0),Angle( 0, 0, 0 ), Vector(1958.499268, -2882.740967, -866.897339), Vector(4570.666504, 1554.973877, 883.979797), Color( 255, 255, 255))
						render.DrawWireframeBox( Vector(0, 0, 0),Angle( 0, 0, 0 ), Vector(1958.499268, -2882.740967, -866.897339), Vector(-155.749695, 1483.531128, 505.995087), Color( 255, 255, 255))
						render.DrawWireframeBox( Vector(0, 0, 0),Angle( 0, 0, 0 ), Vector(-2458.412598, -2320.785645, -262.593933), Vector(-155.749695, 1483.531128, 505.995087), Color( 255, 255, 255))
						render.DrawWireframeBox( Vector(0, 0, 0),Angle( 0, 0, 0 ), Vector(4594.784180, 2140.836426, -1025.721436), Vector(-2459.576172, 1015.339722, 606.321045), Color( 255, 255, 255))
						render.DrawWireframeBox( Vector(0, 0, 0),Angle( 0, 0, 0 ), Vector(4594.784180, 2140.836426, -1025.721436), Vector(-2325.258057, 2867.767822, 625.538391), Color( 255, 255, 255))
						render.DrawWireframeBox( Vector(0, 0, 0),Angle( 0, 0, 0 ), Vector(4594.784180, 2140.836426, -1025.721436), Vector(-2325.258057, 2867.767822, 625.538391), Color( 255, 255, 255))
						render.DrawWireframeBox( Vector(0, 0, 0),Angle( 0, 0, 0 ), Vector(4679.416992, 4760.559570, -620.735901), Vector(-2325.258057, 2867.767822, 625.538391), Color( 255, 255, 255))
						render.DrawWireframeBox( Vector(0, 0, 0),Angle( 0, 0, 0 ), Vector(4679.416992, 4760.559570, -620.735901), Vector(-3481.643311, 6412.885742, 2247.709473), Color( 255, 255, 255))
						render.DrawWireframeBox( Vector(0, 0, 0),Angle( 0, 0, 0 ), Vector(1429.870972, 8615.100586, -827.024231), Vector(-3481.643311, 6412.885742, 2247.709473), Color( 255, 255, 255))
					cam.End3D()
				end)
			end

			local Button = panel:Button( "Hide Zones" )
			Button.DoClick = function()

				if !LocalPlayer():IsSuperAdmin() then if !LocalPlayer():IsAdmin() then print("ERROR ! Player has no acces") return end end

				notification.AddLegacy( "Intercom-System: Zones Hidden", 1, 4 )

				hook.Remove( "HUDPaint", "IntercomCustomDrawBoxLolRofl" )

			end

		end)
	end)
end

if SERVER then
	include("intercom_system/sh_intercom_system_config.lua")
  include("intercom_system/sv_intercom_system_init.lua")

	AddCSLuaFile("intercom_system/sh_intercom_system_config.lua")
	AddCSLuaFile("intercom_system/cl_intercom_system.lua")
	resource.AddFile("sound/alarm.wav")
	resource.AddFile("sound/intercom.wav")
elseif CLIENT then
	include("intercom_system/sh_intercom_system_config.lua")
	include("intercom_system/cl_intercom_system.lua")
end
