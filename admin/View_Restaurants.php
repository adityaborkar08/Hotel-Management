<?php include_once 'include/class.user.php'; $user=new User(); $once = true;

?>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Restaurants</title>
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
              background-repeat: no-repeat;
              background-attachment: fixed;
            }
          
            }

      
</style>
</head>


<body >
<div class="bg-image"></div>
<div class="container justify-content-center">

<?php 

$rest="CALL sp_get_all_restaurants";
$result = mysqli_query($user->db, $rest);
$user->db->next_result(); 
$cuisine = "CALL sp_get_all_cuisines";
$cresult = mysqli_query($user->db, $cuisine);
$user->db->next_result(); 
$eachcusine = mysqli_fetch_array($cresult);

if($result)
{
    if(mysqli_num_rows($result) > 0)
    {
        while($eachrow = mysqli_fetch_array($result))
        {
?>      
<br>
    <div class="card mx-auto" style="width:85% ; filter: drop-shadow(0.25rem 0 0.75rem #ffffff);">
        <img class="card-img-left imgC" src="images/rest.jpg" alt="Card image">
            <div class="card-body">
               <div class="row">
                    <div class="col-md-9">  <h4 class="card-title"name="rest_name"><?php echo $eachrow['restaurant_name'];?></h4> 
                    </div>
                    <button class="btn btn-light">
                         <?php 
                         $t = $eachrow['restaurant_mode']; 
                         if ($t == "Both") {
                            echo "Veg & Non Veg";
                            
                          }else if($t == "Veg"){
                            echo "Veg";
                          }else{
                            echo "Non Veg";
                          }
                         ?> 
                         <span class="badge badge-success"> V </span>
                    </button>
                </div>

                <hr>
             
                <p class="card-text"><?php echo $eachrow['restaurant_detail']; ?> </p>
                
                <div class="row">
                <div class="col-md-6"><span class="font-weight-bold">Cuisines :</span> 
            <!-- WORK HERE FOR CUISINES -->
               <?php
                  $sqll = "CALL get_cuisine_types_by_restID('$eachrow[restaurant_id]')";

                  $result11 = mysqli_query($user->db, $sqll);
                  $user->db->next_result(); 
                  while($row = mysqli_fetch_array($result11))
                  {
                    echo " ".$row['cuisine_type'];
                  }
                ?>
                </div>

                <div class="col-md-6"><span class="font-weight-bold">Rate for two : € </span> <?php echo $eachrow['restaurant_rates']; ?></div>
                </div>

                <div class="row">
                <div class="col-md-6"><span class="font-weight-bold">Open :</span>
                        <?php 
                         $t = $eachrow['restaurant_open_time']; 
                         $closeD = $eachrow['restaurant_close_time']; 
                         echo $t."-".$closeD;
                        // echo date('G',(int)$t )."-".date('G',(int)$closeD ) ;
                         ?> 
                </div>

                <div class="col-md-6"><span class="font-weight-bold">Loyalty Points :</span> <?php echo $eachrow['restaurant_max_loyalty_points']; ?> </div>
                </div>

                <br>
                <hr>

          <form action="" method="POST" >
              <!-- Booked_Restaurant_Confirmation.php -->
              <div class="row">
                <div class="col-md-3">
                  <label class="font-weight-bold">Date </label>
                    <input type="text" class="datepicker" name="checkin"  placeholder ="Date" required>
                </div>

                <div class="col-md-3">
                  <label class="font-weight-bold">Time </label>
                    <select class="custom-select my-1 mr-sm-2 newC" placeholder="Time" name="time" id="time" required> 
                      <!-- <option name="time">Time</option>  -->
                      <?php
                          date_default_timezone_set("Asia/Calcutta");
                          $time_now = date("G");
                          $hour = date('G');
                          $minute = (date('i')>30)?'30':'00';
                          for($hours=$time_now ; $hours<24; $hours++) // the interval for hours is '1'
                          for($mins=$min; $mins<60; $mins+=30) // the interval for mins is '30'
                          echo '<option>'.str_pad($hours,2,'0',STR_PAD_LEFT).':'
                        .str_pad($mins,2,'0',STR_PAD_LEFT).'</option>';
                      ?>       
                    </select>
                  </div>

                <div class="col-md-3">
                  <label class="font-weight-bold">Guests </label>
                    <select class="custom-select my-1 mr-sm-2 newC" id="no_guests" name="no_guests" required>
                      <option value="2">2</option>
                      <option value="4">4</option>
                      <option value="8">8</option>
                      <option value="12">12</option>
                    </select>
                  </div>

                <input type="hidden" name="rest_id" value="<?php echo $eachrow['restaurant_id']; ?>">
                <input type="hidden" name="loyalty" value="<?php echo $eachrow['restaurant_max_loyalty_points']; ?>">

                <div class="col-md-3" >
                  <label > </label>
                    <input type="submit" id="submit" name="submit" value= "Reserve table"  class="btn btn-primary btn-block my-1"></input>
                </div>
              </div>
            </form>
        </div>
    </div>

<br>

<?php 
      if($once){
        if($_SERVER['REQUEST_METHOD'] == 'POST')
        {
          if(isset($_POST['submit'])) 
          { 
             extract($_POST); 

             date_default_timezone_set("Asia/Calcutta");
             $date_now = date("Y-m-d"); 
         
             if ($checkin >= $date_now) //check date greater than today
             { 
                  $combinedDT = date('Y-m-d H:i:s', strtotime("$checkin $time"));
             
                //  $reserveTable=$user->get_max_booked_count_restaurant($rest_id,$combinedDT);
                  $reserveTable = "CALL sp_get_restaurant_availability_by_id('$rest_id','$combinedDT')";
                  $resultOfQuery = mysqli_query($user->db,$reserveTable);
                  $get_count = mysqli_fetch_array($resultOfQuery);
                  $user->db->next_result(); 

                  $guestNo = $get_count[0];
                 
                  $sqlFn = ("SELECT fn_restaurant_availability('$guestNo')");
                  $resFn =  mysqli_query($user->db,$sqlFn);
                  $fetchAvailibitity = mysqli_fetch_array($resFn);
                  $availability = $fetchAvailibitity[0];
                  $user->db->next_result(); 

                  // if($get_count[0] > 20){
                  //   $availability = false;
                  // }else{
                  //   $availability = true;
                  // }
      
                  if($availability) {
                    $textmsg = "Table is available, Register to Book !!";
                    echo "<a href='Customer_Registeration.php?restID=".$rest_id."&DT=".urlencode($checkin)."&time=".$time."&guests=".($no_guests)."&loyalty=".($loyalty)."'> <button class='btn btn-primary btn-block'>$textmsg </button></a>";
                  }else {
                    echo '<script>alert("Restaurant is full please select another time")</script>'; 
                  }
                }
                else{
                 echo 'Please enter date greater than today';
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

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="js/bootstrap.min.js"></script>
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
   <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
</body>
</html>