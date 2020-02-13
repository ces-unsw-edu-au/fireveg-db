$_POST["GivenNames"]
$_POST["AddressLine1"]
$_POST["AddressLine2"]
$_POST["City"]
$_POST["Postcode"]
$_POST["StateID"]
$_POST["Email"]
$_POST["Occupation"]
$_POST["Notes"]

$a == NULL

insert into form.observerid (surname,rowtimestamp,createdbysystemuserid,datecreated,updatedbysystemuserid,dateupdated) values ('Ferrer',CURRENT_TIMESTAMP,1,CURRENT_TIMESTAMP,1,CURRENT_TIMESTAMP);

 $res = pg_insert($dbconn, 'post_log', $_POST, PG_DML_ESCAPE);
  if ($res) {
      echo "POST data is successfully logged\n";
  } else {
      echo "User must have sent wrong inputs\n";
  }
