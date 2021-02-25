## DisCommand library guide
**The second version of the DiscordiaCommands** library, *this version is written using the 'class' library*, which is more intelligent than the previous implementation. Also, in this version, the *methods received more correct names* for your comfort.
## How to install?
Download and move file to `YourBotFolder/libs`
## How to use?
```lua 
local discordia = require("discordia")
local dCommands = require("dis-command")

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
Write to this discord: `Stretch#0421`
