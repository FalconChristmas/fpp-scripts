#!php
<?php
    #############################################################################
    # This sript requires FPP 6.0 or newer with the Video Capture plugin
    # installed and a compatible Video Capture device.   It also requires
    # two PixelOverlay Models, one for the Video Capture and a second for
    # the Text.   The Text model can be a submodel of the video.
    #############################################################################


    #############################################################################
    # Setup some variables (this is the part you want to edit for font, color, etc.)
    $host      = "localhost";    # Host/ip of the FPP instance with the matrix
    $vcModel   = "fb0";          # PixelOverlay Model Name for VideoCapture
    $txtModel  = "fb0-bottom";   # PixelOverlay Model Name for Text
    $pctNice   = 20;             # Percent of "Nice" results
    $listColor = "#00FF00";      # Text Color (also names like 'red', 'blue', etc.)
    $niceColor = "#00FF00";      # Text Color (also names like 'red', 'blue', etc.)
    $naughtyColor = "#FF0000";   # Text Color (also names like 'red', 'blue', etc.)
    $font     = "Helvetica";     # Font Name
    $size     = 50;              # Font size
    $antiAlias = false;          # Anti-Alias the text
    
    
    #############################################################################
    # Function to post the data to the REST API
    function do_post($url, $json) {
        //Initiate cURL.
        $ch = curl_init($url);
        //Tell cURL that we want to send a PUT request.
        curl_setopt($ch, CURLOPT_CUSTOMREQUEST, 'POST');
        
        //Attach our encoded JSON string to the PUT fields.
        curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($json));
        
        //Set the content type to application/json
        curl_setopt($ch, CURLOPT_HTTPHEADER, array('Content-Type: application/json'));
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        
        //Execute the request
        $result = curl_exec($ch);
        //echo "Result: " . $result . "\n";
        return $result;
    }

    $status = file_get_contents("http://$host/api/overlays/model/$vcModel/state");
    $json = json_decode($status, true);
    if ($json["effectRunning"] && $json["effectName"] == "Video Capture") {
        echo "Effect already running";
        exit(0);
    }
    //Turn on Video
    $json = Array();
    $json["command"] = "Overlay Model Effect";
    $json["multisyncCommand"] = false;
    $json["args"] = Array();
    $json["args"][] = $vcModel;
    $json["args"][] = "Enabled";
    $json["args"][] = "Video Capture";
    $json["args"][] = "--Default--";
    do_post("http://$host/api/command", $json);
    sleep(1);

    //Add text to say "Checking List"
    $json["args"] = Array();
    $json["args"][] = $txtModel;
    $json["args"][] = "Transparent RGB";
    $json["args"][] = "Text";
    $json["args"][] = $listColor;
    $json["args"][] = $font;
    $json["args"][] = strval($size);
    $json["args"][] = $antiAlias ? "true" : "false";
    $json["args"][] = "Center";
    $json["args"][] = "10";
    $json["args"][] = "3";
    $json["args"][] = "Checking List";
    do_post("http://$host/api/command", $json);
    time_nanosleep(3, 500000000);

    // Randomly choose naughty or nice and update the text
    $v = random_int(0, 100);
    if ($v < $pctNice) {
        $json["args"][3] = $niceColor;
        $json["args"][10] = "Nice";
    } else {
        $json["args"][3] = $naughtyColor;
        $json["args"][10] = "Naughty";
    }
    do_post("http://$host/api/command", $json);
    time_nanosleep(3, 500000000);

    
    // Turn everything off
    $json = Array();
    $json["command"] = "Overlay Model Effect";
    $json["multisyncCommand"] = false;
    $json["args"] = Array();
    $json["args"][] = $vcModel;
    $json["args"][] = "False";
    $json["args"][] = "Stop Effects";
    do_post("http://$host/api/command", $json);
    $json = Array();
    $json["command"] = "Overlay Model Clear";
    $json["multisyncCommand"] = false;
    $json["args"] = Array();
    $json["args"][] = $vcModel;
    do_post("http://$host/api/command", $json);
?>
