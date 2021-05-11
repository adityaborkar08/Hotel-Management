<?php  include_once 'include/class.user.php'; $user=new User(); $once = true;
?>

<!DOCTYPE html>
<html lang="en">
   <head>
      <meta charset="utf-8">
      <meta http-equiv="X-UA-Compatible" content="IE=edge">
      <meta name="viewport" content="width=device-width, initial-scale=1">
      <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
      <title>Register</title>
      <!-- Bootstrap -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
        <link rel="stylesheet" href="/resources/demos/style.css">
        <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css">
            
        <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
        <link rel="stylesheet" href="/resources/demos/style.css">
        <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
        <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
      <script>
         $( function() {
           $( ".datepicker" ).datepicker({
                         dateFormat : 'yy-mm-dd'
                       });
         } );
      </script>
      <script>
        if ( window.history.replaceState ) {
        window.history.replaceState( null, null, window.location.href );
        }
    </script>
   </head>
   <body>


   <?php 

$banquet_id = "";
$restID="";
$roomNumber="";
$fromConf = "";
   if(isset($_GET["banquet_id"])){                      //--------Banquets
    $banquet_id = $_GET['banquet_id'];

    if(isset($_GET["book_date"])){
        $book_date = $_GET['book_date'];
       }
       if(isset($_GET["time_from"])){
        $time_froms = $_GET['time_from'];
        // echo $time_froms;
       }
       if(isset($_GET["time_to"])){
        $time_tos = $_GET['time_to'];
        // echo $time_tos;
       }
       if(isset($_GET["banquet_capacity"])){
        $banquet_capacity = $_GET['banquet_capacity'];
       }
       if(isset($_GET["banquet_menu_type"])){
        $banquet_menu_type = $_GET['banquet_menu_type'];
       }
       if(isset($_GET["loyalty"])){
        $loyalty = $_GET['loyalty'];
       }
   }
   elseif (isset($_GET["restID"])) {                    //--------Restaurants
    $restID = $_GET['restID'];

    if(isset($_GET["DT"])){
        $checkin = $_GET['DT'];
       }
       if(isset($_GET["time"])){
        $timet = $_GET['time'];
       }
       if(isset($_GET["guests"])){
        $guests = $_GET['guests'];
       }
       if(isset($_GET["loyalty"])){
        $loyalty = $_GET['loyalty'];
       }
    $combinedDT = date('Y-m-d H:i:s', strtotime("$checkin $timet"));
   }

   elseif(isset($_GET["roomNumber"])){
    $roomNumber = $_GET['roomNumber'];
    if(isset($_GET["roomTypeId"])){
      $roomTypeId = $_GET['roomTypeId'];  
     }
     if(isset($_GET["checkIn"])){
      $checkIn = $_GET['checkIn'];
     }
     if(isset($_GET["checkOut"])){
      $checkOut = $_GET['checkOut'];
     }
     if(isset($_GET["troomRent"])){
        $troomRent = $_GET['troomRent'];
       }
  
  }
  elseif (isset($_GET["fromConf"])) {                    //--------Restaurants
    $fromConf = $_GET['fromConf'];
    $confYes = "yes";
    if(isset($_GET["DT"])){
        $date = $_GET['DT'];
       }
       if(isset($_GET["time"])){
        $time = $_GET['time'];
       }
       if(isset($_GET["no_guests"])){
        $no_guests = $_GET['no_guests'];
       }
       if(isset($_GET["tcon"])){
        $tcon = $_GET['tcon'];
       }
    $combinedDT = date('Y-m-d H:i:s', strtotime("$date $time"));
   }
//    $combinedDT = date('Y-m-d H:i:s', strtotime("$checkin $time"));
   
   
   ?>

        <div class="well">
            <div class="form-group">
                <h2 class="text-center" color= #ffbb2b>Customer Registration </h2>
             
                <hr>
                <form action="" method="POST" >
                    <div class="container">
                        <div class="row mb-4">
                            <div class="col-md-6">
                                <div class="card">
                                    <div class="card-header mb-4 text-center">Contact Info</div>
                                    <div class="card-body">
                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <div class="">
                                                        <label for="Customer First Name"> </label>
                                                        <input type="text" class="fname" name="fname" id="" placeholder="First Name" height="40" width="80" margin = right required>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <div class="">
                                                        <label for="Customer Middle Name"> </label>
                                                        <input type="text" class="mname" name="mname" id="" placeholder="Middle Name" height="40" width="80" required>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <div class="">
                                                        <label for="Customer Last Name"> </label>
                                                        <input type="text" class="lname" name="lname" id="" placeholder="Last Name" height="40" width="80" required>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <div class="">
                                                        <label for="Customer  Date of birth"> </label>
                                                        <!-- <input type="text" class="datepicker" name="checkin"  placeholder ="Date"> -->
                                                        <input type="datepicker" class="datepicker" name="dob"  placeholder="Date of birth" height="40" width="80" required>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <div class="">
                                                        <label for="Customer Mobile Number"> </label>
                                                        <input type="text" class="custmnumber" name="custmnumber" id="" placeholder="Mobile Number" height="40" width="80" required>
                                                    </div>
                                                </div>
                                            </div>

                                            <!-- <div class="col-md-6">
                                                <div class="form-group">
                                                    <div class="">
                                                        <label for="Customer Password"> </label>
                                                        <input type="text" class="password" name="password" id="" placeholder="Password" height="40" width="80">
                                                    </div>
                                                </div>
                                            </div> -->
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="card">
                                    <div class="card-header mb-4 text-center">Address</div>
                                    <div class="card-body">
                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <div class="">
                                                        <label for="Street"> </label>
                                                        <input type="text" class="street" name="street" id="" placeholder="Street" height="40" width="80" margin = right required>
                                                    </div>
                                                </div>
                                            </div>
                                    
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <div class="">
                                                        <label for="City"> </label>
                                                        <input type="text" class="city" name="city" id="" placeholder="City" height="40" width="80" required>
                                                    </div>
                                                </div>
                                            </div>

                                           

                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <div class="">
                                                        <label for="State"> </label>
                                                        <input type="text" class="state" name="state" id="" placeholder="State" height="40" width="80" required>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <div class="">
                                                        <label for="Country"> </label>
                                                        <input type="text" class="country" name="country" id="" placeholder="Country" height="40" width="80" required>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    
                        <div class="row">
                            <div class="col-md-6">
                                <div class="card">
                                    <div class="card-header mb-4 text-center">Payment Information</div>
                                    <div class="card-body">
                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <div class="">
                                                        <label for="Card Number"> </label>
                                                        <input type="text" class="cardnumber" name="cardnumber" id="" placeholder="Card Number" height="40" width="80" margin = right required>
                                                    </div>
                                                </div>
                                            </div>
                                    
                                            <!-- <div class="col-md-6">
                                                <div class="form-group">
                                                    <div class="">
                                                        <label for="Passport"> </label>
                                                        <input type="text" class="" name="" id="" placeholder="Expiry Date(MM/YY)" height="40" width="80">
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <div class="">
                                                        <label for="CVV"> </label>
                                                        <input type="text" class="" name="" id="" placeholder="CVV" height="40" width="80">
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <div class="">
                                                        <label for="Name On Card"> </label>
                                                        <input type="text" class="" name="" id="" placeholder="Name On Card" height="40" width="80">
                                                    </div>
                                                </div>
                                            </div> -->
                                        </div>
                                    </div>
                                </div>            
                            </div>  
                        
                            <div class="col-md-6">
                                <div class="card">
                                    <div class="card-header mb-4 text-center">Identification Details</div>
                                    <div class="card-body">
                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <div class="">
                                                        <label for="Passport Number"> </label>
                                                        <input type="text" class="passport" name="passport" id="" placeholder="Passport Number" height="40" width="80" margin = right required>
                                                    </div>
                                                </div>
                                            </div>
                                    
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <div class="">
                                                        <label for="National ID"> </label>
                                                        <input type="text" class="nationalid" name="nationalid" id="" placeholder="National ID" height="40" width="80" required>
                                                    </div>
                                                </div>
                                            </div>
                                            <!-- <div class="col-md-6">
                                                <div class="form-group">
                                                    <div class="">
                                                        <label for="Driving Licence"> </label>
                                                        <input type="text" class="" name="" id="" placeholder="Driving Licence" height="40" width="80">
                                                    </div>
                                                </div>
                                            </div> -->
                                        </div>
                                    </div>
                                </div>
                            </div>

                    </div> 


                    <!-- <hr> -->
                    <br>
          
                    
                    <?php
                    
                    if($banquet_id){
                        ?>
                        <div class="alert alert-primary" role="alert" style="display:none">
                        Booking For :
                        <label>Banquet ID</label>
                        <input readonly type="number" class="banquet_id" name="banquet_id" value="<?php echo $banquet_id; ?>">
                        <label>Booking Date</label>
                        <input readonly type="text" class="book_date" name="book_date" value="<?php echo $book_date; ?>">
                        <label>Booking Time From</label>
                        <input readonly type="number" class="time_from" name="time_from" value="<?php echo $time_from; ?>">
                        <label>Booking Time To</label>
                        <input readonly type="number" class="time_to" name="time_to" value="<?php echo $time_to; ?>">
                        <label>Capacity</label>
                        <input readonly type="number" class="banquet_capacity" name="banquet_capacity" value="<?php echo $banquet_capacity; ?>">
                        <label>Menu Type</label>
                        <input readonly type="number" class="banquet_menu_type" name="banquet_menu_type" value="<?php echo $banquet_menu_type; ?>">
                        <label>Loyalty Points</label>
                        <input readonly type="number" class="loyalty" name="loyalty" value="<?php echo $loyalty; ?>">
                        </div>
                        <div class="text-center mt-4">
                            <?php echo "<a href='Customer_login.php?banquet_id=".$banquet_id."&book_date=".$book_date."&time_from=".$time_froms."&time_to=".$time_tos."&banquet_capacity=".$banquet_capacity."&banquet_menu_type=".$banquet_menu_type."&loyalty=".($loyalty)."'> LOGIN </a>"; ?>
                            <input type="submit" name="submit" id="submit" value="Submit" class="btn btn-outline-info btn-block"></input>
                        </div>  
                         <?php
                        
                    }
                    elseif($restID){
                        ?>
                    <div class="alert alert-primary" role="alert" style="display:none">
                    Booking For :
                    <label>Restaurant ID</label>
                    <input readonly type="number" class="rest_id" name="rest_id" value="<?php echo $restID; ?>">
                    <label>Date </label>
                    <input readonly type="text" class="datetime" name="checkin" value="<?php echo $checkin; ?>">
                    <label> Time</label>
                    <input readonly type="text" class="datetime" name="timet" value="<?php echo $timet; ?>">
                    <label>Guests</label>
                    <input readonly type="number" class="guests" name="guests" value="<?php echo $guests; ?>">
                    <label>Loyalty Points</label>
                    <input readonly type="number" class="loyalty" name="loyalty" value="<?php echo $loyalty; ?>">
                    </div>
                    <div class="text-center mt-4">
                        <?php echo "<a href='Customer_login.php?restID=".$restID."&DT=".urlencode($checkin)."&time=".$timet."&guests=".($guests)."&loyalty=".($loyalty)."'> LOGIN </a>"; ?>
                        <input type="submit" name="submit" id="submit" value="Submit" class="btn btn-outline-info btn-block"></input>
                    </div>   

                    <?php }
                    elseif($roomNumber){
                        ?>
                    <div class="alert alert-primary" role="alert" style="display:none">
                    Booking For :
                    <label>Room Number</label>
                    <input readonly type="number" class="rest_id" name="roomNumber" value="<?php echo $roomNumber; ?>">
                    <label>Check In</label>
                    <input readonly type="text" class="datetime" name="checkIn" value="<?php echo $checkIn; ?>">
                    <label>Check Out</label>
                    <input readonly type="text" class="datetime" name="checkOut" value="<?php echo $checkOut; ?>">
                   <br>
                    <label>Room Type</label>
                    <input readonly type="number" class="loyalty" name="roomType" value="<?php echo $roomTypeId; ?>">
                    </div>
                    <div class="text-center mt-4">
                    <input type="submit" name="submit" id="submit" value="Submit" class="btn btn-outline-info btn-block"></input>
                    </div> 

                    <?php } 
                     else if($fromConf){
                    ?>
                    <div class="alert alert-primary" role="alert" style="display:none">
                        <label>Date Time</label>
                        <input readonly type="text" class="datetime" name="combinedDT" value="<?php echo $combinedDT; ?>">
                        <label>Number of Guests:</label>
                        <input readonly type="text" class="no_guests" name="no_guests" value="<?php echo $no_guests; ?>">
                        <label>Purpose of Conference Room:</label>
                        <input type="text" class="tcon" name="tcon" value="<?php echo $tcon; ?>">
                    </div>
                    <div class="text-center mt-4">
                        <?php echo "<a href='Customer_login.php?&DT=".urlencode($date)."&time=".$time."&no_guests=".($no_guests)."&tcon=".($tcon)."&fromConf=".$confYes."'> LOGIN </a>"; ?>
                        <input type="submit" name="submit" id="submit" value="Submit"></input>
                    </div> 

                    <?php } else{
                                echo "<a href='Customer_login.php'> LOGIN </a>";
                            ?>
                     <div class="text-center mt-4">
            
                        <input type="submit" name="submit" id="submit" value="Submit"></input>
                    </div> 
                    <?php } ?>
                   

                        
                   
                </form> 
                
                
  
            </div>
        </div>

        <?php 
      if($once){
        if($_SERVER['REQUEST_METHOD'] == 'POST'){
          if(isset($_POST['submit'])) 
          { 
            extract($_POST); 
            $username = $lname;
            $password = $passport;
            $isCustomer =true;

              if($banquet_id){
                $sql_check_existinguser = "CALL sp_get_customer_login('$username','$password')";
                $result_user = mysqli_query($user->db,$sql_check_existinguser);
                $old_user=  mysqli_fetch_array($result_user);
                $user->db->next_result(); 
                if($old_user){ 
                echo '<script>toastr.info("User exists please login");</script>';
                echo "<a href='Customer_login.php?banquet_id=".$banquet_id."&book_date=".$book_date."&time_from=".$time_from."&time_to=".$time_to."&banquet_capacity=".$banquet_capacity."&banquet_menu_type=".$banquet_menu_type."&loyalty=".($loyalty)."'> LOGIN </a>";
                }else{
                  
                    $sqlInsert = "CALL sp_banquet_booking('$fname', '$mname','$lname', '$dob', '$custmnumber','$street','$city', '$state', 
                    '$country','$passport', '$nationalid', '$cardnumber', '$banquet_menu_type', '$banquet_id', 
                    '$banquet_capacity', '1','$book_date','$time_froms','$time_tos','$username','$password','$loyalty')";
                    $user->db->next_result(); 
                    if(mysqli_query($user->db, $sqlInsert)){
                    echo  '<script>alert("Confirmed!!")</script>';   
                        ?>
                        <script>
                        window.location = "../index.php";
                        </script>
                        <?php
                    } 
                    else {
                    echo '<script>alert("Something is wrong please try again")</script>'; 
                    }
                }  
              }
              elseif($restID){
                $sql_check_existinguser = "CALL sp_get_customer_login('$username','$password')";
                $result_user = mysqli_query($user->db,$sql_check_existinguser);
                $old_user=  mysqli_fetch_array($result_user);
                $user->db->next_result(); 
                if($old_user){ 
                    echo  '<script>toastr.info("User exists please login");</script>';
                    echo "<a href='Customer_login.php?restID=".$rest_id."&DT=".urlencode($checkin)."&time=".$time."&guests=".($guests)."&loyalty=".($loyalty)."'> LOGIN </a>";
                }else{
                  
                    $sqlInsert = "CALL sp_post_rest_booking('$fname', '$mname','$lname', '$dob', '$custmnumber','$street','$city', '$state', '$country','$passport', '$nationalid', '$cardnumber', '$rest_id', '$checkin','$timet', '$guests', '1','$username','$password','$loyalty')";
                    $user->db->next_result(); 
                    if(mysqli_query($user->db, $sqlInsert)){  
                    echo  '<script>alert("Confirmed!!")</script>';   
                        ?>
                        <script>
                        window.location = "../index.php";
                        </script>
                        <?php
                    } 
                    else {
                        echo  '<script>toastr.error("Something is wrong please again")</script>'; 
                    }
                }  
              }
              elseif($roomNumber){
                $sql_check_existinguser = "CALL sp_get_customer_login('$username','$password')";
                $result_user = mysqli_query($user->db,$sql_check_existinguser);
                $old_user=  mysqli_fetch_array($result_user);
                $user->db->next_result(); 
                if($old_user){ 
                    echo  '<script>toastr.info("User exists please login");</script>';
                    echo "<a href='Customer_login.php?restID=".$rest_id."&DT=".urlencode($checkin)."&time=".$time."&guests=".($guests)."&loyalty=".($loyalty)."'> LOGIN </a>";
                }else{

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

                 echo   $sqlInsert = "CALL sp_post_room_booking_registeration('$fname', '$mname','$lname', '$dob', '$custmnumber','$street','$city', '$state', '$country','$passport', '$nationalid', '$cardnumber', '$roomID ','$adult','$children', '$checkIn', '$checkOut' ,'$username','$password','$roomLoyalty', '$troomRent')";
                    $user->db->next_result(); 
                    if(mysqli_query($user->db, $sqlInsert)){  
                    echo  '<script>alert("Confirmed!!")</script>';   
                        ?>
                        <script>
                        window.location = "../index.php";
                        </script>
                        <?php
                    } 
                    else {
                        echo  '<script>toastr.error("Something is wrong please again")</script>'; 
                    }
                }  
              }


              elseif($fromConf){
                $sql_check_existinguser = "CALL sp_get_customer_login('$username','$password')";
                $result_user = mysqli_query($user->db,$sql_check_existinguser);
                $old_user=  mysqli_fetch_array($result_user);
                $user->db->next_result(); 
                if($old_user){ 
                    echo  '<script>toastr.info("User exists please login");</script>';
                    
                    // echo "User exists please login";
                    echo "<a href='Customer_login.php?&DT=".$date."&time=".$time."&no_guests=".($no_guests)."&tcon=".($tcon)."'> LOGIN </a>";
                }else{
                
                    $sqlInsert = "CALL sp_post_conference_booking('$fname', '$mname','$lname', '$dob', '$custmnumber','$street','$city', 
                    '$state', '$country','$passport', '$nationalid', '$cardnumber', '$date', '$no_guests', '1','$username','$password',
                    '$tcon','300','$time')";
                    $user->db->next_result(); 
                    if(mysqli_query($user->db, $sqlInsert)){ 
                    echo  '<script>alert("Confirmed!!")</script>';   
                        ?>
                        <script>
                        window.location = "../index.php";
                        </script>
                        <?php
                    } 
                    else {
                        echo'<script>toastr.error("Something is wrong please again")</script>'; 
                        }
                    }
                }
            

       
      }
         $once = false;
}    } 
?>


        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
        <!-- Include all compiled plugins (below), or include individual files as needed -->
        <script src="js/bootstrap.min.js"></script>
        <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
        <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    </body>
</html>

