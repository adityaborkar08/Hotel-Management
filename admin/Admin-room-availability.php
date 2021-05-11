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
input[type=text], select, textarea {
    width: 100%;
    padding: 12px;
    border: 1px solid #ccc;
    margin-top: 6px;
    margin-bottom: 16px;
    resize: vertical;
    color: black;
    }
</style>
</body>




<div class="container">

        <div class="mx-auto">
          <div class="card-body border">
         <H3> Book Room for Customer</H3>
         <BR>
          <form method="POST">
       
                <div class="form-group">
                <label for="exampleDropdownFormPassword1">Room Type</label>
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

                
            <div class="form-group">
            <label for="exampleDropdownFormPassword1">Check In</label>
              <input type="text" class="datepicker" name="checkin"  placeholder ="Check In" required>
              </div>
              <div class="form-group">
            <label for="exampleDropdownFormPassword1">Check Out</label>
              <input type="text" class="datepicker" name="checkout"  placeholder ="Check Out" required>
              </div>

              <div class="form-group">
              <input type="submit" class="btn btn-primary btn-block" name="submit"  placeholder ="Submit" Value ="Confirm">
              </div>


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
                  echo "<a href='Admin-room-number.php?checkIn=".$checkin."&checkOut=".$checkout."&roomTypeId=".$room_type."'> <button class='btn btn-primary btn-block'> Rooms are available. check room numbers for dates ".$checkin." -".$checkout." </button></a>";
                  }else{
                    echo 'Please select a room to continue';
                  }
                }else{
                  echo "Please enter date greater than today or check in date";
                }
            }           
        }
         $once = false;
      }     
?>
  </div>

  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
        <!-- Include all compiled plugins (below), or include individual files as needed -->
        <script src="js/bootstrap.min.js"></script>
        <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
        <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
   </body>
</HTML>