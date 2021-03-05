<?php

include("inc/hello.php");

$table_rslts = "";



if(isset($_REQUEST["visit_id"])) {

    $visitid = $_REQUEST["visit_id"];
    $page_title="Overview of samples for $visitid";

$qry = "SELECT visit_id,sample_nr,species,species_code, resprouts_live+recruits_live as nind FROM form.field_samples
LEFT JOIN form.quadrat_samples USING (visit_id,sample_nr)
WHERE visit_id='$visitid'";

 $result = pg_query($dbconn, $qry);
 if (!$result) {
   echo "An error occurred.\n";
   exit;
 }

 $tt = array();
 $spids= array();
 $samples = array();
 while ($row = pg_fetch_assoc($result)) {
    $tt[$row["species_code"]][$row["sample_nr"]] = $row["nind"];
    $spids[$row["species_code"]] = $row["species"];
      $samples[] = $row["sample_nr"];
    $table_rslts.= "<tr> <th><a href='check-visit.php?visit_id=$row[visit_id]'>$row[visit_id]</a></th>
    <td style='text-align:center;'>$row[sample_nr]</td>
    <td><i>$row[species]</i></a></td>
    <td><a href='qry-species.php?species_code=$row[species_code]'>$row[species_code]</a></td></tr> ";

 }
}

pg_close($dbconn);

$samples = array_unique($samples);
sort($samples);
#print_r($samples);

foreach($tt as $k => $v) {
    $table_rslts2.= "<tr><th><i>$spids[$k]</i></th><th>
    <a href='qry-species.php?species_code=$k'>$k</a></th>";
    foreach ($samples as $x) {
       $table_rslts2.= "<td> $v[$x] </td>";
   }
    $table_rslts2.= "</tr>";

}

$table_hdr="<tr>
<th colspan=2>Species</th>
<th colspan=".sizeof($samples).">Samples</th>
</tr> <tr>
<th colspan=2></th>";
 foreach ($samples as $x) {
    $table_hdr.= "<th>$x</th>";
   }
 $table_hdr.= "</tr>";
$main_content="

<table>$table_hdr $table_rslts2</table>";



include_once("skeleton.php");

?>
