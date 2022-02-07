QBCore = nil

Data = {}

TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

-- Load Database, I'm privately using this in most of my scripts...
CreateThread(function()
	Wait(500)
	local result = json.decode(LoadResourceFile(GetCurrentResourceName(), "./database.json"))
	if not result then 
		return
	end

	Data = result
end)



RegisterServerEvent('EventNameHere')
AddEventHandler('EventNameHere', function(data)
    local new_obj = {["steamid"] = GetSteamID()} -- you can enter more data inside the object of course
    Data[#Data + 1] = new_obj
    SaveResourceFile(GetCurrentResourceName(), "./database.json", json.encode(Data), -1)
end)



-- functions 
function GetSteamID()
   local steamid = ""
	for k,v in pairs(GetPlayerIdentifiers(source)) do 
		if string.find(v, "steam:") then 
			steamid = v
		end
	end
	return steamid
end

function IsPlayerRegisteredDatabase(steamid)
	for k,v in pairs(Data) do	
		if Data[k]["steamid"] == steamid then
			return true
		end
	end
	return false
end
