#!/bin/bash
################################################################
# CycleRandomPlaylists.sh - Randomly cycle through playlists   #
#                                                              #
# The playlists are queued to be played once.  If something is #
# already playing, the script will exit immediately.           #
################################################################
shopt -s nullglob
cd ${MEDIADIR}/playlists


# The only configuration expected by the user is to set the
# PLAYLISTS variable here at the top of the script.  Here are
# examples on ways to set that variable:

# File glob to include all playlists
PLAYLISTS=(*)

# File glob to include Donation Box effects playlists
#PLAYLISTS=(DonationEffect_*)

# Specific playlists to include, including one with a space in the name
#PLAYLISTS=("Playlist1" "Playlist3" "Playlist4" "Playlist 5")



# Exit the script immediately if we're already playing
if ${FPPBINDIR}/fpp -s | cut -d',' -f 4 | grep -qc playlists; then
	exit 0
fi

database=$(dirname $(mktemp -u))/playlist_db.txt

check_playlist_and_create_database()
{
	# Check if the database file doesn't exist (reboot, or first-run) or if
	# the database only has 1 (or somehow 0) entries.  If so, we will then
	# (re)create it ensuring that if we have a song queued, we don't use the
	# next queued entry as the first in the new set of data, thus avoiding
	# duplicate plays in a row.
	if [ ! -e $database ] || [ $(cat $database | wc -l) -lt 2 ]; then
		TEMP=$(mktemp)
		TNEXT=""

		# Handle the case where we don't have a variable passed in.  For this we
		# will blindly create the list.  We also handle the case of less playlists
		# than 2 because if we have 0 or 1 we will get stuck in the while loop
		# below forever.
		if [ -z "$1" ] || [ $(ls -1 "${PLAYLISTS[@]}" | wc -l) -lt 2 ]; then
			(ls -1 "${PLAYLISTS[@]}") | shuf > $TEMP
		# Handle the case where we have more than 1 playlist and need to re-queued
		# random data ensuring the first of the new entries is not the next playlist
		# so we don't play the same playlist twice.
		else
			# Loop through until the first song of the new random set is not the
			# same as the next song queued.
			while [ -z "$TNEXT" ] || [ "x$TNEXT" == "x$1" ]; do
				(ls -1 "${PLAYLISTS[@]}") | shuf > $TEMP
				TNEXT="$(head -n 1 $TEMP)"
			done
		fi

		# Now that we've populated our temp file with the new random set, add it to
		# our existing database and remove the temporary file.
		cat $TEMP >> $database
		rm -f $TEMP
	fi
}

# Run this once at the beginning of the world in case this is the first time we
# are running this script.  In that case we will populate the database the first
# time.
check_playlist_and_create_database

# Get our next playlist as the first in our database
next_playlist="$(head -n 1 $database)"

# Remove the first line ("Take one down, pass it around...")
printf '%s\n' "$(sed '1d' $database)" > $database

# Run the randomization again.  We run it now so that when there is only one
# entry left in the file we queue up the new set with a different PLAYLISTS
# than the last in our current set to avoid repeats.
check_playlist_and_create_database "$(head -n 1 $database)"

${FPPBINDIR}/fpp -P "$next_playlist"
