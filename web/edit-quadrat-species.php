 <?php
 $page_title="Edit species in quadrat sample";
 ## read the password from a file in user directory
 include("/home/jferrer/.pgpass.php");
 //connect to a database on "localhost" and set the command line parameter which tells the encoding is in UTF-8
 $dbconn = pg_connect("host=localhost dbname=fireveg user=jferrer password=$clavepasajera options='--client_encoding=UTF8'")
    or die("Could not connect");
$foot_msg .= "Connected successfully\n<br />\n";

if (isset($_REQUEST["record_id"])) {
   $qry = "SELECT * FROM form.quadrat_samples WHERE record_id = '".$_REQUEST["record_id"]."'";
   $result = pg_query($dbconn, $qry);
   if (!$result) {
     echo "An error occurred.\n";
     exit;
   }
   while ($row = pg_fetch_assoc($result)) {
    while(list($name,$value) = each($row)) {
      switch ($name) {
         case "record_id":
            $table_rslts.= "<tr><th>Record ID</th><td><input type='hidden' name='record_id' value='$value'/>$value</td></tr>";
            break;
         case "agegroup":
            $suboptions = '<option value=""> (empty)</option>';
            $subqry = " select enumlabel from pg_type typ left join pg_enum enu on enu.enumtypid=typ.oid where typname ='age_group'";
            $subresult = pg_query($dbconn, $subqry);
            while ($subrow = pg_fetch_row($subresult)) {
               if ($subrow[0]==$value) {
                  $suboptions .= "<option value='$subrow[0]' selected='yes'> $subrow[0]</option>";
               } else {
                  $suboptions .= "<option value='$subrow[0]'> $subrow[0]</option>";
               }
            }
            $table_rslts.= "<tr><th>$name</th><td>
            <select name='quadrat[$name]'>
            $suboptions
            </select></td>
            </tr>";
            break;
         case "resprout_organ":
            $suboptions = '<option value=""> (empty)</option>';
            $subqry = " select enumlabel from pg_type typ left join pg_enum enu on enu.enumtypid=typ.oid where typname ='resprout_type'";
            $subresult = pg_query($dbconn, $subqry);
            while ($subrow = pg_fetch_row($subresult)) {
               if ($subrow[0]==$value) {
                  $suboptions .= "<option value='$subrow[0]' selected='yes'> $subrow[0]</option>";
               } else {
                  $suboptions .= "<option value='$subrow[0]'> $subrow[0]</option>";
               }
            }
            $table_rslts.= "<tr><th>$name</th><td>
            <select name='quadrat[$name]'>
            $suboptions
            </select></td>
            </tr>";
            break;
         case "seedbank":
            $suboptions = '<option value=""> (empty)</option>';
            $subqry = " select enumlabel from pg_type typ left join pg_enum enu on enu.enumtypid=typ.oid where typname ='seedbank_type'";
            $subresult = pg_query($dbconn, $subqry);
            while ($subrow = pg_fetch_row($subresult)) {
               if ($subrow[0]==$value) {
                  $suboptions .= "<option value='$subrow[0]' selected='yes'> $subrow[0]</option>";
               } else {
                  $suboptions .= "<option value='$subrow[0]'> $subrow[0]</option>";
               }
            }
            $table_rslts.= "<tr><th>$name</th><td>
            <select name='quadrat[$name]'>
            $suboptions
            </select></td>
            </tr>";
            break;

         default:
            $table_rslts.= "<tr><th>$name</th><td><input type='text' name='quadrat[$name]' value='$value'/></td></tr>";
      }
   }
 }


    $main_content .= ' <form action="modify-quadrat-species.php" method="post">
        <div class="site">
        <table>
        '.$table_rslts.'
</table>
       </div>
        <input type="submit">
     </form>
    ';
} else {
      $main_content .=  "You should not be here...";
}


 pg_close($dbconn);


 include_once("skeleton.php");

 ?>
