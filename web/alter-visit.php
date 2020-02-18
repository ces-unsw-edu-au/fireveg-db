 <?php
 $vid = $_REQUEST["visit_id"];
 $column = $_REQUEST["column"];
 $newval = $_REQUEST["newval"];
 $page_title="Data for visit $vid";
 ## read the password from a file in user directory
 include("/home/jferrer/.pgpass.php");
 //connect to a database on "localhost" and set the command line parameter which tells the encoding is in UTF-8
 $dbconn = pg_connect("host=localhost dbname=fireveg user=jferrer password=$clavepasajera options='--client_encoding=UTF8'")
    or die("Could not connect");
$foot_msg .= "Connected successfully\n<br />\n";

$schema="form";
   $table="field_visit";

if (isset($newval)) {
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
    while(list($name,$value) = each($row)) {
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
