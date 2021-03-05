<?php

include("inc/hello.php");
$page_title="List of species";



$qry = "SELECT \"FamilyName\",count(distinct \"SpeciesName\") as nn, count(distinct l.species) as rr, count(distinct s.species) as mm, max(\"SortOrder\") as oo FROM \"Species_list\"
LEFT JOIN form.quadrat_samples s ON s.species_code=\"SpeciesCode\"
LEFT JOIN litrev.raw_annotations l ON l.species_code=\"SpeciesCode\"
GROUP BY \"FamilyName\" ORDER BY oo";



$result = pg_query($dbconn, $qry);
if (!$result) {
  $foot_msg .="An error occurred.\n";
  exit;
}
while ($row = pg_fetch_assoc($result)) {
 $table_rws .= "<tr>
 <th>$row[FamilyName]</th>
 <th><a href='list-species-family.php?family=$row[FamilyName]'>+</a></th>
 <td style='text-align:center;'>$row[nn]</td>
 <td style='text-align:center;'>$row[rr]</td>
 <td style='text-align:center;'>$row[mm]</td>
 </tr>";
}
$table_hdr .= "<tr>
<th colspan=2>Family</th>
<th>Total nr. of species</th>
<th>Species in literature</th>
<th>Species in samples</th>
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
