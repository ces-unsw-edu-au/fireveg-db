<?php
$page_title="Adding species to sample";

## read the password from a file in user directory
include("/home/jferrer/.pgpass.php");
//connect to a database on "localhost" and set the command line parameter which tells the encoding is in UTF-8
$dbconn = pg_connect("host=localhost dbname=fireveg user=jferrer password=$clavepasajera options='--client_encoding=UTF8'")
or die("Could not connect");
$foot_msg = "Connected successfully<br/>";



if ($_POST["visit_sample"]==NULL) {
   $foot_msg .= "No visit_id, <a href='new-sample.php'>please go back and fix this</a>!";
   vardump($_POST);
} else {
   $scode = explode("::",$_POST["visit_sample"]);
   $schema="form";
   $table="quadrat_samples";

   $str = "insert into $schema.$table ";

   $strn = "(visit_id,sample_nr,";
   $strv = " VALUES ('".$scode[0]."',".$scode[1].",";
   while(list($name,$value) = each($_POST["quadrat"])) {
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
   $foot_msg .= $str;
   $res = pg_query($dbconn, $str);
   if ($res) {
      $main_content .= "<BR/>POST data is successfully logged<BR/><a href='list-quadrat-species.php?visit_id=".$scode[0]."&sample_nr=".$scode[1]."'>Sample $scode[0] nr $scode[1]</a>\n";
   } else {
      $main_content .= "<BR/>User must have sent wrong inputs<BR/><a href='new-visit.php'>please go back and fix this</a>\n";
   }
}


pg_close($dbconn);
include_once("skeleton.php");

?>
