<?php session_start(); include_once 'include/class.user.php'; $user=new User(); $once = true;
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
    <title>Admin Conference</title>
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
    <div id="wrapper">
        
        <nav class="navbar navbar-default top-navbar" role="navigation">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".sidebar-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
             
                <a class="navbar-brand" href="home.php"><?php echo $_SESSION["user"]; ?> </a>
            </div>

        </nav>
        <!--/. NAV TOP  -->
        <nav class="navbar-default navbar-side" role="navigation">
            <div class="sidebar-collapse">
                <ul class="nav" id="main-menu">

               
                    <li>
                        <a  href="Admin-room-availability.php"> Room Booking</a>
                    </li>
                   
					<li>
                        <a  href="Admin_show-rooms.php">Booked Rooms </a>
                    </li>
                    <li>
                        <a  href="Admin_Restaurants.php">Booked Restaurants</a>
                    </li>
                    <li>
                        <a  href="Admin_Banquets.php"> Booked Banquets</a>
                    </li>
                    <li>
                        <a  href="Admin_spa.php"> Booked Spa</a>
                    </li>
                    <li>
                        <a class="active-menu" href="Admin_Conference.php"> Booked Conference</a>
                    </li>
                    <li>
                        <a  href="profit.php"> Profit</a>
                    </li>
                    <li>
                        <a href="logout.php"> Logout</a>
                    </li>
				
                    


                    
            </div>

        </nav>
        <!-- /. NAV SIDE  -->
        <div id="page-wrapper" >

               <?php
        
               $get_conference = "CALL sp_admin_get_booked_conference";
               $conference_results = mysqli_query($user->db,$get_conference);
             
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
                                            <th>Conference ID</th>
											<th>Customer ID</th>
                                            <th>Customer First name</th>
                                            <th>Customer last name</th>
											<th>Purpose of Conference Hall</th>
											<th>Booked Date</th>
                                            <th>No. of Guests </th>
                                            <th>Booked Time </th>
                                            <th>Price</th>
                                            <th>Booked On</th>
                                            <th> Pay </th>
                                        </tr>
                                    </thead>
                                
                                <tbody>    
									<?php
										while($row = mysqli_fetch_array($conference_results))
										{
											$id = $row['conference_id'];
											if($id % 2 ==1 )
											{
                                                echo"<tr class='gradeC'>
                                                <td>".$row['conference_id']."</td>
													<td>".$row['cust_id']."</td>
                                                    <td>".$row['cust_fname']."</td>
                                                    <td>".$row['cust_lname']."</td>
                                                    <td>".$row['conf_type']."</td>
                                                    <td>".$row['conference_date']."</td>
                                                    <td>".$row['conf_guest']."</td>
                                                    <td>".$row['conf_time']."</td>
                                                    <td>".$row['conf_rent']."</td>
                                                    <td>".$row['created_on']."</td>
                                                    <th><button  class='printBill'><a href=Admin_Bill_conference.php?cid=".$row['cust_id']."&Name=".$row['cust_fname']."&lname=".$row['cust_lname']."&conf_rent=".$row['conf_rent']."&conference_id=".$row['conference_id']."> Pay Now <a> </button></th>

													
												</tr>";
											}
											else
											{
                                                echo"<tr class='gradeU'>
                                                <td>".$row['conference_id']."</td>
                                                <td>".$row['cust_id']."</td>
                                                <td>".$row['cust_fname']."</td>
                                                <td>".$row['cust_lname']."</td>
                                                <td>".$row['conf_type']."</td>
                                                <td>".$row['conference_date']."</td>
                                                <td>".$row['conf_guest']."</td>
                                                <td>".$row['conf_time']."</td>
                                                <td>".$row['conf_rent']."</td>
                                                <td>".$row['created_on']."</td>
                                                <th><button  class='printBill'><a href=Admin_Bill_conference.php?cid=".$row['cust_id']."&Name=".$row['cust_fname']."&lname=".$row['cust_lname']."&conf_rent=".$row['conf_rent']."&conference_id=".$row['conference_id']."> Pay Now <a> </button></th>
                                                </tr>";
                                                


											
                                            }
                                            
                                           
                                                
										
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