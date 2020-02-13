</<!DOCTYPE html>
<html lang="en" dir="ltr">
   <head>
      <meta charset="utf-8">
      <title>Vegetation response to fire</title>
   </head>
   <body>
      <h1>Vegetation response to fire</h1>
      <h2>Database prototype</h2>
<form action="add-observer.php" method="post">
   <div class="person">
      GivenNames: <input type="text" name="GivenNames" value="" size='60'/> (text)<br/>
Surname: <input type="text" name="Surname" value="" size='60' /> (text)<br/>
AddressLine1: <input type="text" name="AddressLine1" value="" size='50' /> (text)<br/>
AddressLine2: <input type="text" name="AddressLine2" value="" size='50' /> (text)<br/>
City: <input type="text" name="City" value="" size='30' /> (text)<br/>
Postcode: <input type="text" name="Postcode" value="" size='4' /> (int, four digits)<br/>
StateID: <select class="" name="StateID">
   <option value="1">NSW</option>
</select><br/>
Email: <input type="text" name="Email" value="" size='75' /> (text)<br/>
Occupation: <input type="text" name="Occupation" value="" size='40' /> (text)<br/>
Notes: <textarea name="Notes" rows="4" cols="40"></textarea><br/>

   </div>
   <input type="submit">
</form>
</body>
</html>
