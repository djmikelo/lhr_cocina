local keys = { ['G'] = 0x760A9C6F, ['S'] = 0xD27782E3, ['W'] = 0x8FD015D8, ['H'] = 0x24978A28, ['G'] = 0x5415BE48, ["ENTER"] = 0xC7B5340A, ['E'] = 0xDFF812F9,["BACKSPACE"] = 0x156F7119 }
local campfire = 0

--menu
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local x, y, z = table.unpack(GetEntityCoords(PlayerPedId()))
		--local campfire = GetClosestObjectOfType(x, y, z, 3.0, GetHashKey("p_campfire02x"), true)
		--local cauldron = GetClosestObjectOfType(x, y, z, 3.0, GetHashKey("S_CAMPFIRECOMBINED01X"), true)
		
		local cauldron = DoesObjectOfTypeExistAtCoords(x, y, z, 1.5, GetHashKey("S_CAMPFIRECOMBINED01X"), true)
		local campfire = DoesObjectOfTypeExistAtCoords(x, y, z, 1.5, GetHashKey("p_campfire02x"), true)
		
		if cauldron or campfire then 
            TriggerEvent("vorp:TipBottom", "Pulsa G para cocinar", 100)
			if IsControlJustReleased(0, 0x760A9C6F) then -- g
				TriggerEvent("def_cookfood:cookchad")
			end
		end
	end
end)

Citizen.CreateThread(function()
    WarMenu.CreateMenu('campfire', "Cocina")
    WarMenu.SetSubTitle('campfire', 'prepara tu comida')
    WarMenu.CreateSubMenu('cook', 'campfire', 'prepara tu comida')
  

    while true do
        local ped = GetPlayerPed(-1)
        local coords = GetEntityCoords(PlayerPedId())

        if WarMenu.IsMenuOpened('campfire') then
            if WarMenu.MenuButton('Cocina', 'cook') then
            end
            WarMenu.Display()
        elseif WarMenu.IsMenuOpened('cook') then
            if WarMenu.Button('Cocinar carne de cerdo') then
					TriggerServerEvent("def_cookfood:pork")
                    WarMenu.CloseMenu()
            elseif WarMenu.Button('Cocinar carne correosa') then
                       TriggerServerEvent("def_cookfood:stringy")
                       WarMenu.CloseMenu()
            elseif WarMenu.Button('Cocinar carne de venado') then
                       TriggerServerEvent("def_cookfood:venison")
                       WarMenu.CloseMenu()
            elseif WarMenu.Button('Cocinar carne de cordero') then
                       TriggerServerEvent("def_cookfood:game")
                       WarMenu.CloseMenu()
            elseif WarMenu.Button('Cocinar carne de ave') then
                       TriggerServerEvent("def_cookfood:bird")
                       WarMenu.CloseMenu()
            elseif WarMenu.Button('Cocinar carne de caza mayor') then
                       TriggerServerEvent("def_cookfood:biggame")
                       WarMenu.CloseMenu()
			end
   
            WarMenu.Display()
		
        end
        Citizen.Wait(0)
    end
end)

--RegisterCommand("cookfood", function(source, args, rawCommand) -- craft COMMAND
AddEventHandler('def_cookfood:cookchad', function()
local _source = source
		if campfire ~= 0 then
            SetEntityAsMissionEntity(campfire)
            DeleteObject(campfire)
            campfire = 0
            end
            local playerPed = PlayerPedId()
			Citizen.Wait(0)
            ClearPedTasksImmediately(PlayerPedId())
			WarMenu.OpenMenu('campfire')
            TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_CROUCH_INSPECT'), -1, true, false, false, false)
       
            local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 2.0, -1.55))
            --local prop = CreateObject(GetHashKey("p_campfire02x"), x, y, z, true, false, true)
            SetEntityHeading(prop, GetEntityHeading(PlayerPedId()))
            PlaceObjectOnGroundProperly(prop)
            campfire = prop

--end, false)
end)

Citizen.CreateThread(function()
    while true do
	local playerPed = PlayerPedId()
        Citizen.Wait(0)
		
        if whenKeyJustPressed(keys['BACKSPACE']) then
            if campfire ~= 0 then
            SetEntityAsMissionEntity(campfire)
            DeleteObject(campfire)
			ClearPedTasksImmediately(PlayerPedId())
            campfire = 0
            end
     end
	end
end)


--- Settings ProgressBars ---

--- Fleisch --- 

RegisterNetEvent('def_cookfood:cookmeat')
AddEventHandler('def_cookfood:cookmeat', function()

    local playerPed = PlayerPedId()
    --TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_CROUCH_INSPECT'), 27000, true, false, false, false)
    exports['progressBars']:startUI(27000, "Cocinando...")
   -- Citizen.Wait(27000)
   -- ClearPedTasksImmediately(PlayerPedId())

end)

function whenKeyJustPressed(key)
    if Citizen.InvokeNative(0x580417101DDB492F, 0, key) then
        return true
    else
        return false
    end
end
-----------------------------------------------------------COOKING 
RegisterNetEvent("theranch_cooking:setHealthC")
AddEventHandler("theranch_cooking:setHealthC", function()
    local target = PlayerPedId()
    local health = Citizen.InvokeNative(0x36731AC041289BB1, target, 0)
    Citizen.InvokeNative(0xC6258F41D86676E0, target, 0, health + 50)
end)

function GetClosestPlayer()
    local players, closestDistance, closestPlayer = GetActivePlayers(), -1, -1
    local playerPed, playerId = PlayerPedId(), PlayerId()
    local coords, usePlayerPed = coords, false
    
    if coords then
        coords = vector3(coords.x, coords.y, coords.z)
    else
        usePlayerPed = true
        coords = GetEntityCoords(playerPed)
    end
    
    for i=1, #players, 1 do
        local tgt = GetPlayerPed(players[i])

        if not usePlayerPed or (usePlayerPed and players[i] ~= playerId) then

            local targetCoords = GetEntityCoords(tgt)
            local distance = #(coords - targetCoords)

            if closestDistance == -1 or closestDistance > distance then
                closestPlayer = players[i]
                closestDistance = distance
            end
        end
    end
    return closestPlayer, closestDistance
end

RegisterNetEvent("theranch_cooking:setPHealth")
AddEventHandler("theranch_cooking:setPHealth", function()
    local health = Citizen.InvokeNative(0x36731AC041289BB1, PlayerPedId(), 0)
    Citizen.InvokeNative(0xC6258F41D86676E0, PlayerPedId(), 0, health + 10)
end)

--Citizen.CreateThread(function()
  --  for k,v in pairs(Config.Pharmacies) do
  --      local blip = N_0x554d9d53f696d002(1664425300, v)
     --   SetBlipSprite(blip, Config.BlipSprite, 1)
    --    SetBlipScale(blip, Config.BlipScale)
    --   Citizen.InvokeNative(0x9CB1A1623062F402, blip, Config.BlipName)
  --  end
--end)

RegisterNetEvent("theranch_cooking:showprompt")
AddEventHandler("theranch_cooking:showprompt", function(msg)
    SetTextScale(0.5, 0.5)
    local str = Citizen.InvokeNative(0xFA925AC00EB830B9, 10, "LITERAL_STRING", msg, Citizen.ResultAsLong())
    Citizen.InvokeNative(0xFA233F8FE190514C, str)
    Citizen.InvokeNative(0xE9990552DEC71600)
end)