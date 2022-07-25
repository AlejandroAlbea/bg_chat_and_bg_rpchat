ESX = nil
print("[^1Información^0]".."Rediseñado por BG-SCRIPTS")
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(100)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)

local pedDisplaying = {}

local playerDistance = 8

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

RegisterNetEvent('ks_chat:sendProximityMessage')
AddEventHandler('ks_chat:sendProximityMessage', function(playerId, title, message, color)
	local target = GetPlayerFromServerId(playerId)
	if target == nil or target == -1 then
		return
	end
	local sourcePed, targetPed = PlayerPedId(), GetPlayerPed(target)
    local sourceCoords, targetCoords = GetEntityCoords(sourcePed), GetEntityCoords(targetPed)
	local distance = #(sourceCoords - targetCoords)
	if target ~= nil and target == player or distance < 8 or (NetworkIsInSpectatorMode() and distance < 20) then
		TriggerEvent("chat:addMessage", {args = {title, message}, color = color})
	end
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		TriggerEvent('chat:removeSuggestion', '/twt')
		TriggerEvent('chat:removeSuggestion', '/me')
		TriggerEvent('chat:removeSuggestion', '/do')
	end
end)

Citizen.CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/id',  _U('id_help'),  { { name = _U('generic_argument_name'), help = _U('generic_argument_help') } } )
    TriggerEvent('chat:addSuggestion', '/me',   _U('me_help'),   { { name = _U('generic_argument_name'), help = _U('generic_argument_help') } } )
    TriggerEvent('chat:addSuggestion', '/do',   _U('do_help'),   { { name = _U('generic_argument_name'), help = _U('generic_argument_help') } } )
    TriggerEvent('chat:addSuggestion', '/ayuda', _U('a_help'), { { name = _U('generic_argument_name'), help = _U('generic_argument_help') } } )
end)