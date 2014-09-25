#!/usr/bin/perl
#############################################################################
# PixelOverlay-Countdown.pl - Scroll a Christmas Countdown across a matrix
#############################################################################
# Set our library path to find the FPP Perl modules
use lib "/opt/fpp/lib/perl/";

# Use the FPP Memory Map module to talk to the daemon
use FPP::MemoryMap;

#############################################################################
# Setup some variables (this is the part you want to edit for font, color, etc.)
my $name  = "Matrix #2";    # Memory Mapped block name
my $color = "#FF0000";      # Text Color (also names like 'red', 'blue', etc.)
my $fill  = "#000000";      # Fill color (not used currently)
my $font  = "fixed";        # Font Name
my $size  = "10";           # Font size
my $pos   = "scroll";       # Position: 'scroll', 'center', 'x,y' (ie, '10,20')
my $dir   = "R2L";          # Scroll Direction: 'R2L', 'L2R', 'T2B', 'B2T'
my $pps   = 5;              # Pixels Per Second

#############################################################################
# Some setup for our countdown
my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime(time);
# In localtime, $year is current year minus 1900
# In localtime, $mon is 0-11, so December is 11 for our Christmas example
my $Christmas = mktime(0, 0, 0, 25, 11, $year, 0, 0);

# Some variables to hold the number of seconds in a time period
my $aDay = 24 * 60 * 60;
my $aHour = 60 * 60;
my $aMin = 60;

#############################################################################
# This function will get called once per second and returns the text string
# to be displayed at that point in time.
sub GetNextMessage
{
	my $diff        =  $Christmas - time;
	my $daysDiff    =  int($diff / $aDay);
	$diff -= $daysDiff * $aDay;

	my $hoursDiff   = int($diff / $aHour);
	$diff -= $hoursDiff * $aHour;

	my $minsDiff    = int($diff / $aMin);
	my $secsDiff    = $diff % $aMin;

	my $msg;

	# Generate a 2-line string with the word Christmas on the top line
	# and a countdown timer like "43d 12h 3m 32s" on the second line

	$msg = sprintf("Christmas\n%dd %dh %dm %ds",
		$daysDiff, $hoursDiff, $minsDiff, $secsDiff);

	return $msg;
}

#############################################################################
# Main part of program

# Instantiate a new instance of the MemoryMap interface
my $fppmm = new FPP::MemoryMap;

# Open the maps
$fppmm->OpenMaps();

# Get info about the block we are interested in
my $blk   = $fppmm->GetBlockInfo($name);

# Clear the block, probably not necessary
$fppmm->SetBlockColor($blk, 0, 0, 0);

# Loop forever (ie, you'll need to CTRL-C to stop this script or kill it)
while (1) {
	$fppmm->TextMessage($blk, \&GetNextMessage, $color, $fill, $font, $size, $pos, $dir, $pps);
}

# Close the maps (shouldn't make it here with the above "while (1)" loop)
$fppmm->CloseMaps();

# Exit cleanly (shouldn't make it here with the above "while (1)" loop)
exit(0);

#############################################################################
