 <?php
 $vid = $_REQUEST["visit_id"];
 $column = $_REQUEST["column"];
 $page_title="Data for visit $vid";

 include("inc/hello.php");

$schema="form";
   $table="field_visit";

   if (isset($_REQUEST["newval"])) {
    $newval = $_REQUEST["newval"];
   $foot_msg .= "New value is".$newval;
   $qry = "UPDATE $schema.$table set $column='$newval' where visit_id='$vid'";

   $res = pg_query($dbconn, $qry);
      if ($res) {
         $main_content .= "<p>POST data is successfully logged<BR/><a href='check-visit.php?visit_id=$vid'>Go back to overview of site</a></p>\n";
      } else {
         $main_content .= "<p>User must have sent wrong inputs<BR/>please try again</p>\n";
      }

}
 $qry = "SELECT $column FROM form.field_visit WHERE visit_id = '$vid'";
 $result = pg_query($dbconn, $qry);
 if (!$result) {
   echo "An error occurred.\n";
   exit;
 }
 while ($row = pg_fetch_assoc($result)) {
   foreach($row as $name => $value) {
      $colmod = " <a style='color: #C56565;'>$name</a><br/><input type='text' name='newval' value='$value'><br/>";
   }
 }

 $main_content.= "<FORM action='alter-visit.php' method='post'>Update $colmod
 <input name='visit_id' value='$vid' type='hidden'>
 <input name='column' value='$column' type='hidden'>
 <input name='doneit' type='submit'>
</FORM> ";
 pg_close($dbconn);
 include_once("skeleton.php");

 ?>
