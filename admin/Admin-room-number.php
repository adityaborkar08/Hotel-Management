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

</body>

<?php

$roomFloor="";
$roomTypeId = "";
$roomType = "";
$checkIn= "";
 $checkOut="";
if (isset($_GET["checkIn"])) {                   
   $checkIn = $_GET['checkIn'];

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
      Select Room number 
      <h4></h4>
      <select class="custom-select" name="roomNumber">
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
   
      <input type="submit" class="btn btn-primary" name="submit"  placeholder ="Submit" value ="Confirm Room Number?">
      
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
              echo "
              Please Register the customer 
              <nav aria-label='breadcrumb'>
                <ol class='breadcrumb'>
                  <li class='breadcrumb-item'> <a href='Admin_book_room.php?roomNumber=".$roomNumber."&checkIn=".$checkIn."&checkOut=".$checkOut."&roomTypeId=".$roomTypeId."'> Register</a>   </li>

                </ol>
              </nav>
              ";
            }else{
               echo "Please select a room number";
             }
            }           
        }
         $once = false;
      }     
?>


    </div>







  </div>
<div>




  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
        <!-- Include all compiled plugins (below), or include individual files as needed -->
        <script src="js/bootstrap.min.js"></script>
        <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
        <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
   </body>
</HTML>