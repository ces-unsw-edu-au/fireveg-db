<?php
$page_title="References";

include("inc/hello.php");

$table_rslts = "";
$qry = "select ref_code,ref_cite from simple_ref_list";

 $result = pg_query($dbconn, $qry);
 if (!$result) {
   echo "An error occurred.\n";
   exit;
 }
 while ($row = pg_fetch_assoc($result)) {
    $table_rslts.= "<tr> <th><a href='check-visit.php?visit_id=$row[ref_code]'>$row[ref_code]</a></th>
    <td>$row[ref_cite]</td></tr> ";

 }


pg_close($dbconn);

$table_hdr="<tr>
<th>Ref code</th>
<th>Reference</th>
</tr> ";

$main_content="<table>$table_hdr $table_rslts</table>";


include_once("skeleton.php");

?>
