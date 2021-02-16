<?php
$page_title="Adding visit";

include("inc/hello.php");

$table_rslts = $opts = $main_content = "";

if(isset($_REQUEST["visit_id"])) {

    $visitid = $_REQUEST["visit_id"];

if(isset($_REQUEST["SRID"])) {
  $location = "ST_GeomFromText('POINT(".$_POST["longitude"]." ".$_POST["latitude"].")', ".$_POST["SRID"].")";
  $ins = "UPDATE form.field_visit SET geom=$location,UpdatedBySystemUserID=1,DateUpdated=CURRENT_TIMESTAMP(0) where visit_id='$visitid'";

  $res = pg_query($dbconn, $ins);
  if ($res) {
     $main_content .= "<BR/>POST data is successfully logged<BR/>\n";
  } else {
     $main_content .= "<BR/>User must have sent wrong inputs<BR/> $ins\n";
  }
}


  $qry = "select visit_id,st_x(geom),st_y(geom),st_srid(geom) from form.field_visit where visit_id='$visitid'";

  $sridnames = array(
    "4326" => "LAT LONG WGS84",
    "4283" => "LAT LONG GDA94",
    "28355" => "UTM ZONE 55",
    "28356" => "UTM ZONE 56"
  );
   $result = pg_query($dbconn, $qry);
   if (!$result) {
     echo "An error occurred.\n";
     exit;
   }
   while ($row = pg_fetch_assoc($result)) {
     foreach($sridnames as $key => $val) {
       if ($key == $row["st_srid"]) {
          $selected="selected='yes'";
       } else {
         $selected ="";
       }
       $opts .= "<option value='$key' $selected>$val</option>";

     }
      $table_rslts.= "<tr>
      <th><input type='hidden' name='visit_id' value='$row[visit_id]'/>$row[visit_id]</th>
      <td><input type='text' name='longitude' value='$row[st_x]'/></td>
      <td><input type='text' name='latitude' value='$row[st_y]'/></td>
      <td><select name='SRID'>$opts</select></td>
      </tr> ";
   }
}



pg_close($dbconn);

$table_hdr="<tr>
<th>Site id</th>
<th>Longitude</th>
<th>Latitude</th>
<th>SRID</th>
</tr> ";

$main_content.="
<form action='edit-coords.php' method='post'>
<table>$table_hdr $table_rslts</table>
<input type='submit'>
</form>";


$page_title="Coordinates of visits";

include_once("skeleton.php");

?>
