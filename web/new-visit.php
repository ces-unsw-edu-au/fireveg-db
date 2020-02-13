</<!DOCTYPE html>
<html lang="en" dir="ltr">
   <head>
      <meta charset="utf-8">
      <title>Vegetation response to fire</title>
   </head>
   <body>
      <h1>Vegetation response to fire</h1>
      <h2>Database prototype</h2>


<?php
## read the password from a file in user directory
include("/home/jferrer/.pgpass.php");
//connect to a database on "localhost" and set the command line parameter which tells the encoding is in UTF-8
$dbconn = pg_connect("host=localhost dbname=fireveg user=jferrer password=$clavepasajera options='--client_encoding=UTF8'")
   or die("Could not connect");
echo "Connected successfully\n<br />\n";

$qry = "SELECT userkey,surname,givennames FROM form.observerID ORDER BY userkey DESC";
$result = pg_query($dbconn, $qry);
if (!$result) {
  echo "An error occurred.\n";
  exit;
}
while ($row = pg_fetch_row($result)) {
  $observers .= "<option value='$row[0]'> $row[0]: $row[1], $row[2]</option>";
}
pg_close($dbconn);

?>
<form action="add-visit.php" method="post">
   <div class="site">
      Location: <input type="text" name="location" value="This location" /><br/>
      Observers: <select class="" name="observer">
   <?php echo $observers?>
</select><br/>
      Sample identifier: <input type="text" name="fsid" value="000" /><br/>
      Date of sampling: <input type="text" name="date" value="2019-01-19" /><br/>
      </div>
   <input type="submit">
</form>
</body>
</html>
