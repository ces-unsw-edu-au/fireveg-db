<?php
 include("inc/hello.php");


 $page_title="Primary juvenile period and standing plant longevity";


 $qry = "WITH fire as ( select visit_id,max(visit_date) as vdate,max(fire_date) as fdate,
  CASE
     WHEN tree_canopy_scorch_best IS NOT NULL  THEN tree_canopy_scorch_best
     ELSE shrub_scorch_best
   END
   as scorch
   from form.field_visit left join form.fire_history USING(visit_id) group by visit_id)

  SELECT species,species_code,MIN((vdate-fdate)/365.0) as pjp,MAX((vdate-fdate)/365.0) as spl
  FROM form.quadrat_samples
 LEFT JOIN fire USING(visit_id)
  WHERE recruits_reproductive>0
 GROUP BY species,species_code
  ORDER by species_code";



 $result = pg_query($dbconn, $qry);
 if (!$result) {
   $foot_msg .="An error occurred.\n";
   exit;
 }
 while ($row = pg_fetch_assoc($result)) {

$table_rws .= "<tr>
<th> <i>$row[species]</i> </th>
<th><a href='qry-species.php?species_code=$row[species_code]'>$row[species_code]</a></th>
<td style='text-align:center;'> ".sprintf("%01.2f",$row["pjp"])." </td>
<td style='text-align:center;'> ".sprintf("%01.2f",$row["spl"])." </td>
</tr>";

 }
 $table_hdr .= "<tr>
 <th colspan=2>Species</th>
 <th>Primary juvenile period</th>
 <th>Standing plant longevity</th>
  </tr>";
 $main_content = "
 <p>Parameter estimates from field data (in years)</p>

 <table>
 $table_hdr
 $table_rws
 </table>
 ";

 pg_close($dbconn);

  include_once("skeleton.php");

 ?>
