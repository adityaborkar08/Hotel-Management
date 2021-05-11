<?php session_start();   include_once 'include/class.user.php'; $user=new User(); $once = true; 
if(!isset($_SESSION["user"]))
{
//  header("location:index.php");
}
?>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
      <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Booked Restaurants</title>
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

    </script>
</head>
<body>
<?php 
   if(isset($_GET["cust_id"])){
    $cust_id = $_GET['cust_id'];
   }
?>
    <div id="wrapper">
        
        <nav class="navbar navbar-default top-navbar" role="navigation">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".sidebar-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
             
               
            </div>
            <h1 style="color:white">ELEGANCE</h1>
            <br>
        </nav>
        <!--/. NAV TOP  -->
        <nav class="navbar-default navbar-side" role="navigation">
            <div class="sidebar-collapse">
                <ul class="nav" id="main-menu">
                    <li>
                        <a href="customer_dashboard.php?cust_id=<?php echo $cust_id; ?>"><i class="fa fa-dashboard"></i>Dashboard</a>
                    </li>
                    <li>
                        <a href="customer_details.php?cust_id=<?php echo $cust_id; ?>"><i class="fa fa-dashboard"></i> Account Details</a>
                    </li>
                    <li>
                        <a class="active-menu" href="dashboard_restaurant.php?cust_id=<?php echo $cust_id; ?>"><i class="fa fa-dashboard"></i> Booked Restaurants</a>
                    </li>
                    <li>
                        <a href="dashboard_rooms.php?cust_id=<?php echo $cust_id; ?>"><i class="fa fa-dashboard"></i> Booked Rooms</a>
                    </li>
                    <li>
                        <a href="dashboard_banquet.php?cust_id=<?php echo $cust_id; ?>"><i class="fa fa-dashboard"></i> Booked Banquets</a>
                    </li>
                    <li>
                        <a href="dashboard_conference.php?cust_id=<?php echo $cust_id; ?>"><i class="fa fa-dashboard"></i> Booked Conference</a>
                    </li>
                    <li>
                        <a  href="dashboard_spa.php?cust_id=<?php echo $cust_id; ?>"><i class="fa fa-dashboard"></i> Booked Spa</a>
                    </li>
                    <li>
                        <a href="Customer_Login.php" ><i class="fa fa-sign-out fa-fw"></i> Logout</a>
                    </li>
                    


                    
            </div>

        </nav>
        <!-- /. NAV SIDE  -->
        <div id="page-wrapper" >

               <?php
        
               $get_restaurants = "CALL sp_get_booked_restaurant_by_cust_id('$cust_id')";
               $rest_results = mysqli_query($user->db,$get_restaurants);
             
               $user->db->next_result(); 
				
	
			   ?>
            <div class="row">
                <div class="col-md-12">
                    <div class="panel panel-default">
                        <div class="panel-body">
                            <div class="table-responsive">
                                <table class="table table-striped table-bordered table-hover" id="dataTables-example">
                                    <thead>
                                        <tr>
                                            <th>Restaurant Booking ID</th>
											<th>Restaurant Name</th>
                                            <th>Booked Date & Time/th>
                                            <th>No. of Guests</th>
											<th>Type(Veg/ Nonveg) </th>
                                           
                                        </tr>
                                    </thead>
                                
                                <tbody>    
									<?php
										while($row = mysqli_fetch_array($rest_results))
										{										
                                            echo"<tr class='gradeU'>
                                            <td>".$row['rest_booking_ID']."</td>
                                            <td>".$row['restaurant_name']."</td>
                                            <td>".$row['restaurant_datetime']."</td>
                                            <td>".$row['restaurant_guests']."</td>
                                            <td>".$row['restaurant_mode']."</td
                                            </tr>";										
										}
										
									?>
                                        
                                    </tbody>
                                </table>
                            </div>
                            
                        </div>
                    </div>
                    <!--End Advanced Tables -->
                </div>
            </div>
                <!-- /. ROW  -->
            
        </div>



        
               
    </div>
        
            
    </div>
             <!-- /. PAGE INNER  -->
            </div>
         <!-- /. PAGE WRAPPER  -->
     <!-- /. WRAPPER  -->
    <!-- JS Scripts-->
    <!-- jQuery Js -->
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
