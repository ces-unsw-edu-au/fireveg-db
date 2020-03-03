<?php
$page_title="Modify species in sample";

## read the password from a file in user directory
include("/home/jferrer/.pgpass.php");
//connect to a database on "localhost" and set the command line parameter which tells the encoding is in UTF-8
$dbconn = pg_connect("host=localhost dbname=fireveg user=jferrer password=$clavepasajera options='--client_encoding=UTF8'")
or die("Could not connect");
$foot_msg = "Connected successfully<br/>";



if ($_POST["record_id"]==NULL) {
   $foot_msg .= "No record_id, <a href='edit-quadrat-sample.php'>please go back and fix this</a>!";
   vardump($_POST);
} else {
   $schema="form";
   $table="quadrat_samples";

   $str = "UPDATE $schema.$table SET";
   $whr = "WHERE record_id=".$_POST["record_id"];
   $strn = " ";
   while(list($name,$value) = each($_POST["quadrat"])) {
      // if(is_bool($value)) {
      //    $strn .= "$name,";
      //    $strv .= ($value ? "true":"false") . ",";
      //    continue;
      // };
      if (!is_null($value) and ($value != "")) {
         $strn .= "$name='$value',";
         continue;
      } else {
         $strn .= "$name=NULL,";
         continue;
      }
   }
   $strn[strlen($strn)-1] = ' ';
   $str .= $strn . $whr;
   $foot_msg .= $str;
   $res = pg_query($dbconn, $str);
   if ($res) {
      $main_content .= "<BR/>POST data is successfully logged<BR/><a href='edit-quadrat-species.php?record_id=".$_POST["record_id"]."'>Check record</a>\n";
   } else {
      $main_content .= "<BR/>User must have sent wrong inputs<BR/><a href='new-visit.php'>please go back and fix this</a>\n";
   }
}


pg_close($dbconn);
include_once("skeleton.php");

?>
