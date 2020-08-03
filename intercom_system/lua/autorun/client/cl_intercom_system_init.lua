--[=[---------------------------------------------------------------------------------------
║                                                                                          ║
║               Copyright (c) 2020 | mr_flolo / mrflolo | All rights reserved              ║
║                                                                                          ║
║                           Contact: mrflolo.addons@gmx.de                                 ║
║                                                                                          ║
║------------------------------------------------------------------------------------------║
║                                                                                          ║
║                                    Intercom System                                       ║
║                                                                                          ║
║                     All code and contributors can be seen on GitHub.                     ║
║                                                                                          ║
║                        https://github.com/mrflolo/Intercom-System                        ║
║                                                                                          ║
║                    I do not own any of the Sounds used in this Addon.                    ║
║                                                                                          ║
-----------------------------------------------------------------------------------------]=]


hook.Add( "PopulateToolMenu", "mr_flolo_config_tool_populate_intercom", function()

  spawnmenu.AddToolMenuOption( "Utilities", "Intercom Addon-Config", "Intercom_config_allwd_jbs", "Allowed jobs", "", "", function(panel)

    panel:ControlHelp("Choose jobs that should be allowed to use the intercom")
    panel:ControlHelp(" ")
    panel:ControlHelp("! Only superadmin / admin can change and see this !")

    if !LocalPlayer():IsSuperAdmin() then
      if !LocalPlayer():IsAdmin() then
        notification.AddLegacy("Intercom-System: acces denied", 1, 8) return
      else notification.AddLegacy("Intercom-System: acces denied", 1, 8) return
      end
    end

    local chkbxs = {}
    local trues = {}

    for g, h in pairs(team.GetAllTeams()) do
      if h.Name == "Joining/Connecting" then
      elseif h.Name == "Spectator" then
      elseif h.Name == "Unassigned" then
      else
        local chkbx = panel:CheckBox( h.Name )
        table.insert(chkbxs, chkbx)
      end
    end

    panel:ControlHelp("")

    local Button = panel:Button("Save")
    Button.DoClick = function()

      if !LocalPlayer():IsSuperAdmin() then
        if !LocalPlayer():IsAdmin() then
          notification.AddLegacy("Intercom-System: acces denied", 1, 8) return
        else notification.AddLegacy("Intercom-System: acces denied", 1, 8) return
        end
      end

      table.Empty( trues )

      for u, i in pairs(chkbxs) do
        if i:GetChecked() == true then
          table.insert(trues, i:GetText())
        end
      end

      notification.AddLegacy("Intercom-System: Allowed Jobs Saved", 2, 4)

      net.Start("ChangeIntercomSaveTeams")
      net.WriteTable(trues)
      net.SendToServer()

    end
  end)

  spawnmenu.AddToolMenuOption("Utilities", "Intercom Addon-Config", "Intercom_config_cnfg", "Zones", "", "",function(panel)

    panel:ControlHelp("Manage the Intercom-System zones")
    panel:ControlHelp("")
    panel:ControlHelp("! Only superadmin / admin can change and see this !")

    if !LocalPlayer():IsSuperAdmin() then
      if !LocalPlayer():IsAdmin() then
        notification.AddLegacy( "Intercom-System: acces denied", 1, 8 ) return
      else notification.AddLegacy( "Intercom-System: acces denied", 1, 8 ) return
      end
    end

    local list = vgui.Create("DListView")

    panel:AddItem(list)

    list:SetMultiSelect(false)

    list:AddColumn("X1", 1)
    list:AddColumn("Y1", 2)
    list:AddColumn("Z1", 3)
    list:AddColumn("|", 4)
    list:AddColumn("X2", 5)
    list:AddColumn("Y2", 6)
    list:AddColumn("Z2", 7)

    local function ReloadZoneMenu()

      list:Clear()
      list:ClearSelection()

      local IntercomZoneCords = {}

      net.Start("GetIntercomZones")
      net.SendToServer()

      net.Receive("SendIntercomZones",function()
        IntercomZoneCords = net.ReadTable()
      end)

      timer.Simple( 0.1 ,function()
        for u, i in pairs(IntercomZoneCords) do
          list:AddLine(i[1].cord1_x, i[2].cord1_y, i[3].cord1_z, "", i[4].cord2_x, i[5].cord2_y, i[6].cord2_z)
        end
      end)
    end

    ReloadZoneMenu()

    list:SetHeight(250)

    local Button = panel:Button("show zone")
    Button.DoClick = function()

      if !LocalPlayer():IsSuperAdmin() then
        if !LocalPlayer():IsAdmin() then
          notification.AddLegacy("Intercom-System: acces denied", 1, 8) return
        else notification.AddLegacy("Intercom-System: acces denied", 1, 8) return
        end
      end

      local line_nmb = list:GetSelectedLine()
      local line = list:GetLine(line_nmb)

      if line == nil then return end

      local cord1 = line:GetColumnText(1)
      local cord2 = line:GetColumnText(2)
      local cord3 = line:GetColumnText(3)

      local cord4 = line:GetColumnText(5)
      local cord5 = line:GetColumnText(6)
      local cord6 = line:GetColumnText(7)

      local showvector1 = Vector( cord1, cord2, cord3 )
      local showvector2 = Vector( cord4, cord5, cord6 )

      hook.Remove("HUDPaint", "IntercomShowSingleZone")

      hook.Add("HUDPaint", "IntercomShowSingleZone",function()
        cam.Start3D()
          render.DrawWireframeBox( Vector(0, 0, 0), Angle( 0, 0, 0 ), showvector1, showvector2, Color( 255, 255, 255))
        cam.End3D()
      end)
    end

    local Button = panel:Button("hide zone")
    Button.DoClick = function()

      if !LocalPlayer():IsSuperAdmin() then
        if !LocalPlayer():IsAdmin() then
          notification.AddLegacy("Intercom-System: acces denied", 1, 8) return
        else notification.AddLegacy("Intercom-System: acces denied", 1, 8) return
        end
      end

      hook.Remove("HUDPaint", "IntercomShowSingleZone")
    end

    local Button = panel:Button("remove zone")
    Button.DoClick = function()

      if !LocalPlayer():IsSuperAdmin() then
        if !LocalPlayer():IsAdmin() then
          notification.AddLegacy("Intercom-System: acces denied", 1, 8) return
        else notification.AddLegacy("Intercom-System: acces denied", 1, 8) return
        end
      end

      local line_nmb = list:GetSelectedLine()
      local line = list:GetLine(line_nmb)

      if line == nil then return end

      local cord1 = line:GetColumnText(1)
      local cord2 = line:GetColumnText(2)
      local cord3 = line:GetColumnText(3)

      local cord4 = line:GetColumnText(5)
      local cord5 = line:GetColumnText(6)
      local cord6 = line:GetColumnText(7)

      local SQLSaveTable = {}

      table.insert(SQLSaveTable, cord1)
      table.insert(SQLSaveTable, cord2)
      table.insert(SQLSaveTable, cord3)
      table.insert(SQLSaveTable, cord4)
      table.insert(SQLSaveTable, cord5)
      table.insert(SQLSaveTable, cord6)

      net.Start("RemoveIntercomZone")
      net.WriteTable(SQLSaveTable)
      net.SendToServer()

      ReloadZoneMenu()
    end

    panel:ControlHelp("")
    panel:ControlHelp("")

    local Button = panel:Button("show all zones")
    Button.DoClick = function()

      if timer.Exists("Intercom_ShowZones_CoolDown") then return end

      timer.Create("Intercom_ShowZones_CoolDown", 5, 1,function()end)

      if !LocalPlayer():IsSuperAdmin() then
        if !LocalPlayer():IsAdmin() then
          notification.AddLegacy("Intercom-System: acces denied", 1, 8) return
        else notification.AddLegacy("Intercom-System: acces denied", 1, 8) return
        end
      end

      local IntercomZoneCords = {}

      net.Start("GetIntercomZones")
      net.SendToServer()

      net.Receive("SendIntercomZones",function()
        IntercomZoneCords = net.ReadTable()
      end)

      notification.AddLegacy("Intercom-System: zones shown", 3, 4)

      hook.Add("HUDPaint", "IntercomShowAllZones",function()
        cam.Start3D()
          for f, g in pairs(IntercomZoneCords) do
            local IntercomShowVector1 = Vector( g[1].cord1_x, g[2].cord1_y, g[3].cord1_z )
            local IntercomShowVector2 = Vector( g[4].cord2_x, g[5].cord2_y, g[6].cord2_z )

            render.DrawWireframeBox( Vector(0, 0, 0), Angle( 0, 0, 0 ), IntercomShowVector1, IntercomShowVector2, Color( 255, 255, 255))
          end
        cam.End3D()
      end)
    end

    local Button = panel:Button("hide all zones")
    Button.DoClick = function()

      if !LocalPlayer():IsSuperAdmin() then
        if !LocalPlayer():IsAdmin() then
          notification.AddLegacy("Intercom-System: acces denied", 1, 8) return
        else notification.AddLegacy("Intercom-System: acces denied", 1, 8) return
        end
      end

      notification.AddLegacy("Intercom-System: zones hidden", 1, 4)

      hook.Remove("HUDPaint", "IntercomShowAllZones")
      hook.Remove("HUDPaint", "IntercomShowSingleZone")

    end

    panel:ControlHelp("")
    panel:ControlHelp("")

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
          notification.AddLegacy("Intercom-System: acces denied", 1, 8) return
        else notification.AddLegacy("Intercom-System: acces denied", 1, 8) return
        end
      end

      Intercom_Zone_pos_1 = LocalPlayer():GetPos()
      TextEntry1:SetValue(tostring(Intercom_Zone_pos_1))

      hook.Add("HUDPaint", "IntercomCustomDrawBeams1",function()
        cam.Start3D()
        render.SetMaterial(Material("cable/redlaser"))
          render.DrawBeam(Intercom_Zone_pos_1 - Vector(0,0,100000), Intercom_Zone_pos_1 + Vector(0,0,100000), 50, 1, 1, Color( 200, 200, 255, 250))
        cam.End3D()
      end)
    end

    panel:Help("Max-Pos")
    panel:AddItem(TextEntry2)
    panel:AddItem(button3)
    button3:SetText("GetPos")
    button3:SetPos(ScrW()/11, 0)
    button3.DoClick = function()

      if !LocalPlayer():IsSuperAdmin() then
        if !LocalPlayer():IsAdmin() then
          notification.AddLegacy("Intercom-System: acces denied", 1, 8) return
        else notification.AddLegacy("Intercom-System: acces denied", 1, 8) return
        end
      end

      Intercom_Zone_pos_2 = LocalPlayer():GetPos()
      TextEntry2:SetValue(tostring(Intercom_Zone_pos_2))

      hook.Add("HUDPaint", "IntercomCustomDrawBeams2",function()
        cam.Start3D()
        render.SetMaterial(Material("cable/redlaser"))
          render.DrawBeam(Intercom_Zone_pos_2 - Vector(0,0,100000), Intercom_Zone_pos_2 + Vector(0,0,100000), 50, 1, 1, Color( 200, 200, 255, 250))
        cam.End3D()
      end)
    end

    panel:ControlHelp("")
    panel:ControlHelp("")

    local button4 = panel:Button("Add Zone")
    button4.DoClick = function()

      if !LocalPlayer():IsSuperAdmin() then
        if !LocalPlayer():IsAdmin() then
          notification.AddLegacy("Intercom-System: acces denied", 1, 8) return
        else notification.AddLegacy("Intercom-System: acces denied", 1, 8) return
        end
      end

      if timer.Exists("IntercomZoneRemoveBeaconCubeTimer") then
        timer.Remove("IntercomZoneRemoveBeaconCubeTimer")
        hook.Remove("HUDPaint", "IntercomShowSingleZone")
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

        notification.AddLegacy("Intercom-System: Too many entitys in the zone, make it smaller!", 10, 1)

      else

        hook.Add("HUDPaint", "IntercomShowSingleZone",function()
          cam.Start3D()
            render.DrawWireframeBox( Vector(0, 0, 0),Angle( 0, 0, 0 ), Intercom_Zone_pos_2_1, Intercom_Zone_pos_1_1, Color( 255, 255, 255))
          cam.End3D()
        end)

        local IntercomNetSaveTable = {Intercom_Zone_pos_2_1, Intercom_Zone_pos_1_1}

        net.Start("SaveNewIntercomZone")
        net.WriteTable(IntercomNetSaveTable)
        net.SendToServer()

        ReloadZoneMenu()

        timer.Create("IntercomZoneRemoveBeaconCubeTimer", 10, 1, function()

          hook.Remove("HUDPaint", "IntercomShowSingleZone")

        end)
      end
    end
  end)

  spawnmenu.AddToolMenuOption("Utilities", "Intercom Addon-Config", "Intercom_config_lang", "Language", "", "",function(panel)

    panel:ControlHelp("Change the Intercom-System language")
    panel:ControlHelp("")
    panel:ControlHelp("! Only superadmin / admin can change and see this !")

    if !LocalPlayer():IsSuperAdmin() then
      if !LocalPlayer():IsAdmin() then
        notification.AddLegacy("Intercom-System: acces denied", 1, 8) return
      else notification.AddLegacy("Intercom-System: acces denied", 1, 8) return
      end
    end

    local lang = {}

    local lang_chkbx1 = panel:CheckBox("ENG")
    local lang_chkbx2 = panel:CheckBox("GER")
    local lang_chkbx3 = panel:CheckBox("FR")
    local lang_chkbx4 = panel:CheckBox("POL")
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

    panel:ControlHelp("")

    local Button = panel:Button("Save")
    Button.DoClick = function()

      if !LocalPlayer():IsSuperAdmin() then
        if !LocalPlayer():IsAdmin() then
          notification.AddLegacy("Intercom-System: acces denied", 1, 8) return
        else notification.AddLegacy("Intercom-System: acces denied", 1, 8) return
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

      notification.AddLegacy("Intercom-System: Language Saved", 2, 4)

      net.Start("ChangeIntercomSaveLang")
      net.WriteTable(lang)
      net.SendToServer()
    end
  end)
end)
