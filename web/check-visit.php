 <?php
 $vid = $_GET["visit_id"];
 $page_title="Data for visit $vid";
 ## read the password from a file in user directory
 include("/home/jferrer/.pgpass.php");
 //connect to a database on "localhost" and set the command line parameter which tells the encoding is in UTF-8
 $dbconn = pg_connect("host=localhost dbname=fireveg user=jferrer password=$clavepasajera options='--client_encoding=UTF8'")
    or die("Could not connect");
$foot_msg .= "Connected successfully\n<br />\n";

 $qry = "SELECT * FROM form.field_visit as v LEFT JOIN form.observerid as o ON v.mainObserver::numeric=o.UserKey WHERE visit_id = '$vid'";
 $result = pg_query($dbconn, $qry);
 if (!$result) {
   echo "An error occurred.\n";
   exit;
 }
 while ($row = pg_fetch_assoc($result)) {
    while(list($name,$value) = each($row)) {
      if (is_null($value)) {
         $outputvalue="<a style='color: #156565;'> is not set (NULL or empty)</a>";

      } else {
         $outputvalue=$value;
      }
      $main_content.= "<a style='color: #C56565;' href='alter-visit.php?visit_id=$vid&column=$name'>$name</a>: $outputvalue<br/> ";
   }
 }
 pg_close($dbconn);
 include_once("skeleton.php");

 ?>
