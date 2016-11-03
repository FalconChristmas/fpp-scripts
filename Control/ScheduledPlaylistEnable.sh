#!/bin/sh
###############################################################################
# ScheduledPlaylistEnable.sh - Enable a scheduled playlist and re-read schedule
###############################################################################
# Specify the playlist name
PLAYLIST="Playlist_Name"

# Update the schedule file
sed -i -e "s/0,${PLAYLIST},/1,${PLAYLIST},/" /home/fpp/media/schedule

# Tell fppd to re-read the schedule
fpp -R

