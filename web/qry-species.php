<?php
 $ecode = $_GET["species_code"];



 include("inc/hello.php");

$qry = "SELECT \"SpeciesCode\",\"FamilyName\",\"GenusName\",\"ScientificName\" FROM  public.\"Species_list\" WHERE \"SpeciesCode\"  = '$ecode'";
$result = pg_query($dbconn, $qry);
 if (!$result) {
   echo "An error occurred.\n";
   exit;
 }
 while ($row = pg_fetch_assoc($result)) {
    $table_spp.= "<tr> ";

    foreach($row as $name => $value) {
        $table_spp.= "<th>$name</th><td>$value</td> ";
      if ($name="ScientificName") {$spName=$value;}
   }
   $table_spp.= "</tr> ";

 }

 $qry = "WITH adu as (SELECT * FROM form.quadrat_samples WHERE (agegroup IS NULL OR agegroup <> 'juvenile') and species_code = '$ecode'), juv as (SELECT * FROM form.quadrat_samples WHERE agegroup = 'juvenile' and species_code = '$ecode'), fire as ( select visit_id,max(visit_date) as vdate,max(fire_date) as fdate,
 CASE
    WHEN tree_canopy_scorch_best IS NOT NULL  THEN tree_canopy_scorch_best
    ELSE shrub_scorch_best
  END
  as scorch
  from form.field_visit left join form.fire_history USING(visit_id) group by visit_id)
  SELECT visit_id,sample_nr,
  CASE
    WHEN adu.resprout_organ IS NOT NULL  THEN adu.resprout_organ
    ELSE juv.resprout_organ
  END
  AS resprout_organ,
  CASE
    WHEN adu.seedbank IS NOT NULL  THEN adu.seedbank
    ELSE juv.seedbank
  END
  AS seedbank,
adu.resprouts_live as a_l, adu.resprouts_died as a_d, adu.resprouts_kill as a_k, adu.resprouts_reproductive as a_r,
juv.resprouts_live as j_l, juv.resprouts_died as j_d, juv.resprouts_kill as j_k, juv.resprouts_reproductive as j_r,
CASE
   WHEN adu.recruits_live IS NOT NULL  THEN adu.recruits_live
   ELSE juv.recruits_live
 END
 AS recruits_live,
 CASE
    WHEN adu.recruits_reproductive IS NOT NULL  THEN adu.recruits_reproductive
    ELSE juv.recruits_reproductive
  END
  AS recruits_reproductive,
 CASE
    WHEN adu.recruits_died IS NOT NULL  THEN adu.recruits_died
    ELSE juv.recruits_died
  END
  AS recruits_died,
CONCAT(adu.comments,juv.comments) as comments,
vdate,fdate,vdate-fdate as tsf,scorch
  FROM adu FULL JOIN juv USING(visit_id,sample_nr,species_code) LEFT JOIN fire USING(visit_id)
ORDER BY visit_id,sample_nr
  ";
 $result = pg_query($dbconn, $qry);
 if (!$result) {
   echo "An error occurred.\n";
   exit;
 }
 while ($row = pg_fetch_assoc($result)) {
    $table_rslts.= "<tr>
      <td><a href='table-species-sample.php?visit_id=$row[visit_id]'>$row[visit_id]</a> ($row[sample_nr])</td>
      <td>$row[resprout_organ]</td>
      <td>$row[seedbank]</td>
      <td></td>
      <td>$row[a_l]</td>
      <td>$row[a_d]</td>
      <td>$row[a_k]</td>
      <td>$row[a_r]</td>
      <td></td>
      <td>$row[j_l]</td>
      <td>$row[j_d]</td>
      <td>$row[j_k]</td>
      <td>$row[j_r]</td>
   <td>$row[recruits_live]</td>
      <td>$row[recruits_reproductive]</td>
      <td>$row[recruits_died]</td>
      <td>$row[comments]</td>
      <td>$row[tsf]</td>
      <td>$row[scorch]</td>
      <td>$row[vdate]</td>


    </tr>";

 }

 // add query for map coordinates:
 // $qry = "select visit_id,ST_AsText(ST_Transform(geom,4326)) from form.field_visit where..." ;


 $qry = "SELECT attribute,value,ref_code FROM litrev.raw_annotations WHERE species_code = '$ecode'";
 $result = pg_query($dbconn, $qry);
 if (!$result) {
   echo "An error occurred.\n";
   exit;
 }
 while ($row = pg_fetch_assoc($result)) {
    $table_rslt2.= "<tr> ";

    foreach($row as $name => $value) {
      switch($name) {
        case "visit_id":
        $table_rslt2.= "<td><a href='table-species-sample.php?visit_id=$value'>$value</a></td> ";
        break;

        default:
        $table_rslt2.= "<td>$value</td> ";
      }
   }
   $table_rslt2.= "</tr> ";

 }


 pg_close($dbconn);

$legend = "
<div style='font-size:10px;'>
U - unburnt plants escaping scorch in last fire <br/>
L - live plants that resprouted after last fire<br/>
D - resprouts from last fire that later died<br/>
K - burnt plants that were killed in last fire (no resprouting)<br/>
R - number of plants in 'L' that show evidence of reproduction since last fire <br/>
Recruits - new individuals that emerged after last fire<br/>
TSF - time since last fire (days)<br/>
Scorch hgt - highest evidence of scorch from last fire above ground (meters)
Obs date - Observation date
</div>
";

if ($table_rslts!="") {

    $table1="
    <h2>Field records from surveys</h2>
<table>
    <tr>
    <th rowspan='2'>Site label<br/>(sample nr.)</th>
    <th rowspan='2'>Resprout<br/>Organ</th>
    <th rowspan='2'>Seedbank</th>
    <th colspan=5>Pre-fire adults</th>
     <th colspan=5>Pre-fire juveniles</th>
     <th colspan=3>Recruits</th> <th rowspan='2'>Comments</th>
     <th rowspan='2' >TSF</th>
          <th rowspan='2'>Scorch hgt</th>
               <th rowspan='2'>Obs date</th>
    </tr>
    <tr>
  <th>U</th><th>L</th><th>D</th><th>K</th><th>R</th>
     <th>U</th><th>L</th><th>D</th><th>K</th><th>R</th>
     <th>L</th><th>R</th><th>D</th>
    </tr>
    $table_rslts
   </table>
    ";

}

if ($table_rslt2!="") {

    $table2="
<h2>Attributes extracted from the literature</h2>
    <table>
    <tr><th>Attribute</th><th>Value</th><th>Reference</th>
    </tr>
    $table_rslt2
   </table>
    ";

}
$main_content="
<table>$table_spp</table>

<h2>Conservation status (NSW) / (COMMONWEALTH) / (GLOBAL):</br>TO DO</h2>

$table2
$table1
$legend
";
 $page_title="Data for species <i>$spName</i>";

 include_once("skeleton.php");

 ?>
