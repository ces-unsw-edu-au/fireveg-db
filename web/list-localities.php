<?php
$page_title="Overview of visits (coordinates)";

include("inc/hello.php");

$table_rslts = "";
$qry = "select visit_id,visit_date,st_x(geom),st_y(geom),st_srid(geom) from form.field_visit order by visit_id, visit_date, st_srid,st_x,st_y";

$sridnames = array(
  "4326" => "LAT LONG WGS84",
  "4283" => "LAT LONG GDA94",
  "28355" => "UTM ZONE 55",
  "28356" => "UTM ZONE 56"
);
 $result = pg_query($dbconn, $qry);
 if (!$result) {
   echo "An error occurred.\n";
   exit;
 }
 while ($row = pg_fetch_assoc($result)) {
   $clr = "#fff";
   $msg = "";
   if ($row["st_x"] == $row["st_y"]) {
     $clr = "#da5271";
     $msg = "same value in both coordinates";
   }
   if ($row["st_x"]>180 & $row["st_srid"] == "4326") {
     $clr = "#D71211";
     $msg = "mismatch between coordinates and projection";
   }
    $table_rslts.= "<tr> <th><a href='show-visit.php?visit_id=$row[visit_id]'>$row[visit_id]</a></th>
    <td>$row[visit_date]</td>
    <td>$row[st_x]</td>
    <td>$row[st_y]</td>
    <td>".$sridnames[$row["st_srid"]]."</td>
    <td style='background-color:$clr; color:white;'>$msg</td>
    <td style='background-color:$clr; color:white;'><a href='edit-coords.php?visit_id=$row[visit_id]'>EDIT</a></td></tr> ";

 }


pg_close($dbconn);

$table_hdr="<tr>
<th>Site id</th>
<th>Date</th>
<th>Longitude</th>
<th>Latitude</th>
<th>SRID</th>
</tr> ";

$main_content="<table>$table_hdr $table_rslts</table>";


include_once("skeleton.php");

?>
