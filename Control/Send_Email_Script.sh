#!/bin/sh
. /opt/fpp/scripts/common
##########################################################################
# Setup some variables (edit these with the data you want to send)

SUBJECT="Enter the Subject line here"  # i.e  SUBJECT="FPP Status"
MESSAGE="Enter your Message here"      # i.e  MESSAGE="The show has started" 

#############################################################################

EMAIL=$(getSetting emailtoemail)
mail -s "${SUBJECT}" ${EMAIL} <<< "${MESSAGE}"
