<?php
// YOU MIGHT WANT TO ADD SOME SECURITY ON THIS PAGE
// E.G. CHECK IF VALID USER LOGIN
// if (isset($_SESSION['admin'])) { ... DO SEARCH AS BELOW ... }

// (1) CONNECT TO DATABASE
include("/home/jferrer/.pgpass.php");
//connect to a database on "localhost" and set the command line parameter which tells the encoding is in UTF-8
$host = 'localhost';
$dbname = 'fireveg';
$user = 'jferrer';
$password = $clavepasajera;
$charset = 'utf8';
$pdo = new PDO(
	"pgsql:host=$host;dbname=$dbname;charset=$charset", $user, $password, [
		PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
		PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
		PDO::ATTR_EMULATE_PREPARES => false,
	]
);

// (2) SEARCHING FOR?
$data = [];
switch ($_POST['type']) {
  // (2A) INVALID SEARCH TYPE
  default :
    break;

  // (2B) SEARCH FOR USER
  case "spname":
    // You might want to limit number of results on massive databases
    // SELECT * FROM XYZ WHERE `FIELD` LIKE ? LIMIT 20
    $stmt = $pdo->prepare('SELECT "ScientificName" FROM "Species_list" WHERE "ScientificName" LIKE ?');
    $stmt->execute(["%" . $_POST['term'] . "%"]);
    while ($row = $stmt->fetch(PDO::FETCH_NAMED)) {
      $data[] = $row['name'];
    }
    break;

}

// (3) RETURN RESULT
$pdo = null;
echo json_encode($data);
?>
