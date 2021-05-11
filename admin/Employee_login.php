<?php  include_once 'include/class.user.php'; $user=new User(); $once = true;?>
<!DOCTYPE html>
<html >
<head>
  <meta charset="UTF-8">
  <meta charset="utf-8">
      <meta http-equiv="X-UA-Compatible" content="IE=edge">
      <meta name="viewport" content="width=device-width, initial-scale=1">
      <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
      <title>Employee Login</title>
      <!-- Bootstrap -->
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
  <title>Login</title>
  
  
     
      <link rel="stylesheet" href="css/style.css">
      <script>
      if ( window.history.replaceState ) {
        window.history.replaceState( null, null, window.location.href );
        }
        </script>
</head>




<body>

  <!-- <div id="clouds">
	<div class="cloud x1"></div> -->
	<!-- Time for multiple clouds to dance around -->
	<!-- <div class="cloud x2"></div>
	<div class="cloud x3"></div>
	<div class="cloud x4"></div>
	<div class="cloud x5"></div> -->
<!-- </div> -->

 <div class="container" style="margin-left:25%;">
 

      <div id="login">

        <form method="post" action="">
        <h6 class="mb-4">EMPLOYEE LOGIN</h6>
          <!-- <fieldset class="clearfix"> -->

            <p><span class="fontawesome-user"></span><input type="text"  name="user" value="Username" onBlur="if(this.value == '') this.value = 'Username'" onFocus="if(this.value == 'Username') this.value = ''" required></p> <!-- JS because of IE support; better: placeholder="Username" -->
            <p><span class="fontawesome-lock"></span><input type="password" name="pass"  value="Password" onBlur="if(this.value == '') this.value = 'Password'" onFocus="if(this.value == 'Password') this.value = ''" required></p> <!-- JS because of IE support; better: placeholder="Password" -->
            <p><input type="submit" name="submit"  value="Login"></p>

          <!-- </fieldset> -->

        </form>

       

      </div> <!-- end login -->

    </div>
    <div class="bottom">  <h3><a href="../index.php">Go back to HOMEPAGE</a></h3></div>
  
  


<?php
   include('db.php');
  
   
   if($_SERVER["REQUEST_METHOD"] == "POST") {
      // username and password sent from form 
      if(isset($_POST['submit'])) 
    { 

      $myusername = mysqli_real_escape_string($con,$_POST['user']); 
      $mypassword = mysqli_real_escape_string($con,$_POST['pass']);

   
      
        $sql_check_existinguser = "CALL sp_get_employee_login('$myusername','$mypassword')";
        $result_user = mysqli_query($user->db,$sql_check_existinguser);
        $old_user=  mysqli_fetch_array($result_user);
        $emp_id = $old_user[0];
        $user->db->next_result(); 
        if($old_user)
        {               
            ?>
            <script>
            var emp_id = "<?php echo $emp_id ?>";
                window.location = "employee_dashboard.php?emp_id=" + emp_id;
            </script>
              <?php
        }
    
      else
      {
        echo  '<script>alert("invalid!!")</script>';  
     
      }
    } 
   }
?>
</body>
</html>

