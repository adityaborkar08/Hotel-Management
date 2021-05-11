<?php session_start();   include_once 'include/class.user.php'; $user=new User(); $once = true; 

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
    </script>
    <style>
.credit-card-div  span { padding-top:10px; }
.credit-card-div img { padding-top:30px; }
.credit-card-div .small-font { font-size:9px; }
.credit-card-div .pad-adjust { padding-top:10px; }
.panel panel-default{
    
}
</style>
</head>
<?php 
if(isset($_GET["cust_id"])){
    $cust_id = $_GET['cust_id'];
}
if(isset($_GET["bill"])){
$bill = $_GET['bill'];
}
if(isset($_GET["bookingId"])){                      
  $bookingId = $_GET['bookingId'];
}
if(isset($_GET["checkin"])){                      
    $checkin = $_GET['checkin'];
}
if(isset($_GET["checkout"])){                      
    $checkout = $_GET['checkout'];
}
$roomTotal=0;
$roomTotalTax=0;


$sql = "CALL sp_get_loyalty_points('$cust_id')";
$user->db->next_result();
$result = mysqli_query($user->db,$sql);
$fetchPoint=  mysqli_fetch_array($result);
$user->db->next_result(); 


$getAllRooms = "CALL sp_admin_pay_rooms_by_RM('$checkin','$checkout','$cust_id')";
$roomResult = mysqli_query($user->db,$getAllRooms);
$user->db->next_result(); 

if($roomResult)
 {
 if(mysqli_num_rows($roomResult) > 0)
   {
     ?>
     <div class="row">
       <div class="col-md-12">
    
           <?php 
            while($rooms = mysqli_fetch_array($roomResult))
            {
            
            //    echo "<br> Room Type : ";
            //    echo "<input value='".$rooms['room_type']."' input name='roomtype' type='text'></input> ";
               
               $bid = $rooms['bookingID'];
               $cid = $rooms['cust_id'];
               $room_sql= "CALL sp_admin_room_rate_by_bid('$bid','$cid')";
               $room_res = mysqli_query($user->db,$room_sql);
               
               while($room_col = mysqli_fetch_array($room_res)){
              // echo "<input value='".$room_col['total_rent']."' input name='roomP' type='text' readonly></input> <br>";
            
               
               $roomTotal = $room_col['total_rent'] + $roomTotal;
               
               }$user->db->next_result(); 
             

   }
            $user->db->next_result();
            $tax = $roomTotal * 0.05;
            $roomTotalTax = $roomTotal + $tax;
           ?>

           
         </div>
       </div>

     <?php
   }
 }



?>
<body>
<div class="container">
<form method="POST" class="credit-card-div" >


<div class="alert alert-warning" role="alert" style="margin-left : 30%;margin-right : 30%;">
<p style="font-size:15px; font-weight:bold">Booked Rooms within dates <?php echo $checkin." - ". $checkout; ?> </p>
Total bill with tax : <?php echo $roomTotal; ?>
<div>Total bill after Tax : <?php echo $roomTotalTax; ?></div>
<div >


<div style=" width=100%;"><?php echo "Customer's total loyalty points :".$fetchPoint[0].""; ?></div>
<p style="font-size:15px; font-weight:bold"> Loyalty points Terms & Conditions </p>
<div > Can be used if customer has a minimum of 100 points. Valid upto 1000 points per transaction !! </div>
</div>


</div>

<div class="panel panel-default" style="margin-left : 30%;margin-right : 30%;">
 <div class="panel-heading">

      <div class="row ">
              <div class="col-md-12">
                  <input type="number" class="form-control" name="cardnumber" placeholder="Enter Card Number" required/>
              </div>
          </div>
     <div class="row ">
              <div class="col-md-3 col-sm-3 col-xs-3">
                  <span class="help-block text-muted small-font" > Expiry Month</span>
                  <input type="number" class="form-control" placeholder="MM" required />
              </div>
         <div class="col-md-3 col-sm-3 col-xs-3">
                  <span class="help-block text-muted small-font" >  Expiry Year</span>
                  <input type="number" class="form-control" placeholder="YY" required/>
              </div>
        <div class="col-md-3 col-sm-3 col-xs-3">
                  <span class="help-block text-muted small-font" >  CCV</span>
                  <input type="number" class="form-control" placeholder="CCV" required/>
              </div>
         <div class="col-md-3 col-sm-3 col-xs-3">
            <img src="images/mastercard.png" class="img-rounded" style="width:65px;" />
         </div>
          </div>
        <div class="row ">
              <div class="col-md-12 pad-adjust">

                  <input type="text" name = "cardname" class="form-control" placeholder="Name On The Card" required/>
              </div>
          </div>
          <div class="row ">
              <div class="col-md-12 pad-adjust">

                  <input type="number" name = "custloyalty" class="form-control" placeholder="Loyalty Points" required/>
              </div>
          </div>
     <div class="row">
<div class="col-md-12 pad-adjust">
    <div class="checkbox">
    <label>
       Type Name as printed on the card 
    </label>
  </div>
</div>
     </div>
       <div class="row ">
            <div class="col-md-6 col-sm-6 col-xs-6 pad-adjust">
                 <input type="cancel"  class="btn btn-danger" value="CANCEL" />
              </div>
              <div class="col-md-6 col-sm-6 col-xs-6 pad-adjust">
                  <input type="submit" name="submit" class="btn btn-warning btn-block" value="Pay Now" />
              </div>
          </div>
     
                   </div>
              </div>
</form>


<?php 
   if($_SERVER['REQUEST_METHOD'] == 'POST'){
    if(isset($_POST['submit'])) 
    { 
       extract($_POST); 

       $custloyalty = $custloyalty;
       $roomTotal = $roomTotal;
       if($custloyalty % 100 != 0){
        echo " Please enter loyalty --> 100's multiple (upto 1000)";
       }else
       if($custloyalty > $fetchPoint[0]){
         echo " You dont have sufficient loyalty points";
       } else if($custloyalty > 1000){
        echo " Loyalty points cannot be more than 1000 (allowed 100-1000) ";
       }
       else{

        if($roomTotal){
        
          // <--tax function in phpmyadmin
          $sqlFn = ("SELECT fn_calculate_tax('$roomTotal')");
          $resFn =  mysqli_query($user->db,$sqlFn);
          $ftax = mysqli_fetch_array($resFn);
          $tax = $ftax[0];
          $user->db->next_result(); 

          //$tax = $restbill * 0.05;

          $finalBillwtax = $roomTotal + $tax;

          // <-- loyalty point calculation function
          $sqlDis = ("SELECT fn_calculate_loyalty_discount('$custloyalty')");
          $resdiscount = mysqli_query($user->db,$sqlDis);
          $fdiscount =  mysqli_fetch_array($resdiscount);
          $fres = $fdiscount[0];
          $discount =$fres * $finalBillwtax;
          $user->db->next_result(); 
          //substract discount from final bill

          $finalBill = $finalBillwtax - $discount;

        $sql_invoice = "CALL sp_invoice_rooms_online('$cust_id','Rooms - Online','$custloyalty','$finalBill','$checkin','$checkout','$cardnumber','$cardname','$bookingId')";
         $user->db->next_result(); 
        if(mysqli_query($user->db,$sql_invoice)){
            echo " 
            <div class ='row'>
            <div class='col-6'>
            <a href=Print_Combined_bill.php?cid=".$cid."&restamount=".$roomTotal."&loyalty=".$custloyalty."&tax=".$tax."&discount=".$discount."&finalBill=".$finalBill."><button class='btn btn-block btn-primary'> Print Bill  </button> <a>
            </div>
            </div>";
            echo "<div class='alert alert-danger' role='alert'><h1>Total Bill Generated for : € ".$finalBill." With Loyalty Points : ".$custloyalty." </h1></div>";
            }else{
           echo '<script>alert("Something is wrong please again")</script>'; 
         }
          
         
        }
       }







       echo "<div class='alert alert-warning' role='alert' style='margin-left : 30%;margin-right : 30%;'>Total bill with tax : </div>";

    }
}


?>
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
