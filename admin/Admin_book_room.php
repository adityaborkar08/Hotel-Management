<?php  include_once 'include/class.user.php'; $user=new User(); $once = true; ?>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Admin | Room booking</title>
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

    if ( window.history.replaceState ) {
      window.history.replaceState( null, null, window.location.href );
    }
      $( function() {
        $( ".datepicker" ).datepicker({
                      dateFormat : 'yy-mm-dd'
                    });
      });
    </script>
<style>
input[type=text]  {
    width: 100%;
    padding: 6px;
    border: 1px solid #ccc;
    margin-top: 6px;
    margin-bottom: 16px;
    resize: vertical;
    color: black;
    border-radius : 5px;
    }
    input[type=number]  {
    width: 100%;
    padding: 6px;
    border: 1px solid #ccc;
    margin-top: 6px;
    margin-bottom: 16px;
    resize: vertical;
    color: black;
    border-radius : 5px;
    }
</style>
</head>
<body>

<?php 
  if(isset($_GET["roomNumber"])){
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
  }

?>



<div class="container">
  
	<div class="col-lg-12 well">
    
	<div class="row">
				<form method="POST">
                <h4 ><div class="alert alert-dark" role="alert">Customer Personal Details<div></h4>
					<div class="col-sm-12">
						<div class="row">
							<div class="col-sm-4 form-group">
								<label>First Name</label>
								<input type="text" placeholder="Enter First Name Here.." name="fname" class="form-control">
							</div>
							<div class="col-sm-4 form-group">
								<label>Middle Name</label>
								<input type="text" placeholder="Enter Middle Name Here.." name="mname" class="form-control">
							</div>
                            <div class="col-sm-4 form-group">
								<label>Last Name</label>
								<input type="text" placeholder="Enter Last Name Here.." name="lname"  class="form-control">
							</div>
						</div>					
					
                        <div class="row">
							<div class="col-sm-6 form-group">
								<label>Date of Birth</label>
                                <br>
								<input type="text" placeholder="Enter DOB Here.." name="dob" class="datepicker">
							</div>		
							<div class="col-sm-6 form-group">
								<label>Phone number</label>
								<input type="text" placeholder="Enter Phone Number Here.." name="custmnumber" class="form-control">
							</div>	
						</div>
						<div class="row">
							<div class="col-sm-3 form-group">
								<label>Street</label>
								<input type="text" placeholder="Enter Street Name Here.." name="street" class="form-control">
							</div>	
							<div class="col-sm-3 form-group">
								<label>City</label>
								<input type="text" placeholder="Enter City Name Here.." name="city" class="form-control">
							</div>	
							<div class="col-sm-3 form-group">
								<label>State</label>
								<input type="text" placeholder="Enter State  Here.." name="state" >
							</div>
                            <div class="col-sm-3 form-group">
								<label>Country</label>
								<input type="text" placeholder="Enter Country Here.."  name="country" >
							</div>		
						</div>
											
                    <div class="row">
                        <div class="col-sm-6 form-group">
                            <label>Passport Number</label>
                            <input type="text" placeholder="Enter Passport number Here.."  name="passport" class="form-control">
					    </div>
                        <div class="col-sm-6 form-group">
                            <label>National ID</label>
                            <input type="text" placeholder="Enter national ID Here.." name="nationalid" class="form-control">
					    </div>
                    </div>		
					<div class="form-group">
						<label>Card Number</label>
						<input type="text" placeholder="Enter Card Number Here.." name="cardnumber" class="form-control">
					</div>	

                    <div class="row">
							<div class="col-sm-3 form-group">
                            <label>Room Number</label>
                            <input readonly type="number" class="rest_id" name="roomNumber" value="<?php echo $roomNumber; ?>">         
							</div>	
							<div class="col-sm-3 form-group">
                            <label>Check In</label>
                            <input readonly type="text" class="datetime" name="checkIn" value="<?php echo $checkIn; ?>">
							</div>
                            <div class="col-sm-3 form-group">
                            <label>Check Out</label>
                            <input readonly type="text" class="datetime" name="checkOut" value="<?php echo $checkOut; ?>">
							</div>	
							<div class="col-sm-3 form-group">
                            <label>Room Type</label>
                            <input readonly type="number" class="loyalty" name="roomType" value="<?php echo $roomTypeId; ?>">
							</div>
                           		
						</div>



				</div>


                <div class="row">
                    <div class="col form-group">
                    <input type="submit" name="submit" id="submit" value="Register and Book" class="btn btn-info btn-block"></input>
                    </div>
                </div>


                </div>
			</form> 
		</div>
	</div>
</div>


<?php

	if($once){
		if($_SERVER['REQUEST_METHOD'] == 'POST')
			{
			if(isset($_POST['submit'])) 
				{ 
                extract($_POST); 
                
                $username = $lname;
                $password = $passport;

                    $sql_check_existinguser = "CALL sp_get_customer_login('$username','$password')";
                    $result_user = mysqli_query($user->db,$sql_check_existinguser);
                    $old_user=  mysqli_fetch_array($result_user);
                    $user->db->next_result(); 

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



                    $sqlFn = ("SELECT fn_get_price_by_days('$roomTypeId','$checkIn','$checkOut')");
                    $resFn =  mysqli_query($user->db,$sqlFn);
                    $fcal = mysqli_fetch_array($resFn);
                    $troomRent = $fcal[0];
                    $user->db->next_result();




                    if($old_user){ 
                        $cust_id = $old_user[0];
                        echo  '<script>toastr.info("Customer already exists, Roomed booked with same entry !!");</script>';
                        $sqlInsert = "CALL sp_post_roombooking_by_login('$cust_id','$roomID ','$adult','$children', '$checkIn', '$checkOut','$roomLoyalty','$troomRent')";
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
                    }else{
    
                        $sqlInsert = "CALL sp_post_room_booking_registeration('$fname', '$mname','$lname', '$dob', '$custmnumber','$street','$city', '$state', '$country','$passport', '$nationalid', '$cardnumber', '$roomID ','$adult','$children', '$checkIn', '$checkOut' ,'$username','$password','$roomLoyalty','$troomRent')";
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
			
			


		}
		$once = false;
	}
	?>






</body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
        <!-- Include all compiled plugins (below), or include individual files as needed -->
        <script src="js/bootstrap.min.js"></script>
        <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
        <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
        <div>