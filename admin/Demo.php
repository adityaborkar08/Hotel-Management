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
                 if(isset($_GET["cid"])){                      //--------Banquets
                    $cust_id = $_GET['cid'];
                   }
                   if(isset($_GET["checkin"])){                      //--------Banquets
                    $checkin = $_GET['checkin'];
                   }
                   if(isset($_GET["checkout"])){                      //--------Banquets
                    $checkout = $_GET['checkout'];
                   }
        
               $getAllData = "CALL sp_admin_pay_amenities_by_RM('$checkin','$checkout','$cust_id')";
               $rest_results = mysqli_query($user->db,$getAllData);
                $user->db->next_result(); 
               if($rest_results)
                {
                    if(mysqli_num_rows($rest_results) > 0)
                    { 
                        echo "HAS ROOMS";
                    }else{
                        echo "NO ROOMS ONLY AMENITIES";
                    }
                }
              // $user->db->next_result(); 

               $getAllRooms = "CALL sp_admin_pay_rooms_by_RM('$checkin','$checkout','$cust_id')";
               $roomResult = mysqli_query($user->db,$getAllRooms);
               $user->db->next_result(); 
				
			   ?>
          <div class="row">
                <div class="col-md-12">
                <h2>Booked Rooms within dates <?php echo $checkin." - ". $checkout; ?> </h2>
                <br>
                  <form method="POST" action="">
                    
                    <?php 
              
                    while($rowr = mysqli_fetch_array($rest_results))
                    {
                      $user->db->next_result(); 
                      if($rowr['rest_abbr']=='REST'){
                        echo "Restaurant Name : ";
                        echo "<input value='".$rowr['bookings']."' input name='rest'></input> ";
                        
                        $bid = $rowr['bookingID'];
                        $cid = $rowr['cust_id'];
                        $rest_sql= "CALL sp_admin_restaurant_rates_by_BID('$bid','$cid')";
                        $rest_res = mysqli_query($user->db,$rest_sql);
                        
                        while($rest_col = mysqli_fetch_array($rest_res)){
                        $sumofrest = $rest_col['restaurant_guests'] * $rest_col['restaurant_rates'];
                        echo "<input value='$sumofrest' input name='restP'></input><br> ";
                        
                        $restTotal = ($rest_col['restaurant_guests'] * $rest_col['restaurant_rates']) + $restTotal;
                        
                        }$user->db->next_result(); 
                        }
                      
                      if($rowr['rest_abbr']=='BQT'){
                        echo "<br>Banquet Name : ";
                        echo "<input value='".$rowr['bookings']."' input name='banquet'></input> ";

                        $cid = $rowr['cust_id'];
                        $bid = $rowr['bookingID'];

                        $banq_sql= "CALL sp_admin_banquet_rates_by_bid('$cid','$bid')";
                        $banq_res = mysqli_query($user->db,$banq_sql);
                        
                        while($banq_col = mysqli_fetch_array($banq_res)){
                        echo "<input value='".$banq_col['banquet_capacity_price']."' input name='banquetP'></input><br> ";
                        
                        $banqRate = $banq_col['banquet_capacity_price'] + $banqRate;
                        
                        } $user->db->next_result();
                      }

                      if($rowr['rest_abbr']=='SPA'){
                        echo "<br> Spa Facility : ";
                        echo "<input value='".$rowr['bookings']."' input name='spa'></input> ";
                       
                        $bid = $rowr['bookingID'];
                        $cid = $rowr['cust_id'];

                        $spa_sql= "CALL sp_admin_spa_rates_by_bid('$bid','$cid')";
                        $spa_res = mysqli_query($user->db,$spa_sql);
                        
                        while($spa_col = mysqli_fetch_array($spa_res)){
                        echo "<input value='".$spa_col['spa_rate']."' input name='spaP'></input>";

                        $spaRate = $spa_col['spa_rate'] + $spaRate;

                        } $user->db->next_result();


                      }

                      if($rowr['rest_abbr']=='CONF'){
                        echo "<br> Conference Meeting : ";
                        echo "<input value='".$rowr['bookings']."' input name='conference'></input> ";

                        $bid = $rowr['bookingID'];
                        $cid = $rowr['cust_id'];

                        $conf_sql= "CALL sp_admin_conf_rates_by_bid('$bid','$cid')";
                        $conf_res = mysqli_query($user->db,$conf_sql);
                        
                        while($conf_col = mysqli_fetch_array($conf_res)){
                        echo "<input value='".$conf_col['conf_rent']."' input name='confP'></input> <br>";
                        
                        $confRate = $conf_col['conf_rent'] + $confRate;

                        } $user->db->next_result();
                      }
                      ?>

                      <?php
                    }
                    $user->db->next_result();
                    ?>  
                 <input type ="submit" name="submit" ></submit>
                  </form>

                  <?php 
                  if($once){
                    if($_SERVER['REQUEST_METHOD'] == 'POST')
                    {
                      if(isset($_POST['submit'])) 
                      { 
                        extract($_POST);
                        echo $restTotal;
                        echo $banqRate;
                        echo $spaRate;
                        echo $confRate;
                        echo "<br>";
                        echo $total = $restTotal + $banqRate + $spaRate + $confRate;
                       
                        
                      }
                    }
                  }
             ?>
                    
        </div>
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
