

<?php
$page_title="List of species";
 ## read the password from a file in user directory
include("/home/jferrer/.pgpass.php");
//connect to a database on "localhost" and set the command line parameter which tells the encoding is in UTF-8
$dbconn = pg_connect("host=localhost dbname=fireveg user=jferrer password=$clavepasajera options='--client_encoding=UTF8'")
   or die("Could not connect");
$foot_msg .="Connected successfully\n<br />\n";


$qry = "SELECT s.species_code,MAX(s.species),MAX(\"FamilyName\"),MAX(\"ScientificName\") FROM form.quadrat_samples s LEFT JOIN \"Species_list\" l ON s.species_code=l.\"SpeciesCode\" GROUP BY s.species_code ORDER BY MAX(\"SortOrder\")";
$result = pg_query($dbconn, $qry);
if (!$result) {
  $foot_msg .="An error occurred.\n";
  exit;
}
$main_content .= "<ul> List of registered species:\n";
$oldfam = "NOT KNOWN";
$y ="";
while ($row = pg_fetch_row($result)) {
   if ($row[2]!=$oldfam) {
      $main_content .= "$y <li> Family: $row[2]</li><ol>\n";
      $oldfam = $row[2];
      $y="</ol>";
   }
  $main_content .= "<li> Species ID: <a href='qry-species.php?species_code=$row[0]'>$row[0]</a>   Name: <i>$row[3]</i></li>\n";
}


$main_content .= "$y</ul>\n";

pg_close($dbconn);

 include_once("skeleton.php");

?>
