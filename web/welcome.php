<html>
<body>

We now know that  <?php echo $_POST["observer"]; ?> were in <?php echo $_POST["location"]; ?> on the <?php echo $_POST["date"]; ?><br>

<?php
## read the password from a file in user directory
include("/home/jferrer/.pgpass.php");
//connect to a database on "localhost" and set the command line parameter which tells the encoding is in UTF-8
$dbconn = pg_connect("host=localhost dbname=fireveg user=jferrer password=$clavepasajera options='--client_encoding=UTF8'")
   or die("Could not connect");
echo "Connected successfully";

 $res = pg_insert($dbconn, 'post_log', $_POST, PG_DML_ESCAPE);
  if ($res) {
      echo "POST data is successfully logged\n";
  } else {
      echo "User must have sent wrong inputs\n";
  }
pg_close($dbconn);

?>
</body>
</html>
