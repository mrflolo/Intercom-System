util.AddNetworkString("ChangeIntercomSaveTeams")
util.AddNetworkString("ChangeIntercomSaveLang")
util.AddNetworkString("intercom_overlay_p1" )
util.AddNetworkString("intercom_overlay_p1_own" )
util.AddNetworkString("intercom_overlay_p2" )
util.AddNetworkString("intercom_overlay_p2_own" )
util.AddNetworkString("intercom_overlay_p3" )
util.AddNetworkString("intercom_overlay_p3_own" )
util.AddNetworkString("intercom_overlay_end")
util.AddNetworkString("intercomfailed" )
util.AddNetworkString("intercomfailed2" )

resource.AddFile("sound/alarm.wav")
resource.AddFile("sound/intercom.wav")

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

net.Receive( "ChangeIntercomSaveLang", function( len, ply )

  if !ply:IsSuperAdmin() then if !ply:IsAdmin() then print("ERROR ! Player has no acces") return end end

  sql.Query("DELETE FROM sv_intercom_system_saved_language")

  for j, k in pairs(net.ReadTable()) do
      sql.Query("INSERT INTO sv_intercom_system_saved_language (`lang`) VALUES ('"..k.."')")
  end

  logcount = sql.QueryValue("SELECT COUNT(lang) FROM sv_intercom_system_saved_language")

  local b2 = tonumber( logcount, 10 )

  local DataBaseOutput = {}

  for o=1, b2 do

    table.insert( DataBaseOutput, sql.QueryRow("SELECT lang FROM sv_intercom_system_saved_language", o ))

  end

  print("NOTE ! Intercom language was changed by: " .. ply:Nick() .. ", new language: ")

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

local function table_exist()
  if sql.TableExists("sv_intercom_system_saved_teams") then
    Msg("sv_intercom_system_saved_teams table exists! \n")
  else
    local query = "CREATE TABLE sv_intercom_system_saved_teams ( name varchar(255) )"
    local result = sql.Query(query)
    if sql.TableExists("sv_intercom_system_saved_teams") then
      Msg("Succes ! sv_intercom_system_saved_teams table was created \n")
    else
      Msg("Error ! Something went wrong by creating the sv_intercom_system_saved_teams table. \n")
      Msg( sql.LastError( result ) .. "\n" )
    end
  end

  if sql.TableExists("sv_intercom_system_saved_language") then
    Msg("sv_intercom_system_saved_language table exists! \n")
  else
    local query = "CREATE TABLE sv_intercom_system_saved_language ( lang varchar(255) )"
    local result = sql.Query(query)
    if sql.TableExists("sv_intercom_system_saved_language") then
      Msg("Succes ! sv_intercom_system_saved_language table was created \n")
    else
      Msg("Error ! Something went wrong by creating the sv_intercom_system_saved_language table. \n")
      Msg( sql.LastError( result ) .. "\n" )
    end
  end
end

table_exist()

timer.Simple( 0, function()
  local function intercomvers()

    print("Intercom Version v0.2-Beta")

  end

  DarkRP.defineChatCommand("intercomvers", intercomvers )
end )
