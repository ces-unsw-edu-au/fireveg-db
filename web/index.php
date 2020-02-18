

<?php
$page_title="Database overview";
 ## read the password from a file in user directory
include("/home/jferrer/.pgpass.php");
//connect to a database on "localhost" and set the command line parameter which tells the encoding is in UTF-8
$dbconn = pg_connect("host=localhost dbname=fireveg user=jferrer password=$clavepasajera options='--client_encoding=UTF8'")
   or die("Could not connect");
$foot_msg .="Connected successfully\n<br />\n";

$qry = "SELECT userkey,surname,GivenNames FROM form.observerID";
$result = pg_query($dbconn, $qry);
if (!$result) {
  $foot_msg .="An error occurred.\n";
  exit;
}
$main_content = "<ol> List of registered Observers:\n";
while ($row = pg_fetch_row($result)) {
  $main_content .= "<li> ID: <a href='check-observer.php?userkey=$row[0]'>$row[0]</a>   Name: $row[1], $row[2]</li>\n";
}
$main_content .= "</ol>\n";


$qry = "SELECT visit_id,visit_date FROM form.field_visit";
$result = pg_query($dbconn, $qry);
if (!$result) {
  $foot_msg .="An error occurred.\n";
  exit;
}
$main_content .= "<ol> List of registered visits:\n";
while ($row = pg_fetch_row($result)) {
  $main_content .= "<li> ID: <a href='check-visit.php?visit_id=$row[0]'>$row[0]</a>   Date: $row[1]</li>\n";
}
$main_content .= "</ol>\n";


$qry = "SELECT visit_id,fire_date FROM form.fire_history";
$result = pg_query($dbconn, $qry);
if (!$result) {
  $foot_msg .="An error occurred.\n";
  exit;
}
$main_content .= "<ol> List of registered fire events:\n";
while ($row = pg_fetch_row($result)) {
  $main_content .= "<li> Site ID: <a href='check-fire.php?visit_id=$row[0]'>$row[0]</a>   Date: $row[1]</li>\n";
}
$main_content .= "</ol>\n";

pg_close($dbconn);

 include_once("skeleton.php");

?>
