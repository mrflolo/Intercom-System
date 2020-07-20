AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

local intercomactivateswitch = false

function ENT:Initialize()

    self:SetModel("models/props/de_prodigy/desk_console1.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:SetUseType( SIMPLE_USE )

    local phys = self:GetPhysicsObject()

    if phys:IsValid() then
        phys:Wake()
    end

end

local IntercomIsPressedByUser = false
local IntercomIsPressedUser = ""

function CheckIfYouCanHear( ply, validintercomplayers, intercom_selected_lang )

  local validintercomplayers2 = validintercomplayers
  local validintercomplayers3 = validintercomplayers
  local validintercomplayers4 = validintercomplayers

  if intercomactivateswitch == false then

    local TimerLenth = 2.3

    for g, h in pairs(validintercomplayers2) do
      if h:IsPlayer() then
        local function SendOverlayStart(text,ChatText2,ChatText3)
          net.Start("intercom_overlay_start")
          local trans_tab = {}
          trans_tab.TimerLen = TimerLenth
          trans_tab.ChatTextPhase2 = ChatText2 or "missing language"
          trans_tab.ChatTextPhase3 = ChatText3 or "missing language"
          trans_tab.TransString = text or "missing language"
          if IsValid(ply) then
            trans_tab.Talker = ply
          end
          net.WriteTable(trans_tab)
          net.Send(h)
        end

        if intercom_selected_lang == "GER" then
          SendOverlayStart( "Intercom überträgt", "Übertragung gestartet", "Übertragung beendet" )
        elseif intercom_selected_lang == "POL" then
          SendOverlayStart( "transmisje interkomowe", "transmisja rozpoczęta", "transmisja zakończona" )
        elseif intercom_selected_lang == "FR" then
          SendOverlayStart( "l'interphone transmet", "la transmission a commencé", "transmission terminée" )
        else
          SendOverlayStart( "intercom transmits", "transmission started", "transmission finished" )
        end
      end
    end

    timer.Simple( TimerLenth,function()

      timer.Create( "CheckIfPlayerEntered", 2.5, 0,function()

        local InBoxPlayer = {}
        local IntercomZoneCords = {}

        logcount = sql.QueryValue("SELECT COUNT(cord1_x) FROM sv_intercom_system_saved_zonestable")

        if logcount == false then print("getting sv_intercom_system_saved_zonestable table failed") return end

        local b2 = tonumber( logcount, 10 )

        for o=1, b2 do
          local IntercomZoneCords_temp = {
            sql.QueryRow("SELECT cord1_x FROM sv_intercom_system_saved_zonestable", o ),
            sql.QueryRow("SELECT cord1_y FROM sv_intercom_system_saved_zonestable", o ),
            sql.QueryRow("SELECT cord1_z FROM sv_intercom_system_saved_zonestable", o ),
            sql.QueryRow("SELECT cord2_x FROM sv_intercom_system_saved_zonestable", o ),
            sql.QueryRow("SELECT cord2_y FROM sv_intercom_system_saved_zonestable", o ),
            sql.QueryRow("SELECT cord2_z FROM sv_intercom_system_saved_zonestable", o )
          }
          table.insert( IntercomZoneCords, IntercomZoneCords_temp )
        end

        local IntercomWaitForTableCheck = true
        local IntercomZoneTableCount = 0

        timer.Create( "IntercomZoneCooldownTimer", 0.01, table.Count(IntercomZoneCords), function()
          IntercomZoneTableCount = IntercomZoneTableCount + 1

          if table.IsEmpty(IntercomZoneCords) then
            IntercomWaitForTableCheck = false
          else

            local IntercomZoneCords2 = IntercomZoneCords[IntercomZoneTableCount]
            local IntercomShowVector1 = Vector( IntercomZoneCords2[1].cord1_x, IntercomZoneCords2[2].cord1_y, IntercomZoneCords2[3].cord1_z )
            local IntercomShowVector2 = Vector( IntercomZoneCords2[4].cord2_x, IntercomZoneCords2[5].cord2_y, IntercomZoneCords2[6].cord2_z )
            table.Add( InBoxPlayer, ents.FindInBox( IntercomShowVector1, IntercomShowVector2 ) )

            if IntercomZoneTableCount == table.Count(IntercomZoneCords) then
              IntercomWaitForTableCheck = false
            end

          end
        end)

        function CheckIfIntercomShouldWait()
          if IntercomWaitForTableCheck == false then

            IntercomWaitForTableCheck = true

            table.Empty( validintercomplayers2 )

            for y, x in pairs(InBoxPlayer) do
              if x:IsPlayer() then
                validintercomplayers2[x] = true
              end
            end

            validintercomplayers3 = table.KeysFromValue( validintercomplayers2, true )

            for o, p in pairs(validintercomplayers3) do
              if validintercomplayers4[p] == true then
              else
                local function SendOverlayStart(text,ChatText2,ChatText3)
                  net.Start("intercom_overlay_p2")
                  local trans_tab = {}
                  trans_tab.TimerLen = TimerLenth
                  trans_tab.ChatTextPhase2 = ChatText2 or "missing language"
                  trans_tab.ChatTextPhase3 = ChatText3 or "missing language"
                  trans_tab.TransString = text or "missing language"
                  if IsValid(ply) then
                    trans_tab.Talker = ply
                  end
                  net.WriteTable(trans_tab)
                  net.Send(p)
                end

                if intercom_selected_lang == "GER" then
                  SendOverlayStart( "Intercom überträgt", "Übertragung gestartet", "Übertragung beendet" )
                elseif intercom_selected_lang == "POL" then
                  SendOverlayStart( "transmisje interkomowe", "transmisja rozpoczęta", "transmisja zakończona" )
                elseif intercom_selected_lang == "FR" then
                  SendOverlayStart( "l'interphone transmet", "la transmission a commencé", "transmission terminée" )
                else
                  SendOverlayStart( "intercom transmits", "transmission started", "transmission finished" )
                end
              end
            end

            validintercomplayers4 = validintercomplayers2

            for d, f in pairs(player.GetAll()) do
              local counter = 0
              for c, v in pairs(validintercomplayers3) do
                if f:IsPlayer() then
                  if f == v then
                    counter = counter + 1
                  end
                end
              end
              if counter > 0 then
              else
                net.Start("intercom_overlay_end")
                net.Send(f)
              end
            end
            validintercomplayers2 = validintercomplayers3
          else
            timer.Simple(0.2,function()
              CheckIfIntercomShouldWait()
            end)
          end

        end
        CheckIfIntercomShouldWait()
      end)

      hook.Add("PlayerCanHearPlayersVoice", "CheckIfYouCanHearHook", function(listener, talker)
        if talker == ply then
          for t, z in pairs(validintercomplayers3) do
            if z == listener then
              return true
            end
          end
        end
      end)
      intercomactivateswitch = true
    end)

  else

    table.Empty(validintercomplayers3)

    hook.Remove( "PlayerCanHearPlayersVoice", "CheckIfYouCanHearHook" )
    hook.Remove( "PlayerDeath", "CheckIfIntercomActivatedPlayerDied" )
    hook.Remove( "PlayerDisconnected", "CheckIfIntercomActivatedPlayerLeft" )
    hook.Remove( "PlayerChangedTeam", "CheckIfIntercomActivatedPlayerChangedJob" )
    timer.Remove("CheckIfPlayerEntered")

    IntercomIsPressedByUser = false
    IntercomIsPressedUser = ""

    intercomactivateswitch = false

    timer.Simple(0.1,function()
      net.Start("intercom_overlay_end")
      net.Broadcast()
    end)
  end
end

function CheckIfJob(ply)

  local intercom_selected_lang = sql.QueryValue("SELECT lang FROM sv_intercom_system_saved_language")

  logcount = sql.QueryValue("SELECT COUNT(name) FROM sv_intercom_system_saved_teams")

  local b2 = tonumber( logcount, 10 )

  local check_jobs_1 = {}

  for o=1, b2 do
  	table.insert( check_jobs_1, sql.QueryRow("SELECT name FROM sv_intercom_system_saved_teams", o ))
  end

  local validintercomplayers = {}

  local InBoxPlayer = {}
  local IntercomZoneCords = {}

  logcount = sql.QueryValue("SELECT COUNT(cord1_x) FROM sv_intercom_system_saved_zonestable")

  if logcount == false then print("getting sv_intercom_system_saved_zonestable table failed") return end

  local b2 = tonumber( logcount, 10 )

  for o=1, b2 do
    local IntercomZoneCords_temp = {
      sql.QueryRow("SELECT cord1_x FROM sv_intercom_system_saved_zonestable", o ),
      sql.QueryRow("SELECT cord1_y FROM sv_intercom_system_saved_zonestable", o ),
      sql.QueryRow("SELECT cord1_z FROM sv_intercom_system_saved_zonestable", o ),
      sql.QueryRow("SELECT cord2_x FROM sv_intercom_system_saved_zonestable", o ),
      sql.QueryRow("SELECT cord2_y FROM sv_intercom_system_saved_zonestable", o ),
      sql.QueryRow("SELECT cord2_z FROM sv_intercom_system_saved_zonestable", o )
    }
    table.insert( IntercomZoneCords, IntercomZoneCords_temp )
  end

  local IntercomWaitForTableCheck = true
  local IntercomZoneTableCount = 0

  timer.Create( "IntercomZoneCooldownTimer", 0.01, table.Count(IntercomZoneCords), function()
    IntercomZoneTableCount = IntercomZoneTableCount + 1

    if table.IsEmpty(IntercomZoneCords) then
      IntercomWaitForTableCheck = false
    else

      local IntercomZoneCords2 = IntercomZoneCords[IntercomZoneTableCount]
      local IntercomShowVector1 = Vector( IntercomZoneCords2[1].cord1_x, IntercomZoneCords2[2].cord1_y, IntercomZoneCords2[3].cord1_z )
      local IntercomShowVector2 = Vector( IntercomZoneCords2[4].cord2_x, IntercomZoneCords2[5].cord2_y, IntercomZoneCords2[6].cord2_z )
      table.Add( InBoxPlayer, ents.FindInBox( IntercomShowVector1, IntercomShowVector2 ) )

      if IntercomZoneTableCount == table.Count(IntercomZoneCords) then
        IntercomWaitForTableCheck = false
      end

    end
  end)

  function CheckIfIntercomShouldWaitFunction()
    if IntercomWaitForTableCheck == false then

      IntercomWaitForTableCheck = true
      table.Empty( validintercomplayers )

      for y, x in pairs(InBoxPlayer) do
        if x:IsPlayer() then
          validintercomplayers[x] = true
        end
      end

      validintercomplayers2 = table.KeysFromValue( validintercomplayers, true )

      local counter = 0
      for j, l in pairs(check_jobs_1) do
        if team.GetName(ply:Team()) == l.name then
          counter = counter + 1
          if validintercomplayers[ply] == true then
            counter = counter + 1
          end
        end
      end

      if counter == 0 then

        if intercom_selected_lang == "GER" then
          local intercom_lang_table = {
            "Zugangsberechtigung verweigert!",
            "KRITISCHER-SYSTEMFEHLER"
          }

          net.Start("intercomfailed")
          net.WriteTable(intercom_lang_table)
          net.Send( ply )
        elseif intercom_selected_lang == "POL" then
          local intercom_lang_table = {
            "Odmówiono autoryzacji dostępu!",
            "KRYTYCZNY-BŁĄD-SYSTEMU"
          }

          net.Start("intercomfailed")
          net.WriteTable(intercom_lang_table)
          net.Send( ply )
        elseif intercom_selected_lang == "FR" then
          local intercom_lang_table = {
            "autorisation d'accès refusée !",
            "ERREUR-CRITIQUE-DU-SYSTÈME"
          }

          net.Start("intercomfailed")
          net.WriteTable(intercom_lang_table)
          net.Send( ply )
        else
          local intercom_lang_table = {
            "access authorization denied!",
            "CRITICAL-SYSTEM-ERROR"
          }

          net.Start("intercomfailed")
          net.WriteTable(intercom_lang_table)
          net.Send( ply )
        end
      elseif counter == 1 then
        if intercom_selected_lang == "GER" then
          local intercom_lang_table = {
            "Außerhalb des Sendebereichs",
            "KRITISCHER-SYSTEMFEHLER"
          }

          net.Start("intercomfailed2")
          net.WriteTable(intercom_lang_table)
          net.Send( ply )
        elseif intercom_selected_lang == "POL" then
          local intercom_lang_table = {
            "poza zasięgiem!",
            "KRYTYCZNY-BŁĄD-SYSTEMU"
          }

          net.Start("intercomfailed2")
          net.WriteTable(intercom_lang_table)
          net.Send( ply )
        elseif intercom_selected_lang == "FR" then
          local intercom_lang_table = {
            "hors de portée !",
            "ERREUR-CRITIQUE-DU-SYSTÈME"
          }

          net.Start("intercomfailed2")
          net.WriteTable(intercom_lang_table)
          net.Send( ply )
        else
          local intercom_lang_table = {
            "out of range!",
            "CRITICAL-SYSTEM-ERROR"
          }

          net.Start("intercomfailed2")
          net.WriteTable(intercom_lang_table)
          net.Send( ply )
        end
      elseif counter > 1 then
        if IntercomIsPressedByUser == true then
          IntercomIsPressedByUser = true
          IntercomIsPressedUser = ply
          CheckIfYouCanHear( ply, validintercomplayers2, intercom_selected_lang )
        else
          hook.Add( "PlayerDeath", "CheckIfIntercomActivatedPlayerDied",function( cply1, inflictor, attacker )

            if cply1 == ply then

              net.Start("intercom_overlay_end")
              net.Broadcast()

              intercomactivateswitch = false

              hook.Remove( "PlayerCanHearPlayersVoice", "CheckIfYouCanHearHook")
              hook.Remove( "PlayerDeath", "CheckIfIntercomActivatedPlayerDied" )
              hook.Remove( "PlayerDisconnected", "CheckIfIntercomActivatedPlayerLeft" )
              hook.Remove( "PlayerChangedTeam", "CheckIfIntercomActivatedPlayerChangedJob" )
              timer.Remove( "CheckIfPlayerEntered" )

              IntercomIsPressedByUser = false
              IntercomIsPressedUser = ""
            end
          end)

          hook.Add( "PlayerDisconnected", "CheckIfIntercomActivatedPlayerLeft",function( cply2 )

            if cply2 == ply then

              net.Start("intercom_overlay_end")
              net.Broadcast()

              intercomactivateswitch = false

              hook.Remove("PlayerCanHearPlayersVoice", "CheckIfYouCanHearHook")
              hook.Remove( "PlayerDeath", "CheckIfIntercomActivatedPlayerDied" )
              hook.Remove( "PlayerDisconnected", "CheckIfIntercomActivatedPlayerLeft" )
              hook.Remove( "PlayerChangedTeam", "CheckIfIntercomActivatedPlayerChangedJob" )
              timer.Remove( "CheckIfPlayerEntered" )

              IntercomIsPressedByUser = false
              IntercomIsPressedUser = ""
            end
          end)

          hook.Add( "PlayerChangedTeam", "CheckIfIntercomActivatedPlayerChangedJob",function( cply3, oTeam, nTeam )

            if cply3 == ply then

              net.Start("intercom_overlay_end")
              net.Broadcast()

              intercomactivateswitch = false

              hook.Remove("PlayerCanHearPlayersVoice", "CheckIfYouCanHearHook")
              hook.Remove( "PlayerDeath", "CheckIfIntercomActivatedPlayerDied" )
              hook.Remove( "PlayerDisconnected", "CheckIfIntercomActivatedPlayerLeft" )
              hook.Remove( "PlayerChangedTeam", "CheckIfIntercomActivatedPlayerChangedJob" )
              timer.Remove( "CheckIfPlayerEntered" )

              IntercomIsPressedByUser = false
              IntercomIsPressedUser = ""
            end
          end)
          IntercomIsPressedByUser = true
          IntercomIsPressedUser = ply
          CheckIfYouCanHear( ply, validintercomplayers2, intercom_selected_lang )
        end
      end
    else
      timer.Simple( 0.2,function()
        CheckIfIntercomShouldWaitFunction()
      end)
    end
  end
  CheckIfIntercomShouldWaitFunction()
end

function ENT:Use(act, call)

    local ply = call

    if timer.Exists("IntercomPressCooldownTimer") then
    else
      timer.Create( "IntercomPressCooldownTimer", 3, 1,function()end)
      if IntercomIsPressedByUser == true then
        if ply == IntercomIsPressedUser then
          CheckIfJob(ply)
        else
        end
      else
        CheckIfJob(ply)
      end
    end
end
