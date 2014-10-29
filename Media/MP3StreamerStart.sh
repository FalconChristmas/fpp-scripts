#!/bin/sh
###################################################################
# MP3StreamerStart.sh - Stream live stream from internet          #
#                                                                 #
# Will Play Until MP3StreamerStop.sh Is Called                    #
#                                                                 #
# v1.0 - Written By MyKroft - Can Be Used Without Restrictions    #
#                                                                 #
###################################################################

# Edit this line to hold the URL of the stream:port in quotes
STREAMURL="http://relay5.181.fm:11082"

# Edit this line to hold any options required in quotes
STREAMOPTIONS="-q "
#
# Options Available
#
# usage: mpg123 [option(s)] [file(s) | URL(s) | -]
# supported options [defaults in brackets]:
#   -v    increase verbosity level       -q    quiet (don't print title)
#   -t    testmode (no output)           -s    write to stdout
#   -w <filename> write Output as WAV file
#   -k n  skip first n frames [0]        -n n  decode only n frames [all]
#   -c    check range violations         -y    DISABLE resync on errors
#   -b n  output buffer: n Kbytes [0]    -f n  change scalefactor [32768]
#   -r n  set/force samplerate [auto]
#   -os,-ol,-oh  output to built-in speaker,line-out connector,headphones
#                                        -a d  set audio device
#   -2    downsample 1:2 (22 kHz)        -4    downsample 1:4 (11 kHz)
#
#   -d n  play every n'th frame only     -h n  play every frame n times
#   -0    decode channel 0 (left) only   -1    decode channel 1 (right) only
#   -m    mix both channels (mono)       -p p  use HTTP proxy p [$HTTP_PROXY]
#   -@ f  read filenames/URLs from f     -T get realtime priority
#   -z    shuffle play (with wildcards)  -Z    random play
#   -u a  HTTP authentication string     -E f  Equalizer, data from file
#   -C    enable control keys            --no-gapless  not skip junk/padding in mp3s
#   -?    this help                      --version  print name + version

mpg123 ${STREAMOPTIONS} ${STREAMURL} &
echo $! >/tmp/mpg123.pid

