#!/usr/bin/php
<?php
    #############################################################################
    # Setup some variables (this is the part you want to edit for font, color, etc.)
    $host  = "127.0.0.1";    # Host/ip of the FPP instance with the matrix
    $name  = "Matrix";       # PixelOverlay Model Name
    $color = "#FF0000";      # Text Color (also names like 'red', 'blue', etc.)
    $font  = "Helvetica";    # Font Name
    $size  = 20;             # Font size
    $pos   = "Center";          # Position: 'Center', 'L2R', 'R2L', 'T2B', 'B2T'
    $pps   = 5;              # Pixels Per Second
    $antiAlias = false;      # Anti-Alias the text
    
    #############################################################################
    # Some setup for our countdown

    # set end time to current time plus number of minutes * 60 for total seconds before this script exits.
	# example 5*60 = 5 minutes from now
    $endTime = time() + 5*60;
	
    #############################################################################
    # This function will get called once per second and returns the text string
    # to be displayed at that point in time.
    function GetNextMessage() {
        global $endTime, $running;

        $diff = $endTime - time();
		
		# exit script when timer expires
		if ($diff <= 0) $running = false; 
        
        $minsDiff    = (int)($diff / 60);
        $secsDiff    = $diff % 60;
        
        # Generate a 2-line string with the word Christmas on the top line
        # and a countdown timer like "3m 32s" on the second line
        $msg = sprintf("Time till show start:\n%dm %ds", $minsDiff, $secsDiff);
        
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
