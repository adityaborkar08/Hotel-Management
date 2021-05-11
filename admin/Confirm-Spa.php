<?php include_once 'include/class.user.php'; $user=new User();$once = true;
?>
<!DOCTYPE html>
<html>
<head>
	<title>Register Form</title>
	<h2>Login and confirm your Details for Slot Booking:</h2>
	<br>
</head>
<style>
  h2 {text-align: center;}
  #dtt
  {
    font-size: 10pt; 
  height: 35px; 
  width:180px
  background-color: pink;
  }
</style>
<script>
$( function() {
        $( ".datepicker" ).datepicker({
                      dateFormat : 'yyyy-mm-dd'
                    });
      });
</script>
<body>

   <?php 
   if(isset($_GET["DT"])){
    $date = $_GET['DT'];
   }
 
   if(isset($_GET["time"])){
    $time = $_GET['time'];
   }
   
   if(isset($_GET["spa_massage_type"])){
    $spa_massage_type = $_GET['spa_massage_type'];
   }
  
   $combinedDT = date('Y-m-d H:i:s', strtotime("$date $time"));


   ?>
         <form action="">
            
<table align ="center">
    <tr>
       <td>
        <fieldset>
 <label><B>DATE & TIME CHOSEN:</B></label>
         <input readonly type="text" id="dtt" class="datetime" name="combinedDT" value="<?php echo $combinedDT; ?>">
       </td>
     </tr>
         <br>
         <br>
         <tr>
         <td>
          <fieldset>
           <label><B>SPA MASSAGE CHOSEN</B></label>
            <?php
               $result3 = mysqli_query($user->db,"CALL sp_get_spa_massage_type_by_id('$spa_massage_type')");
               while($spa_massage_type_id = mysqli_fetch_array($result3))
               {
                ?>
                <input readonly type="text" class="spa_massage_type" id="dtt" name="spa_massage_type" value="<?php echo $spa_massage_type_id['spa_massage_type']; ?>">
                <?php  
               }
               $user->db->next_result();
            ?>
                
              </td>
            </tr>
          </table>
                <br>
                <br>        
                        <?php echo "<center><a href='Customer_login.php?&DT=".urlencode($date)."&time=".$time."&spa_massage_type=".($spa_massage_type)."'> LOGIN </a></center>"; ?>
                    </div>
                </div>  
                </form>
              </div>
            
</body>
</html>