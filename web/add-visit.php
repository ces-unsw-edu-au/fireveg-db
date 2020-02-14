<?php
$page_title="Adding visit";

## read the password from a file in user directory
include("/home/jferrer/.pgpass.php");
//connect to a database on "localhost" and set the command line parameter which tells the encoding is in UTF-8
$dbconn = pg_connect("host=localhost dbname=fireveg user=jferrer password=$clavepasajera options='--client_encoding=UTF8'")
or die("Could not connect");
$foot_msg = "Connected successfully<br/>";



if ($_POST["visit"]["visit_id"]==NULL) {
   $foot_msg .= "No visit_id, <a href='new-visit.php'>please go back and fix this</a>!";
} else {

   $schema="form";
   $table="field_visit";

   $location = "ST_GeomFromText('POINT(".$_POST["longitude"]." ".$_POST["latitude"].")', ".$_POST["SRID"].")";
   $str = "insert into $schema.$table ";

   $strn = "(CreatedBySystemUserID,DateCreated,UpdatedBySystemUserID,DateUpdated,geom,";
   $strv = " VALUES (1,CURRENT_TIMESTAMP,1,CURRENT_TIMESTAMP,".$location.",";
   while(list($name,$value) = each($_POST["visit"])) {
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
      $main_content .= "<BR/>POST data is successfully logged<BR/><a href='index.php'>Go back home an continue with step 2</a>\n";
   } else {
      $main_content .= "<BR/>User must have sent wrong inputs<BR/><a href='new-visit.php'>please go back and fix this</a>\n";
   }


   $table="fire_history";
   foreach ($_POST["fire"] as $firenr) {
      if ($firenr["fire_date"]==NULL) {
         $foot_msg .= "Ignoring fire with no date<br/>";
      } else {
         $str = "insert into $schema.$table ";

         $strn = "(visit_id,";
         $strv = " VALUES ('".$_POST["visit"]["visit_id"]."',";
         while(list($name,$value) = each($firenr)) {
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
            $main_content .= "<BR/>POST data is successfully logged<BR/><a href='index.php'>Go back home an continue with step 2</a>\n";
         } else {
            $main_content .= "<BR/>User must have sent wrong inputs<BR/><a href='new-visit.php'>please go back and fix this</a>\n";
         }
      }
   }
}

pg_close($dbconn);
include_once("skeleton.php");

?>
