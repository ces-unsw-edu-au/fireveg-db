<?php
$page_title="Database overview";
include("inc/hello.php");

$qry = "SELECT count(distinct userkey) FROM form.observerID";
$result = pg_query($dbconn, $qry);
if (!$result) {
  $foot_msg .="An error occurred.\n";
  exit;
}
$main_content = "<ul> Summary of database:\n";
while ($row = pg_fetch_row($result)) {
  $main_content .= "<li> $row[0] observers</li>\n";
}


$qry = "SELECT count(distinct v.visit_id) as vid,count( s.sample_nr) as snr FROM form.field_visit v LEFT JOIN form.field_samples s ON  v.visit_id=s.visit_id ";
$result = pg_query($dbconn, $qry);
if (!$result) {
  $foot_msg .="An error occurred.\n";
  exit;
}
while ($row = pg_fetch_row($result)) {
  $main_content .= "<li> $row[0] visits: <a href='list-localities.php'>check coordinates</a></li>
  <li> $row[1] samples: <a href='list-samples.php'>check list of samples</a></li>\n";
}



$qry = "SELECT count(*) FROM form.fire_history ";
$result = pg_query($dbconn, $qry);
if (!$result) {
  $foot_msg .="An error occurred.\n";
  exit;
}
while ($row = pg_fetch_row($result)) {
  $main_content .= "<li> $row[0] fire records: <a href='list-fires.php'>check list of fire events</a></li>\n";
}
$main_content .= "</ol>\n";

$qry = "select count(distinct species_code) from litrev.raw_annotations";
$result = pg_query($dbconn, $qry);
if (!$result) {$foot_msg .="An error occurred.\n";exit;}
while ($row = pg_fetch_row($result)) {
  $main_content .= "<li> <a href='species-list.php'>$row[0]</a> species with attributes extracted from the literature</li>\n";
}


$qry = "SELECT count(distinct species_code),COUNT(distinct species) AS alt_names FROM form.quadrat_samples ";
$result = pg_query($dbconn, $qry);
if (!$result) {
  $foot_msg .="An error occurred.\n";
  exit;
}
while ($row = pg_fetch_row($result)) {
  $main_content .= "<li> Field data for $row[1] taxa, including <a href='species-list.php'>$row[0] identified to species</a></li>\n";
}


$main_content .= "</ul>\n";

pg_close($dbconn);

$main_content .= "<ol>In order to add new records to the database:
<li><a href='new-observer.php'>ADD</a> an observer</li>
<li><a href='new-visit.php'>ADD</a> a new visit</li>
<li><a href='new-sample.php'>ADD</a> a new sample (quadrat or transect) to an existing visit</li>
<li><a href='search-species.php'>LOOK-UP</a> a species name</li>
<li><a href='new-quadrat-species.php'>ADD</a> species to a quadrat sample</li>
<li>ADD species to a transect sample</li>
</ol>\n";

 include_once("skeleton.php");

?>
