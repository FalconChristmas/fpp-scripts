#!/bin/sh
###############################################################################
# ScheduledPlaylistDisable.sh - Disable scheduled playlist and re-read schedule
###############################################################################
# Specify the playlist name
PLAYLIST="Playlist_Name"

# Update the schedule file
sed -i -e "s/1,${PLAYLIST},/0,${PLAYLIST},/" /home/fpp/media/schedule

# Tell fppd to re-read the schedule
fpp -R

