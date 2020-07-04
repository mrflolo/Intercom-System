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
local pos_w = ScrW()/2.4
local width = ScrW()/6.74
local text_pos_w = ScrW()/2.38
local text_pos_h = ScrH()/36
local color1
local color2
local text

--Verschiedene Stadien des User Overlays

net.Receive( "intercom_overlay_p1",
function()

	surface.PlaySound( "intercom.wav" )

	color1 = Vector(150,150,20)

	hook.Add("HUDPaint", "IntercomDrawInfoMessageHook", function()

		draw.RoundedBox(5, pos_w, 0, width, 80, color1)

	end)

end)
net.Receive( "intercom_overlay_p2",
function()

	hook.Remove("HUDPaint", "IntercomDrawInfoMessageHook")

	color1 = Vector(120,200,120)
	color2 = Vector(80, 80, 80)
	text = net.ReadString()

	hook.Add("HUDPaint", "IntercomDrawInfoMessageHook", function()

		draw.RoundedBox(5, pos_w, 0, width, 80, color1)
		draw.DrawText(text, "HudTextDefaultRevolte", text_pos_w, text_pos_h, color2)

	end)

end)
net.Receive( "intercom_overlay_p3",
function()

	hook.Remove("HUDPaint", "IntercomDrawInfoMessageHook")

	surface.PlaySound( "alarm.wav" )

	color1 = Vector(100,10,5)

	hook.Add("HUDPaint", "IntercomDrawInfoMessageHook", function()

		draw.RoundedBox(5, pos_w, 0, width, 80, color1)

	end)

	timer.Simple( 1,function()

		hook.Remove("HUDPaint", "IntercomDrawInfoMessageHook")

	end)

end)

net.Receive( "intercom_overlay_end",function()

	hook.Remove("HUDPaint", "IntercomDrawInfoMessageHook")

end)

net.Receive( "intercom_overlay_p2_own",function()

	local intercom_txt1 = ""

	intercom_txt1 = net.ReadString()

	chat.AddText( Color( 180, 20, 20 ), " !--------------------------------------------------------------------! " )
	chat.AddText( Color( 120, 20, 20 ), "  [INTERCOM SYSTEM] ", Color( 50, 50, 50 ), intercom_txt1 )
	chat.AddText( Color( 180, 20, 20 ), " !--------------------------------------------------------------------! " )

end)

net.Receive( "intercom_overlay_p3_own",function()

	local intercom_txt2 = ""

	intercom_txt2 = net.ReadString()

	chat.AddText( Color( 180, 20, 20 ), " !--------------------------------------------------------------------! " )
	chat.AddText( Color( 120, 20, 20 ), "  [INTERCOM SYSTEM] ", Color( 50, 50, 50 ), intercom_txt2 )
	chat.AddText( Color( 180, 20, 20 ), " !--------------------------------------------------------------------! " )

end)

net.Receive("intercomfailed", function()

	local intercom_tx3_table = net.ReadTable()
	local intercom_txt3 = ""
	local intercom__err_txt = ""

	intercom_txt3 = intercom_tx3_table[1]
	intercom__err_txt = intercom_tx3_table[2]



	chat.AddText( Color( 180, 20, 20 ), " !---------------"..intercom__err_txt.."---------------! " )
	chat.AddText( Color( 120, 20, 20 ), "  [INTERCOM SYSTEM] ",  Color( 50, 50, 50 ), intercom_txt3 )
	chat.AddText( Color( 180, 20, 20 ), " !--------------------------------------------------------------------! " )

end)

net.Receive("intercomfailed2", function()

	local intercom_tx4_table = net.ReadTable()
	local intercom_txt4 = ""
	local intercom__err_txt = ""

	intercom_txt4 = intercom_tx4_table[1]
	intercom__err_txt = intercom_tx4_table[2]

	chat.AddText( Color( 180, 20, 20 ), " !---------------"..intercom__err_txt.."---------------! " )
	chat.AddText( Color( 120, 20, 20 ), "  [INTERCOM SYSTEM] ", Color( 50, 50, 50 ), intercom_txt4 )
	chat.AddText( Color( 180, 20, 20 ), " !-------------------------------------------------------------------! " )

end)
