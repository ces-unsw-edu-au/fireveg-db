 <?php
 $vid = $_GET["visit_id"];
 $page_title="Data for visit $vid";
 ## read the password from a file in user directory
 include("/home/jferrer/.pgpass.php");
 //connect to a database on "localhost" and set the command line parameter which tells the encoding is in UTF-8
 $dbconn = pg_connect("host=localhost dbname=fireveg user=jferrer password=$clavepasajera options='--client_encoding=UTF8'")
    or die("Could not connect");
$foot_msg .= "Connected successfully\n<br />\n";

 $qry = "SELECT visit_id,visit_date,visit_description,GivenNames,Surname FROM form.field_visit as v LEFT JOIN form.observerid as o ON v.observer::numeric=o.UserKey WHERE visit_id = '$vid'";
 $result = pg_query($dbconn, $qry);
 if (!$result) {
   echo "An error occurred.\n";
   exit;
 }
 while ($row = pg_fetch_row($result)) {
    $main_content.= "visit_id: $row[0]<br/> visit_date: $row[1]<br/> description: $row[2]<br/> observer: $row[3] $row[4]<br/>";
 }
 pg_close($dbconn);
 include_once("skeleton.php");

 ?>
