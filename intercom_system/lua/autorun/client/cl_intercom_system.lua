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

surface.CreateFont( "HudTextDefaultIntercom_Small", {
	font = "Arial",
	extended = false,
	size = 15,
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
local width = ScrW()/6.74
local text_pos_w = ScrW()/2.38
local text_pos_h = ScrH()/36
local showedtxt1 = false
local showedtxt2 = false

function IntercomSystemStartPhase2(InfosTab)

  local text = InfosTab.TransString or "NIL"

  color1 = Color(120, 200, 120 )
  color2 = Color( 80, 80, 80 )

  -- phase 2

  local DPanel_intercom_overlay_p2 = vgui.Create( "DPanel" )
  DPanel_intercom_overlay_p2:SetSize( width, 80)
  DPanel_intercom_overlay_p2:SetPos(0,0)
  DPanel_intercom_overlay_p2:CenterHorizontal(0.5)
  DPanel_intercom_overlay_p2:SetKeyboardInputEnabled(false)

  function DPanel_intercom_overlay_p2:Paint( w, h )
    draw.RoundedBox( 0, 0, 0, w, h, color1)
  end

  local DPanel_intercom_Text = vgui.Create( "DLabel", DPanel_intercom_overlay_p2 )
  DPanel_intercom_Text:SetFont("HudTextDefaultIntercom")
  DPanel_intercom_Text:SetText(text)
  DPanel_intercom_Text:SizeToContents()
  DPanel_intercom_Text:CenterHorizontal(0.5)
  DPanel_intercom_Text:SetTextColor(color2)

  local Avatar = vgui.Create( "AvatarImage", DPanel_intercom_overlay_p2 )
  Avatar:SetSize( 32, 32)
  Avatar:SetPos( 5, DPanel_intercom_overlay_p2:GetTall() - Avatar:GetTall() - 5 )
  Avatar:SetPlayer( InfosTab.Talker, 64)

  local DPanel_intercom_Text_Player = vgui.Create( "DLabel", DPanel_intercom_overlay_p2)
  DPanel_intercom_Text_Player:SetFont("HudTextDefaultIntercom_Small")
  DPanel_intercom_Text_Player:SetText(InfosTab.Talker:Nick() or "invalid player")
  DPanel_intercom_Text_Player:SizeToContents()
  DPanel_intercom_Text_Player:SetPos(Avatar:GetWide()+10, DPanel_intercom_overlay_p2:GetTall() - Avatar:GetTall()-2.5)
  DPanel_intercom_Text_Player:SetTextColor(color2)

  if LocalPlayer() == InfosTab.Talker then
		if showedtxt1 == false then
			showedtxt1 = true
	    local ChatTextP2 = InfosTab.ChatTextPhase2

	    chat.AddText( Color( 180, 20, 20 ), " !--------------------------------------------------------------------! " )
	    chat.AddText( Color( 120, 20, 20 ), "  [INTERCOM SYSTEM] ", Color( 50, 50, 50 ), ChatTextP2 )
	    chat.AddText( Color( 180, 20, 20 ), " !--------------------------------------------------------------------! " )
		end
  end

	net.Receive("intercom_overlay_end_2", function()

		DPanel_intercom_overlay_p2:Remove()

		color1 = Color( 100, 10, 5 )

		local DPanel_intercom_overlay_p3 = vgui.Create( "DPanel" )
		DPanel_intercom_overlay_p3:SetSize( width, 80 )
		DPanel_intercom_overlay_p3:SetPos(0,0)
		DPanel_intercom_overlay_p3:CenterHorizontal(0.5)
		DPanel_intercom_overlay_p3:SetKeyboardInputEnabled(false)

		function DPanel_intercom_overlay_p3:Paint( w, h )
			draw.RoundedBox( 0, 0, 0, w, h, color1 )
		end

		DPanel_intercom_overlay_p3:SetAlpha(255)
		DPanel_intercom_overlay_p3:AlphaTo( 0, 1, 0.3,function()

			timer.Simple(1.5,function()
				DPanel_intercom_overlay_p3:Remove()
			end)
		end)
	end)

  net.Receive("intercom_overlay_end", function()

    DPanel_intercom_overlay_p2:Remove()

    surface.PlaySound( "alarm.wav" )

    color1 = Color( 100, 10, 5 )

    local DPanel_intercom_overlay_p3 = vgui.Create( "DPanel" )
    DPanel_intercom_overlay_p3:SetSize( width, 80 )
    DPanel_intercom_overlay_p3:SetPos(0,0)
    DPanel_intercom_overlay_p3:CenterHorizontal(0.5)
    DPanel_intercom_overlay_p3:SetKeyboardInputEnabled(false)

    function DPanel_intercom_overlay_p3:Paint( w, h )
      draw.RoundedBox( 0, 0, 0, w, h, color1 )
    end

    DPanel_intercom_overlay_p3:SetAlpha(255)
    DPanel_intercom_overlay_p3:AlphaTo( 0, 1, 0.3,function()

      timer.Simple(1.5,function()
        DPanel_intercom_overlay_p3:Remove()
      end)
    end)

    if LocalPlayer() == InfosTab.Talker then
	  	local ChatTextP3 = InfosTab.ChatTextPhase3

	    chat.AddText( Color( 180, 20, 20 ), " !--------------------------------------------------------------------! " )
	    chat.AddText( Color( 120, 20, 20 ), "  [INTERCOM SYSTEM] ", Color( 50, 50, 50 ), ChatTextP3 )
	    chat.AddText( Color( 180, 20, 20 ), " !--------------------------------------------------------------------! " )
    end
  end)
end

net.Receive( "intercom_overlay_start", function()

	showedtxt1 = false

	surface.PlaySound( "intercom.wav" )

  local InfosTab = net.ReadTable()
  local text = InfosTab.TransString or "NIL"

  local color1 = Color(150, 150, 20)

  --phase 1

  local DPanel_intercom_overlay_p1 = vgui.Create("DPanel")
  DPanel_intercom_overlay_p1:SetSize( width, 80)
  DPanel_intercom_overlay_p1:SetPos(0,0)
  DPanel_intercom_overlay_p1:CenterHorizontal(0.5)
  DPanel_intercom_overlay_p1:SetKeyBoardInputEnabled(false)

  function DPanel_intercom_overlay_p1:Paint( w, h )
    draw.RoundedBox(0, 0, 0, w, h, color1)
  end

  DPanel_intercom_overlay_p1:SetAlpha(0)

  DPanel_intercom_overlay_p1:AlphaTo( 255, InfosTab.TimerLen or 2.3, 0,function()
    timer.Simple(0.3,function()
      DPanel_intercom_overlay_p1:Remove()
    end)
  end)
  timer.Simple(InfosTab.TimerLen or 2.3, function()
    IntercomSystemStartPhase2(InfosTab)
  end)
end)

net.Receive("intercom_overlay_start_2", function()
  local InfosTab = net.ReadTable()
  IntercomSystemStartPhase2(InfosTab)
end)

net.Receive("intercomfailed", function()

	local intercom_tx3_table = net.ReadTable()
	local intercom_txt3 = intercom_tx3_table[1]
	local intercom__err_txt = intercom_tx3_table[2]

	chat.AddText( Color( 180, 20, 20 ), " !---------------"..intercom__err_txt.."---------------! ")
	chat.AddText( Color( 120, 20, 20 ), "  [INTERCOM SYSTEM] ",  Color( 50, 50, 50 ), intercom_txt3 )
	chat.AddText( Color( 180, 20, 20 ), " !--------------------------------------------------------------------! ")

end)

net.Receive("intercomfailed2", function()

	local intercom_tx4_table = net.ReadTable()
	local intercom_txt4 = intercom_tx4_table[1]
	local intercom__err_txt = intercom_tx4_table[2]

	chat.AddText( Color( 180, 20, 20 ), " !---------------"..intercom__err_txt.."---------------! ")
	chat.AddText( Color( 120, 20, 20 ), "  [INTERCOM SYSTEM] ", Color( 50, 50, 50 ), intercom_txt4 )
	chat.AddText( Color( 180, 20, 20 ), " !-------------------------------------------------------------------! ")

end)
