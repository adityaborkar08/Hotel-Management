<?php
    include "db_config.php";
        class user
        {
            public $db;
            public function __construct()
            {
                $this->db=new mysqli(DB_SERVER,DB_USERNAME,DB_PASSWORD,'hotel');
                if(mysqli_connect_errno())
                {
                    echo "Error: Could not connect to database.";
                    exit;
                }
            }


            // Post Online contact form
            public function post_form($firstname, $lastname, $email, $number, $subject)
            {
                    $sql1="INSERT INTO t_support_online_form SET cust_fname='$firstname', cust_lname='$lastname', cust_email='$email', cust_number='$number', cust_queries='$subject'";
                    $result= mysqli_query($this->db,$sql1) or die(mysqli_connect_errno()."Data cannot inserted".mysqli_error($con));
                    if($result){
                        return $result;
                    }else{
                        return false;
                    }
            }

            //View Restaurants

            public function get_restaurants()
            {
                   $sql="SELECT `restaurant_id`,`restaurant_name`, `restaurant_detail`, `restaurant_mode`, `restaurant_rates`, `restaurant_max_loyalty_points`, `restaurant_open_time`, `restaurant_close_time` FROM `t_restaurants`";
                   $result = mysqli_query($this->db,$sql);
                
                    if($result){
                        return $result;
                    }else{
                        return false;
                    }
            }

            //Show Restaurant Cuisines

            public function get_restaurant_cuisine(){
                $sql="SELECT  `restaurant_id`, `cuisine_type` FROM `t_restaurant_cuisine`";
                   $result = mysqli_query($this->db,$sql);
                
                    if($result){
                        return $result;
                    }else{
                        return false;
                    }
            }

            //book restaurant

            public function post_book_restaurant($rest_id,$checkin,$time,$no_guests){
            
                $combinedDT = date('Y-m-d H:i:s', strtotime("$checkin $time"));
                $sql1="INSERT INTO t_restaurant_booking SET restaurant_id='$rest_id', restaurant_datetime='$combinedDT', restaurant_guests='$no_guests' , is_booked ='0'";
            
                $result= mysqli_query($this->db,$sql1) or die(mysqli_connect_errno()."Data cannot inserted".mysqli_error($con));
               
                if($result){
                    return $result;
                }else{
                    return false;
                }
            }




            public function get_latest_rest_booking(){
                $sql= "SELECT * FROM t_restaurant_booking ORDER BY rest_booking_ID DESC LIMIT 0, 1";
                $result = mysqli_query($this->db,$sql);
                
                    if($result){
                        return $result;
                    }else{
                        return false;
                    }

            }

            //FIRST CHECK IF RESTAURANT IS FULL OR NO
            public function  get_max_booked_count_restaurant($id, $time){
                
                $sql= "SELECT SUM(restaurant_guests) FROM t_restaurant_booking WHERE restaurant_id = '$id' AND restaurant_datetime = '$time' AND is_booked = 1";
                $result = mysqli_query($this->db,$sql);
                
                    if($result){
                        return $result;
                    }else{
                        return false;
                    }
            }


            //available restaurants 

            
            // public function  get_available_restaurants($id, $time){
            //     $sql= "SELECT * from t_restaurant_booking WHERE restaurant_id != $id AND restaurant_datetime = '$time'";
            //     $result = mysqli_query($this->db,$sql);
                
            //         if($result){
            //             return $result;
            //         }else{
            //             return false;
            //         }
            // }

            public function update_restaurant_time($id, $date, $time){
                $combinedDT = date('Y-m-d H:i:s', strtotime("$date $time"));
                $sql= "update t_restaurant_booking SET restaurant_datetime = '$combinedDT' WHERE rest_booking_ID = '$id';";
                $result = mysqli_query($this->db,$sql);
                
                    if($result){
                        return $result;
                    }else{
                        return false;
                    }
            }

                // public function update_restaurant_confirmation($id){
                //     $sql= "update t_restaurant_booking SET is_booked = "1" WHERE rest_booking_ID = '$id';";
                //     $result = mysqli_query($this->db,$sql);
                    
                //         if($result){
                //             return $result;
                //         }else{
                //             return false;
                //         }
                // }


            //Register customer
            // public function register_customer($fname,$lname,$mname,$dob, $custmnumber, $password, $street, $city, $state, $country, $cardnumber, $passport, $nationalid){
            //     $sql1="INSERT INTO `t_customer_personal_data`(`cust_fname`, `cust_mname`, `cust_lname`, `cust_dob`, `cust_phone_number`, `customer_password`) VALUES ('$fname','$mname','$lname','$dob','$custmnumber', '$password')";
            //     $result= mysqli_query($this->db,$sql1) or die(mysqli_connect_errno()."Data cannot inserted".mysqli_error($con));
               
            //     if($result){
            //        $sql2 = "INSERT INTO `t_customer_address`(`cust_id`, `cust_street`, `cust_city`, `cust_state`, `cust_country`) VALUES (`1`,`$street`, `$city`, `$state`, `$country`)";
            //        $result1= mysqli_query($this->db,$sql2) or die(mysqli_connect_errno()."Data cannot inserted".mysqli_error($con));

            //        if($result1){
            //         $sql3 = "INSERT INTO `t_customer_identity_data`(`cust_id`, `cust_passport_number`, `cust_national_id`, `cust_card_details`, ) VALUES (`1`,"$passport","$nationalid","$cardnumber")";
            //         $result2= mysqli_query($this->db,$sql3) or die(mysqli_connect_errno()."Data cannot inserted".mysqli_error($con));
            //     }
            //     if($result1){
            //        return $result;
            //     }else{
            //         return false;
            //     }


            // }




            public function reg_user($name, $username, $password, $email)
            {
                //$password=md5($password);
                $sql="SELECT * FROM manager WHERE uname='$username' OR uemail='$email'";
                $check=$this->db->query($sql);
                $count_row=$check->num_rows;
                if($count_row==0)
                {
                    $sql1="INSERT INTO manager SET uname='$username', upass='$password', fullname='$name', uemail='$email'";
                    $result= mysqli_query($this->db,$sql1) or die(mysqli_connect_errno()."Data cannot inserted");
                    return $result;
                }
                else
                {
                    return false;
                }
            }
            
            
            public function add_room($roomname, $room_qnty, $no_bed, $bedtype,$facility,$price)
            {
                
                    $available=$room_qnty;
                    $booked=0;
                    
                    $sql="INSERT INTO room_category SET roomname='$roomname', available='$available', booked='$booked', room_qnty='$room_qnty', no_bed='$no_bed', bedtype='$bedtype', facility='$facility', price='$price'";
                    $result= mysqli_query($this->db,$sql) or die(mysqli_connect_errno()."Data cannot inserted");
                
                
                    for($i=0;$i<$room_qnty;$i++)
                    {
                        $sql2="INSERT INTO rooms SET room_cat='$roomname', book='false'";
                        mysqli_query($this->db,$sql2);
                        
                    }
                
                    return $result;
                

            }
            
            public function check_available($checkin, $checkout)
            {
                
                
                   $sql="SELECT DISTINCT room_cat FROM rooms WHERE room_id NOT IN (SELECT DISTINCT room_id
                    FROM rooms WHERE (checkin <= '$checkin' AND checkout >='$checkout') OR (checkin >= '$checkin' AND checkin <='$checkout') OR (checkin <= '$checkin' AND checkout >='$checkin') )";
                    $check= mysqli_query($this->db,$sql)  or die(mysqli_connect_errno()."Query Doesnt run");;

                
                    return $check;
                

            }
            
            //deals
            function runQuery($query) {
                $result = mysqli_query($this->db,$query);
                while($row=mysqli_fetch_assoc($result)) {
                    $resultset[] = $row;
                }		
                if(!empty($resultset))
                    return $resultset;
            }
            
            function numRows($query) {
                $result  = mysqli_query($this->db,$query);
                $rowcount = mysqli_num_rows($result);
                return $rowcount;	
            }
            
            
            
            public function booknow($checkin, $checkout, $name, $phone,$roomname)
            {
                    
                    $sql="SELECT * FROM rooms WHERE room_cat='$roomname' AND (room_id NOT IN (SELECT DISTINCT room_id
   FROM rooms WHERE checkin <= '$checkin' AND checkout >='$checkout'))";
                    $check= mysqli_query($this->db,$sql)  or die(mysqli_connect_errno()."Data herecannot inserted");;
                 
                    if(mysqli_num_rows($check) > 0)
                    {
                        $row = mysqli_fetch_array($check);
                        $id=$row['room_id'];
                        
                        $sql2="UPDATE rooms  SET checkin='$checkin', checkout='$checkout', name='$name', phone='$phone', book='true' WHERE room_id=$id";
                         $send=mysqli_query($this->db,$sql2);
                        if($send)
                        {
                            $result="Your Room has been booked!!";
                        }
                        else
                        {
                            $result="Sorry, Internel Error";
                        }
                    }
                    else                       
                    {
                        $result = "No Room Is Available";
                    }
                    
                    
                
                    return $result;
                

            }
            
            
            
            
             public function edit_all_room($checkin, $checkout, $name, $phone,$id)
            {
                                
                        $sql2="UPDATE rooms  SET checkin='$checkin', checkout='$checkout', name='$name', phone='$phone', book='true' WHERE room_id=$id";
                         $send=mysqli_query($this->db,$sql2);
                        if($send)
                        {
                            $result="Your Room has been booked!!";
                        }
                        else
                        {
                            $result="Sorry, Internel Error";
                        }
                    
                
                    return $result;
                

            }
            
            
            
            
            
             public function edit_room_cat($roomname, $room_qnty, $no_bed, $bedtype,$facility,$price,$room_cat)
            {
                    
                 
                        $sql2="DELETE FROM rooms WHERE room_cat='$room_cat'";
                        mysqli_query($this->db,$sql2);
                 
                 
                        for($i=0;$i<$room_qnty;$i++)
                        {
                            $sql3="INSERT INTO rooms SET room_cat='$roomname', book='false'";
                            mysqli_query($this->db,$sql3);

                        }

                 
                        $available=$room_qnty;
                        $booked=0;
                 
                        $sql="UPDATE room_category  SET roomname='$roomname', available='$available', booked='$booked', room_qnty='$room_qnty', no_bed='$no_bed', bedtype='$bedtype', facility='$facility', price='$price' WHERE roomname='$room_cat'";
                         $send=mysqli_query($this->db,$sql);
                        if($send)
                        {
                            $result="Updated Successfully!!";
                        }
                        else
                        {
                            $result="Sorry, Internel Error";
                        }
  
                    
                
                    return $result;
                

            }
            
            
            
            
            
            public function check_login($emailusername,$password)
            {
                //$password=md5($password);
                $sql2="SELECT uid from manager WHERE uemail='$emailusername' OR uname='$emailusername' and upass='$password'";
                $result=mysqli_query($this->db,$sql2);
                $user_data=mysqli_fetch_array($result);
                $count_row=$result->num_rows;
                
                if($count_row==1)
                {
                    $_SESSION['login']=true;
                    $_SESSION['uid']=$user_data['uid'];
                    return true;    
                }
                else
                {
                    return false;
                }
            }



            public function get_session()
            {
                return $_SESSION['login'];
            }
            public function user_logout()
            {
                $_SESSION['login']=false;
                session_destroy();
            }


       
        }

?>