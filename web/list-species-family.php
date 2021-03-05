<?php
$family = $_REQUEST["family"];
include("inc/hello.php");


$page_title="List of species in $family";


$qry = "SELECT \"ScientificName\", \"SpeciesCode\",count(distinct l.attribute) as rr, count(distinct s.visit_id) as mm, max(\"SortOrder\") as oo FROM \"Species_list\"
LEFT JOIN form.quadrat_samples s ON s.species_code=\"SpeciesCode\"
LEFT JOIN litrev.raw_annotations l ON l.species_code=\"SpeciesCode\"
WHERE \"FamilyName\" = '$family'
GROUP BY \"ScientificName\", \"SpeciesCode\" ORDER BY oo";



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
 $table_rws .= "<tr>
 <th>$row[ScientificName]</th>
 <th><a href='qry-species.php?species_code=$row[SpeciesCode]'>$row[SpeciesCode]</a></th>
 $nlit
 $nvid
 </tr>";
}
$table_hdr .= "<tr>
<th colspan=2>Species</th>
<th>Attributes in literature</th>
<th>Samples with records</th>
 </tr>";
$main_content = "
<table>
$table_hdr
$table_rws
</table>
";

pg_close($dbconn);

 include_once("skeleton.php");

?>
