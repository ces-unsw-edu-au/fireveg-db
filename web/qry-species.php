<?php
 $ecode = $_GET["species_code"];



 ## read the password from a file in user directory
 include("/home/jferrer/.pgpass.php");
 //connect to a database on "localhost" and set the command line parameter which tells the encoding is in UTF-8
 $dbconn = pg_connect("host=localhost dbname=fireveg user=jferrer password=$clavepasajera options='--client_encoding=UTF8'")
    or die("Could not connect");
$foot_msg .= "Connected successfully\n<br />\n";

$qry = "SELECT \"SpeciesCode\",\"FamilyName\",\"GenusName\",\"ScientificName\" FROM  public.\"Species_list\" WHERE \"SpeciesCode\"  = '$ecode'";
$result = pg_query($dbconn, $qry);
 if (!$result) {
   echo "An error occurred.\n";
   exit;
 }
 while ($row = pg_fetch_assoc($result)) {
    $table_spp.= "<tr> ";
    while(list($name,$value) = each($row)) {
      $table_spp.= "<th>$name</th><td>$value</td> ";
      if ($name="ScientificName") {$spName=$value;}
   }
   $table_spp.= "</tr> ";

 }

 $qry = "SELECT visit_id, agegroup, resprout_organ, seedbank, resprouts_live, resprouts_died, resprouts_kill, resprouts_reproductive, recruits_live, recruits_reproductive,recruits_died,comments FROM form.quadrat_samples WHERE species_code = '$ecode'";
 $result = pg_query($dbconn, $qry);
 if (!$result) {
   echo "An error occurred.\n";
   exit;
 }
 while ($row = pg_fetch_assoc($result)) {
    $table_rslts.= "<tr> ";
    while(list($name,$value) = each($row)) {
      $table_rslts.= "<td>$value</td> ";
   }
   $table_rslts.= "</tr> ";

 }

 // add query for map coordinates:
 // $qry = "select visit_id,ST_AsText(ST_Transform(geom,4326)) from form.field_visit where..." ;


 pg_close($dbconn);


 $table_hdr="<tr>
 <th></th> <th>Adult<br/>Juvenile</th> <th>Resprout<br/>Organ</th> <th>Seedbank</th> <th colspan=4>Resprouts</th><th colspan=3>Recruits</th> <th>Comments</th>
 </tr> ";
 $table_hdr.= "<tr>
 <th></th> <th></th> <th></th> <th></th> <th>L</th><th>D</th><th>K</th><th>R</th> <th>L</th><th>R</th><th>D</th> <th></th>
 </tr> ";

$main_content="<table>$table_spp</table><table>$table_hdr $table_rslts</table>";
 $page_title="Data for species <i>$spName</i>";

 include_once("skeleton.php");

 ?>
