 <?php
 $page_title="Add species to existing sample";
 ## read the password from a file in user directory
 include("/home/jferrer/.pgpass.php");
 //connect to a database on "localhost" and set the command line parameter which tells the encoding is in UTF-8
 $dbconn = pg_connect("host=localhost dbname=fireveg user=jferrer password=$clavepasajera options='--client_encoding=UTF8'")
    or die("Could not connect");
$foot_msg .= "Connected successfully\n<br />\n";

 $qry = "SELECT visit_id,sample_nr FROM form.field_samples  ORDER BY visit_id DESC,sample_nr ASC";
 $result = pg_query($dbconn, $qry);
 if (!$result) {
   echo "An error occurred.\n";
   exit;
 }
 while ($row = pg_fetch_row($result)) {
     $visitids .= "<option value='$row[0]::$row[1]'> $row[0] sample $row[1] </option>";
 }
 pg_close($dbconn);



 $sample_table = '
 Select a site: <select class="" name="visit_sample">'.$visitids.'
 </select>

 <table>

 <tr>
 <th>Code</th>
 <th>Species Name</th>
 <th colspan=4>Resprouts</th>
 <th colspan=3>Recruits</th>
</tr>
<tr>
<th colspan=2></th>
<th>Live</th>
<th>Died</th>
<th>Kill</th>
<th>Repr</th>
<th>Live</th>
<th>Died</th>
<th>Repr</th>
</tr>
 <tr>
 <td>
 <input type="text" name="quadrat[species_code]" value="'.$_REQUEST["ecode"].'" size="4" />
 </td>
 <td>
 <input type="text" name="quadrat[species_name]" value="" size="14"/>
 </td>
 <td>
 <input type="text" name="quadrat[resprouts_live]" value="" size="4" />
 </td>
 <td>
 <input type="text" name="quadrat[resprouts_died]" value="" size="4" />
 </td>
 <td>
 <input type="text" name="quadrat[resprouts_kill]" value="" size="4" />
 </td>
 <td>
 <input type="text" name="quadrat[resprouts_reproductive]" value="" size="4" />
 </td>
 <td>
 <input type="text" name="quadrat[recruits_live]" value="" size="4" />
 </td>
 <td>
 <input type="text" name="quadrat[recruits_died]" value="" size="4" />
 </td>
 <td>
 <input type="text" name="quadrat[recruits_reproductive]" value="" size="4" />
 </td>

 </tr>

 </table>
 agegroup
 resprout_organ
 seedbank
 comments
 ';


 $main_content .= ' <form action="add-sample.php" method="post">
     <div class="site">
     '.$sample_table.'
    </div>
     <input type="submit">
  </form>
 ';
 include_once("skeleton.php");

 ?>
