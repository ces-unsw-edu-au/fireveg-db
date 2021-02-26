<?php
 $ecode = $_GET["species_code"];



 include("inc/hello.php");

$qry = "SELECT \"SpeciesCode\",\"FamilyName\",\"GenusName\",\"ScientificName\" FROM  public.\"Species_list\" WHERE \"SpeciesCode\"  = '$ecode'";
$result = pg_query($dbconn, $qry);
 if (!$result) {
   echo "An error occurred.\n";
   exit;
 }
 while ($row = pg_fetch_assoc($result)) {
    $table_spp.= "<tr> ";

    foreach($row as $name => $value) {
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

    foreach($row as $name => $value) {
      switch($name) {
        case "visit_id":
        $table_rslts.= "<td><a href='table-species-sample.php?visit_id=$value'>$value</a></td> ";
        break;

        default:
        $table_rslts.= "<td>$value</td> ";
      }
   }
   $table_rslts.= "</tr> ";

 }

 // add query for map coordinates:
 // $qry = "select visit_id,ST_AsText(ST_Transform(geom,4326)) from form.field_visit where..." ;


 $qry = "SELECT attribute,value,ref_code FROM litrev.raw_annotations WHERE species_code = '$ecode'";
 $result = pg_query($dbconn, $qry);
 if (!$result) {
   echo "An error occurred.\n";
   exit;
 }
 while ($row = pg_fetch_assoc($result)) {
    $table_rslt2.= "<tr> ";

    foreach($row as $name => $value) {
      switch($name) {
        case "visit_id":
        $table_rslt2.= "<td><a href='table-species-sample.php?visit_id=$value'>$value</a></td> ";
        break;

        default:
        $table_rslt2.= "<td>$value</td> ";
      }
   }
   $table_rslt2.= "</tr> ";

 }


 pg_close($dbconn);

if ($table_rslts!="") {

    $table1="
    <p>Field records from surveys</p>
<table>
    <tr>
    <th></th> <th>Adult<br/>Juvenile</th> <th>Resprout<br/>Organ</th> <th>Seedbank</th> <th colspan=4>Resprouts</th><th colspan=3>Recruits</th> <th>Comments</th>
    </tr>
    <tr>
    <th></th> <th></th> <th></th> <th></th> <th>L</th><th>D</th><th>K</th><th>R</th> <th>L</th><th>R</th><th>D</th> <th></th>
    </tr>
    $table_rslts
   </table>
    ";

}

if ($table_rslt2!="") {

    $table2="
<p>Attributes extracted from the literature</p>
    <table>
    <tr><th>Attribute</th><th>Value</th><th>Reference</th>
    </tr>
    $table_rslt2
   </table>
    ";

}
$main_content="
<table>$table_spp</table>
$table2
$table1

";
 $page_title="Data for species <i>$spName</i>";

 include_once("skeleton.php");

 ?>
