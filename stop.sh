#!/bin/bash
# James Chambers - February 15th 2019
# Minecraft Server stop script - primarily called by minecraft service but can be ran manually

# Check if server is already running
if /usr/bin/screen -list | /bin/grep -q "minecraft"; then
    echo "Server is not currently running!"
    exit 1
fi

# Stop the server
/usr/bin/screen -Rd minecraft -X stuff "say Closing server (stop.sh called)...$(printf '\r')"
/usr/bin/screen -Rd minecraft -X stuff "stop $(printf '\r')"
/bin/sleep 30s

if /usr/bin/screen -list | grep -q "minecraft"; then
  echo "Minecraft server still hasn't closed after 30 seconds, closing screen manually"
  /usr/bin/screen -S minecraft -X quit
fi

# Sync all filesystem changes out of temporary RAM
sync