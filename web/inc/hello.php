<?php
$filename = "/Users/jferrer/.pgpass.php";
if (file_exists($filename)) {
  include($filename);
}
$filename = "/home/jferrer/.pgpass.php";
if (file_exists($filename)) {
  include($filename);
}

function trimq($a) {
  return trim($a,'""');
}

$dbconn = pg_connect("host=terra.ad.unsw.edu.au dbname=fireveg user=jferrer password=$clavepasajera options='--client_encoding=UTF8'")
   or die("Could not connect");

$foot_msg ="Connected successfully\n<br />\n";
$map_content = "";
## print "Connected successfully<br/>";
$ROOTDIR = pathinfo($_SERVER['PHP_SELF'])['dirname'];

 $main_content = "";
 $table_spp = "";
 $table_rslts = "";
 $page_title = "";
 

?>
