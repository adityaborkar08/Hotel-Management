<?php  include_once 'include/class.user.php'; $user=new User(); $once = true;
?>

<!DOCTYPE html>
<html lang="en">
   <head>
      <meta charset="utf-8">
      <meta http-equiv="X-UA-Compatible" content="IE=edge">
      <meta name="viewport" content="width=device-width, initial-scale=1">
      <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
      <title>Employee Registration</title>
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
      <script>
         $( function() {
           $( ".datepicker" ).datepicker({
                         dateFormat : 'yy-mm-dd'
                       });
         } );
      </script>
      <script>
        if ( window.history.replaceState ) {
        window.history.replaceState( null, null, window.location.href );
        }
    </script>
   </head>
   <body>
        <div class="well">
            <div class="form-group">
            <div>
                <span>
                    <h2 class="text-center" color= #ffbb2b>Employee Registration</h2>
                    <a href ="Employee_Login.php"><button  type="button" style=" border-radius:10px"  class="btn color: #007bff btn btn-primary" >Login</button></a>
                </span>
                <!-- <p>Already Registered ?</p> -->
                
            </div>

                <hr>
                <form action="" method="POST" >
                    <div class="container">
                        <div class="row mb-4">
                            <div class="col-md-6">
                                <div class="card">
                                    <div class="card-header mb-4 text-center">Contact Info</div>
                                    <div class="card-body">
                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <div class="">
                                                       
                                                        <input type="text" class="fname" name="fname" id="" placeholder="First Name" height="40" width="80" margin = right required>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <div class="">
                                                       
                                                        <input type="text" class="mname" name="mname" id="" placeholder="Middle Name" height="40" width="80" required>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <div class="">
                                                       
                                                        <input type="text" class="lname" name="lname" id="" placeholder="Last Name" height="40" width="80" required>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <div class="">
                                                        <input type="datepicker" class="datepicker" name="dob"  placeholder="Date of birth" height="40" width="80" required>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <div class="">
                                                    
                                                        <input type="number" class="pNumber" name="pNumber" id="" placeholder="Mobile Number" height="40" width="80" required>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="card">
                                    <div class="card-header mb-4 text-center">Address</div>
                                    <div class="card-body">
                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <div class="">
                                                        
                                                        <input type="text" class="street" name="street" id="" placeholder="Street" height="40" width="80" margin = right required>
                                                    </div>
                                                </div>
                                            </div>
                                    
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <div class="">
                                                      
                                                        <input type="text" class="city" name="city" id="" placeholder="City" height="40" width="80" required>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <div class="">
                                                        
                                                        <input type="text" class="state" name="state" id="" placeholder="State" height="40" width="80" required>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <div class="">
                                                        
                                                        <input type="text" class="country" name="country" id="" placeholder="Country" height="40" width="80" required>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    
                        <div class="row">
                            <div class="col-md-6">
                                <div class="card">
                                    <div class="card-header mb-4 text-center">Bank Information</div>
                                    <div class="card-body">
                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <input type="text" class="IBAN" name="IBAN" id="IBAN" placeholder="IBAN Number" height="40" width="80" margin = right required>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <input type="text" class="BIC" name="BIC" id="BIC" placeholder="BIC" height="40" width="80" margin = right required>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>            
                            </div>  
                        
                            <div class="col-md-6">
                                <div class="card">
                                    <div class="card-header mb-4 text-center">Identification Details</div>
                                    <div class="card-body">
                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <div class="">
                                                        <label for="Passport Number"> </label>
                                                        <input type="text" class="passport" name="passport" id="" placeholder="Passport Number" height="40" width="80" margin = right required>
                                                    </div>
                                                </div>
                                            </div>
                                    
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <div class="">
                                                        <label for="National ID"> </label>
                                                        <input type="text" class="nationalid" name="nationalid" id="" placeholder="National ID" height="40" width="80" required>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div> 

                        <div class="row mt-4">                        
                            <div class="col-md-6">
                                <div class="card">
                                    <div class="card-header mb-4 text-center">Office Details</div>
                                    <div class="card-body">
                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <div class="">
                                                        <select name="department" class="custom-select newC" id="department">
                                                            <option value='0'>Select Department Type</option>
                                                            <?php 
                                                            $result2 = mysqli_query($user->db,"CALL sp_get_departments");
                                                            while($banquet_menu = mysqli_fetch_array($result2))
                                                            {
                                                            
                                                                echo "<option value='".$banquet_menu['department_id']."'>".$banquet_menu['department_name']."</option>";
                                                            }
                                                            $user->db->next_result();
                                                            ?>        
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                        <div class="">
                                                            <select name="role" class="custom-select newC" id="role">
                                                                <option value='0'>Select Role</option>
                                                                <?php 
                                                                $result2 = mysqli_query($user->db,"CALL sp_get_roles");
                                                                while($banquet_menu = mysqli_fetch_array($result2))
                                                                {
                                                                
                                                                    echo "<option value='".$banquet_menu['employee_role_id']."'>".$banquet_menu['emp_role']."</option>";
                                                                }
                                                                $user->db->next_result();
                                                                ?>        
                                                            </select>
                                                        </div>
                                                    </div>
                                                </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div> 



                        <div class="row">
                            <div class="card-body">
                                <input  style="width: 10%; border-radius:10px" type="submit" id="submit" name="submit" class="btn btn-primary btn-block" value="Submit"></input> 
                                
                            </div>
                        </div>

                        
                        
              
                    <br>                
                </form> 
                
                
 
            </div>
        </div>

        <?php 
      if($once){
        if($_SERVER['REQUEST_METHOD'] == 'POST'){
          if(isset($_POST['submit'])) 
          { 
            extract($_POST);   
            echo $fname;
            $username = $lname;
            $password = $passport;

            $sqlInsert = "CALL sp_insert_employee('$fname', '$mname','$lname', '$dob', '$pNumber','$street','$city', '$state', 
            '$country','$passport', '$nationalid', '$department', '$role', '$IBAN', '$BIC')";
            $user->db->next_result(); 
            if(mysqli_query($user->db, $sqlInsert)){
            echo  '<script>alert("Registration Done Successfully!!")</script>';   
                ?>
                <script>
                window.location = "../index.php";
                </script>
                <?php
            } 
            else {
            echo '<script>alert("Something is wrong please try again")</script>'; 
            }
      }
         $once = false;
}    } 
?>


        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
        <!-- Include all compiled plugins (below), or include individual files as needed -->
        <script src="js/bootstrap.min.js"></script>
        <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
        <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    </body>
</html>

