<!DOCTYPE html>
<html lang="en" dir="ltr">
   <head>
      <meta charset="utf-8">
      <title>Vegetation response to fire</title>
      <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel='stylesheet' href='https://fonts.googleapis.com/css?family=Roboto'>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
html,body,h1,h2,h3,h4,h5,h6 {font-family: "Roboto", sans-serif}
th {background-color:powderblue; text-align:center; font-size: 88%; color: "#675622"}
td {background-color:pink; text-align:left; font-size: 85%; color: "#675622"}

</style>
   </head>
   <body class="w3-light-grey">
      <!-- Page Container -->
      <div class="w3-content w3-margin-top" style="max-width:1400px;">

        <!-- The Grid -->
        <div class="w3-row-padding">

          <!-- Left Column -->
          <div class="w3-third">

            <div class="w3-white w3-text-grey w3-card-4">
                      <!--//
              <div class="w3-display-container">
          <img src="/w3images/avatar_hat.jpg" style="width:100%" alt="Avatar">
                <div class="w3-display-bottomleft w3-container w3-text-black">
                </div>
                </div> //-->
                <h1>Vegetation response to fire</h1>
              <h2>Database prototype</h2>
              <div class="w3-container">
                 <p> <a href='index.php'>Home</a></p>
                 <p> <a href='map.php'>Map</a></p>
                 <p> <a href='species-list.php'>Taxonomic list</a></p>
                 <p> <a href='list-localities.php'>List of sites (coordinates)</a></p>
              <p> <a href='list-references.php'>List of references</a></p>
                 <!--//

                <p><i class="fa fa-briefcase fa-fw w3-margin-right w3-large w3-text-teal"></i>Designer</p>
                <p><i class="fa fa-home fa-fw w3-margin-right w3-large w3-text-teal"></i>London, UK</p>
                <p><i class="fa fa-envelope fa-fw w3-margin-right w3-large w3-text-teal"></i>ex@mail.com</p>
                <p><i class="fa fa-phone fa-fw w3-margin-right w3-large w3-text-teal"></i>1224435534</p>
                <hr>

                <p class="w3-large"><b><i class="fa fa-asterisk fa-fw w3-margin-right w3-text-teal"></i>Skills</b></p>
                <p>Adobe Photoshop</p>
                <div class="w3-light-grey w3-round-xlarge w3-small">
                  <div class="w3-container w3-center w3-round-xlarge w3-teal" style="width:90%">90%</div>
                </div>
                <p>Photography</p>
                <div class="w3-light-grey w3-round-xlarge w3-small">
                  <div class="w3-container w3-center w3-round-xlarge w3-teal" style="width:80%">
                    <div class="w3-center w3-text-white">80%</div>
                  </div>
                </div>
                <p>Illustrator</p>
                <div class="w3-light-grey w3-round-xlarge w3-small">
                  <div class="w3-container w3-center w3-round-xlarge w3-teal" style="width:75%">75%</div>
                </div>
                <p>Media</p>
                <div class="w3-light-grey w3-round-xlarge w3-small">
                  <div class="w3-container w3-center w3-round-xlarge w3-teal" style="width:50%">50%</div>
                </div>
                <br>

                <p class="w3-large w3-text-theme"><b><i class="fa fa-globe fa-fw w3-margin-right w3-text-teal"></i>Languages</b></p>
                <p>English</p>
                <div class="w3-light-grey w3-round-xlarge">
                  <div class="w3-round-xlarge w3-teal" style="height:24px;width:100%"></div>
                </div>
                <p>Spanish</p>
                <div class="w3-light-grey w3-round-xlarge">
                  <div class="w3-round-xlarge w3-teal" style="height:24px;width:55%"></div>
                </div>
                <p>German</p>
                <div class="w3-light-grey w3-round-xlarge">
                  <div class="w3-round-xlarge w3-teal" style="height:24px;width:25%"></div>
               </div>//-->
                <br>
              </div>
            </div><br>

          <!-- End Left Column -->
          </div>

          <!-- Right Column -->
          <div class="w3-twothird">

             <?php
              echo "<h1>$page_title</h1>";

             echo $main_content;
             ?>

            <!-- If map content, then source map code and data... -->

        <?php
             echo $map_content;
             ?>

          <!-- End Right Column -->
          </div>

        <!-- End Grid -->
        </div>

        <!-- End Page Container -->
      </div>

      <footer class="w3-container w3-teal w3-center w3-margin-top">
         <?php
             echo $foot_msg;
             ?>
         <!--//
        <p>Find me on social media.</p>
        <i class="fa fa-facebook-official w3-hover-opacity"></i>
        <i class="fa fa-instagram w3-hover-opacity"></i>
        <i class="fa fa-snapchat w3-hover-opacity"></i>
        <i class="fa fa-pinterest-p w3-hover-opacity"></i>
        <i class="fa fa-twitter w3-hover-opacity"></i>
        <i class="fa fa-linkedin w3-hover-opacity"></i>
        <p>Powered by <a href="https://www.w3schools.com/w3css/default.asp" target="_blank">w3.css</a></p>
        //-->
        <a href='index.php'>Back to the index</a>
      </footer>
</body>
</html>
