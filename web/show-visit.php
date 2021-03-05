 <?php
 $vid = $_GET["visit_id"];
 include("inc/hello.php");
 $page_title="Data for visit ID $vid";

 $qry = "SELECT * FROM form.field_visit as v LEFT JOIN form.observerid as o ON v.mainObserver::numeric=o.UserKey WHERE visit_id = '$vid'";
 $result = pg_query($dbconn, $qry);
 if (!$result) {
   echo "An error occurred.\n";
   exit;
 }
 while ($row = pg_fetch_assoc($result)) {
    $timeOfVisit = new DateTime( $row["visit_date"]);

$infobox = "
<p>This site was visited on: $row[visit_date]</p>

<p><b>Notes on the site</b>: $row[visit_description]</p>
<p><b>Location of the site</b>: $row[location_description]</p>
";

 }

$qry = "select visit_id,fire_date,fire_date_uncertain,fire_name,how_inferred,cause_of_ignition from form.fire_history where visit_id='$vid' order by fire_date";

 $result = pg_query($dbconn, $qry);
 if (!$result) {
   echo "An error occurred.\n";
   exit;
 }
 $fires = array();$numberOfFires =0;

 while ($row = pg_fetch_assoc($result)) {
    $dateOfFire = new DateTime($row["fire_date"]);
$numberOfFires +=1;
 $table_rslts.= "<tr> <th>$row[fire_date]</th>
 <td>$row[fire_name]</td>
 <td>$row[how_inferred]</td>
 <td>$row[cause_of_ignition]</td>
 </tr> ";

 }

$interval = $dateOfFire->diff($timeOfVisit);
$daysSinceFire= $interval->format('%a days');


 $qry = "SELECT visit_id,sample_nr,species,species_code, resprouts_live+recruits_live as nind FROM form.field_samples
 LEFT JOIN form.quadrat_samples USING (visit_id,sample_nr)
 WHERE visit_id='$vid'";

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
  }

 $samples = array_unique($samples);
 sort($samples);

 foreach($tt as $k => $v) {
     $table_rslts2.= "<tr><th><i>$spids[$k]</i></th><th>
     <a href='qry-species.php?species_code=$k'>$k</a></th>";
     foreach ($samples as $x) {
        $table_rslts2.= "<td> $v[$x] </td>";
    }
     $table_rslts2.= "</tr>";

 }

 $table_hdr2="<tr>
 <th colspan=2>Species</th>
 <th colspan=".sizeof($samples).">Samples</th>
 </tr> <tr>
 <th colspan=2></th>";
  foreach ($samples as $x) {
     $table_hdr2.= "<th>$x</th>";
    }
  $table_hdr2.= "</tr>";

  $numberOfSamples = sizeof($samples);
  $numberOfSpecies = sizeof($spids);



 pg_close($dbconn);

$table_hdr ="<tr><th>Date</th><th>Name</th><th>How inferred</th><th>Cause of ignition</th></tr>";

 $main_content = "
<h2>Basic information</h2>
 $infobox
 <p><a href='check-visit.php?visit_id=$vid'>EDIT data</a></p>
<h2>Fire records</h2>
 <p> There have been $numberOfFires fire events recorded on this site. The site was visited $daysSinceFire after the last known fire event.</p>
<table>
<caption>Fire history</caption>
$table_hdr
$table_rslts
</table>
<h2>Species records on site</h2>
<p> There are field records for $numberOfSpecies species from $numberOfSamples field samples on this site. </p>
<table><caption>Species in samples</caption>$table_hdr2 $table_rslts2</table>
 ";
 pg_close($dbconn);
 include_once("skeleton.php");

 ?>
