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
    <title>Booked Rooms</title>
	<!-- Bootstrap Styles-->
    <link href="assets/css/bootstrap.css" rel="stylesheet" />
     <!-- FontAwesome Styles-->
    <!-- <link href="assets/css/font-awesome.css" rel="stylesheet" /> -->
    <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
     <!-- Morris Chart Styles-->
   
        <!-- Custom Styles-->
    <link href="assets/css/custom-styles.css" rel="stylesheet" />
     <!-- Google Fonts-->
   <link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css' />
     <!-- TABLE STYLES-->
    <link href="assets/js/dataTables/dataTables.bootstrap.css" rel="stylesheet" />
    <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css">

    <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
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
                        <a  href="dashboard_restaurant.php?cust_id=<?php echo $cust_id; ?>"><i class="fa fa-dashboard"></i> Booked Restaurants</a>
                    </li>
                    <li>
                        <a class="active-menu" href="dashboard_rooms.php?cust_id=<?php echo $cust_id; ?>"><i class="fa fa-dashboard"></i> Booked Rooms</a>
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
        
               $get_rooms = "CALL sp_get_booked_rooms_by_cust_id('$cust_id')";
               $rest_results = mysqli_query($user->db,$get_rooms);
             
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
                                            <th>Room Type</th>
                                            <th>Room Floor</th>
                                            <th>Room Number</th>
											<th>No. of Adults</th>
                                            <th>No. of Children</th>
                                            <th>Check In</th>
											<th>Check Out</th>
                                            <th>Room Rent</th>
                                            <th>Customer Loyalty Points</th>
                                            <th class='text-center'>Action</th>
                                            <th>Pay now</th>
                                        </tr>
                                    </thead>
                                
                                <tbody>    
									<?php
										while($row = mysqli_fetch_array($rest_results))
                                        {	$bookingId = $row['room_booking_id'];
                                            $roomTypeId = $row['room_type_id'];		
                                            $check_in = $row['check_in'];
                                            $check_out = $row['check_out'];

                                            echo"<tr class='gradeU'>
                                            <td>".$row['room_type']."</td>
                                            <td>".$row['room_floor']."</td>
                                            <td>".$row['room_number']."</td>
                                            <td>".$row['adults']."</td>
                                            <td>".$row['children']."</td>
                                            <td>".$check_in."</td>
                                            <td>".$check_out."</td>
                                            <td>".$row['total_rent']."</td>    
                                            <td>".$row['cust_loyalty_points']."</td> 
                                            <td class='text-center'><a  href='View_Rooms.php?cust_id=$cust_id&updateRooms=updateRooms&bookingId=$bookingId&roomTypeId=$roomTypeId&checkIn=$check_in&checkOut=$check_out'><i class='fa fa-edit'></i></a>
                                            <i id='delete_room_booking' class='fa fa-trash'></i>
                                            </td>
                                            <td><a href='Credit_card.php?cust_id=$cust_id&bill=".$row['total_rent']."&checkin=$check_in&checkout=$check_out&bookingId=$bookingId'>Pay Now</a></td>
                                            </tr>
                                            <input type='text' id='booking_id' value='$bookingId' style='display:none'>";										
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


                $("#delete_room_booking").click(function(){

                    // alert($("#booking_id").val());
                    // debugger;
                   
                    var cust_id = "<?php echo $cust_id ?>";
                    var booking_id = $("#booking_id").val();
                    //  alert("Delete Room Booking ?");

                    $.ajax({
                        type: "GET",
                        url: "ajax_delete_room.php",
                        data: {
                            action : 'delete_room_by_booking_id',
                            cust_id : cust_id,
                            booking_id : booking_id
                        }, 
                        success: function (data) {
                            alert(data);
                            window.location.reload();
                            // toastr.success("Room booking deleted succeesfully");
                        }
                    });
                });
            
            });
    </script>
         <!-- Custom Js -->
    <script src="assets/js/custom-scripts.js"></script>
    
   
</body>
</html>
