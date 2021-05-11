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
      <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css">

      <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
      <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
      <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
      <script>
         if ( window.history.replaceState ) {
           window.history.replaceState( null, null, window.location.href );
         }
           $( function() {
             $( ".datepicker" ).datepicker({
                           dateFormat : 'yy-mm-dd'  }); });
      </script>
</head>

<body>


<?php

$roomFloor="";
$roomTypeId = "";
$roomType = "";
$checkIn= "";
 $checkOut="";
 $insertRoom="";
 $updateRooms="";
 if (isset($_GET["insertRoom"])) {                   
  $insertRoom = $_GET['insertRoom'];
    if (isset($_GET["checkIn"])) {                   
    $checkIn = $_GET['checkIn'];
    }
    if(isset($_GET["checkOut"])){
    $checkOut = $_GET['checkOut'];
    }
    if(isset($_GET["roomTypeId"])){
    $roomTypeId = $_GET['roomTypeId'];
    if((int)$roomTypeId == 1){
    $roomType = "Deluxe";
    $roomFloor = "1st Floor";
    }if((int)$roomTypeId == 2){
     $roomType = "Super Deluxe";
     $roomFloor = "2nd Floor";
    }if((int)$roomTypeId == 3){
     $roomType = "Premium";
     $roomFloor = "3rd Floor";
    }if((int)$roomTypeId == 4){
     $roomType = "Villa";
     $roomFloor = "4th Floor";
    }
    
       }

       $sqlFn = ("SELECT fn_get_price_by_days('$roomTypeId','$checkIn','$checkOut')");
       $resFn =  mysqli_query($user->db,$sqlFn);
       $fcal = mysqli_fetch_array($resFn);
       $troomRent = $fcal[0];


       $user->db->next_result(); 


   }


   if(isset($_GET["updateRooms"])){
      $updateRooms = $_GET['updateRooms'];
    
      if(isset($_GET["cust_id"])){
        $cust_id = $_GET['cust_id'];
      }

      if(isset($_GET["bookingId"])){
        $bookingId = $_GET['bookingId'];
      }

      if (isset($_GET["checkIn"])) {                   
        $checkIn = $_GET['checkIn'];
      }

      if(isset($_GET["checkOut"])){
        $checkOut = $_GET['checkOut'];
      }
      if(isset($_GET["roomTypeId"])){
        $roomTypeId = $_GET['roomTypeId'];
        if((int)$roomTypeId == 1){
        $roomType = "Deluxe";
        $roomFloor = "1st Floor";
        }if((int)$roomTypeId == 2){
        $roomType = "Super Deluxe";
        $roomFloor = "2nd Floor";
        }if((int)$roomTypeId == 3){
        $roomType = "Premium";
        $roomFloor = "3rd Floor";
        }if((int)$roomTypeId == 4){
        $roomType = "Villa";
        $roomFloor = "4th Floor";
        }
        
      }

      $sqlFn = ("SELECT fn_get_price_by_days('$roomTypeId','$checkIn','$checkOut')");
      $resFn =  mysqli_query($user->db,$sqlFn);
      $fcal = mysqli_fetch_array($resFn);
      $troomRent = $fcal[0];


      $user->db->next_result();

  }
 
?>

<br>
<div class="container">
  <div class="row">

    <div class="col border">
      <br>
      <div class="alert alert-primary" role="alert">
        <!-- -->
        Room type - <?php echo $roomType; ?>
        <br>
        Check in - <?php echo $checkIn; ?>
        | Check out - <?php echo $checkOut; ?>
        <br>
        Floor Number - <?php echo $roomFloor; ?>
        <br>
      
      </div>
      <div class="alert alert-warning" role="alert">
      <h4> Total Rent - <?php echo $troomRent; ?></h4>
      Note : 10% extra charges applicable per day on weekends !
      </div>

      <?php
          $sp_avCount = "CALL sp_get_available_room_count('$roomTypeId','$checkIn','$checkOut')";
          $res_avCount = mysqli_query($user->db, $sp_avCount);
          while($rC=mysqli_fetch_array($res_avCount))
          {   $count = $rC['count'];
            ?> 
          <h4> <?php if($count){
              echo $rC['count']." Available Rooms based on your search ";
          }
              else{
              echo "No rooms available";
              }
              ?></h4>
        
          
          
          <?php }
          $user->db->next_result();
      ?>   

      <br>

      <form method="POST">
      Select Room number (Refer Room Chart)
      <h4></h4>
      <select class="custom-select" name="roomNumber" required>
        <option value='0'>Select room number</option>
          <?php
          $sp_available = "CALL sp_get_available_room_number_by_room_type_id('$roomTypeId','$checkIn','$checkOut')";
          $res_av = mysqli_query($user->db, $sp_available);
          while($rD=mysqli_fetch_array($res_av))
          {   
            echo
            "<option value='".$rD['room_number']."'>".$rD['room_number']."</option>";
          
          }
          $user->db->next_result();
          ?>
      </select>
      <h1></h1>
      <div>
      <br>
      
      <?php
      if($updateRooms){
        ?>
        <input type="submit" class="btn btn-primary" name="submit"  placeholder ="Submit" value ="Update">
        <?php
      }
      else{
        ?>
        <input type="submit" class="btn btn-primary" name="submit"  placeholder ="Submit" value ="Confirm Room Number?">
        <?php
      }
      ?>
   
      <!-- <input type="submit" class="btn btn-primary" name="submit"  placeholder ="Submit" value ="Confirm Room Number?"> -->
      
      </div> 
      </form>
<br>
      
<?php
      if($once){
        if($_SERVER['REQUEST_METHOD'] == 'POST')
        {
          if(isset($_POST['submit'])) 
          { 
             extract($_POST); 
             if($roomNumber){
              if($insertRoom){
                echo "
                Please Register or Login to continue
                <nav aria-label='breadcrumb'>
                  <ol class='breadcrumb'>
                    <li class='breadcrumb-item'> <a href='Customer_Registeration.php?roomNumber=".$roomNumber."&checkIn=".$checkIn."&checkOut=".$checkOut."&roomTypeId=".$roomTypeId."&troomRent=".$troomRent."'> Register</a>   </li>
                    <li class='breadcrumb-item'> <a href='Customer_Login.php?roomNumber=".$roomNumber."&checkIn=".$checkIn."&checkOut=".$checkOut."&roomTypeId=".$roomTypeId."&troomRent=".$troomRent."'> Login</a>   </li>
                  </ol>
                </nav>
                ";
              }
              if($updateRooms){
                
                $sp_ac = "CALL sp_get_adult_child_capacity_by_roomtype('$roomTypeId')";
                $ac = mysqli_query($user->db, $sp_ac);
                while($rC=mysqli_fetch_array($ac))
                {  $adult = $rC['adult_capacity'];
                  $children = $rC['children_capacity'];
                } 
                $user->db->next_result();

                $sp_rid = "CALL sp_get_roomID_by_roomNumber('$roomNumber')";
                $res_rid = mysqli_query($user->db, $sp_rid);
                while($rRid=mysqli_fetch_array($res_rid))
                { $roomID = $rRid['room_number_id']; }
                $user->db->next_result();
  
                $sp_rtid = "CALL sp_get_room_details_by_id('$roomTypeId')";
                $res_rtid = mysqli_query($user->db, $sp_rtid);
                while($rRtid=mysqli_fetch_array($res_rtid))
                { $roomLoyalty = $rRtid['room_loyalty']; }
                $user->db->next_result();

                $updateSql = "CALL sp_update_booked_rooms_by_booking_id('$bookingId','$roomID','$adult','$children','$checkIn',
                '$checkOut', '$roomLoyalty', '$troomRent', '$cust_id')";
                $roomUpdate = mysqli_query($user->db, $updateSql);
                // while($rRtid=mysqli_fetch_array($res_rtid))
                // { $roomLoyalty = $rRtid['room_loyalty']; }
                $user->db->next_result();
                echo  '<script>alert("Updated Successfully")</script>';
                ?>
                <script>
                var cust_id = "<?php echo $cust_id ?>";
                    window.location = "customer_dashboard.php?cust_id=" + cust_id;
                </script>
                  <?php
              }
              
            
            }
            else{
               echo "Please select a room number";
             }
            
       
           
            }           
        }
         $once = false;
      }     
?>


    </div>





    <div class="col border">
    <br>
    <div class="alert alert-dark" role="alert">
       Room Chart
      </div>
    <h5><span class="badge badge-primary ">Extreme Corner </span> xx1 - xx3 </h5> <br>
    <h5><span class="badge badge-success ">Near Elevator </span> xx4 - xx6 </h5> <br>
    <h5><span class="badge badge-primary ">Extreme Corner </span> xx7 - x10 </h5> <br>

    <div class="alert alert-dark" role="alert">
       Room Deals
      </div>
          <div class="card mx-auto">
            <img class="card-img-top" src="images/burrito.jpg" style="height : 250px"alt="Card image cap">
              <div class="card-body">
                <p class="card-text">Check out <a href="Deal.php">Deals</a> on your booked rooms</p>
                <small>Please Note : The deals are available only for loyal customer.</small>
              </div>
          </div>  
    </div>


  </div>
<div>




   </body>
</HTML>