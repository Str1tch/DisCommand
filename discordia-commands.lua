local discordia = require "discordia"
local class = discordia.class
discordia.extensions.string()

-- > Creating class base
local Command = class("Command")

function Command:__init(name)
	if name then
		self._name = name
		self._permissions = {}
		self._callback = function() end
	end
end

-- > Adding class methods
function Command:GetPermissions()
	return self._permissions
end

function Command:GetCallback()
	return self._callback
end

function Command:SetPermissions(permissionsTable)
	if permissionsTable then
		self._permissions = permissionsTable
	end
	return self
end

function Command:SetCallback(callbackFunction)
	if callbackFunction then
		self._callback = callbackFunction
	end
	return self
end

-- > Creating library functions
local commandTable = {}
local commandPrefix = "-"
local function newCommand(name)
	if not name then return end
	if #name >= 1 then
		local newCommandObj = Command(name)
		commandTable[commandPrefix .. name] = newCommandObj
		return newCommandObj
	end
end

local function newListener(client)
	if client then
		client:on("messageCreate", function(message)
			if message.author.bot then return end
			local messageSplit = string.split(message.content, " ")
			local commandObject = commandTable[messageSplit[1]]
			local commandCallback = commandObject:GetCallback()
			if commandObject then
				local isaccess = false
				local permissions = commandObject:GetPermissions()
				if #permissions <= 0 then
					isaccess = true
				else
					for _, perm in pairs(permissions) do
						if message.member:hasRole(perm) then
							isaccess = true
						end
					end
				end
				if isaccess then
					coroutine.wrap(function()
						local suc, err = pcall(commandCallback, message, messageSplit)
						if not suc then
							error(err)
						end
					end)()
				end
			end
			message:delete()
		end)
	end
end

local function setPrefix(prefix)
	if not prefix then return end
	if #prefix == 1 then
		commandPrefix = prefix
	end
end

return {
	newCommand = newCommand,
	newListener = newListener,
	setPrefix = setPrefix
}