## DisCommand library guide
> Library writed for simple creating command in your lua bots writed on discordia. 
> Script requires installed Discordia
## How to install?
> Download and move file to `YourBotFolder/libs`
## How to use?
```lua 
local discordia = require("discordia")
local dCommands = require("discommand")

local client = discordia.Client()

dCommands:newListener(client) -- Starting "messageCreate" event listener.

dCommands:newCommand("kick")
  :SetPermissions({"324234234324324", "234234234234234234"})
  :SetCallback(function(message, split)
    local mentionedUser = message.mentionedUsers.first
    if mentionedUser and split[3] then
      message.guild:getMember(mentionedUser):kick(split[3])
    end
  end)
  
client:run("Bot TOKEN")
```
## How to contact with me?
> Write to this discord: `Stretch#0421`
