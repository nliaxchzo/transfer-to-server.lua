ENT.Base 		= 'base_ai'
ENT.Type 		= 'ai'
ENT.PrintName		= 'script'
ENT.Author 		= 'senpachz'
ENT.Contact	 	= ''
ENT.Category 		= 'senpachz-script'
ENT.Spawnable 		= true
ENT.AdminSpawnable 	= true

if SERVER then
AddCSLuaFile()
function ENT:Initialize()
	self:SetModel("models/Humans/Group02/male_06.mdl") -- модель
	self:SetHullType(HULL_HUMAN)
	self:SetHullSizeNormal()
	self:SetNPCState(NPC_STATE_SCRIPT)
	self:SetSolid(SOLID_BBOX)
	self:SetUseType(SIMPLE_USE)
	self:SetBloodColor(BLOOD_COLOR_RED)
	self:CapabilitiesAdd(bit.bor(CAP_ANIMATEDFACE, CAP_TURN_HEAD))
end

util.AddNetworkString 'script.senpachz'

function ENT:AcceptInput(name, ply, caller)
	if not ply:IsValid() or not ply:IsPlayer() then return end
	net.Start('script.senpachz')
	net.Send(ply)
end

elseif CLIENT then

surface.CreateFont('script.senpachz.fonts', {
	size = 64,
	weight = 350,
	antialias = true,
	extended = true,
	font = "Roboto"
})

function ENT:Draw()
	self:DrawModel()
	local pos = self:GetPos()
	if EyePos():DistToSqr(pos) < 40000 then
		local ang = self:GetAngles()
		ang:RotateAroundAxis(ang:Up(), 90)
		ang:RotateAroundAxis(ang:Forward(), 90)
		ang:RotateAroundAxis(ang:Right(), 0)
		cam.Start3D2D(pos, ang, 0.1)
			draw.SimpleText('Переехать в другой город', 'script.senpachz.fonts', 0, -800, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
		cam.End3D2D()
	end
end

net.Receive('script.senpachz', function(len)
	Derma_Query('Ты действительно хочешь:\nПоехать в другой город под названием rp_downtown_tits_v2 ?', 'Переехать',
		'Да', function()
			LocalPlayer():ConCommand('connect АЙПИ)
		end, 'Нет'
	)
end)
end

