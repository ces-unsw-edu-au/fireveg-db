<?php
// YOU MIGHT WANT TO ADD SOME SECURITY ON THIS PAGE
// E.G. CHECK IF VALID USER LOGIN
// if (isset($_SESSION['admin'])) { ... DO SEARCH AS BELOW ... }

// (1) CONNECT TO DATABASE
include("/home/jferrer/.pgpass.php");
//connect to a database on "localhost" and set the command line parameter which tells the encoding is in UTF-8

$dbconn = pg_connect("host=localhost dbname=fireveg user=jferrer password=$clavepasajera options='--client_encoding=UTF8'")
or die("Could not connect");

$data = [];
switch ($_REQUEST['type']) {
  // (2A) INVALID SEARCH TYPE
  default :
    break;

  // (2B) SEARCH FOR USER
  case "spname":
    // You might want to limit number of results on massive databases
    // SELECT * FROM XYZ WHERE `FIELD` LIKE ? LIMIT 20
    $qry = 'SELECT "ScientificName" FROM "Species_list" WHERE "ScientificName" LIKE \''.$_REQUEST['term'] . "%' limit 10";
	 $result = pg_query($dbconn, $qry);
		if (!$result) {
		  $foot_msg .="An error occurred.\n";
		  exit;
		}
	 while ($row = pg_fetch_row($result)) {
	    $data[] = $row[0];
    }
    break;

}

//echo $qry;
//var_dump($_REQUEST);
// (3) RETURN RESULT
echo json_encode($data);

pg_close($dbconn);

?>
