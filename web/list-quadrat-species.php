<?php

## read the password from a file in user directory
include("/home/jferrer/.pgpass.php");
//connect to a database on "localhost" and set the command line parameter which tells the encoding is in UTF-8
$dbconn = pg_connect("host=localhost dbname=fireveg user=jferrer password=$clavepasajera options='--client_encoding=UTF8'")
or die("Could not connect");
$foot_msg = "Connected successfully<br/>";

if ($_REQUEST["visit_id"]==NULL) {
   $foot_msg .= "No visit_id, <a href='new-sample.php'>please go back and fix this</a>!";
   vardump($_POST);
} else {

$qry = "SELECT record_id,species, agegroup, resprout_organ, seedbank, resprouts_live, resprouts_died, resprouts_kill, resprouts_reproductive, recruits_live, recruits_reproductive,recruits_died,comments FROM form.quadrat_samples WHERE visit_id='".$_REQUEST["visit_id"]."' AND sample_nr='".$_REQUEST["sample_nr"]."' ORDER BY record_id";

 $result = pg_query($dbconn, $qry);
 if (!$result) {
   echo "An error occurred.\n";
   exit;
 }
 while ($row = pg_fetch_assoc($result)) {
    $table_rslts.= "<tr> ";
    while(list($name,$value) = each($row)) {
      if ($name=="record_id") {
         $table_rslts.= "<td><a href='edit-quadrat-species.php?record_id=$value'>$value</a></td> ";

      } else {
         $table_rslts.= "<td>$value</td> ";
      }
   }
   $table_rslts.= "</tr> ";

 }

 // add query for map coordinates:
 // $qry = "select visit_id,ST_AsText(ST_Transform(geom,4326)) from form.field_visit where..." ;


 pg_close($dbconn);


 $table_hdr="<tr>
 <th></th><th></th> <th>Adult<br/>Juvenile</th> <th>Resprout<br/>Organ</th> <th>Seedbank</th> <th colspan=4>Resprouts</th><th colspan=3>Recruits</th> <th>Comments</th>
 </tr> ";
 $table_hdr.= "<tr>
 <th></th> <th></th><th></th> <th></th> <th></th> <th>L</th><th>D</th><th>K</th><th>R</th> <th>L</th><th>R</th><th>D</th> <th></th>
 </tr> ";

$main_content="<table>$table_spp</table><table>$table_hdr $table_rslts</table>";
}

$page_title="List of species in sample ".$_REQUEST["visit_id"]." nr. ".$_REQUEST["sample_nr"];

include_once("skeleton.php");

?>
