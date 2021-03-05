<?php
$page_title="Fire history";

include("inc/hello.php");

$table_rslts = "";
$qry = "select visit_id,fire_date,fire_date_uncertain from form.fire_history order by fire_date DESC";

 $result = pg_query($dbconn, $qry);
 if (!$result) {
   echo "An error occurred.\n";
   exit;
 }
 $fires = array();
 while ($row = pg_fetch_assoc($result)) {
    $fires[$row["visit_id"]][] = $row["fire_date"];
   # $table_rslts.= "<tr> <th><a href='check-visit.php?visit_id=$row[visit_id]'>$row[visit_id]</a></th><td>$row[fire_date]</td></tr> ";

 }
 pg_close($dbconn);

foreach($fires as $k => $v) {

    $table_rslts2.= "<tr> <th><a href='show-visit.php?visit_id=$k'>$k</a></th>";

   foreach($v as $f ) {
      $table_rslts2.= " <td>$f</td> ";
   }
$table_rslts2.= "</tr>";
}


$table_hdr="<tr>
<th>Visit ID</th>
<th colspan=4>Fire dates</th>
</tr> ";

$main_content="<table>$table_hdr $table_rslts2</table>";


include_once("skeleton.php");

?>
