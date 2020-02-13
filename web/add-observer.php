<html>
<body>



<?php
## read the password from a file in user directory
include("/home/jferrer/.pgpass.php");
//connect to a database on "localhost" and set the command line parameter which tells the encoding is in UTF-8
$dbconn = pg_connect("host=localhost dbname=fireveg user=jferrer password=$clavepasajera options='--client_encoding=UTF8'")
   or die("Could not connect");
echo "Connected successfully<br/>";

$schema="form";
$table="observerID";

if ($_POST["Surname"]==NULL) {
   echo "No surname, <a href='new-observer.php'>please go back and fix this</a>!";
} else {
   $str = "insert into $schema.$table ";

   $strn = "(RowTimeStamp,CreatedBySystemUserID,DateCreated,UpdatedBySystemUserID,DateUpdated,";
   $strv = " VALUES (CURRENT_TIMESTAMP,1,CURRENT_TIMESTAMP,1,CURRENT_TIMESTAMP,";
   while(list($name,$value) = each($_POST)) {
       if(is_bool($value)) {
                $strn .= "$name,";
                $strv .= ($value ? "true":"false") . ",";
                continue;
        };
       if (!is_null($value) and ($value != "")) {
                $strn .= "$name,";
                $strv .= "'$value',";
                continue;
       }
   }
   $strn[strlen($strn)-1] = ')';
   $strv[strlen($strv)-1] = ')';
   $str .= $strn . $strv;
   echo $str;

}
$res = pg_query($dbconn, $str);
  if ($res) {
      echo "<BR/>POST data is successfully logged<BR/><a href='index.php'>Go back home an continue with step 2</a>\n";
  } else {
      echo "<BR/>User must have sent wrong inputs<BR/><a href='new-observer.php'>please go back and fix this</a>\n";
  }

pg_close($dbconn);

?>
</body>
</html>
