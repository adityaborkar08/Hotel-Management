<?php  
session_start();  

?> 
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Customer Dashboard</title>
    <!-- Bootstrap Styles-->
    <link href="assets/css/bootstrap.css" rel="stylesheet" />
    <!-- FontAwesome Styles-->
    <link href="assets/css/font-awesome.css" rel="stylesheet" />
    <!-- Morris Chart Styles-->
    <link href="assets/js/morris/morris-0.4.3.min.css" rel="stylesheet" />
    <!-- Custom Styles-->
    <link href="assets/css/custom-styles.css" rel="stylesheet" />
    <!-- Google Fonts-->
    <link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css' />
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
           
<!-- 
            <ul class="nav navbar-top-links navbar-right">
                <li class="dropdown">
                    <a class="dropdown-toggle" data-toggle="dropdown" href="#" aria-expanded="false">
                        <i class="fa fa-user fa-fw"></i> <i class="fa fa-caret-down"></i>
                    </a>
                    <ul class="dropdown-menu dropdown-user">
                        <li><a href="usersetting.php"><i class="fa fa-user fa-fw"></i> User Profile</a>
                        </li>
                        <li><a href="settings.php"><i class="fa fa-gear fa-fw"></i> Settings</a>
                        </li>
                        <li class="divider"></li>
                        <li><a href="logout.php"><i class="fa fa-sign-out fa-fw"></i> Logout</a>
                        </li>
                    </ul>
                </li>
            </ul> -->
        </nav>
        <!--/. NAV TOP  -->
        <nav class="navbar-default navbar-side" role="navigation">
            <div class="sidebar-collapse">
                <ul class="nav" id="main-menu">
                    

                    <li>
                        <a class="active-menu" href="customer_dashboard.php?cust_id=<?php echo $cust_id; ?>"><i class="fa fa-dashboard"></i>Dashboard</a>
                    </li>
                    <li>
                        <a href="customer_details.php?cust_id=<?php echo $cust_id; ?>"><i class="fa fa-dashboard"></i> Account Details</a>
                        <!-- <a href="employee_details.php?restID=.$restID."><i class="fa fa-dashboard"></i> Account Details</a> -->
                    </li>
                    <li>
                        <a href="dashboard_restaurant.php?cust_id=<?php echo $cust_id; ?>"><i class="fa fa-dashboard"></i> Booked Restaurants</a>
                        <!-- <a href="employee_details.php?restID=.$restID."><i class="fa fa-dashboard"></i> Account Details</a> -->
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
                        <a href="dashboard_spa.php?cust_id=<?php echo $cust_id; ?>"><i class="fa fa-dashboard"></i> Booked Spa</a>
                    </li>
                    <li>
                        <a href="Customer_Login.php"><i class="fa fa-sign-out fa-fw"></i> Logout</a>
                    </li>
                   


                    
					</ul>

            </div>

        </nav>
        <!-- /. NAV SIDE  -->
        <div id="page-wrapper">
            <div id="page-inner">
            <h1> YOUR DASHBOARD </h1>
				
            </div>
            <!-- /. PAGE INNER  -->
        </div>
        <!-- /. PAGE WRAPPER  -->
    </div>
    <!-- /. WRAPPER  -->
    <!-- JS Scripts-->
    <!-- jQuery Js -->
    <script src="assets/js/jquery-1.10.2.js"></script>
    <!-- Bootstrap Js -->
    <script src="assets/js/bootstrap.min.js"></script>
    <!-- Metis Menu Js -->
    <script src="assets/js/jquery.metisMenu.js"></script>
    <!-- Morris Chart Js -->
    <script src="assets/js/morris/raphael-2.1.0.min.js"></script>
    <script src="assets/js/morris/morris.js"></script>
    <!-- Custom Js -->
    <script src="assets/js/custom-scripts.js"></script>


</body>

</html>