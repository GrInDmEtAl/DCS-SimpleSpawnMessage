#Simple Message Script

This script will display a message every time a player aircraft spawns in.

Add a DO SCRIPT after adding the DO SCRIPT for SpawnMessage.lua and write:

```lua
spawnmsg.message = "A message"
```

To add breaks in the message, dont hit enter type \n\n

so
```lua
spawnmsg.message = "Line1\n\nLine2"
```