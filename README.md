# Simple purge script for your FiveM server

It will automatically start the purge t-minus 3 minutes before server has to be restarted.

It just gives an asthetic feel/look for your server and the players inside of it.

![image](https://github.com/user-attachments/assets/07f9ed44-d9d6-4080-be57-00ebfedb7766)

**How do we set it up through TxAdmin?**
- Put a Scheduled Restart on or if you guys have pre-made/setup ones you it will just run whenever there is 3 minutes left to restart

**How do we change the time from 3 minutes?**
- Go into the main `server.lua` and change the `180 seconds` and change it to however long you want it for 5 minutes (300 seconds) 10 minutes (600 seconds), etc.
