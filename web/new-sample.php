 <?php
 $page_title="New sample";
 ## read the password from a file in user directory
 include("/home/jferrer/.pgpass.php");
 //connect to a database on "localhost" and set the command line parameter which tells the encoding is in UTF-8
 $dbconn = pg_connect("host=localhost dbname=fireveg user=jferrer password=$clavepasajera options='--client_encoding=UTF8'")
    or die("Could not connect");
$foot_msg .= "Connected successfully\n<br />\n";

 $qry = "SELECT userkey,surname,givennames FROM form.observerID ORDER BY userkey DESC";
 $result = pg_query($dbconn, $qry);
 if (!$result) {
   echo "An error occurred.\n";
   exit;
 }
 while ($row = pg_fetch_row($result)) {
    $observers .= "<option value='$row[0]'> $row[0]: $row[1], $row[2]</option>";
    $observers2 .= "<input type='checkbox'  name='otherObserver' value='$row[0]'> <label>$row[0]: $row[1], $row[2]</label><br/>";

 }
 pg_close($dbconn);


 $main_content .= ' <form action="add-visit.php" method="post">
     <div class="site">


'.$sample_table.
'

        </div>
     <input type="submit">
  </form>
 ';
 include_once("skeleton.php");

 ?>
