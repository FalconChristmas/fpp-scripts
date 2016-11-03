#!/bin/sh
##############################################################################
# ScheduledPlaylistsUpdate.sh - Enable/Disable scheduled playlists           #
##############################################################################
# Fill in the playlist names to enable and disable.
#
# NOTE: Playlist names can NOT contain spaces, playlist names should be
#       separated by a space in the lists below.  You can also leave a list
#       empty to skip enabling/disabling anything.
PLAYLISTS_TO_ENABLE="2013_Filler"
PLAYLISTS_TO_DISABLE="Sequence_Test Sync_Test"

#################################
# Enable some playlists
for PLAYLIST in ${PLAYLISTS_TO_ENABLE}
do
    sed -i -e "s/^0,${PLAYLIST},/1,${PLAYLIST},/" /home/fpp/media/schedule
done

#################################
# Disable some other playlists
for PLAYLIST in ${PLAYLISTS_TO_DISABLE}
do
    sed -i -e "s/^1,${PLAYLIST},/0,${PLAYLIST},/" /home/fpp/media/schedule
done

######################################
# Trigger fppd to re-read the schedule
fpp -R

