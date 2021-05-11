<?php  include_once 'include/class.user.php'; $user=new User(); $once = true;?>
<!DOCTYPE html>
<html >
<head>
  <meta charset="UTF-8">
  <meta charset="utf-8">
      <meta http-equiv="X-UA-Compatible" content="IE=edge">
      <meta name="viewport" content="width=device-width, initial-scale=1">
      <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
      <title>Login</title>
      <!-- Bootstrap -->
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
        <link rel="stylesheet" href="css/style.css">
  <title>Login</title>
  
  <link rel="stylesheet" href="css/style.css">
     
    
      <script>
      if ( window.history.replaceState ) {
        window.history.replaceState( null, null, window.location.href );
        }
        </script>
</head>

<?php 


  $banquet_id = "";
  $restID = "";
  $discountID="";
  $spa_massage_type="";
  $roomNumber="";
  $fromConf="";
     if(isset($_GET["banquet_id"])){                      //--------Banquets
    $banquet_id = $_GET['banquet_id'];

    if(isset($_GET["book_date"])){
        $book_date = $_GET['book_date'];
       }
       if(isset($_GET["time_from"])){
        $time_from = $_GET['time_from'];

       }
       if(isset($_GET["time_to"])){
        $time_to = $_GET['time_to'];

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
   elseif (isset($_GET["discountID"])) {                       //--------Deals
    $discountID = $_GET['discountID'];

   
    $sql_disc = "CALL sp_get_discount_details_by_id('$discountID')";
    $disc_result = mysqli_query($user->db,$sql_disc);
    $disc_array=  mysqli_fetch_array($disc_result);

    $discLoyalty = $disc_array['loyalty_points'];
    $discRoomID = $disc_array['room_type_id'];
    $user->db->next_result(); 
   }
elseif(isset($_GET["spa_massage_type"])){
  $spa_massage_type = $_GET['spa_massage_type'];

  if(isset($_GET["DT"])){
    $date = $_GET['DT'];
   }
   if(isset($_GET["time"])){
    $timet = $_GET['time'];
   }
   $combinedDT = date('Y-m-d H:i:s', strtotime("$date $timet"));
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
elseif (isset($_GET["fromConf"])) {                    
  $fromConf = $_GET['fromConf'];

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

   ?>


<body>
  <!-- <div id="clouds">
	<div class="cloud x1"></div>

	<div class="cloud x2"></div>
	<div class="cloud x3"></div>
	<div class="cloud x4"></div>
	<div class="cloud x5"></div> -->
</div>

 <div class="container" style="margin-left:25%;">

      <div id="login">
        <form method="post" action="">
        
            <p><span class="fontawesome-user"></span><input type="text"  name="user" value="Username" onBlur="if(this.value == '') this.value = 'Username'" onFocus="if(this.value == 'Username') this.value = ''" required></p> <!-- JS because of IE support; better: placeholder="Username" -->
            <p><span class="fontawesome-lock"></span><input type="password" name="pass"  value="Password" onBlur="if(this.value == '') this.value = 'Password'" onFocus="if(this.value == 'Password') this.value = ''" required></p> <!-- JS because of IE support; better: placeholder="Password" -->
            <p><input type="submit" name="submit"  value="Login"></p>
        </form>
      </div> 
    </div>
    <div class="bottom">  <h3><a href="../index.php">Go back to HOMEPAGE</a></h3></div>
  
    
</body>
</html>

<?php
   include('db.php');
  
   
   if($_SERVER["REQUEST_METHOD"] == "POST") {
      if(isset($_POST['submit'])) 
    { 

      $myusername = mysqli_real_escape_string($con,$_POST['user']); 
      $mypassword = mysqli_real_escape_string($con,$_POST['pass']);

   
      
        $sql_check_existinguser = "CALL sp_get_customer_login('$myusername','$mypassword')";
        $result_user = mysqli_query($user->db,$sql_check_existinguser);
        $old_user=  mysqli_fetch_array($result_user);
        $user->db->next_result(); 
        if($old_user)
        {  
          
         $cust_id = $old_user[0];

          if($banquet_id){
           
            $sqlInsert = "CALL sp_book_banquet_by_login('$cust_id','$banquet_id', '$book_date', '$time_from','$time_to','$banquet_menu_type','$banquet_capacity', '1','$loyalty')";
            if(mysqli_query($user->db, $sqlInsert))
            {
             echo  '<script>toastr.success("Confirmed")</script>';     
            } else{
              echo  '<script>toastr.error("error")</script>'; 
            }
          }

          elseif($restID){
            $sqlInsert = "CALL sp_post_rest_booking_by_login('$cust_id','$restID', '$checkin','$timet','$guests','1','$loyalty')";
            if(mysqli_query($user->db, $sqlInsert))
            {
             echo  '<script>toastr.success("Confirmed")</script>';     
            } else{
              echo  '<script>toastr.error("error")</script>'; 
            }
          }
          
          elseif($discountID){
            $sqlLoyalty = "SELECT fn_calculate_existing_loyalty_points('$cust_id', '$discLoyalty')";
            $resLoyalty = mysqli_query($user->db,$sqlLoyalty);
            $fdiscount =  mysqli_fetch_array($resLoyalty);
            $valid = $fdiscount[0];
            $user->db->next_result(); 

            if($valid){
              $sqlInsert = "CALL	sp_post_customer_deals('$cust_id','$discountID', '$discRoomID', '$discLoyalty')";
              if(mysqli_query($user->db, $sqlInsert))
              {
               echo  '<script>toastr.success("Confirmed")</script>';     
              } else{
                echo  '<script>toastr.error("error")</script>'; 
              }

            }else{
            echo  '<script>toastr.error("You dont have enough points ")</script>';   
            }
          }

          elseif($spa_massage_type){
            $sqlInsert = "CALL sp_post_spa_booking_by_login('$date','$timet', '$spa_massage_type','1','$cust_id')";
            if(mysqli_query($user->db, $sqlInsert))
            {
              echo  '<script>toastr.success("Confirmed")</script>';     
             } else{
               echo  '<script>toastr.error("error")</script>'; 
             }
          }

          elseif($roomNumber){
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

            $sqlInsert = "CALL sp_post_roombooking_by_login('$cust_id', '$roomID ','$adult','$children', '$checkIn', '$checkOut', '$roomLoyalty',' $troomRent' )";
              if(mysqli_query($user->db, $sqlInsert))
              {
                echo  '<script>toastr.success("Confirmed")</script>';     
              } else{
                echo  '<script>toastr.error("error")</script>'; 
              }
          }
          elseif($fromConf){
            $sqlInsert = "CALL sp_post_conference_booking_by_login('$date', '$tcon', '1', '$no_guests','$cust_id', '$time')";
            if(mysqli_query($user->db, $sqlInsert))
            {
              echo  '<script>toastr.success("Confirmed")</script>';     
             } else{
               echo  '<script>toastr.error("error")</script>'; 
             }
          }
            else  {               
              ?>
              <script>
              var cust_id = "<?php echo $cust_id ?>";
                  window.location = "customer_dashboard.php?cust_id=" + cust_id;
              </script>
                <?php
          }



          $user->db->next_result(); 
         
        }
    
      else
      {
        echo  '<script>toastr.error("Invalid")</script>';  
      }
    } 
   }
?>


