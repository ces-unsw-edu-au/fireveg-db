 <?php
 $page_title="Search species";

 if (isset($_POST["term"])) {
 ## read the password from a file in user directory
 include("/home/jferrer/.pgpass.php");
 //connect to a database on "localhost" and set the command line parameter which tells the encoding is in UTF-8
 $dbconn = pg_connect("host=localhost dbname=fireveg user=jferrer password=$clavepasajera options='--client_encoding=UTF8'")
    or die("Could not connect");
$foot_msg .= "Connected successfully\n<br />\n";

 $qry = "SELECT \"SpeciesCode\",\"FamilyName\",\"ScientificName\" FROM \"Species_list\"  WHERE \"".$_POST["term"]."\" LIKE '%".$_POST["name"]."%'";
 $result_table = $qry;
 $result = pg_query($dbconn, $qry);
 if (!$result) {
   echo "An error occurred.\n";
   exit;
 }
 while ($row = pg_fetch_row($result)) {
     $result_table .= "<tr><td> $row[0] </td><td> $row[1] </td><td> <i>$row[2]</i></td><td><a href='new-quadrat-species.php?ecode=$row[0]'>ADD to quadrat sample</a></td></tr>";
 }
 pg_close($dbconn);
} else {
   $result_table = "Ask and thou shall receive...";
}

 $sample_table = '
 <table>
  <tr>
 <th>Search by:</th>
 <td>
 <select name="term">
 <option value="FamilyName">family</option>
 <option value="GenusName">genus</option>
 <option value="SpeciesName">species epithet</option>
 <option value="ScientificName">species name</option>
 </select>
 </td>
 </tr>
 <tr>
 <th>Search for name (partial match):</th>
 <td>
<input type="text" name="name" value="" /> (text)
 </td>
 </tr>
 </table>
 ';


 $main_content .= ' <form action="search-species.php" method="post">
     <div class="site">
     '.$sample_table.'
    </div>
     <input type="submit">
  </form>
    <div class="result">
     <table>'.$result_table.'</table>
    </div>

 ';

 include_once("skeleton.php");

 ?>
