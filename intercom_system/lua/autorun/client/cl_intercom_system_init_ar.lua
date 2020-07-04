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

    panel:ControlHelp(" ")
    panel:ControlHelp(" ")

    local button2 = vgui.Create("DButton")
    local TextEntry1 = vgui.Create("DTextEntry")
    local button3 = vgui.Create("DButton")
    local TextEntry2 = vgui.Create("DTextEntry")
    local Intercom_Zone_pos_1
    local Intercom_Zone_pos_2

    panel:Help("Min-Pos")
    panel:AddItem( TextEntry1 )
    panel:AddItem(button2)
    button2:SetText("GetPos")
    button2:SetPos( ScrW()/11, 0 )
    button2.DoClick = function()
      TextEntry1:SetValue(tostring(LocalPlayer():GetPos()))
    end

    panel:Help("Max-Pos")
    panel:AddItem( TextEntry2 )
    panel:AddItem( button3 )
    button3:SetText("GetPos")
    button3:SetPos( ScrW()/11, 0 )
    button3.DoClick = function()
      TextEntry2:SetValue(tostring(LocalPlayer():GetPos()))
    end

    panel:ControlHelp(" ")
    panel:ControlHelp(" ")

    local button4 = panel:Button("Add Zone")
    button4.DoClick = function()

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

      if !LocalPlayer():IsSuperAdmin() then if !LocalPlayer():IsAdmin() then print("ERROR ! Player has no acces") return end end

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
