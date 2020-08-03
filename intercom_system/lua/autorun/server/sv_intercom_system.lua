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

net.Receive("GetIntercomZones",function( l, ply )
  if !ply:IsSuperAdmin() then if !ply:IsAdmin() then print("ERROR ! Player has no acces") return end end

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

  net.Start("SendIntercomZones")
  net.WriteTable(IntercomZoneCords)
  net.Send(ply)

end)

net.Receive("SaveNewIntercomZone",function( l, ply )
  if !ply:IsSuperAdmin() then if !ply:IsAdmin() then print("ERROR ! Player has no acces") return end end

  local CordTable = net.ReadTable()

  local CordTable_1 = CordTable[1]
  local CordTable_2 = CordTable[2]

  local SQLquery = sql.Query("INSERT INTO sv_intercom_system_saved_zonestable (`cord1_x`, `cord1_y`, `cord1_z`, `cord2_x`, `cord2_y`, `cord2_z`) VALUES ('"..CordTable_1.x.."', '"..CordTable_1.y.."', '"..CordTable_1.z.."', '"..CordTable_2.x.."', '"..CordTable_2.y.."', '"..CordTable_2.z.."')")

  if SQLquery == false then
    Msg("Error ! Something went wrong by creating the zone table. \n")
    Msg( sql.LastError( SQLquery ) .. "\n" )
  end

end)

net.Receive( "RemoveIntercomZone", function( l, ply )

  if !ply:IsSuperAdmin() then if !ply:IsAdmin() then print("ERROR ! Player has no acces") return end end

  local SQLSaveTable = net.ReadTable()

  local SQLquery = sql.Query("DELETE FROM sv_intercom_system_saved_zonestable WHERE cord1_x='"..SQLSaveTable[1].."' and cord1_y='"..SQLSaveTable[2].."' and cord1_z='"..SQLSaveTable[3].."' and cord2_x='"..SQLSaveTable[4].."' and cord2_y='"..SQLSaveTable[5].."' and cord2_z='"..SQLSaveTable[6].."'")

  if SQLquery == false then
    Msg("Error ! Something went wrong by deleting the zone table. \n")
    Msg( sql.LastError( SQLquery ) .. "\n" )
  end
end)
