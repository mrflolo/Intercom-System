include("intercom_system/sh_intercom_system_config.lua")
include("shared.lua")

surface.CreateFont( "TheDefaultSettings", {
	font = "Arial",
	extended = false,
	size = 30,
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

-- 3D text wird erstellt
local function Draw3DText( pos, ang, scale, text, flipView )
	if ( flipView ) then
		ang:RotateAroundAxis( Vector( 0, 0, 1 ), 180 )
	end

	cam.Start3D2D( pos, ang, scale )
		-- Erstellt den text wirklich
		draw.DrawText( text, "TheDefaultSettings", 0, 0, Color(80, 80, 80, 255 ), TEXT_ALIGN_CENTER )
	cam.End3D2D()
end

function ENT:Draw()
	-- Model wird erstellt
	self:DrawModel()

	-- Text der angezeigt wird
	local text = "intercom system"

	local mins, maxs = self:GetModelBounds()
	local pos = self:GetPos() + Vector( 0, 0, maxs.z + 8 )

	-- Grad zahl
	local ang = Angle( 0, SysTime() * 100 % 360, 90 )

	-- font wird gemalt
	Draw3DText( pos, ang, 0.2, text, false )

	Draw3DText( pos, ang, 0.2, text, true )
end
