<?php  include_once 'include/class.user.php'; $user=new User(); $once = true;?>
<!DOCTYPE html>
<html lang="en">
   <head>
      <title>Rooms</title>
      <meta charset="utf-8">
      <meta name="viewport" content="width=device-width, initial-scale=1">
      <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
      <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
      <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
      <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
      <link rel="stylesheet" href="/resources/demos/style.css">
      <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
      <link rel="stylesheet" href="/resources/demos/style.css">
      <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
      <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
      <script>
         if ( window.history.replaceState ) {
           window.history.replaceState( null, null, window.location.href );
         }
           $( function() {
             $( ".datepicker" ).datepicker({
                           dateFormat : 'yy-mm-dd'  }); });
      </script>
      <style>
        .imgC{
         height:250px;
         }
         input[type=text], .newC {
         width: 100%;
         padding: 6px;
         border: 1px solid #ccc;
         border-radius : 4px;
         margin-top: 6px;
         margin-bottom: 16px;
         resize: vertical;
         color: black;
         }
         body{
         background-image: url('images/home_bg.jpg');
         background-repeat: no-repeat;
         background-repeat: no-repeat;
         background-attachment: fixed;
         }
         }

         .greyB{
           background-color : gray;
         }
      </style>
   </head>
<?php
 $updateRooms="";
 if(isset($_GET["updateRooms"])){
  $updateRooms = $_GET['updateRooms'];

 if(isset($_GET["cust_id"])){
  $cust_id = $_GET['cust_id'];
 }

 if(isset($_GET["bookingId"])){
  $bookingId = $_GET['bookingId'];
 }
 if(isset($_GET["roomTypeId"])){
  $roomTypeId = $_GET['roomTypeId'];
 }

 if(isset($_GET["checkIn"])){
  $checkIn = $_GET['checkIn'];
 }
 
 if(isset($_GET["checkOut"])){
  $checkOut = $_GET['checkOut'];
 }
}
?>
   <body>
    <div class="bg-image"></div>
      <div class="container">
        <div class="mx-auto">
          <div class="card-body">
          <form method="POST">
          <?php
            if($updateRooms){
              ?>
              <div class="row greyB" style="background-color : gray">
                

                <div class="col-5">
                  <select name="room_type" class="custom-select newC" id="room_type" required>
                    <option value='0'>Select Room Type</option>
                    <option   value="1" >Deluxe</option>
                    <option  value="2" >Super Deluxe</option>
                    <option   value="3" >Premium</option>
                    <option  value="4" >Villa</option>              
                  </select>
                </div> 

                <div class="col-3">
                <input type="text" class="datepicker" name="checkin" value="<?php echo $checkIn ?>"  placeholder ="Check In" required>
                </div>
                <div class="col-3">
                <input type="text" class="datepicker" name="checkout"  value="<?php echo $checkOut ?>"  placeholder ="Check Out" required>
                </div>

                <div class="col-1">
                <input type="submit" class="btn btn-primary" name="submit"  placeholder ="Submit" Value ="Confirm">
                </div>

              
                <input type="hidden" name="rest_id" value="<?php echo $eachrow['restaurant_id']; ?>">
                <input type="hidden" name="loyalty" value="<?php echo $eachrow['restaurant_max_loyalty_points']; ?>">
              </div>
              <?php
            }
            else{
              ?>
              <div class="row greyB" style="background-color : gray">
            

                <div class="col-5">
                  <select name="room_type" class="custom-select newC" id="room_type" required>
                    <option value='0'>Select Room Type</option>
                    <?php 
                    $room_type_query = mysqli_query($user->db,"CALL sp_get_room_type");
                    while($room_type = mysqli_fetch_array($room_type_query))
                    {echo "<option value='".$room_type['room_type_id']."'required>".$room_type['room_type']."</option>";
                    }
                    $user->db->next_result();
                    ?>  
                  </select>
                </div> 

                <div class="col-3">
                <input type="text" class="datepicker" name="checkin"  placeholder ="Check In" required>
                </div>
                <div class="col-3">
                <input type="text" class="datepicker" name="checkout"  placeholder ="Check Out" required>
                </div>

                <div class="col-1">
                <input type="submit" class="btn btn-primary" name="submit"  placeholder ="Submit" Value ="Confirm">
                </div>

              
                <input type="hidden" name="rest_id" value="<?php echo $eachrow['restaurant_id']; ?>">
                <input type="hidden" name="loyalty" value="<?php echo $eachrow['restaurant_max_loyalty_points']; ?>">


              </div>
              <?php
            }
          ?>


            </form>
          </div>
        </div>
        <!-- close class mx-auto -->
        <?php 
      if($once){
        if($_SERVER['REQUEST_METHOD'] == 'POST')
        {
          if(isset($_POST['submit'])) 
          { 
             extract($_POST); 

             date_default_timezone_set("Asia/Calcutta");
             $date_now = date("Y-m-d"); 
         
             if ($checkin >= $date_now && $checkout >= $checkin ) //check date greater than today
             { 
               if($room_type > 0) {
                 if($updateRooms){
                  echo "<a href='Room_Availability.php?checkIn=".$checkin."&checkOut=".$checkout."&roomTypeId=".$room_type."&bookingId=".$bookingId."&updateRooms=".$updateRooms."&cust_id=".$cust_id."'> <button class='btn btn-primary btn-block'> You can update room number now"."</button></a>";
                 }
                 else{
                  echo "<a href='Room_Availability.php?checkIn=".$checkin."&checkOut=".$checkout."&roomTypeId=".$room_type."&insertRoom=insertRoom"."'> <button class='btn btn-primary btn-block'> you will be re directed to room number selection page for dates ".$checkin." -".$checkout." </button></a>";
                 }
                }
                else{
                  echo 'Please select a room to continue';
                }
              }
              else{
                  echo "Please enter date greater than today or check in date";
                }
            }           
        }
         $once = false;
      }     
?>
  
         <?php 
            $sql="select * from t_room_type";
            $result = mysqli_query($user->db,$sql);

         

            
            if($result)
            {
                if(mysqli_num_rows($result) > 0)
                {
                    while($eachrow = mysqli_fetch_array($result))
                    { 
            ?>   

         <br>
                <div class="card ">
                <img class="card-img-left imgC" src="images/rvilla.jpg" alt="Card image">
                    <div class="card-body">
                      
                      <div class ="row">
                      <!-- col - 8 -->
                      <div class ="col-12">

                        <div class="row">
                          <div class="col-9 " style="text-align: justify;">
                          <h4>
                              <?php 
                              $sp_roomDetails = "CALL sp_get_room_details_by_id('$eachrow[room_type_id]')";
                              $roomD_result = mysqli_query($user->db, $sp_roomDetails);
                              while($rD=mysqli_fetch_array($roomD_result))
                              {echo " ".$rD['room_type'];}
                              $user->db->next_result();
                              ?>
                           
                             </h4>
                          </div>
                          <div class="col-3"><h4>€<?php   echo  $eachrow['room_rent']; ?> </h4></div>
                          <hr>
                        </div>
                        <hr>
                        <div class="row">
                          <div class="col">
                            <?php 
                            $sp_roomDetails = "CALL sp_get_room_details_by_id('$eachrow[room_type_id]')";
                            $roomD_result = mysqli_query($user->db, $sp_roomDetails);
                            while($rD=mysqli_fetch_array($roomD_result))
                            {  echo " ".$rD['room_details'];
                              echo "<B><U> LOYALTY POINTS - </U></B>".$rD['room_loyalty']." "; }
                            $user->db->next_result();
                            ?>
                          </div>
                        </div>
                          
                        <br>
                    

                        <?php
                        // $sp_roomDetails = "CALL sp_get_room_details_by_id('$eachrow[room_type_id]')";
                        // $roomD_result = mysqli_query($user->db, $sp_roomDetails);
                        // while($rD=mysqli_fetch_array($roomD_result))
                        { ?>

                        <div class="row">
                          <div class ="col-6">
                            <b>Location :</b> 
                            <?php 
                            
                            $sp_floor = "CALL sp_get_room_floor_by_roomID('$eachrow[room_type_id]')";
                            $rflor = mysqli_query($user->db, $sp_floor);
                            while($rF=mysqli_fetch_array($rflor))
                            {  echo " ".$rF['room_floor']." Floor"; 
                             }
                            $user->db->next_result();
                            
                            
                             ?>
                          </div>

                          <div class ="col-6">
                            <b>Max Occupancy : </b>
                            <?php 

                            $sp_ac = "CALL sp_get_adult_child_capacity_by_roomtype('$eachrow[room_type_id]')";
                            $ac = mysqli_query($user->db, $sp_ac);
                            while($rC=mysqli_fetch_array($ac))
                            {  echo " ".$rC['adult_capacity']." Adults + ".$rC['children_capacity']." Children";} 
                            $user->db->next_result();
                           
                            ?> 
                         
                          </div>
                        </div>
                     
                      
                        <div class="row">
                          <div class ="col-6">
                            <b>Smoking Allowed? : </b>
                            <?php
                            $sp_roomDetails = "CALL sp_get_room_details_by_id('$eachrow[room_type_id]')";
                            $roomD_result = mysqli_query($user->db, $sp_roomDetails);
                            while($rD=mysqli_fetch_array($roomD_result))
                            {
                            echo $rD['room_preference']; ?>
                          </div>
                          <div class = "col-6">
                            <button class="btn btn-link" type="button" data-toggle="collapse" data-target="#collapseExample" aria-expanded="false" aria-controls="collapseExample">
                            <a>More Amenities 
                            <?php  ?>
                            </a>
                            </button>
                          </div>
                   
                        </div>


                        <div class="collapse" id="collapseExample">
                          <div class="card card-body">
                         <?php echo $rD['room_amenity_details'];?>
                       
                          </div>
                        </div>
                        
                     
                      
                      </div>
                      <?php $user->db->next_result();}}?>
                     
                 <!-- col - 9 -->
                    
                  <div class ="col-3" style="width:100% ; "> 
            

                  </div>
                    
                </div>
                <br>
               </div>
              </div>
                <br>

        




                <?php
                  }
                  }
                  }
                  ?>  
            </div>

        <!-- <script>
          $(document).ready(function(){

            $("#room_type").change(function(){
              // alert("The text has been changed.");
              var room_type_id = $("#room_type option:selected").val();
               
              $.ajax({
                  type: "GET",
                  url: "ajax_call_rooms.php",
                  data: {
                      action : 'get_rooms_by_room_type_id',
                      room_type_id : room_type_id
                  }, 
                  success: function (data) {
                    // var arr = [];
                    // arr.push(data);
                    // $(jQuery.parseJSON(JSON.stringify(data))).each(function() {  
                    //     var room_type = this.room_type;
                        // var TITLE = this.Title;
                    });
                    alert(data);
                    // alert(JSON.stringify(data[0].room_type));
                    // var abc = [];
                    // var i;
                    // for (i = 0; i < data.length; i++) {
                    //   console.log(data[i].room_type);
                    // }

                    // for (var i = 0; i < data.length; i++) {
                    //   var object = data[i];
                    //   for (var room in object) {
                    //     alert('item ' + i + ': ' + property + '=' + object[0]);
                    //   }
                    // }
                      $("#price").text(data);

                  }
              });
            });

          }); -->
        <!-- </script> -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
        <!-- Include all compiled plugins (below), or include individual files as needed -->
        <script src="js/bootstrap.min.js"></script>
        <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
        <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
   </body>
</HTML>