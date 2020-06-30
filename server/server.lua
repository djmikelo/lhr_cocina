local data = {}
Citizen.CreateThread(function()
    data = exports.vorp_inventory:vorp_inventoryApi()
end) 

RegisterServerEvent('def_cookfood:pork')
AddEventHandler("def_cookfood:pork", function(name, weapon)
    local _source = tonumber(source)
    --TriggerEvent('vorp:getCharacter', _source, function(user)
		local count = data.getItemCuantity(_source, "pork")
		if count >= 1 then
		
			data.subItem(_source,"pork", 1)
			
          TriggerClientEvent('def_cookfood:cookmeat', _source)
		  
          Citizen.Wait(26000)
		  
                data.addItem(_source,"consumable_meat_gristly", 1)
                TriggerClientEvent("vorp:NotifyLeft", _source, "~t6~¡Cocinado!", "¡Carne cocinada!", "generic_textures", "tick", 3000)
        else
            TriggerClientEvent("vorp:NotifyLeft", _source, "~e~¡Error!", "Necesitas carne de cerdo cruda", "menu_textures", "cross", 3000)
        end
    end)
--end)

RegisterServerEvent('def_cookfood:stringy')
AddEventHandler("def_cookfood:stringy", function(name, weapon)
    local _source = tonumber(source)
    --TriggerEvent('vorp:getCharacter', _source, function(user)
		local count = data.getItemCuantity(_source, "stringy")
		if count >= 1 then
		
			data.subItem(_source,"stringy", 1)
			
          TriggerClientEvent('def_cookfood:cookmeat', _source)
		  
          Citizen.Wait(26000)
		  
                data.addItem(_source,"consumable_stringy", 1)
                TriggerClientEvent("vorp:NotifyLeft", _source, "~t6~¡Cocinado!", "¡Carne cocinada!", "generic_textures", "tick", 3000)
        else
            TriggerClientEvent("vorp:NotifyLeft", _source, "~e~¡Error!", "Necesitas carne correosa cruda", "menu_textures", "cross", 3000)
        end
    end)
--end)

RegisterServerEvent('def_cookfood:venison')
AddEventHandler("def_cookfood:venison", function(name, weapon)
    local _source = tonumber(source)
    --TriggerEvent('vorp:getCharacter', _source, function(user)
		local count = data.getItemCuantity(_source, "venison")
		if count >= 1 then
		
			data.subItem(_source,"venison", 1)
			
          TriggerClientEvent('def_cookfood:cookmeat', _source)
		  
          Citizen.Wait(26000)
		  
                data.addItem(_source,"consumable_meat_mature", 1)
                TriggerClientEvent("vorp:NotifyLeft", _source, "~t6~¡Cocinado!", "¡Carne cocinada!", "generic_textures", "tick", 3000)
        else
            TriggerClientEvent("vorp:NotifyLeft", _source, "~e~¡Error!", "Necesitas carne de venado cruda", "menu_textures", "cross", 3000)
        end
    end)
--end)

RegisterServerEvent('def_cookfood:game')
AddEventHandler("def_cookfood:game", function(name, weapon)
    local _source = tonumber(source)
    --TriggerEvent('vorp:getCharacter', _source, function(user)
		local count = data.getItemCuantity(_source, "game")
		if count >= 1 then
		
			data.subItem(_source,"game", 1)
			
          TriggerClientEvent('def_cookfood:cookmeat', _source)
		  
          Citizen.Wait(26000)
		  
                data.addItem(_source,"consumable_meat_mature", 1)
                TriggerClientEvent("vorp:NotifyLeft", _source, "~t6~¡Cocinado!", "¡Carne cocinada!", "generic_textures", "tick", 3000)
        else
            TriggerClientEvent("vorp:NotifyLeft", _source, "~e~¡Error!", "Necesitas carne de cordero cruda", "menu_textures", "cross", 3000)
        end
    end)
--end)

RegisterServerEvent('def_cookfood:bird')
AddEventHandler("def_cookfood:bird", function(name, weapon)
    local _source = tonumber(source)
    --TriggerEvent('vorp:getCharacter', _source, function(user)
		local count = data.getItemCuantity(_source, "bird")
		if count >= 1 then
		
			data.subItem(_source,"bird", 1)
			
          TriggerClientEvent('def_cookfood:cookmeat', _source)
		  
          Citizen.Wait(26000)
		  
                data.addItem(_source,"consumable_meat_bird", 1)
                TriggerClientEvent("vorp:NotifyLeft", _source, "~t6~¡Cocinado!", "¡Carne cocinada!", "generic_textures", "tick", 3000)
        else
            TriggerClientEvent("vorp:NotifyLeft", _source, "~e~¡Error!", "Necesitas carne de ave cruda", "menu_textures", "cross", 3000)
        end
    end)
--end)

RegisterServerEvent('def_cookfood:biggame')
AddEventHandler("def_cookfood:biggame", function(name, weapon)
    local _source = tonumber(source)
    --TriggerEvent('vorp:getCharacter', _source, function(user)
		local count = data.getItemCuantity(_source, "biggame")
		if count >= 1 then
		
			data.subItem(_source,"biggame", 1)
			
          TriggerClientEvent('def_cookfood:cookmeat', _source)
		  
          Citizen.Wait(26000)
		  
                data.addItem(_source,"consumable_meat_mature", 1)
                TriggerClientEvent("vorp:NotifyLeft", _source, "~t6~¡Cocinado!", "¡Carne cocinada!", "generic_textures", "tick", 3000)
        else
            TriggerClientEvent("vorp:NotifyLeft", _source, "~e~¡Error!", "Necesitas carne de caza mayor cruda", "menu_textures", "cross", 3000)
        end
    end)
--end)
------------------------------------------------------------------------------------
local data = {}
TriggerEvent("redemrp_inventory:getData",function(call)
    data = call
end)

RegisterServerEvent("RegisterUsableItem:cookedmeat")
AddEventHandler("RegisterUsableItem:cookedmeat", function(source)
    local _source = source
    TriggerClientEvent("theranch_cooking:setPHealth", _source)
    data.subItem(_source, "cookedmeat", 1)
    TriggerClientEvent("redemrp_notification:start", _source, "You've eat", 3, "success")
end)


RegisterServerEvent("theranch_cooking:setHealthS")
AddEventHandler("theranch_cooking:setHealthS", function(source, target)
    local _source = source
    TriggerEvent("vorp:getCharacter", target, function()
        TriggerClientEvent("theranch_cooking:setHealthC", target)
    end)
    data.subItem(_source, "mbandage", 1)
    TriggerClientEvent("redemrp_notification:start", _source, "You've eat", 3, "success")
end)