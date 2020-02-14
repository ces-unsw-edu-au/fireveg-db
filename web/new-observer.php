<?php
 $page_title="New observer";
 $main_content .= '
<form action="add-observer.php" method="post">
   <div class="person">
   <table>
   <tr>
   <th>GivenNames</th>
   <td>
<input type="text" name="GivenNames" value="" size="60"/> (text)
   </td>
   </tr>

   <tr>
   <th>Surname</th>
   <td>
<input type="text" name="Surname" value="" size="60" /> (text)
   </td>
   </tr>

   <tr>
   <th>Address:</th>
   <td>
<input type="text" name="AddressLine1" value="" size="50" /> (text) (text)
   </td>
   </tr>

   <tr>
   <th></th>
   <td>
<input type="text" name="AddressLine2" value="" size="50" /> (text)
   </td>
   </tr>

   <tr>
   <th>City</th>
   <td>

<input type="text" name="City" value="" size="30" /> (text)
   </td>
   </tr>

   <tr>
   <th>Postcode</th>
   <td>
<input type="text" name="Postcode" value="" size="4" /> (int, four digits)
   </td>
   </tr>

   <tr>
   <th>StateID</th>
   <td>
   <select class="" name="StateID">
      <option value="1">NSW</option>
   </select><br/>
   </td>
   </tr>

   <tr>
   <th>e-Mail</th>
   <td>
<input type="email" name="Email" value="" size="75" /> (email address)
   </td>
   </tr>

   <tr>
   <th>Occupation</th>
   <td>
<input type="text" name="Occupation" value="" size="40" /> (text)
   </td>
   </tr>

   <tr>
   <th>Notes</th>
   <td>
<textarea name="Notes" rows="4" cols="40"></textarea><br/>
   </td>
   </tr>
      </table>
   </div>
   <input type="submit">
</form>
';

 include_once("skeleton.php");

 ?>
