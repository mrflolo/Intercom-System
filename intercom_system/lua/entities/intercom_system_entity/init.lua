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

function CheckIfYouCanHear( ply, validintercomplayers )

  local validintercomplayers2 = validintercomplayers
  local validintercomplayers3 = validintercomplayers

    if intercomactivateswitch == false then
        for g, h in pairs(validintercomplayers2) do
          if h:IsPlayer() then
            net.Start("intercom_overlay_p1")
            net.Send(h)
          end
        end

        timer.Simple(2.3,function()

          local intercom_selected_lang = sql.QueryValue("SELECT lang FROM sv_intercom_system_saved_language")

          if intercom_selected_lang == "GER" then
              net.Start("intercom_overlay_p2_own")
              net.WriteString("Übertragung gestartet")
              net.Send(ply)
          elseif intercom_selected_lang == "POL" then
              net.Start("intercom_overlay_p2_own")
              net.WriteString("transmisja rozpoczęta")
              net.Send(ply)
          elseif intercom_selected_lang == "FR" then
              net.Start("intercom_overlay_p2_own")
              net.WriteString("la transmission a commencé")
              net.Send(ply)
          else
            net.Start("intercom_overlay_p2_own")
            net.WriteString("transmission started")
            net.Send(ply)
          end

          for o, p in pairs(validintercomplayers2) do
            if p:IsPlayer() then
              if intercom_selected_lang == "GER" then
                net.Start("intercom_overlay_p2")
                net.WriteString("Intercom überträgt")
                net.Send(p)
              elseif intercom_selected_lang == "POL" then
                net.Start("intercom_overlay_p2")
                net.WriteString("transmisje interkomowe")
                net.Send(p)
              elseif intercom_selected_lang == "FR" then
                net.Start("intercom_overlay_p2")
                net.WriteString("l'interphone transmet")
                net.Send(p)
              else
                net.Start("intercom_overlay_p2")
                net.WriteString("intercom transmits")
                net.Send(p)
              end
            end
          end

          timer.Create( "CheckIfPlayerEntered", 5, 0,function()

            local InBoxPlayer2 = {}

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
              timer.Simple( 0.05,function()
                table.Add( InBoxPlayer, ents.FindInBox( g[1], g[2] ) )
              end)
            end


            table.Empty( validintercomplayers3 )

            for y, x in pairs(InBoxPlayer2) do
              if table.IsEmpty(validintercomplayers2) then
                if x:IsPlayer() then
                  table.insert( validintercomplayers3, x )
                end
              else
                for f, g in pairs(validintercomplayers2) do
                  if x == g then
                  else
                    if x:IsPlayer() then
                      table.insert( validintercomplayers3, x )
                    end
                  end
                end
              end
            end

            local intercom_selected_lang = sql.QueryValue("SELECT lang FROM sv_intercom_system_saved_language")

            for o, p in pairs(validintercomplayers3) do
              if p:IsPlayer() then
                if intercom_selected_lang == "GER" then
                  net.Start("intercom_overlay_p2")
                  net.WriteString("Intercom überträgt")
                  net.Send(p)
                elseif intercom_selected_lang == "POL" then
                  net.Start("intercom_overlay_p2")
                  net.WriteString("transmisje interkomowe")
                  net.Send(p)
                elseif intercom_selected_lang == "FR" then
                  net.Start("intercom_overlay_p2")
                  net.WriteString("l'interphone transmet")
                  net.Send(p)
                else
                  net.Start("intercom_overlay_p2")
                  net.WriteString("intercom transmits")
                  net.Send(p)
                end
              end
            end

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
          end)

        hook.Add("PlayerCanHearPlayersVoice", "CheckIfYouCanHearHook", function(listener, talker)

            if talker == ply then
                for t, z in pairs(validintercomplayers2) do
                  if z:IsPlayer() then
                    if z == listener then
                    return true
                    end
                  end
                end
            end
        end)
        intercomactivateswitch = true
      end)

    else

      local intercom_selected_lang = sql.QueryValue("SELECT lang FROM sv_intercom_system_saved_language")

      if intercom_selected_lang == "GER" then
        net.Start("intercom_overlay_p3_own")
        net.WriteString("Übertragung beendet")
        net.Send(ply)
      elseif intercom_selected_lang == "POL" then
        net.Start("intercom_overlay_p3_own")
        net.WriteString("transmisja zakończona")
        net.Send(ply)
      elseif intercom_selected_lang == "FR" then
        net.Start("intercom_overlay_p3_own")
        net.WriteString("transmission terminée")
        net.Send(ply)
      else
        net.Start("intercom_overlay_p3_own")
        net.WriteString("transmission finished")
        net.Send(ply)
      end

        for o, p in pairs(validintercomplayers2) do
          if p:IsPlayer() then
            if intercom_selected_lang == "GER" then
              net.Start("intercom_overlay_p3")
              net.WriteString("Übertragung beendet")
              net.Send(p)
            elseif intercom_selected_lang == "POL" then
              net.Start("intercom_overlay_p3")
              net.WriteString("transmisja zakończona")
              net.Send(p)
            elseif intercom_selected_lang == "FR" then
              net.Start("intercom_overlay_p3")
              net.WriteString("transmission terminée")
              net.Send(p)
            else
              net.Start("intercom_overlay_p3")
              net.WriteString("transmission finished")
              net.Send(p)
            end
          end
        end

        table.Empty(validintercomplayers2)

        hook.Remove( "PlayerCanHearPlayersVoice", "CheckIfYouCanHearHook" )
        hook.Remove( "PlayerDeath", "CheckIfIntercomActivatedPlayerDied" )
        hook.Remove( "PlayerDisconnected", "CheckIfIntercomActivatedPlayerLeft" )
        hook.Remove( "PlayerChangedTeam", "CheckIfIntercomActivatedPlayerChangedJob" )
        timer.Remove("CheckIfPlayerEntered")

        IntercomIsPressedByUser = false
        IntercomIsPressedUser = ""

        intercomactivateswitch = false
    end
end

function CheckIfJob(ply)

    logcount = sql.QueryValue("SELECT COUNT(name) FROM sv_intercom_system_saved_teams")

    local b2 = tonumber( logcount, 10 )

    local check_jobs_1 = {}

    for o=1, b2 do

    	table.insert( check_jobs_1, sql.QueryRow("SELECT name FROM sv_intercom_system_saved_teams", o ))

    end

    local validintercomplayers = {}

    local InBoxPlayer = {}

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
        table.Add( InBoxPlayer, ents.FindInBox( g[1], g[2] ) )
    end

    table.Empty( validintercomplayers )

    for y, x in pairs(InBoxPlayer) do
      if table.IsEmpty(validintercomplayers) then
        if x:IsPlayer() then
          table.insert( validintercomplayers, x )
        end
      else
        for f, g in pairs(validintercomplayers) do
          if x == g then
          else
            if x:IsPlayer() then
              table.insert( validintercomplayers, x )
            end
          end
        end
      end
    end

    local counter = 0
    for j, l in pairs(check_jobs_1) do
        if team.GetName(ply:Team()) == l.name then
          counter = counter + 1
          for c, v in pairs(validintercomplayers) do
            if ply == v then
              counter = counter + 1
            end
          end
        end
    end

    if counter == 0 then

      local intercom_selected_lang = sql.QueryValue("SELECT lang FROM sv_intercom_system_saved_language")

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

      local intercom_selected_lang = sql.QueryValue("SELECT lang FROM sv_intercom_system_saved_language")

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
        CheckIfYouCanHear( ply, validintercomplayers )
      else
        hook.Add( "PlayerDeath", "CheckIfIntercomActivatedPlayerDied",function( cply1, inflictor, attacker )

          if cply1 == ply then
            for o, p in pairs(player.GetAll()) do
                net.Start("intercom_overlay_end")
                net.Send(p)
            end
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
            for o, p in pairs(player.GetAll()) do
                net.Start("intercom_overlay_end")
                net.Send(p)
            end
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
            for o, p in pairs(player.GetAll()) do
                net.Start("intercom_overlay_end")
                net.Send(p)
            end
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
        CheckIfYouCanHear( ply, validintercomplayers )
      end
    end
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
