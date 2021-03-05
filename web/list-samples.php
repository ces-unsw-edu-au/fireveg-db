<?php
$page_title="Overview of samples";

include("inc/hello.php");

$table_rslts = "";
$qry = "SELECT visit_id,string_agg(DISTINCT sample_nr::varchar,' / ' ) as slist, count(DISTINCT sample_nr) as snr,sample_method,count(distinct species) FROM form.field_samples
LEFT JOIN form.quadrat_samples USING (visit_id,sample_nr)
GROUP BY visit_id,sample_method
ORDER BY visit_id";

 $result = pg_query($dbconn, $qry);
 if (!$result) {
   echo "An error occurred.\n";
   exit;
 }
 while ($row = pg_fetch_assoc($result)) {

    $table_rslts.= "<tr> <th><a href='show-visit.php?visit_id=$row[visit_id]'>$row[visit_id]</a></th>
    <td style='text-align:center;'>$row[snr]</td>
    <td>$row[slist]</td>
    <td>$row[sample_method]</td>
    <td><a href='table-species-sample.php?visit_id=$row[visit_id]'>$row[count]</a></td></tr> ";

 }


pg_close($dbconn);

$table_hdr="<tr>
<th>Site id</th>
<th>Total nr. of samples</th>
<th>Samples</th>
<th>Sample method</th>
<th>Nr. of species</th>
</tr> ";

$main_content="<table>$table_hdr $table_rslts</table>";



include_once("skeleton.php");

?>
