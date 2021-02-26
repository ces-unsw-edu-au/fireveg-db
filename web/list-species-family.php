<?php
$family = $_REQUEST["family"];
$page_title="List of species in $family";

include("inc/hello.php");



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
 $table_rws .= "<tr>
 <th>$row[ScientificName]</th>
 <th><a href='qry-species.php?species_code=$row[SpeciesCode]'>$row[SpeciesCode]</a></th>
 <td style='text-align:center;'>$row[rr]</td>
 <td style='text-align:center;'>$row[mm]</td>
 </tr>";
}
$table_hdr .= "<tr>
<th colspan=2>Species</th>
<th>Attributes in literature</th>
<th>Samples with records</th>
 </tr>";
$main_content = "<p> List of families</p>
<table>
$table_hdr
$table_rws
</table>
";

pg_close($dbconn);

 include_once("skeleton.php");

?>
