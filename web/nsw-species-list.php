<?php

include("inc/hello.php");
$page_title="List of species";



$qry = "select nsw_status,count(species_code)
from litrev.nsw_status
group by nsw_status";



$result = pg_query($dbconn, $qry);
if (!$result) {
  $foot_msg .="An error occurred.\n";
  exit;
}
while ($row = pg_fetch_assoc($result)) {
 $table_rws .= "<tr>
 <th><a href='nsw-species-list.php?status=$row[nsw_status]'>$row[nsw_status]</a></th>
 <td style='text-align:center;'>$row[count]</td>
 </tr>";
}
$table_hdr .= "<tr>
<th>Status</th>
<th>Total nr. of species</th>
 </tr>";

if (isset($_REQUEST["status"])) {
   $status = $_REQUEST["status"];

   $qry = "select \"FamilyName\",n.species_code,n.species,n.common_name, count(distinct l.attribute) as rr, count(distinct s.visit_id) as mm, max(\"SortOrder\") as oo
   FROM litrev.nsw_status n
LEFT JOIN \"Species_list\" p ON n.species_code=\"SpeciesCode\"
LEFT JOIN form.quadrat_samples s USING(species_code)
LEFT JOIN litrev.raw_annotations l USING(species_code)
where nsw_status='$status'
GROUP by \"FamilyName\",n.species_code
ORDER by oo DESC
";

##echo $qry;

$result = pg_query($dbconn, $qry);
if (!$result) {
  $foot_msg .="An error occurred.\n";
  exit;
}
while ($row = pg_fetch_assoc($result)) {

   if ($row["rr"]>0) {
      $nlit = "<td style='text-align:center;'>$row[rr]</td>";
   } else {
      $nlit = "<td style='text-align:center;background-color:white;color:grey;'>none</td>";
   }
   if ($row["mm"]>0) {
      $nvid = "<td style='text-align:center;'>$row[mm]</td>";
   } else {
      $nvid = "<td style='text-align:center;background-color:white;color:grey;'>none</td>";
   }
 $table_rws2 .= "<tr>
 <th>$row[FamilyName]</th>
 <th>$row[species]</th>
 <th>$row[common_name]</th>
<th><a href='qry-species.php?species_code=$row[species_code]'>$row[species_code]</a></th>
 $nlit
 $nvid
 </tr>";
}
$table_hdr2 .= "<tr>
<th colspan=4>Species with status <i>$status</i> in NSW</th>
<th>Attributes in literature</th>
<th>Samples with records</th>
 </tr>";


}


 $main_content = "
 <table>
 $table_hdr
 $table_rws
 </table>

<table>
$table_hdr2
$table_rws2
</table>
";
pg_close($dbconn);

 include_once("skeleton.php");

?>
