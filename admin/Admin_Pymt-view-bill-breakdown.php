<?php session_start();   include_once 'include/class.user.php'; $user=new User(); $once = true; 
if(!isset($_SESSION["user"]))
{
 header("location:index.php");
}
?>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
      <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Admin Restaurants</title>
	<!-- Bootstrap Styles-->
    <link href="assets/css/bootstrap.css" rel="stylesheet" />
     <!-- FontAwesome Styles-->
    <link href="assets/css/font-awesome.css" rel="stylesheet" />
     <!-- Morris Chart Styles-->
   
        <!-- Custom Styles-->
    <link href="assets/css/custom-styles.css" rel="stylesheet" />
     <!-- Google Fonts-->
   <link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css' />
     <!-- TABLE STYLES-->
    <link href="assets/js/dataTables/dataTables.bootstrap.css" rel="stylesheet" />

    
 <script>
         if ( window.history.replaceState ) {
           window.history.replaceState( null, null, window.location.href );
         }
           $( function() {
             $( ".datepicker" ).datepicker({
                           dateFormat : 'yy-mm-dd'  }); });
     
    </script>

    <style>
    input[type=text]  {
    width: 20%;
    padding: 6px;
    border: 1px solid #ccc;
    margin-top: 6px;
    margin-bottom: 16px;
    resize: vertical;
    color: black;
    border-radius : 5px;
    }
    input[type=submit]  {
    width: 20%;
    padding: 6px;
    border: 1px solid #ccc;
    margin-top: 6px;
    margin-bottom: 16px;
    resize: vertical;
    color: black;
    border-radius : 5px;
    }
   
</style>
    </style>
</head>
<body>
    <div id="wrapper">
        
        <nav class="navbar navbar-default top-navbar" role="navigation">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".sidebar-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
             
                <a class="navbar-brand" href="home.php">Amenities </a>
            </div>

        </nav>
        <!--/. NAV TOP  -->
        <nav class="navbar-default navbar-side" role="navigation">
            <div class="sidebar-collapse">
                <ul class="nav" id="main-menu">

                <li>
                        <a  href="home.php"> Room Booking</a>
                    </li>
                   
					<li>
                        <a  href="Admin_show-rooms.php"> Booked Rooms </a>
                    </li>
                    <li>
                        <a   href="Admin_Restaurants.php"> Booked Restaurants</a>
                    </li>
                    <li>
                        <a  href="Admin_Banquets.php"> Booked Banquets</a>
                    </li>
                    <li>
                        <a  href="Admin_spa.php"> Booked Spa</a>
                    </li>
                    <li>
                        <a  href="Admin_Conference.php"> Booked Conference</a>
                    </li>
                    <li>
                        <a class="active-menu" href="Admin_payment.php"> Payment </a>
                    </li>
                    <li>
                        <a  href="profit.php">Profit</a>
                    </li>
                    <li>
                        <a href="logout.php">Logout</a>
                    </li>
                    


                    
            </div>

        </nav>
        <!-- /. NAV SIDE  -->
        <div id="page-wrapper" >


        <?php
        $spaRate = 0;
        $restTotal= 0;
        $banqRate = 0;
        $confRate = 0;
        $roomTotal = 0;
       if(isset($_GET["cid"])){                      
           $cust_id = $_GET['cid'];
         }
         if(isset($_GET["checkin"])){                      
           $checkin = $_GET['checkin'];
         }
         if(isset($_GET["checkout"])){                      
           $checkout = $_GET['checkout'];
         }
         if(isset($_GET["status"])){                      
           $status = $_GET['status'];
         }
         if(isset($_GET["fname"])){                      
           $fname = $_GET['fname'];
         }
         if(isset($_GET["lname"])){                      
           $lname = $_GET['lname'];
         }

         $sqlloyalty = "CALL sp_get_loyalty_points('$cust_id')";
         $user->db->next_result();
         $resultlo = mysqli_query($user->db,$sqlloyalty);
         $fetchPoint=  mysqli_fetch_array($resultlo);
         $user->db->next_result(); 
 
        $getAllData = "CALL sp_admin_pay_amenities_by_RM('$checkin','$checkout','$cust_id')";
        $rest_results = mysqli_query($user->db,$getAllData);
        $user->db->next_result(); 


        ?>
        <div class="alert alert-danger" role="alert"><h1> Bill Breakdown </h1></div>
          <div class=" alert alert-warning">
        <h2> Customer Details </h2>
        <p></p>
        <?php echo "Customer ID : ".$cust_id.""; ?><br>
        <?php echo "Customer Name : ".$fname." ".$lname.""; ?><br>
        <div style=" width=100%;"><?php echo "Customer's total loyalty points :".$fetchPoint[0].""; ?></div>
        </div>
        <?php
        if($rest_results)
         {
         if(mysqli_num_rows($rest_results) > 0)
           { 
            
        
        
        ?>
     
        
           <!-- LOYALTY -->
      
        <!-- loyalty -->
          <form method="POST" action="">
               <?php
               
                    ?>

                    <div class="row">
                      <div class="col-md-12">
                        <h2>Booked Amenities within dates <?php echo $checkin." - ". $checkout; ?> </h2>
                        <br>
                        
                          <?php 
                           while($rowr = mysqli_fetch_array($rest_results))
                           {
                             $user->db->next_result(); 
                             if($rowr['rest_abbr']=='REST'){
                               echo "Restaurant Name : ";
                               echo "<input value='".$rowr['bookings']."' input name='rest' type='text' ></input> ";
                               
                               $bid = $rowr['bookingID'];
                               $cid = $rowr['cust_id'];
                               $rest_sql= "CALL sp_admin_restaurant_rates_by_BID('$bid','$cid')";
                               $rest_res = mysqli_query($user->db,$rest_sql);
                               
                               while($rest_col = mysqli_fetch_array($rest_res)){
                               $sumofrest = $rest_col['restaurant_guests'] * $rest_col['restaurant_rates'];
                               echo "<input value='$sumofrest' input name='restP' type='text' readonly></input><br> ";
                               
                               $restTotal = ($rest_col['restaurant_guests'] * $rest_col['restaurant_rates']) + $restTotal;
                               
                               }$user->db->next_result(); 
                               }
                             
                             if($rowr['rest_abbr']=='BQT'){
                               echo "<br>Banquet Name : ";
                               echo "<input value='".$rowr['bookings']."' input name='banquet' type='text'></input> ";
       
                               $cid = $rowr['cust_id'];
                               $bid = $rowr['bookingID'];
       
                               $banq_sql= "CALL sp_admin_banquet_rates_by_bid('$cid','$bid')";
                               $banq_res = mysqli_query($user->db,$banq_sql);
                               
                               while($banq_col = mysqli_fetch_array($banq_res)){
                               echo "<input value='".$banq_col['banquet_capacity_price']."' input name='banquetP' type='text' readonly></input><br> ";
                               
                               $banqRate = $banq_col['banquet_capacity_price'] + $banqRate;
                               
                               } $user->db->next_result();
                             }
       
                             if($rowr['rest_abbr']=='SPA'){
                               echo "<br> Spa Facility : ";
                               echo "<input value='".$rowr['bookings']."' input name='spa' type='text'></input> ";
                              
                               $bid = $rowr['bookingID'];
                               $cid = $rowr['cust_id'];
       
                               $spa_sql= "CALL sp_admin_spa_rates_by_bid('$bid','$cid')";
                               $spa_res = mysqli_query($user->db,$spa_sql);
                               
                               while($spa_col = mysqli_fetch_array($spa_res)){
                               echo "<input value='".$spa_col['spa_rate']."' input name='spaP' type='text' readonly></input> <br>";
       
                               $spaRate = $spa_col['spa_rate'] + $spaRate;
       
                               } $user->db->next_result();
                             }
       
                             if($rowr['rest_abbr']=='CONF'){
                               echo "<br> Conference Meeting : ";
                               echo "<input value='".$rowr['bookings']."' input name='conference' type='text'></input> ";
       
                               $bid = $rowr['bookingID'];
                               $cid = $rowr['cust_id'];
       
                               $conf_sql= "CALL sp_admin_conf_rates_by_bid('$bid','$cid')";
                               $conf_res = mysqli_query($user->db,$conf_sql);
                               
                               while($conf_col = mysqli_fetch_array($conf_res)){
                               echo "<input value='".$conf_col['conf_rent']."' input name='confP' type='text' readonly></input> <br>";
                               
                               $confRate = $conf_col['conf_rent'] + $confRate;
       
                               } $user->db->next_result();
                             }
                             ?>
       
                            <?php
                          }
                          $user->db->next_result();
                          ?> 
                          
                          
                             
                         
        
                      
                           
                      </div>
                    </div>



                  <?php
                  }else{
                        echo "NO ROOMS ONLY AMENITIES";
                  }
                } 

                //ROOMS-----------------------------
               $getAllRooms = "CALL sp_admin_pay_rooms_by_RM('$checkin','$checkout','$cust_id')";
               $roomResult = mysqli_query($user->db,$getAllRooms);
               $user->db->next_result(); 

               if($roomResult && $status == 'yes')
                {
                if(mysqli_num_rows($roomResult) > 0)
                  {
                    ?>
                    <div class="row">
                      <div class="col-md-12">
                        <h2>Booked Rooms within dates <?php echo $checkin." - ". $checkout; ?> </h2>
                        <br>
                        
                          <?php 
                           while($rooms = mysqli_fetch_array($roomResult))
                           {
                           
                              echo "<br> Room Type : ";
                              echo "<input value='".$rooms['room_type']."' input name='roomtype' type='text'></input> ";
                              
                              $bid = $rooms['bookingID'];
                              $cid = $rooms['cust_id'];
                              $room_sql= "CALL sp_admin_room_rate_by_bid('$bid','$cid')";
                              $room_res = mysqli_query($user->db,$room_sql);
                              
                              while($room_col = mysqli_fetch_array($room_res)){
                              echo "<input value='".$room_col['total_rent']."' input name='roomP' type='text' readonly></input> <br>";
                           
                              
                              $roomTotal = $room_col['total_rent'] + $roomTotal;
                              
                              }$user->db->next_result(); 
                            

                  }
                           $user->db->next_result();
                          ?>

                          
                        </div>
                      </div>

                    <?php
                  }
                }
				
			   ?>
         <div  >
        <label for="subject">Loyalty Points</label>
        <input class="custloyalty" name="custloyalty"  type="number" required>
        
        </div>
         <input type ="submit" name="submit" value="Confirm Amount" class="btn btn-primary"></input> 
        </form>
        <?php 
        if($once){
          if($_SERVER['REQUEST_METHOD'] == 'POST')
            {
              if(isset($_POST['submit'])) 
                { 
                  extract($_POST);
               

                  $total = $restTotal + $banqRate + $spaRate + $confRate;
                  $total = $total + $roomTotal ;
                
                  
                  $custloyalty = $custloyalty;
                  $restbill = $total;
                  if($custloyalty % 100 != 0){
                   echo " Please enter loyalty --> 100's multiple (upto 1000)";
                  }else
                  if($custloyalty > $fetchPoint[0]){
                    echo " Customer dont have sufficient loyalty points";
                  } else if($custloyalty > 1000){
                   echo " Loyalty points cannot be more than 1000 (allowed 100-1000) ";
                  }
                  else{

                    if($restbill){
                      echo "<div class='alert alert-danger' role='alert'><h1>Total Bill Generated for : € ".$total." With Loyalty Points : ".$custloyalty." </h1></div>";
                      // <--tax function in phpmyadmin
                      $sqlFn = ("SELECT fn_calculate_tax('$restbill')");
                      $resFn =  mysqli_query($user->db,$sqlFn);
                      $ftax = mysqli_fetch_array($resFn);
                      $tax = $ftax[0];
                      $user->db->next_result(); 
    
                      //$tax = $restbill * 0.05;
    
                      $finalBillwtax = $restbill + $tax;
    
                      // <-- loyalty point calculation function
                      $sqlDis = ("SELECT fn_calculate_loyalty_discount('$custloyalty')");
                      $resdiscount = mysqli_query($user->db,$sqlDis);
                      $fdiscount =  mysqli_fetch_array($resdiscount);
                      $fres = $fdiscount[0];
                      $discount =$fres * $finalBillwtax;
                      $user->db->next_result(); 
                      //substract discount from final bill
    
                      $finalBill = $finalBillwtax - $discount;
    
                      if($status == 'yes')
                      { 
                      

                        echo " <br>
                        <div class ='row'>
                        <div class='col-6'>
                        <a href=Print_Combined_bill.php?cid=".$cid."&restamount=".$restbill."&loyalty=".$custloyalty."&tax=".$tax."&discount=".$discount."&finalBill=".$finalBill."><button class='btn btn-block btn-primary'> Print Bill  </button> <a>
                        </div>
                        
                        </div>";
 
                      $sql_invoice = "CALL sp_invoice_combined('$cid','Rooms & Amenities','$custloyalty','$finalBill','$checkin','$checkout')";
                      $user->db->next_result(); 
                      if(mysqli_query($user->db,$sql_invoice)){

                     


                        }else{
                       echo '<script>alert("Something is wrong please again")</script>'; 
                     }
                      
                      }else{
                      $sql_invoice = "CALL sp_invoice_amenities('$cid','Amenities','$custloyalty','$finalBill','$checkin','$checkout')";
                      $user->db->next_result(); 
                      if(mysqli_query($user->db,$sql_invoice)){
                      
                      echo " <br>
                      <div class ='row'>
                      <div class='col-6'>
                      <a href=Print_Combined_bill.php?cid=".$cid."&restamount=".$restbill."&loyalty=".$custloyalty."&tax=".$tax."&discount=".$discount."&finalBill=".$finalBill."><button class='btn btn-block btn-primary'> Print Bill  </button> <a>
                      </div>
                      
                      </div>";
                       }else{
                       echo '<script>alert("Something is wrong please again")</script>'; 
                     }

                      }
                    }
                   }





                  

                 
                  // <a href='Admin_combined_Bill.php?cid=".$cust_id."&fname=".$fname."&lname=".$lname."&total=".$total."&checkin=".$checkin."&checkout=".$checkout."&status=".$status."'><button class='btn btn-block btn-secondary'> Print Bill</button></a>
                  // ";
                }
              }
            }
          ?>  
      </div>   
    </div>  
 

    <script src="assets/js/jquery-1.10.2.js"></script>
      <!-- Bootstrap Js -->
    <script src="assets/js/bootstrap.min.js"></script>
    <!-- Metis Menu Js -->
    <script src="assets/js/jquery.metisMenu.js"></script>
     <!-- DATA TABLE SCRIPTS -->
    <script src="assets/js/dataTables/jquery.dataTables.js"></script>
    <script src="assets/js/dataTables/dataTables.bootstrap.js"></script>
        <script>
            $(document).ready(function () {
                $('#dataTables-example').dataTable();
            });
    </script>
         <!-- Custom Js -->
    <script src="assets/js/custom-scripts.js"></script>
    
   
</body>
</html>
