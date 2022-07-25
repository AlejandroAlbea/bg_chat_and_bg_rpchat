ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

AddEventHandler('chatMessage', function(source, name, message)
	if string.sub(message, 1, string.len("/")) ~= "/" then
		local name = GetPlayerName(source)
		TriggerClientEvent('ks_chat:sendProximityMessage', -1, source, _U('oop_prefix', " | " .. name .. " [" .. source .. "]"), message, { 128, 128, 128 })
	end
	CancelEvent()
end)

  --- STRING SPLIT FUNCTION ---
function stringsplit(inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
	local t={} ; i=1
	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
		t[i] = str
		i = i + 1
	end
	return t
end

RegisterCommand('msg', function(source, args, rawCommand)
	if source == 0 then
		print('ks_chat: you cant use this command from rcon!')
		return
	end
	if tonumber(args[1]) and args[2] then
		local id=tonumber(args[1])
		msg = table.concat(args, ' ', 2)
		local name =  GetPlayerName(source)
		local characterName = GetCharacterName(source)
		name = name
		local target = ESX.GetPlayerFromId(id)
		if(target ~= nil) then
			TriggerClientEvent('chat:addMessage', id, { args = { _U('msg_prefix', source.. ") " .. name), msg }, color = {0, 140, 19} })
			TriggerClientEvent('chat:addMessage', source, { args = { _U('msg_prefix', source.. ") " .. name), msg }, color = {0, 140, 19} })
		else
			TriggerClientEvent('esx:showNotification', source, "Este ID no está jugando...")
		end
	end

end, false)

RegisterCommand('ayuda', function(source, args, rawCommand)
	if source == 0 then
		print('ks_chat: you can\'t use this command from rcon!')
		return
	end
	args = table.concat(args, ' ')
	local name = GetPlayerName(source)
	if Config.DisableESXIdentity then name = GetCharacterName(source) end
	TriggerClientEvent('chat:addMessage', -1, { args = { _U('a_prefix', name .. " [" .. source .. "] "), args }, color = {255, 111, 0} })
	--print(('%s: %s'):format(name, args))
end, false)

RegisterCommand('id', function(source, args, rawCommand)
	if source == 0 then
		print('ks_chat: you can\'t use this command from rcon!')
		return
	end
	args = table.concat(args, ' ')
	local name = GetPlayerName(source)
	if Config.DisableESXIdentity then name = GetCharacterName(source) end
	TriggerClientEvent('chat:addMessage', -1, { args = { _U('id_prefix', name .. " [" .. source .. "] "), args }, color = {169, 102, 235} })
	--print(('%s: %s'):format(name, args))
end, false)

RegisterCommand('taxi', function(source, args, rawCommand)
	if source == 0 then
		print('ks_chat: you can\'t use this command from rcon!')
		return
	end
	local target = ESX.GetPlayerFromId(source)

	if target.job ~= nil and target.job.name == "taxi" then
		args = table.concat(args, ' ')
		local name = GetPlayerName(source)
		if Config.EnableESXIdentity then name = GetCharacterName(source) end

		TriggerClientEvent('chat:addMessage', -1, { args = { _U('taxi_prefix', name), args }, color = { 255, 227, 51 } })
		--print(('%s: %s'):format(name, args))
	end
end, false)

Citizen.CreateThread(function()
    while ESX == nil do
        Citizen.Wait(100)
	end
	while true do 
		SavedPlayers = ESX.GetPlayers()
		Wait(120000)
	end
end)

RegisterCommand('f', function(source, args, rawCommand)
    if source == 0 then
        print("ks_chat: you can't use this command from rcon!")
        return
    end

    local xLocalPlayer = ESX.GetPlayerFromId(source)
    if xLocalPlayer.job ~= nil then
        args = table.concat(args, ' ')
        local name = GetPlayerName(source)
		if Config.EnableESXIdentity then name = GetCharacterName(source) end
        if xLocalPlayer.job.name == "police" then
            for k,v in ipairs(SavedPlayers) do
				local p = ESX.GetPlayerFromId(v)
				local grade = xLocalPlayer.job.grade_label
				print(p.job.name)
                if p.job ~= nil and p.job.name == "police" then
                    TriggerClientEvent('chat:addMessage', v, { args = { _U('rpol_prefix', grade ..  " " .. name), args }, color = { 255, 197, 125 } })
                end
			end
        elseif xLocalPlayer.job.name == "ambulance" then
            for k,v in ipairs(SavedPlayers) do
				local p = ESX.GetPlayerFromId(v)
				local grade = xLocalPlayer.job.grade_label
                if p.job ~= nil and p.job.name == "ambulance" then
                    TriggerClientEvent('chat:addMessage', v, { args = { _U('rems_prefix', grade ..  " " .. name), args }, color = { 255, 197, 125 } })
                end
            end
        end
    end
end, false)

RegisterCommand('rf', function(source, args, rawCommand)
    if source == 0 then
        print("ks_chat: you can't use this command from rcon!")
        return
    end

    local xLocalPlayer = ESX.GetPlayerFromId(source)
    if xLocalPlayer.job ~= nil then
        args = table.concat(args, ' ')
        local name = GetPlayerName(source)
		if Config.EnableESXIdentity then name = GetCharacterName(source) end


        if xLocalPlayer.job.name == "police" then
            for k,v in ipairs(SavedPlayers) do
				local p = ESX.GetPlayerFromId(v)
				local grade = xLocalPlayer.job.grade_label
                if p.job ~= nil and p.job.name == "police" then
                    TriggerClientEvent('chat:addMessage', v, { args = { _U('rpol_prefix', grade ..  " " .. name), args }, color = { 3, 102, 252 } })
                end
            end
        end

    end
end, false)

RegisterCommand('fems', function(source, args, rawCommand)
    if source == 0 then
        print("ks_chat: you can't use this command from rcon!")
        return
    end

    local xLocalPlayer = ESX.GetPlayerFromId(source)
    if xLocalPlayer.job ~= nil then
        args = table.concat(args, ' ')
        local name = GetPlayerName(source)
        if Config.EnableESXIdentity then name = GetCharacterName(source) end

        if xLocalPlayer.job.name == "police" or xLocalPlayer.job.name == "ambulance" then
            for k,v in ipairs(SavedPlayers) do
                local p = ESX.GetPlayerFromId(v)
                if p.job ~= nil then
					local isValid = p.job.name == "police" or p.job.name == "ambulance"
					local Perfix
					if xLocalPlayer.job.name == "police" then Perfix = "🚓" 
				elseif xLocalPlayer.job.name == 'ambulance' then Perfix = "🚑"
				end
					if isValid then
                        TriggerClientEvent('chat:addMessage', v, { args = { _U('rpolems_prefix', name) .. " " .. Perfix, args }, color = { 0, 255, 153 } })
                    end
                end
            end
        end

    end
end, false)

RegisterCommand('meca', function(source, args, rawCommand)
	if source == 0 then
		print('ks_chat: you can\'t use this command from rcon!')
		return
	end
	local target = ESX.GetPlayerFromId(source)

	if target.job ~= nil and target.job.name == "mechanic" or target.job.name == "bennys" then
		args = table.concat(args, ' ')
		local name = GetPlayerName(source)
		if Config.EnableESXIdentity then name = GetCharacterName(source) end

		TriggerClientEvent('chat:addMessage', -1, { args = { _U('meca_prefix', name), args }, color = { 160, 160, 160 } })
--print(('%s: %s'):format(name, args))
	end
end, false)

RegisterCommand('lspd', function(source, args, rawCommand)
	if source == 0 then
		print('ks_chat: you can\'t use this command from rcon!')
		return
	end
	local target = ESX.GetPlayerFromId(source)

	if target.job ~= nil and target.job.name == "police" then
		args = table.concat(args, ' ')
		local name = GetPlayerName(source)
		if Config.EnableESXIdentity then name = GetCharacterName(source) end

		TriggerClientEvent('chat:addMessage', -1, { args = { _U('pol_prefix', name), args }, color = { 0, 102, 255 } })
--print(('%s: %s'):format(name, args))
	end
end, false)
RegisterCommand('badu', function(source, args, rawCommand)
	if source == 0 then
		print('ks_chat: you can\'t use this command from rcon!')
		return
	end
	local target = ESX.GetPlayerFromId(source)

	if target.job ~= nil and target.job.name == "tendero" or target.job.name == "tendero" then
		args = table.concat(args, ' ')
		local name = GetPlayerName(source)
		if Config.EnableESXIdentity then name = GetCharacterName(source) end

		TriggerClientEvent('chat:addMessage', -1, { args = { _U('badu_prefix', name), args }, color = { 160, 160, 160 } })
--print(('%s: %s'):format(name, args))
	end
end, false)

RegisterCommand('lsfd', function(source, args, rawCommand)
	if source == 0 then
		print('ks_chat: you can\'t use this command from rcon!')
		return
	end
	local target = ESX.GetPlayerFromId(source)

	if target.job ~= nil and target.job.name == "ambulance" then
		args = table.concat(args, ' ')
		local name = GetPlayerName(source)
		if Config.EnableESXIdentity then name = GetCharacterName(source) end

		TriggerClientEvent('chat:addMessage', -1, { args = { _U('ems_prefix', name), args }, color = { 255, 51, 51 } })
--print(('%s: %s'):format(name, args))
	end
end, false)

RegisterCommand('oop', function(source, args, rawCommand)
	if source == 0 then
		print('ks_chat: you can\'t use this command from rcon!')
		return
	end
	args = table.concat(args, ' ')
	local name = GetPlayerName(source)
	if Config.DisableESXIdentity then name = GetCharacterName(source) end
	TriggerClientEvent('ks_chat:sendProximityMessage', -1, source, _U('oop_prefix', " | " .. name .. " [" .. source .. "]"), args, { 128, 128, 128 })
	--print(('%s: %s'):format(name, args))
end, false)

RegisterCommand('me', function(source, args, rawCommand)
	if source == 0 then
		print('ks_chat: you can\'t use this command from rcon!')
		return
	end
	local playerped = GetPlayerPed(source)
	args = table.concat(args, ' ')
	local name = GetPlayerName(source)
	if Config.EnableESXIdentity then name = GetCharacterName(source) end
	TriggerClientEvent('ks_chat:sendProximityMessage', -1, source, '^6[' .. source .. ']^6 ' .. args .. "")
end, false)

RegisterCommand('do', function(source, args, rawCommand)
	if source == 0 then
		print('ks_chat: you can\'t use this command from rcon!')
		return
	end
	args = table.concat(args, ' ')
	local name = GetPlayerName(source)
	if Config.EnableESXIdentity then name = GetCharacterName(source) end
	TriggerClientEvent('ks_chat:sendProximityMessage', -1, source, '^3[' .. source .. '] ^3' .. args .. "")
	--print(('%s: %s'):format(name, args))
end, false)

function GetCharacterName(source)
	local result = MySQL.Sync.fetchAll('SELECT firstname, lastname FROM users WHERE identifier = @identifier', {
		['@identifier'] = GetPlayerIdentifiers(source)[1]
	})
	if result[1] and result[1].firstname and result[1].lastname then
		if Config.OnlyFirstname then
			return result[1].firstname
		else
			return ('%s %s'):format(result[1].firstname, result[1].lastname)
		end
	else
		return GetPlayerName(source)
	end
end


function stringsplit(inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
	local t={} ; i=1
	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
		t[i] = str
		i = i + 1
	end
	return t
end

function tablelength(T)
    local count = 0
    for _ in pairs(T) do count = count + 1 end
    return count
end