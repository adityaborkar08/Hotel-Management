<?php  include_once 'include/class.user.php'; $user=new User();  $once = true; ?>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Banquet Halls</title>
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


  
<style>
.imgC{
    height:250px;
}
input[type=text], .newC {
        width: 100%;
        padding: 6px;
        border: 1px solid #ccc;
        border-radius : 4px;
        margin-top: 6px;
        margin-bottom: 16px;
        resize: vertical;
        color: black;
    }
        body{
        background-image: url('images/home_bg.jpg');
        background-repeat: no-repeat;
        background-attachment: fixed;
        }
    
</style>
<script>
  $( function() {
    $( ".datepicker" ).datepicker({
                  dateFormat : 'yy-mm-dd'
        
                });
  });

  
  if ( window.history.replaceState ) {
      window.history.replaceState( null, null, window.location.href );
    }
  </script>
</head>
<body >

<div class="container justify-content-center">
<?php 


// $sql="SELECT * FROM `t_banquets`";
$sql2 = "SELECT * FROM `t_banquet_menu_type`";


$result = mysqli_query($user->db,"CALL sp_get_banquets_details");

$user->db->next_result(); 

// $result2 = mysqli_query($user->db,"CALL sp_get_banquet_menu_type");
// $banquet_menu = mysqli_fetch_array($result2);

if($result)
{
    if(mysqli_num_rows($result) > 0)
    {
        while($eachrow = mysqli_fetch_array($result))
        {
?>
         


    <div class="card" style="width:85%">
        <img class="card-img-left imgC" src="images/banquet_1.jpg" alt="Card image">
            <div class="card-body">
                
               <div class="row">
                    <div class="col-md-9">  <h4 class="card-title"><?php echo $eachrow['banquet_name']; ?></h4> </div>
                </div>

                <hr>
                <p class="card-text"><?php echo $eachrow['banquet_description']; ?> </p>
               
                <div class="row">
                    <div class="col-md-3"><span class="font-weight-bold">Total Capacity :</span> <?php echo $eachrow['total_capacity']; ?></div>
                    <div class="col-md-3"><span class="font-weight-bold">Seating Capacity :</span> <?php echo $eachrow['seating_capacity']; ?></div>
                    <div class="col-md-3"><span class="font-weight-bold">Loyalty Points :</span> <?php echo $eachrow['banquet_loyalty_points']; ?></div>
                </div>

                <div class="row">
                    <div class="col-md-3"><span class="font-weight-bold">Opening Time  :</span> <?php echo $eachrow['opening_time']; ?></div>
                    <div class="col-md-3"><span class="font-weight-bold">Closing Time :</span> <?php echo $eachrow['closing_time']; ?> </div>
                </div>
                <?php
             
                    // $sql2 = "SELECT * FROM `t_banquet_menu_type`";
                    
                    $result2 = mysqli_query($user->db,"CALL sp_get_banquet_menu_type");
                    // while($banquet_menu = mysqli_fetch_array($result2))
                    // {
                ?>
                <form action="" method="POST">
                <div class="row mt-4">
                        <div class="col-md-3">
                            <select name="banquet_menu_type" class="custom-select newC" id="banquet_menu_type" name="banquet_menu_type">
                            <option value='0'>Select Meal Type</option>
                            <?php 
                            while($banquet_menu = mysqli_fetch_array($result2))
                            {
                            
                                echo "<option value='".$banquet_menu['banquet_menu_type_id']."'>".$banquet_menu['banquet_menu_type']."</option>";
                            }
                            $user->db->next_result();
                            ?>        
                            </select>
                        <!-- <div class="col-md-3"><span class="font-weight-bold">Menu type  :</span> <?php echo $banquet_menu['banquet_menu_type']; ?></div> -->
                        </div>
                        <input type="hidden" name="banquet_id" value="<?php echo $eachrow['banquet_id']; ?>">
                        <input type="hidden" name="loyalty" value="<?php echo $eachrow['banquet_loyalty_points']; ?>">
                        <div class="col-md-3">
                            <select name="banquet_capacity" class="custom-select newC" id="banquet_capacity">
                            <option value='0'>Select Number of Guest</option>
                            <?php 
                            $result3 = mysqli_query($user->db,"CALL sp_get_capacity_price");
                            while($banquet_capacity_price = mysqli_fetch_array($result3))
                            {
                                echo "<option value='".$banquet_capacity_price['banquet_capacity_price_id']."'>".$banquet_capacity_price['banquet_capacity']."</option>";
                            }
                            $user->db->next_result();
                            ?>        
                            </select>
                        </div>
                        <div class="col-md-3"> 
                            <label class="mt-2">Price : <span id="price"></span> </label>
                        </div>
                            <?php
                        
                        ?>
                        <!-- <div class="col-md-3"><span class="font-weight-bold">Menu type  :</span> <?php echo $banquet_menu['banquet_menu_type']; ?></div> -->
                        
                    </div>
                <?php
                        
                    // }
                    
                ?>
            <br>

                    <div class="row">
                        <div class="col-md-3">
                            <input type="text" class="datepicker" name="checkin" id="checkin" placeholder ="Date">
                        </div>

                        <div class="col-md-3">
                            <select class="custom-select my-1 mr-sm-2 newC" id="from" name="from">
                                <option selected>From</option>
                                <option value="10:00:00">10:00:00</option>
                                <option value="19:00:00">19:00:00</option> 
                                <!-- <option value="2">10:00 - 23:30</option> -->
                            </select>
                        </div>

                        <div class="col-md-3">
                            <select class="custom-select my-1 mr-sm-2 newC" name="to" id="to">
                                <option selected>To</option>
                                <option value="03:00:00">03:00:00</option>
                                <option value="23:00:00">23:00:00</option> 
                                <!-- <option value="2">10:00 - 23:30</option> -->
                            </select>
                           
                        </div>

                        <div class="col-md-3" >
                            <button type="submit" id="submit" name="submit" class="btn btn-primary btn-block my-1">Book Now</button>
                        </div> 

                    </div>
                </form>
                  

            </div>
    </div>


<br>
<br>


<?php 
          if($once){
            if($_SERVER['REQUEST_METHOD'] == 'POST')
            {
              if(isset($_POST['submit'])) 
              { 
                 extract($_POST); 

                //  echo $checkin."checking";

    
                 date_default_timezone_set("Asia/Calcutta");
                 $date_now = date("Y-m-d"); 
             
                 if ($checkin >= $date_now) //check date greater than today
                 { 
                      $booking_date = $checkin;
                      $booking_time_from = $from;
                      $booking_time_to = $to;
                    //   echo  $booking_date."BOOKING DATE"; 
                    //   echo $booking_time_from."BOOKING TIME FROM";
                    //   echo $to."TIME TO";
                    //  $reserveTable=$user->get_max_booked_count_restaurant($rest_id,$combinedDT);
                      $reserveBanquet = "CALL sp_get_banquet_availability_by_id('$banquet_id','$booking_date', '$booking_time_from')";
                      $resultOfQuery = mysqli_query($user->db,$reserveBanquet);
                      $get_result = mysqli_fetch_array($resultOfQuery);
                     // $isBooked = $get_result[0];
                      $user->db->next_result(); 
                    
    
                      if($get_result){
                        $availability = false;
                      }else{
                        $availability = true;
                      }
          
                      if($availability) {
                        $textmsg = "Banquet is available, Register to Book !!";
                        echo  '<script>toastr.success("Banquet is available")</script>';
                        echo "<a href='Customer_Registeration.php?banquet_id=".$banquet_id."&book_date=".$checkin."&time_from=".$booking_time_from."&time_to=".$to."&banquet_capacity=".($banquet_capacity)."&banquet_menu_type=".($banquet_menu_type)."&loyalty=".($loyalty)."'> <button class='btn btn-primary btn-block'>$textmsg </button></a>";
                      }else {
                        echo  '<script>toastr.error("Banquet is already booked for this time")</script>'; 
                        // echo '<script>alert("Banquet is already booked for this time")</script>'; 
                      }
                    }
                    else{
                        echo  '<script>toastr.warning("Please enter date greater than today")</script>'; 
                    //  echo 'Please enter date greater than today';
                  }   
                }           
            }
             $once = false;
          }     
?>


<?php
}
}
}
?>  

    
</div>
<script>
$(document).ready(function(){

  $("#banquet_capacity").change(function(){
    // alert($("#checkin").html());
    var id = $("#banquet_capacity option:selected").val();
    //  alert(id);
    $.ajax({
        type: "GET",
        url: "ajax_call.php",
        data: {
            action : 'get_banquet_capacity_price_by_id',
            banquet_capacity_price_id : id
        }, 
        success: function (data) {
            $("#price").text(data);

        }
    });
  });
  
  $("#from").change(function(){
    var val = $('#from option:selected').val();
    if(val == '10:00:00'){
        var from = $('#from option:selected').html();
        $('#to option[value="03:00:00"]').attr('selected','selected');
    }
    else{
        var from = $('#from option:selected').html();
        $('#to option[value="23:00:00"]').attr('selected','selected');
    }
    
  });
});

  
</script>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="js/bootstrap.min.js"></script>
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
   <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
</body>
</html>