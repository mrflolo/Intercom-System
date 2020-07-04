util.AddNetworkString("intercom_overlay_p1" )
util.AddNetworkString("intercom_overlay_p1_own" )

util.AddNetworkString("intercom_overlay_p2" )
util.AddNetworkString("intercom_overlay_p2_own" )

util.AddNetworkString("intercom_overlay_p3" )
util.AddNetworkString("intercom_overlay_p3_own" )

util.AddNetworkString("intercom_overlay_end")

util.AddNetworkString("intercomfailed" )
util.AddNetworkString("intercomfailed2" )

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

local function Initialize()
  table_exist()
end

hook.Add( "Initialize", "InitializeForIntercomDBCheck", Initialize )

timer.Simple( 0, function()
  local function intercomvers()

    print("Intercom Version 0.2-Alpha")

  end

  DarkRP.defineChatCommand("intercomvers", intercomvers )
end )
