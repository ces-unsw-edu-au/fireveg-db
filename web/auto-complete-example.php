<!DOCTYPE html>
<html>
  <head>
    <title>
      jQuery Autocomplete Demo
    </title>
    <!-- (1) YOU NEED TO LOAD BOTH JQUERY AND JQUERY UI -->
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>

    <!-- (2) ATTACH AUTOCOMPLETE ON PAGE LOAD -->
    <script>
      //$(function () {
        // NAME AUTO-COMPLETE
        $('#spname').autocomplete({
          source: function (request, response) {
            $.ajax({
              type: "POST",
              url: "inc/prueba.php",
              data: {
                term: request.term,
                type: "spname"
              },
              success: response,
              dataType: 'json',
              minLength: 2,
              delay: 100
            });
          }
        });
      //});
    </script>
  </head>
  <body>
    <!-- (3) DUMMY FORM -->
     <FORM action='inc/prueba.php'>
    Name: <input type="text" id="spname"/>
   Search: <input type="text" name="term" />
    What: <input type="text" name="type" value='spname'/>
    <br/>
    <input type='submit'/>
</FORM>
  </body>
</html>
