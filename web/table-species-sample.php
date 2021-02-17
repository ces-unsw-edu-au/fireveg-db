<?php
$page_title="Overview of samples";

include("inc/hello.php");

$table_rslts = "";



if(isset($_REQUEST["visit_id"])) {

    $visitid = $_REQUEST["visit_id"];

$qry = "SELECT visit_id,sample_nr,species,species_code FROM form.field_samples
LEFT JOIN form.quadrat_samples USING (visit_id,sample_nr)
WHERE visit_id='$visitid'";

 $result = pg_query($dbconn, $qry);
 if (!$result) {
   echo "An error occurred.\n";
   exit;
 }
 while ($row = pg_fetch_assoc($result)) {

    $table_rslts.= "<tr> <th><a href='check-visit.php?visit_id=$row[visit_id]'>$row[visit_id]</a></th>
    <td style='text-align:center;'>$row[sample_nr]</td>
    <td><i>$row[species]</i></a></td>
    <td><a href='qry-species.php?species_code=$row[species_code]'>$row[species_code]</a></td></tr> ";

 }
}

pg_close($dbconn);

$table_hdr="<tr>
<th>Site id</th>
<th>Sample Nr.</th>
<th>Species</th>
</tr> ";

$main_content="<table>$table_hdr $table_rslts</table>";



include_once("skeleton.php");

?>
