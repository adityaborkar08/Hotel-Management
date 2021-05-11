<?php  include_once 'include/class.user.php'; $user=new User(); $once = true; ?>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Admin Bill desk</title>
<meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
  <link rel="stylesheet" href="/resources/demos/style.css">
    
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <link rel="stylesheet" href="/resources/demos/style.css">
  <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
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
.custloyalty, .restbill{
    width: 100%;
    padding: 12px;
    border: 1px solid #ccc;
    border-radius : 10px;
    margin-top: 6px;
    margin-bottom: 16px;
    resize: vertical;
    color: black;
    }
</style>
</head>
<body>

<?php 

if(isset($_GET["cid"])){
 $cid = $_GET['cid'];
}
if(isset($_GET["fname"])){
  $Name = $_GET['fname'];
 }
 if(isset($_GET["lname"])){
  $lname = $_GET['lname'];
 }
 if(isset($_GET["total"])){
  $total = $_GET['total'];
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
$custloyalty =0;
$restbill=0;
$sql = "CALL sp_get_loyalty_points('$cid')";
$user->db->next_result();
$result = mysqli_query($user->db,$sql);
$fetchPoint=  mysqli_fetch_array($result);
$user->db->next_result(); 
?>


<br><br>
<div class="container justify-content-center">
<div class="alert alert-danger" role="alert"><p text-center style="text-align:center; width=100%; font-weight:bold;font-size:30px">Admin Payment Desk </p> 
<p style="text-align:center; width=100%; font-weight:bold;font-size:20px">Bill for : <?php echo $checkin." - ".$checkout; ?></p> </div>
<br>
<div class="row">



<div class="col-5 border">
<form method ="POST" action="">
 <div class= "row">
 <div class="col-12" style="margin: 10px;width:100%">
 <label for="subject">Combined Bill</label>
 <input  style="width:90%"   value ="<?php echo $total; ?>" class="restbill" name="restbill" type="number" readonly></input>
 </div>

 <div class="col-12"  style="margin: 10px;width:100%" >
 <label for="subject">Loyalty Points</label>
 <input  style="width:90%" class="custloyalty" name="custloyalty"  type="number" required>
 </div>
 </div>
   
    <input  style="margin: 5px; width:90%; border-radius:10px" type="submit" id="submit" name="submit" class="btn btn-primary btn-block"value= "Enter Details"></input> 
    </form>
</div>

<div class="col-2 "></div>
<div class="col-5 border">
<p style="font-size:20px; font-weight:bold"> Customer Details </p>
<p> <?php echo "Customer ID : ".$cid.""; ?><p>
<p> <?php echo "Customer Name : ".$Name." ".$lname.""; ?><p>
<div style=" width=100%;"><?php echo "Customer's total loyalty points :".$fetchPoint[0].""; ?></div>
<br>
<p style="font-size:20px; font-weight:bold"> Loyalty points Terms & Conditions </p>
<p > Can be used if customer has a minimum of 100 points. Valid upto 1000 points per transaction !! </p>
</div>
</div>





    
    

      <?php
       
        //on submit --> update restaurant booked = 0
        //update loyalty points --> customer login
        // display only isBooked = 1;
    
  
        if($_SERVER['REQUEST_METHOD'] == 'POST'){
            if(isset($_POST['submit'])) 
            { 
               extract($_POST); 
               $custloyalty = $custloyalty;
               $restbill = $restbill;
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

                  // $sql_invoice = "CALL sp_invoice_restaurant('$cid','Restaurant','$custloyalty','$finalBill','$restID')";
                  // $user->db->next_result(); 
                 //  if(mysqli_query($user->db,$sql_invoice)){
                   echo " <br>
                   <div class ='row'>
                   <div class='col-6'>
                   <a href=Print_Combined_bill.php?cid=".$cid."&restamount=".$restbill."&loyalty=".$custloyalty."&tax=".$tax."&discount=".$discount."&finalBill=".$finalBill."><button class='btn btn-block btn-secondary'> Print Bill  </button> <a>
                   </div>
                   <div class='col-6'>
                   <a href=Print_Details-Combined-bill.php?cid=".$cid."&restamount=".$restbill."&loyalty=".$custloyalty."&tax=".$tax."&discount=".$discount."&finalBill=".$finalBill."&checkin=".$checkin."&checkout=".$checkout."&status=".$status."><button class='btn btn-block btn-dark'> Print Combined Bill</button> <a>
                   </div>
                   </div>
                   
                   ";
                //  }else{
                  //  echo '<script>alert("Something is wrong please again")</script>'; 
                //  }
                  
                }
               }

            }  
          }
         
        
        ?>

    <script src="assets/js/jquery-1.10.2.js"></script>
    <script src="assets/js/bootstrap.min.js"></script>
    <script src="assets/js/jquery.metisMenu.js"></script>
    <script src="assets/js/dataTables/jquery.dataTables.js"></script>
    <script src="assets/js/dataTables/dataTables.bootstrap.js"></script>
       
    <script src="assets/js/custom-scripts.js"></script>
</div>
</body>
</html>