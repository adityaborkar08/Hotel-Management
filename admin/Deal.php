<?php  include_once 'include/class.user.php'; $user=new User(); $once = true; ?>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Deals</title>
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
    input[type=text], input[type=submit], textarea {
   
    padding: 12px;
    border: 1px solid #ccc;
    margin-top: 6px;
    margin-bottom: 16px;
    resize: vertical;
    color: black;
    }

    .wdiv{
        width: 50%; 
    }
    input[type=text], input[type=submit], textarea {
    width: 100%;
    padding: 12px;
    border: 1px solid #ccc;
    margin-top: 6px;
    margin-bottom: 16px;
    resize: vertical;
    color: black;
    }

</style>
</head>


<body>
<br><br>
<div class="container">
<p text-center style="text-align:center; width=100%; font-weight:bold;font-size:30px">Special Deals only for loyal customers </p>

<br>

<?php
$rest="CALL sp_get_all_deals";
$result = mysqli_query($user->db, $rest);

if($result)
{
    if(mysqli_num_rows($result) > 0)
    {
        while($eachrow = mysqli_fetch_array($result))
        {?>
        <div  class="border border-primary wdiv">
        <form method="POST" >
            <div class="d-flex justify-content-center">
            <img src="<?php echo $eachrow["image"]; ?>" style="width:100%">
            </div>
            <p><h2><?php echo $eachrow['name'] ?></h2> </p>
            <div class="product-title">Breakfast + Dinner 1 night</div>
            <div class="product-price">Loyalty points required :<span> <?php echo $eachrow['price'] ?></div>      
            
            <input type="hidden" name="discountID" value="<?php echo $eachrow['id']; ?>">            
            <input type="submit" class="btn btn-primary" type="button" name="submit" value="Book This Deal"></input>
        </form>
        </div>
<br>

<?php
}
}
}
?> 

<?php
if($_SERVER['REQUEST_METHOD'] == 'POST'){
    if(isset($_POST['submit'])) 
    { 
        extract($_POST); 
        $id = $discountID;
        echo  '<script>toastr.error("Please login below to continue...")</script>';  
        echo "<a href='Customer_login.php?discountID=".$id."'> <button class='btn btn-primary btn-block'> Login to continue  </button> </a>";        
    }  
    }
?>

<script>
$(document).ready(function(){
  $("#myBtn").click(function(){
    $('.toast').toast('show');
  });
});
</script>

    <script src="assets/js/jquery-1.10.2.js"></script>
    <script src="assets/js/bootstrap.min.js"></script>
    <script src="assets/js/jquery.metisMenu.js"></script>
    <script src="assets/js/dataTables/jquery.dataTables.js"></script>
    <script src="assets/js/dataTables/dataTables.bootstrap.js"></script>
       
    <script src="assets/js/custom-scripts.js"></script>

</body>
</html>