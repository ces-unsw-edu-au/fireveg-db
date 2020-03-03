 <?php
 $page_title="New sample";
 ## read the password from a file in user directory
 include("/home/jferrer/.pgpass.php");
 //connect to a database on "localhost" and set the command line parameter which tells the encoding is in UTF-8
 $dbconn = pg_connect("host=localhost dbname=fireveg user=jferrer password=$clavepasajera options='--client_encoding=UTF8'")
    or die("Could not connect");
$foot_msg .= "Connected successfully\n<br />\n";

 $qry = "SELECT v.visit_id,MAX(s.sample_nr) FROM form.field_visit v LEFT JOIN form.field_samples s ON s.visit_id=v.visit_id GROUP BY v.visit_id ORDER BY visit_id DESC";
 $result = pg_query($dbconn, $qry);
 if (!$result) {
   echo "An error occurred.\n";
   exit;
 }
 while ($row = pg_fetch_row($result)) {
    if ($row[1]>0) {
      $leg= "(has $row[1] sample(s))";
   } else {
      $leg= "(does not have registered samples)";
   }
     $visitids .= "<option value='$row[0]'> $row[0] $leg</option>";

 }
 pg_close($dbconn);


 $sample_table = '
 <table>
  <tr>
 <th>Select a site</th>
 <td>
 <select class="" name="sample[visit_id]">'.$visitids.'
 </select>
 </td>
 </tr>
 <tr>
 <th>Sample Number</th>
 <td>
<input type="text" name="sample[sample_nr]" value="" /> (text)
 </td>
 </tr>
 <tr>
 <th>Sample method</th>
 <td>
  <select class="" name="sample[sample_method]">
  <option value="quadrat">Quadrat</option>
  <option value="transect">Transect</option>
  <option value="other">Other</option>
 </select>

 </td>
 </tr>
 <tr>
 <th>Quadrat_area</th>
 <td>
 <input type="text" name="sample[quadrat_area]" value="" />
 </td>
 </tr>
 <tr>
 <th>Transect length</th>
 <td>
 <input type="text" name="sample[transect_length]" value="" /> (text)
 </td>
 </tr>
 <tr>
 <th>Comments</th>
 <td>
 <textarea name="sample[comments]" rows="4" cols="40"></textarea>
 </td>
 </tr>

 </table>
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
