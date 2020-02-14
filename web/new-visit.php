 <?php
 $page_title="New visit";
 ## read the password from a file in user directory
 include("/home/jferrer/.pgpass.php");
 //connect to a database on "localhost" and set the command line parameter which tells the encoding is in UTF-8
 $dbconn = pg_connect("host=localhost dbname=fireveg user=jferrer password=$clavepasajera options='--client_encoding=UTF8'")
    or die("Could not connect");
$foot_msg .= "Connected successfully\n<br />\n";

 $qry = "SELECT userkey,surname,givennames FROM form.observerID ORDER BY userkey DESC";
 $result = pg_query($dbconn, $qry);
 if (!$result) {
   echo "An error occurred.\n";
   exit;
 }
 while ($row = pg_fetch_row($result)) {
   $observers .= "<option value='$row[0]'> $row[0]: $row[1], $row[2]</option>";
 }
 pg_close($dbconn);

 $hgt_table = '
 <TABLE>
 <TR>
 <TH></TH>
 <TH>Best</TH>
 <TH>Lower</TH>
 <TH>Upper</TH>
 <TH>Cover</TH>
 </TR>

    <TR>
       <TH>Tree height</TH>
       <TD><input type="text" name="visit[tree_canopy_height_best]" size=2 /> </TD>
       <TD><input type="text" name="visit[tree_canopy_height_lower]" size=2 /> </TD>
       <TD><input type="text" name="visit[tree_canopy_height_upper]" size=2 /> </TD>
       <TD><input type="text" name="visit[tree_canopy_cover]" size=2 /> </TD>
    </TR>
    <TR>
       <TH>Tree scorch height</TH>
       <TD><input type="text" name="visit[tree_canopy_scorch_best]" size=2 /> </TD>
       <TD><input type="text" name="visit[tree_canopy_scorch_lower]" size=2 /> </TD>
       <TD><input type="text" name="visit[tree_canopy_scorch_upper]" size=2 /> </TD>
    <TD> </TD>
    </TR>
    <TR>
       <TH>Mid-canopy height</TH>
       <TD><input type="text" name="visit[mid_canopy_height_best]" size=2 /> </TD>
       <TD><input type="text" name="visit[mid_canopy_height_lower]" size=2 /> </TD>
       <TD><input type="text" name="visit[mid_canopy_height_upper]" size=2 /> </TD>
       <TD><input type="text" name="visit[mid_canopy_cover]" size=2 /> </TD>
    </TR>
    <TR>
       <TH>Mid-canopy scorch height</TH>
       <TD><input type="text" name="visit[mid_canopy_scorch_best]" size=2 /> </TD>
       <TD><input type="text" name="visit[mid_canopy_scorch_lower]" size=2 /> </TD>
       <TD><input type="text" name="visit[mid_canopy_scorch_upper]" size=2 /> </TD>
        <TD> </TD>
    </TR>
    <TR>
       <TH>Shrub height</TH>
       <TD><input type="text" name="visit[shrub_height_best]" size=2 /> </TD>
       <TD><input type="text" name="visit[shrub_height_lower]" size=2 /> </TD>
       <TD><input type="text" name="visit[shrub_height_upper]" size=2 /> </TD>
       <TD><input type="text" name="visit[shrub_cover]" size=2 /> </TD>
    </TR>
    <TR>
       <TH>Shrub scorch height</TH>
       <TD><input type="text" name="visit[shrub_scorch_best]" size=2 /> </TD>
       <TD><input type="text" name="visit[shrub_scorch_lower]" size=2 /> </TD>
       <TD><input type="text" name="visit[shrub_scorch_upper]" size=2 /> </TD>
       <TD> </TD>
    </TR>
    <TR>
       <TH>Ground Layer</TH>
       <TD><input type="text" name="visit[ground_burnt_best]" size=2 /> </TD>
       <TD><input type="text" name="visit[ground_burnt_lower]" size=2 /> </TD>
       <TD><input type="text" name="visit[ground_burnt_upper]" size=2 /> </TD>
       <TD><input type="text" name="visit[ground_cover]" size=2 /> </TD>
    </TR>
 </TABLE>';

$firehst_table = '
<TABLE>
<TR>
<TH></TH>
<TH>Name</TH>
<TH>Date</TH>
<TH>How inferred?</TH>
<TH>Cause of ignition</TH>
</TR>

   <TR>
      <TH>Most recent fire</TH>
      <TD><input type="text" name="fire[0][fire_name]" size=2 /> </TD>
      <TD><input type="date" name="fire[0][fire_date]" size=2 />
<select name="fire[0][fire_date_uncertain]"><option value="1 DAY">exact date</option> <option  value="1 YEAR">year</option> <option  value="1 MONTH">month</option></select>
      </TD>
      <TD><input type="text" name="fire[0][how_inferred]" size=2 /> </TD>
      <TD><input type="text" name="fire[0][cause_of_ignition]" size=2 /> </TD>
   </TR>
   <TR>
      <TH>Penultimate</TH>
      <TD><input type="text" name="fire[1][fire_name]" size=2 /> </TD>
      <TD><input type="date" name="fire[1][fire_date]" size=2 />
<select name="fire[1][fire_date_uncertain]"><option value="1 DAY">exact date</option> <option  value="1 YEAR">year</option> <option  value="1 MONTH">month</option></select>
      </TD>
      <TD><input type="text" name="fire[1][how_inferred]" size=2 /> </TD>
      <TD><input type="text" name="fire[1][cause_of_ignition]" size=2 /> </TD>
   </TR>
   <TR>
      <TH>Antecedent</TH>
      <TD><input type="text" name="fire[2][fire_name]" size=2 /> </TD>
      <TD><input type="date" name="fire[2][fire_date]" size=2 />
<select name="fire[2][fire_date_uncertain]"><option value="1 DAY">exact date</option> <option  value="1 YEAR">year</option> <option  value="1 MONTH">month</option></select>
      </TD>
      <TD><input type="text" name="fire[2][how_inferred]" size=2 /> </TD>
      <TD><input type="text" name="fire[2][cause_of_ignition]" size=2 /> </TD>
   </TR>
</TABLE>';
$biomass_table = '
<TABLE>
<TR>
<TH>Foliage biomass consumed</TH>
<TH>Best</TH>
<TH>Lower</TH>
<TH>Upper</TH>
</TR>
<TR>
   <TH>Tree</TH>
   <TD><input type="text" name="visit[tree_foliage_biomass_consumed_best]" size=2 /> </TD>
   <TD><input type="text" name="visit[tree_foliage_biomass_consumed_lower]" size=2 /> </TD>
   <TD><input type="text" name="visit[tree_foliage_biomass_consumed_upper]" size=2 /> </TD>
</TR>
<TR>
   <TH>Shrub</TH>
   <TD><input type="text" name="visit[shrub_foliage_biomass_consumed_best]" size=2 /> </TD>
   <TD><input type="text" name="visit[shrub_foliage_biomass_consumed_lower]" size=2 /> </TD>
   <TD><input type="text" name="visit[shrub_foliage_biomass_consumed_upper]" size=2 /> </TD>
</TR>
<TR>
   <TH>Ground</TH>
   <TD><input type="text" name="visit[ground_foliage_biomass_consumed_best]" size=2 /> </TD>
   <TD><input type="text" name="visit[ground_foliage_biomass_consumed_lower]" size=2 /> </TD>
   <TD><input type="text" name="visit[ground_foliage_biomass_consumed_upper]" size=2 /> </TD>
</TR>
</TABLE>';

$twigs_table = '
<TABLE>
<TR>
<TH></TH>
<TH>Best</TH>
<TH>Lower</TH>
<TH>Upper</TH>
<TH>Raw</TH>
</TR>
<TR>
   <TH>Largest shrub twigs</TH>
   <TD><input type="text" name="visit[largest_twigs_consumed_best]" size=2 /> </TD>
   <TD><input type="text" name="visit[largest_twigs_consumed_lower]" size=2 /> </TD>
   <TD><input type="text" name="visit[largest_twigs_consumed_upper]" size=2 /> </TD>
   <TD><input type="text" name="visit[largest_twigs_consumed_raw]" size=20 /> </TD>
</TR>
</TABLE>';


$peat_table = '
<TABLE>
<TR>
<TH></TH>
<TH>%Area/plot</TH>
<TH>max depth</TH>
</TR>
<TR>
   <TH>Peat consumption</TH>
   <TD><input type="text" name="visit[peat_consumption_area]" size=2 /> </TD>
   <TD><input type="text" name="visit[peat_consumption_maxdepth]" size=2 /> </TD>
</TR>
</TABLE>';

$site_table = '
<table>
<tr>
<th>Site description</th>
<td>
<input type="text" name="visit[visit_description]" value="" /> (text)
</td>
</tr>
<tr>
<th>Observers</th>
<td>
<select class="" name="visit[observer]">'.$observers.'
</select>
</td>
</tr>
<tr>
<th>Sample identifier</th>
<td>
<input type="text" name="visit[visit_id]" value="000" /> (text)
</td>
</tr>
<tr>
<th>Date of sampling</th>
<td>
<input type="date" name="visit[visit_date]" value="" />
</td>
</tr>
<tr>
<th>Plant Community Type</th>
<td>
<textarea name="visit[PlantCommunityType]" rows="4" cols="40"></textarea>
</td>
</tr>
<tr>
<th>ThreatenedEcologicalCommunity</th>
<td>
<textarea name="visit[ThreatenedEcologicalCommunity]" rows="4" cols="40"></textarea>

</td>
</tr>
</table>
';

$locs_table = '
<table>
<tr>
<th>Location</th>
<td>
<input type="text" name="visit[location_description]" value="" /> (text)
</td>
</tr>
<tr>
<th>Coordinates (lat/long or norhting/easting)</th>
<td>
<input type="text" name="latitude" size=7 /> <input type="text" name="longitude" size=7 />
</td>
</tr>
<tr>
<th>Spatial projection</th>
<td>
<select name="SRID">
<option value="4326">LAT LONG WGS84</option>
<option  value="4283">LAT LONG GDA94</option>
<option  value="28355">UTM ZONE 55</option>
<option  value="28356">UTM ZONE 56</option></select>
</td>
</tr>
</table>
';


 $main_content .= ' <form action="add-visit.php" method="post">
     <div class="site">


'.$site_table.$locs_table.$firehst_table.
$hgt_table.$biomass_table.$twigs_table.$peat_table.
'

        </div>
     <input type="submit">
  </form>
 ';
 include_once("skeleton.php");

 ?>
