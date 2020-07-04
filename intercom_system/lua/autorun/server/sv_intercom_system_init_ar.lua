util.AddNetworkString("ChangeIntercomSaveTeams")
util.AddNetworkString("ChangeIntercomSaveLang")

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
