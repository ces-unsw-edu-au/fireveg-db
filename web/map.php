<!DOCTYPE html>
<html lang="en" dir="ltr">
   <head>
      <meta charset="utf-8">
      <title>Vegetation response to fire</title>
      <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel='stylesheet' href='https://fonts.googleapis.com/css?family=Roboto'>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://unpkg.com/leaflet@1.6.0/dist/leaflet.css"
   integrity="sha512-xwE/Az9zrjBIphAcBb3F6JVqxf46+CDLwfLMHloNu6KEQCAWi6HcDUbeOfBIptF7tcCzusKFjFw2yuvEpDL9wQ=="
   crossorigin=""/>
    <!-- Make sure you put this AFTER Leaflet's CSS -->
 <script src="https://unpkg.com/leaflet@1.6.0/dist/leaflet.js"
   integrity="sha512-gZwIG9x3wUXg2hdXF6+rVkLF/0Vi9U8D2Ntg4Ga5I5BZpVkVxlJWbSQtXPSiUTtC0TjtGOmxa1AJPuV0CPthew=="
   crossorigin=""></script>
   <script src="js/Wicket-master/wicket.js" type="text/javascript"></script>
   <script src="js/Wicket-master/wicket-leaflet.js"type="text/javascript" ></script>
<style>
html,body,h1,h2,h3,h4,h5,h6 {font-family: "Roboto", sans-serif};
</style>
   </head>
   <body class="w3-light-grey">
      <!-- Page Container -->
      <div class="w3-content w3-margin-top" style="max-width:1400px;">

        <!-- The Grid -->
        <div class="w3-row-padding">

          <!-- Left Column -->
          <div class="w3-third">

            <div class="w3-white w3-text-grey w3-card-4">
                   <h1>Vegetation response to fire</h1>
              <h2>Database prototype</h2>
              <div class="w3-container">
                 <p> <a href='index.php'>Home</a></p>
                 <p> <a href='map.php'>Map</a></p>
                 <p>Step 1: <a href='new-observer.php'>ADD an observer</a></p>
                 <p>Step 2: <a href='new-visit.php'>ADD a new visit</a></p>
                <br>
              </div>
            </div><br>

          </div>

          <div class="w3-twothird">
             <!--// https://tile.thunderforest.com/outdoors/{z}/{x}/{y}.png?apikey=48a1c0019a434234b88d1dbf22da8c8a
             https://tile.thunderforest.com/landscape/{z}/{x}/{y}.png?apikey=<insert-your-apikey-here> //-->

             <?php

             include("inc/hello.php");

              echo "<h1>$page_title</h1>";

##select ST_AsText(ST_Transform(geom,4326)) from form.field_visit ;

             echo $main_content;
             ?>


             <div id="mapid" style="width: 800px; height: 650px;"></div>
             <script>



var mymap = L.map('mapid').setView([-33, 151], 6);

L.tileLayer('https://tile.thunderforest.com/landscape/{z}/{x}/{y}.png?apikey=48a1c0019a434234b88d1dbf22da8c8a', {
		maxZoom: 18,
		attribution: 'Maps &copy; <a href="http://www.thunderforest.com/">Thunderforest</a>, Data &copy; ' +
			'<a href="http://www.openstreetmap.org/copyright">OpenStreetMap contributors</a>',
		id: 'thunderforest/landscape',
		tileSize: 512,
		zoomOffset: -1
	}).addTo(mymap);
//   var marker = L.marker([-34, 151]).addTo(mymap);
// Create a new Wicket instance
var wkt = new Wkt.Wkt();

<?php

$qry = "select visit_id,ST_AsText(ST_Transform(geom,4326)) from form.field_visit" ;
 $result = pg_query($dbconn, $qry);
		if (!$result) {
		  $foot_msg .="An error occurred.\n";
		  exit;
		}
	 while ($row = pg_fetch_row($result)) {
	   echo  "wkt.read(\"".$row[1]."\");\n";
       echo  "var marker = wkt.toObject().bindPopup('<a href=\"check-visit.php?visit_id=".$row[0]."\">".$row[0]."</a>');\n";
       echo "marker.addTo(mymap);\n";
   }

pg_close($dbconn);

 ?>
// // Read in any kind of WKT string
// //wkt.read("POINT(151.031024039124 -34.1480144699649)");
/// wkt.read("POINT(151.032276564831 -34.157601293261)");
// var marker = wkt.toObject().bindPopup('<a href="check-visit.php?visit_id=ROY001">ROY001</a>');
// marker.addTo(mymap);
// wkt.read("POINT(151.03314 -34.14428)");
// var marker = wkt.toObject().bindPopup('<a href="check-visit.php?visit_id=ROY003">ROY003</a>');
// marker.addTo(mymap);
// wkt.read("POINT(151.04979 -34.17011)");
// var marker = wkt.toObject().bindPopup('<a href="check-visit.php?visit_id=R0Y005">ROY005</a>');
// marker.addTo(mymap);
// wkt.read("POINT(151.20192 -33.72486)");
// var marker = wkt.toObject().bindPopup('<a href="check-visit.php?visit_id=Ka5">Ka5</a>');
// marker.addTo(mymap);
// wkt.read("POINT(151.031024039124 -34.1480144699649)");
// var marker = wkt.toObject().bindPopup('<a href="check-visit.php?visit_id=ROY002">ROY002</a>');
// marker.addTo(mymap);



 </script>
           </div>

        </div>

      </div>

      <footer class="w3-container w3-teal w3-center w3-margin-top">
         <?php
             echo $foot_msg;
             ?>
        <a href='index.php'>Back to the index</a>
      </footer>
</body>
</html>
