hook.Add( "PopulateToolMenu", "mr_flolo_config_tool_populate_intercom", function()

  spawnmenu.AddToolMenuOption( "Utilities", "Intercom Addon-Config", "Intercom_config_allwd_jbs", "Allowed jobs", "", "", function(panel)

    local chkbxs = {}
    local trues = {}

    panel:ControlHelp( "Choose jobs that should be allowed to use the intercom")
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

      if !LocalPlayer():IsSuperAdmin() then
        if !LocalPlayer():IsAdmin() then
          notification.AddLegacy( "Intercom-System: acces denied", 1, 8 ) return
        else notification.AddLegacy( "Intercom-System: acces denied", 1, 8 ) return
        end
      end

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

  spawnmenu.AddToolMenuOption( "Utilities", "Intercom Addon-Config", "Intercom_config_cnfg", "Zones (WIP)", "", "",function(panel)

    panel:ControlHelp("!!!-WorkInProgress-!!!")
    panel:ControlHelp("")
    panel:ControlHelp("")
    panel:ControlHelp( "Manage the Intercom-System zones")
    panel:ControlHelp(" ")
    panel:ControlHelp( "! Only superadmin / admin can change this !")

    local list = vgui.Create("DListView")

    panel:AddItem(list)

    local Button = panel:Button( "Reload Zones" )
    Button.DoClick = function()

      if !LocalPlayer():IsSuperAdmin() then
        if !LocalPlayer():IsAdmin() then
          notification.AddLegacy( "Intercom-System: acces denied", 1, 8 ) return
        else notification.AddLegacy( "Intercom-System: acces denied", 1, 8 ) return
        end
      end

      notification.AddLegacy( "Intercom-System: Zones Reloaded", 2, 4 )

      hook.Remove( "HUDPaint", "IntercomCustomDrawBoxLolRofl" )

      hook.Add( "HUDPaint", "IntercomCustomDrawBoxLolRofl",function()
        cam.Start3D()

          local IntercomZoneCords = {
            {Vector(8095.897461, -2623.414307, -851.979187), Vector(4570.666504, 1554.973877, 883.979797)},
            {Vector(1958.499268, -2882.740967, -866.897339), Vector(4570.666504, 1554.973877, 883.979797)},
            {Vector(1958.499268, -2882.740967, -866.897339), Vector(-155.749695, 1483.531128, 505.995087)},
            {Vector(-2458.412598, -2320.785645, -262.593933), Vector(-155.749695, 1483.531128, 505.995087)},
            {Vector(4594.784180, 2140.836426, -1025.721436), Vector(-2459.576172, 1015.339722, 606.321045)},
            {Vector(4594.784180, 2140.836426, -1025.721436), Vector(-2325.258057, 2867.767822, 625.538391)},
            {Vector(4679.416992, 4760.559570, -620.735901), Vector(-2325.258057, 2867.767822, 625.538391)},
            {Vector(4679.416992, 4760.559570, -620.735901), Vector(-3481.643311, 6412.885742, 2247.709473)},
            {Vector(1429.870972, 8615.100586, -827.024231), Vector(-3481.643311, 6412.885742, 2247.709473)}
          }

          for f, g in pairs(IntercomZoneCords) do
            render.DrawWireframeBox( Vector(0, 0, 0), Angle( 0, 0, 0 ), g[1], g[2], Color( 255, 255, 255))
          end

        cam.End3D()
      end)
    end

    local Button = panel:Button( "Show Zones" )
    Button.DoClick = function()

      if !LocalPlayer():IsSuperAdmin() then
        if !LocalPlayer():IsAdmin() then
          notification.AddLegacy( "Intercom-System: acces denied", 1, 8 ) return
        else notification.AddLegacy( "Intercom-System: acces denied", 1, 8 ) return
        end
      end

      notification.AddLegacy( "Intercom-System: Zones Shown", 3, 4 )

      hook.Add( "HUDPaint", "IntercomCustomDrawBoxLolRofl",function()
        cam.Start3D()
          local IntercomZoneCords = {
            {Vector(8095.897461, -2623.414307, -851.979187), Vector(4570.666504, 1554.973877, 883.979797)},
            {Vector(1958.499268, -2882.740967, -866.897339), Vector(4570.666504, 1554.973877, 883.979797)},
            {Vector(1958.499268, -2882.740967, -866.897339), Vector(-155.749695, 1483.531128, 505.995087)},
            {Vector(-2458.412598, -2320.785645, -262.593933), Vector(-155.749695, 1483.531128, 505.995087)},
            {Vector(4594.784180, 2140.836426, -1025.721436), Vector(-2459.576172, 1015.339722, 606.321045)},
            {Vector(4594.784180, 2140.836426, -1025.721436), Vector(-2325.258057, 2867.767822, 625.538391)},
            {Vector(4679.416992, 4760.559570, -620.735901), Vector(-2325.258057, 2867.767822, 625.538391)},
            {Vector(4679.416992, 4760.559570, -620.735901), Vector(-3481.643311, 6412.885742, 2247.709473)},
            {Vector(1429.870972, 8615.100586, -827.024231), Vector(-3481.643311, 6412.885742, 2247.709473)}
          }

          for f, g in pairs(IntercomZoneCords) do
            render.DrawWireframeBox( Vector(0, 0, 0), Angle( 0, 0, 0 ), g[1], g[2], Color( 255, 255, 255))
          end
        cam.End3D()
      end)
    end

    local Button = panel:Button( "Hide Zones" )
    Button.DoClick = function()

      if !LocalPlayer():IsSuperAdmin() then
        if !LocalPlayer():IsAdmin() then
          notification.AddLegacy( "Intercom-System: acces denied", 1, 8 ) return
        else notification.AddLegacy( "Intercom-System: acces denied", 1, 8 ) return
        end
      end

      notification.AddLegacy( "Intercom-System: Zones Hidden", 1, 4 )

      hook.Remove( "HUDPaint", "IntercomCustomDrawBoxLolRofl" )

    end

    panel:ControlHelp(" ")
    panel:ControlHelp(" ")

    local button2 = vgui.Create("DButton")
    local TextEntry1 = vgui.Create("DTextEntry")
    local button3 = vgui.Create("DButton")
    local TextEntry2 = vgui.Create("DTextEntry")
    local Intercom_Zone_pos_1 = Vector( 0, 0, 0 )
    local Intercom_Zone_pos_2 = Vector( 0, 0, 0 )

    panel:Help("Min-Pos")
    panel:AddItem( TextEntry1 )
    panel:AddItem(button2)
    button2:SetText("GetPos")
    button2:SetPos( ScrW()/11, 0 )
    button2.DoClick = function()

      if !LocalPlayer():IsSuperAdmin() then
        if !LocalPlayer():IsAdmin() then
          notification.AddLegacy( "Intercom-System: acces denied", 1, 8 ) return
        else notification.AddLegacy( "Intercom-System: acces denied", 1, 8 ) return
        end
      end

      Intercom_Zone_pos_1 = LocalPlayer():GetPos()
      TextEntry1:SetValue(tostring(Intercom_Zone_pos_1))

      hook.Add( "HUDPaint", "IntercomCustomDrawBeams1",function()
        cam.Start3D()
        render.SetMaterial(Material("cable/redlaser"))
          render.DrawBeam(Intercom_Zone_pos_1 - Vector(0,0,100000), Intercom_Zone_pos_1 + Vector(0,0,100000), 50, 1, 1, Color( 200, 200, 255, 250))
        cam.End3D()
      end)
    end

    panel:Help("Max-Pos")
    panel:AddItem( TextEntry2 )
    panel:AddItem( button3 )
    button3:SetText("GetPos")
    button3:SetPos( ScrW()/11, 0 )
    button3.DoClick = function()

      if !LocalPlayer():IsSuperAdmin() then
        if !LocalPlayer():IsAdmin() then
          notification.AddLegacy( "Intercom-System: acces denied", 1, 8 ) return
        else notification.AddLegacy( "Intercom-System: acces denied", 1, 8 ) return
        end
      end

      Intercom_Zone_pos_2 = LocalPlayer():GetPos()
      TextEntry2:SetValue(tostring(Intercom_Zone_pos_2))

      hook.Add( "HUDPaint", "IntercomCustomDrawBeams2",function()
        cam.Start3D()
        render.SetMaterial(Material("cable/redlaser"))
          render.DrawBeam(Intercom_Zone_pos_2 - Vector(0,0,100000), Intercom_Zone_pos_2 + Vector(0,0,100000), 50, 1, 1, Color( 200, 200, 255, 250))
        cam.End3D()
      end)
    end

    panel:ControlHelp(" ")
    panel:ControlHelp(" ")

    local button4 = panel:Button("Add Zone")
    button4.DoClick = function()

      if !LocalPlayer():IsSuperAdmin() then
        if !LocalPlayer():IsAdmin() then
          notification.AddLegacy( "Intercom-System: acces denied", 1, 8 ) return
        else notification.AddLegacy( "Intercom-System: acces denied", 1, 8 ) return
        end
      end

      if timer.Exists("IntercomZoneRemoveBeaconCubeTimer") then
        timer.Remove("IntercomZoneRemoveBeaconCubeTimer")
        hook.Remove("HUDPaint", "IntercomCustomDrawBoxLolRofl2")
      end

      local Intercom_Zone_pos_1_1 = Intercom_Zone_pos_1
      local Intercom_Zone_pos_2_1 = Intercom_Zone_pos_2

      TextEntry1:SetValue("")
      TextEntry2:SetValue("")

      Intercom_Zone_pos_1 = Vector( 0, 0, 0 )
      Intercom_Zone_pos_2 = Vector( 0, 0, 0 )

      hook.Remove("HUDPaint", "IntercomCustomDrawBeams1")
      hook.Remove("HUDPaint", "IntercomCustomDrawBeams2")

      local IntercomZonesEntLimit = 512 - 50 - game.MaxPlayers()

      if table.Count(ents.FindInBox(Intercom_Zone_pos_1_1, Intercom_Zone_pos_2_1)) > IntercomZonesEntLimit then

        notification.AddLegacy( "Intercom-System: Too many entitys in the zone, make it smaller!", 10, 1 )

      else

        hook.Add( "HUDPaint", "IntercomCustomDrawBoxLolRofl2",function()
          cam.Start3D()
            render.DrawWireframeBox( Vector(0, 0, 0),Angle( 0, 0, 0 ), Intercom_Zone_pos_2_1, Intercom_Zone_pos_1_1, Color( 255, 255, 255))
          cam.End3D()
        end)

        timer.Create( "IntercomZoneRemoveBeaconCubeTimer", 10, 1, function()

          hook.Remove("HUDPaint", "IntercomCustomDrawBoxLolRofl2")

        end)
      end
    end
  end)

  spawnmenu.AddToolMenuOption( "Utilities", "Intercom Addon-Config", "Intercom_config_lang", "Language", "", "",function(panel)

    panel:ControlHelp( "Change the Intercom-System language")
    panel:ControlHelp(" ")
    panel:ControlHelp( "! Only superadmin / admin can change this !")

    local lang = {}

    local lang_chkbx1 = panel:CheckBox( "ENG" )
    local lang_chkbx2 = panel:CheckBox( "GER" )
    local lang_chkbx3 = panel:CheckBox( "FR" )
    local lang_chkbx4 = panel:CheckBox( "POL" )
    function lang_chkbx1:OnChange( val )
      if val then
        lang_chkbx2:SetValue(0)
        lang_chkbx3:SetValue(0)
        lang_chkbx4:SetValue(0)
      end
    end
    function lang_chkbx2:OnChange( val )
      if val then
        lang_chkbx1:SetValue(0)
        lang_chkbx3:SetValue(0)
        lang_chkbx4:SetValue(0)
      end
    end
    function lang_chkbx3:OnChange( val )
      if val then
        lang_chkbx1:SetValue(0)
        lang_chkbx2:SetValue(0)
        lang_chkbx4:SetValue(0)
      end
    end
    function lang_chkbx4:OnChange( val )
      if val then
        lang_chkbx1:SetValue(0)
        lang_chkbx2:SetValue(0)
        lang_chkbx3:SetValue(0)
      end
    end

    panel:ControlHelp(" ")

    local Button = panel:Button( "Save" )
    Button.DoClick = function()

      if !LocalPlayer():IsSuperAdmin() then
        if !LocalPlayer():IsAdmin() then
          notification.AddLegacy( "Intercom-System: acces denied", 1, 8 ) return
        else notification.AddLegacy( "Intercom-System: acces denied", 1, 8 ) return
        end
      end

      table.Empty( lang )

      if lang_chkbx1:GetChecked() == true then
        table.insert( lang, lang_chkbx1:GetText())
      elseif lang_chkbx2:GetChecked() == true then
        table.insert( lang, lang_chkbx2:GetText())
      elseif lang_chkbx3:GetChecked() == true then
        table.insert( lang, lang_chkbx3:GetText())
      elseif lang_chkbx4:GetChecked() == true then
        table.insert( lang, lang_chkbx4:GetText())
      end

      notification.AddLegacy( "Intercom-System: Language Saved", 2, 4 )

      net.Start( "ChangeIntercomSaveLang" )
      net.WriteTable( lang )
      net.SendToServer()
    end
  end)
end)

surface.CreateFont( "HudTextDefaultIntercom", {
	font = "Arial",
	extended = false,
	size = 28,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
})

local pos_w = ScrW()/2.4
local width = ScrW()/6
local text_pos_w = ScrW()/2.38
local text_pos_h = ScrH()/36

net.Receive( "intercom_overlay_start", function()

	surface.PlaySound( "intercom.wav" )

  local InfosTab = net.ReadTable()
  local text = InfosTab.TransString or "Nil"

	local color1 = Color(150,150,20)
  -- phase 1
  local DPanel_intercom_overlay_p1 = vgui.Create( "DPanel" )
  DPanel_intercom_overlay_p1:SetSize( width, 80) -- setup size first
  DPanel_intercom_overlay_p1:SetPos(0,0)
  DPanel_intercom_overlay_p1:CenterHorizontal(0.5) -- Center it
  DPanel_intercom_overlay_p1:SetKeyboardInputEnabled(false)
  function DPanel_intercom_overlay_p1:Paint( w, h )
    draw.RoundedBox( 0, 0, 0, w, h, color1 )
  end
  DPanel_intercom_overlay_p1:SetAlpha(0)

  DPanel_intercom_overlay_p1:AlphaTo( 255, InfosTab.TimerLen or 2.3, 0, function()
    timer.Simple(0.3,function()
      DPanel_intercom_overlay_p1:Remove()
    end)
  end )

  timer.Simple(InfosTab.TimerLen or 2.3,function()

    color1 = Color(120,200,120)
    color2 = Color(80, 80, 80)
    -- phase 2
    local DPanel_intercom_overlay_p2 = vgui.Create( "DPanel" )
    DPanel_intercom_overlay_p2:SetSize( width, 80) -- setup size first
    DPanel_intercom_overlay_p2:SetPos(0,0)
    DPanel_intercom_overlay_p2:CenterHorizontal(0.5) -- Center it
    DPanel_intercom_overlay_p2:SetKeyboardInputEnabled(false)
    function DPanel_intercom_overlay_p2:Paint( w, h )
      draw.RoundedBox( 0, 0, 0, w, h, color1 )
    end

    local DPanel_intercom_Text = vgui.Create("DLabel",DPanel_intercom_overlay_p2)
    DPanel_intercom_Text:SetFont("HudTextDefaultIntercom")
    DPanel_intercom_Text:SetText(text)
    DPanel_intercom_Text:SizeToContents()
    DPanel_intercom_Text:CenterHorizontal(0.5)
    DPanel_intercom_Text:CenterVertical(0.5)
    DPanel_intercom_Text:SetTextColor(color2)

    local ChatTextP2 = InfosTab.ChatTextPhase2
    chat.AddText( Color( 180, 20, 20 ), " !--------------------------------------------------------------------! " )
    chat.AddText( Color( 120, 20, 20 ), "  [INTERCOM SYSTEM] ", Color( 50, 50, 50 ), ChatTextP2 )
    chat.AddText( Color( 180, 20, 20 ), " !--------------------------------------------------------------------! " )


    -- phase 3
    net.Receive( "intercom_overlay_end", function()
      DPanel_intercom_overlay_p2:Remove()

      surface.PlaySound( "alarm.wav" )

      color1 = Color(100,10,5)


      local DPanel_intercom_overlay_p3 = vgui.Create( "DPanel" )
      DPanel_intercom_overlay_p3:SetSize( width, 80)
      DPanel_intercom_overlay_p3:SetPos(0,0)
      DPanel_intercom_overlay_p3:CenterHorizontal(0.5)
      DPanel_intercom_overlay_p3:SetKeyboardInputEnabled(false)
      function DPanel_intercom_overlay_p3:Paint( w, h )
        draw.RoundedBox( 0, 0, 0, w, h, color1 )
      end
      DPanel_intercom_overlay_p3:SetAlpha(255)


      DPanel_intercom_overlay_p3:AlphaTo( 0, 1, 0.3, function()
        timer.Simple(1.5,function()
          DPanel_intercom_overlay_p3:Remove()
        end)
      end)

      local ChatTextP3 = InfosTab.ChatTextPhase3

      chat.AddText( Color( 180, 20, 20 ), " !--------------------------------------------------------------------! " )
      chat.AddText( Color( 120, 20, 20 ), "  [INTERCOM SYSTEM] ", Color( 50, 50, 50 ), ChatTextP3)
      chat.AddText( Color( 180, 20, 20 ), " !--------------------------------------------------------------------! " )


    end)
  end)
end)



net.Receive("intercomfailed", function()

	local intercom_tx3_table = net.ReadTable()
	local intercom_txt3 = ""
	local intercom__err_txt = ""

	intercom_txt3 = intercom_tx3_table[1]
	intercom__err_txt = intercom_tx3_table[2]



	chat.AddText( Color( 180, 20, 20 ), " !---------------"..intercom__err_txt.."---------------! " )
	chat.AddText( Color( 120, 20, 20 ), "  [INTERCOM SYSTEM] ",  Color( 50, 50, 50 ), intercom_txt3 )
	chat.AddText( Color( 180, 20, 20 ), " !--------------------------------------------------------------------! " )

end)

net.Receive("intercomfailed2", function()

	local intercom_tx4_table = net.ReadTable()
	local intercom_txt4 = ""
	local intercom__err_txt = ""

	intercom_txt4 = intercom_tx4_table[1]
	intercom__err_txt = intercom_tx4_table[2]

	chat.AddText( Color( 180, 20, 20 ), " !---------------"..intercom__err_txt.."---------------! " )
	chat.AddText( Color( 120, 20, 20 ), "  [INTERCOM SYSTEM] ", Color( 50, 50, 50 ), intercom_txt4 )
	chat.AddText( Color( 180, 20, 20 ), " !-------------------------------------------------------------------! " )

end)
