#!/usr/bin/perl
#############################################################################
# PixelOverlay-ScrollingTextMultiMatrix.pl -
# - Scroll a text string across a pair of identical matrices
#############################################################################
# Set our library path to find the FPP Perl modules
use lib "/opt/fpp/lib/perl/";

# Use the FPP Memory Map module to talk to the daemon
use FPP::MemoryMap;

#############################################################################
# Setup some variables (this is the part you want to edit for font, color, etc.)
my $name  = "Matrix #1";    # Memory Mapped block name
my $name2 = "Matrix #2";    # Memory Mapped block name
my $color = "#FF0000";      # Text Color (also names like 'red', 'blue', etc.)
my $fill  = "#000000";      # Fill color (not used currently)
my $font  = "fixed";        # Font Name
my $size  = "10";           # Font size
my $pos   = "scroll";       # Position: 'scroll', 'center', 'x,y' (ie, '10,20')
my $dir   = "R2L";          # Scroll Direction: 'R2L', 'L2R', 'T2B', 'B2T'
my $pps   = 10;             # Pixels Per Second
my $msg   = "The message you want to scroll";

#############################################################################
# Main part of program

# Instantiate a new instance of the MemoryMap interface
my $fppmm = new FPP::MemoryMap;

# Open the maps
$fppmm->OpenMaps();

# Dump the config
#$fppmm->DumpConfig();

# Get info about the blocks we are interested in
my $blk   = $fppmm->GetBlockInfo($name);
my $blk2  = $fppmm->GetBlockInfo($name2);

# Dump info about a specific block
#$fppmm->DumpBlockInfo(1, $blk);
#$fppmm->DumpBlockInfo(1, $blk2);

# Clear the blocks, probably not necessary
$fppmm->SetBlockColor($blk, 0, 0, 0);
$fppmm->SetBlockColor($blk2, 0, 0, 0);

# Enable the blocks (pass 2 for transparent mode, or 3 for transparent RGB)
$fppmm->SetBlockState($blk, 1);
$fppmm->SetBlockState($blk2, 1);

# Scroll the message
$fppmm->TextMessage($blk, $msg, $color, $fill, $font, $size, $pos, $dir, $pps, $blk2);

# Disable the blocks
$fppmm->SetBlockState($blk, 0);
$fppmm->SetBlockState($blk2, 0);

# Close the maps (shouldn't make it here with the above "while (1)" loop)
$fppmm->CloseMaps();

# Exit cleanly (shouldn't make it here with the above "while (1)" loop)
exit(0);

#############################################################################
