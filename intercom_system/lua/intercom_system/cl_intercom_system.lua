surface.CreateFont( "HudTextDefaultRevolte", {
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

--Coordinaten
local pos_w = ScrW()/2.25
local width = ScrW()/8
local text_pos_w = ScrW()/2.23
local text_pos_h = ScrH()/36
local color1
local color2
local text

--Verschiedene Stadien des User Overlays

net.Receive( "intercom_overlay_p1",
function()

	surface.PlaySound( intercom_system_config.StartSound )

	color1 = Vector(150,150,20)
	color2 = Vector(80, 80, 80)
	text = " "

	hook.Add("HUDPaint", "IntercomDrawInfoMessageHook", function()

		draw.RoundedBox(14, pos_w, 0, width, 80, color1)
		draw.DrawText(text, "HudTextDefaultRevolte", text_pos_w, text_pos_h, color2)

	end)

end)
net.Receive( "intercom_overlay_p2",
function()

	hook.Remove("HUDPaint", "IntercomDrawInfoMessageHook")

	color1 = Vector(120,200,120)
	color2 = Vector(80, 80, 80)
	text = intercom_system_config.txt2

	hook.Add("HUDPaint", "IntercomDrawInfoMessageHook", function()

		draw.RoundedBox(14, pos_w, 0, width, 80, color1)
		draw.DrawText(text, "HudTextDefaultRevolte", text_pos_w, text_pos_h, color2)

	end)

end)
net.Receive( "intercom_overlay_p3",
function()

	hook.Remove("HUDPaint", "IntercomDrawInfoMessageHook")

	surface.PlaySound( intercom_system_config.EndSound )

	color1 = Vector(100,10,5)
	color2 = Vector(200, 200, 200)
	text = " "

	hook.Add("HUDPaint", "IntercomDrawInfoMessageHook", function()

		draw.RoundedBox(14, pos_w, 0, width, 80, color1)
		draw.DrawText(text, "HudTextDefaultRevolte", text_pos_w, text_pos_h, color2)

	end)

	timer.Simple( 1,function()

		hook.Remove("HUDPaint", "IntercomDrawInfoMessageHook")

	end)

end)

net.Receive( "intercom_overlay_end",function()

	hook.Remove("HUDPaint", "IntercomDrawInfoMessageHook")

end)

net.Receive( "intercom_overlay_p1_own",function()


end)

net.Receive( "intercom_overlay_p2_own",function()

	chat.AddText( Color( 180, 20, 20 ), " !---------------------------------------------------------! " )
	chat.AddText( Color( 120, 20, 20 ), "  [INTERCOM SYSTEM] ", Color( 50, 50, 50 ), intercom_system_config.txt5 )
	chat.AddText( Color( 180, 20, 20 ), " !---------------------------------------------------------! " )

end)

net.Receive( "intercom_overlay_p3_own",function()

	chat.AddText( Color( 180, 20, 20 ), " !---------------------------------------------------------! " )
	chat.AddText( Color( 120, 20, 20 ), "  [INTERCOM SYSTEM] ", Color( 50, 50, 50 ), intercom_system_config.txt6 )
	chat.AddText( Color( 180, 20, 20 ), " !---------------------------------------------------------! " )

end)

net.Receive("intercomfailed", function()

		chat.AddText( Color( 180, 20, 20 ), " !---------------KRITISCHER-SYSTEMFEHLER---------------! " )
		chat.AddText( Color( 120, 20, 20 ), "  [INTERCOM SYSTEM] ",  Color( 50, 50, 50 ), intercom_system_config.txt7 )
		chat.AddText( Color( 180, 20, 20 ), " !---------------------------------------------------------------! " )

end)

net.Receive("intercomfailed2", function()

		chat.AddText( Color( 180, 20, 20 ), " !-------------KRITISCHER-SYSTEMFEHLER-------------! " )
		chat.AddText( Color( 120, 20, 20 ), "  [INTERCOM SYSTEM] ", Color( 50, 50, 50 ), intercom_system_config.txt8 )
		chat.AddText( Color( 180, 20, 20 ), " !-----------------------------------------------------------! " )

end)
