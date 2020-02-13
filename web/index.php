</<!DOCTYPE html>
<html lang="en" dir="ltr">
   <head>
      <meta charset="utf-8">
      <title>Vegetation response to fire</title>
   </head>
   <body>
      <h1>Vegetation response to fire</h1>
      <h2>Database prototype</h2>


      <p>STEP 1: <a href='new-observer.php'>ADD an observer</a></p>
      <p>STEP 2: <a href='new-visit.php'>ADD a new visit</a></p>


<?php
## read the password from a file in user directory
include("/home/jferrer/.pgpass.php");
//connect to a database on "localhost" and set the command line parameter which tells the encoding is in UTF-8
$dbconn = pg_connect("host=localhost dbname=fireveg user=jferrer password=$clavepasajera options='--client_encoding=UTF8'")
   or die("Could not connect");
echo "Connected successfully\n<br />\n";

$qry = "SELECT visit_id,visit_date FROM form.field_visit";
$result = pg_query($dbconn, $qry);
if (!$result) {
  echo "An error occurred.\n";
  exit;
}

while ($row = pg_fetch_row($result)) {
  echo "ID: $row[0]  Date: $row[1]";
  echo "<br />\n";
}
pg_close($dbconn);

?>

   </body>
</html>
