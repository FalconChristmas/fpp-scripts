#!/usr/bin/php
<?php
    #############################################################################
    # Setup some variables (this is the part you want to edit for font, color, etc.)
    $host  = "localhost";    # Host/ip of the FPP instance with the matrix
    $name  = "Matrix";       # PixelOverlay Model Name
    $color = "#FF0000";      # Text Color (also names like 'red', 'blue', etc.)
    $font  = "Helvetica";    # Font Name
    $size  = 10;             # Font size
    $pos   = "R2L";          # Position: 'Center', 'L2R', 'R2L', 'T2B', 'B2T'
    $pps   = 5;              # Pixels Per Second
    $antiAlias = false;      # Anti-Alias the text
    
    #############################################################################
    # Some setup for our countdown
    $lt = localtime(time(), TRUE);
    $year = $lt["tm_year"] + 1900;
    # In localtime, $year is current year minus 1900
    # In localtime, $mon is 1-12, so December is 12 for our Christmas example
    $Christmas = mktime(0, 0, 0, 12, 25, $year);
    
    # Some variables to hold the number of seconds in a time period
    $aDay = 24 * 60 * 60;
    $aHour = 60 * 60;
    $aMin = 60;

    #############################################################################
    # This function will get called once per second and returns the text string
    # to be displayed at that point in time.
    function GetNextMessage() {
        global $aDay, $aHour, $aMin, $Christmas;
        
        $diff = $Christmas - time();
        $daysDiff    =  (int)($diff / $aDay);
        $diff -= $daysDiff * $aDay;
        
        $hoursDiff   = (int)($diff / $aHour);
        $diff -= $hoursDiff * $aHour;
        
        $minsDiff    = (int)($diff / $aMin);
        $secsDiff    = $diff % $aMin;
        
        # Generate a 2-line string with the word Christmas on the top line
        # and a countdown timer like "43d 12h 3m 32s" on the second line
        $msg = sprintf("Christmas\n%dd %dh %dm %ds",
                       $daysDiff, $hoursDiff, $minsDiff, $secsDiff);
        
        return $msg;
    }
    
    function do_put($url, $data) {
        //Initiate cURL.
        $ch = curl_init($url);
        //Tell cURL that we want to send a PUT request.
        curl_setopt($ch, CURLOPT_CUSTOMREQUEST, 'PUT');
        
        //Attach our encoded JSON string to the PUT fields.
        curl_setopt($ch, CURLOPT_POSTFIELDS, $data);
        
        //Set the content type to application/json
        curl_setopt($ch, CURLOPT_HTTPHEADER, array('Content-Type: application/json'));
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        
        //Execute the request
        $result = curl_exec($ch);
        
        return $result;
    }
    #############################################################################
    # setup a signal handler to clear the screen if ctrl-c is used to
    # stop the script
    $running = true;
    declare(ticks=1); // PHP internal, make signal handling work
    function signalHandler($signo)  {
        global $running;
        $running = false;
        
    }
    pcntl_signal(SIGINT, 'signalHandler');
    
    #############################################################################
    # Main part of program
    
    # Clear the block, probably not necessary
    file_get_contents("http://$host/api/overlays/model/$name/clear");

    # Enable the block (pass 2 for transparent mode, or 3 for transparent RGB)
    $data = array( 'State' => 1 );
    do_put("http://$host/api/overlays/model/$name/state",
            json_encode($data));
    
    
    # Loop forever (ie, you'll need to CTRL-C to stop this script or kill it)
    while ($running) {
        $msg = GetNextMessage();
        $data = array('Message' => $msg,
                      'Color' => $color,
                      'Font' => $font,
                      'FontSize' => $size,
                      'AntiAlias' => $antiAlias,
                      'Position' => $pos,
                      'PixelsPerSecond' => $pps);
        do_put("http://$host/api/overlays/model/$name/text",
                json_encode($data));
        sleep(1);
    }
    
    # Clear the block
    file_get_contents("http://$host/api/overlays/model/$name/clear");
    # Disable the block
    $data = array('State' => 0);
    do_put("http://$host/api/overlays/model/$name/state",
            json_encode($data));

    
    # Exit cleanly (shouldn't make it here with the above "while (1)" loop)
    exit(0);
    #############################################################################
?>
