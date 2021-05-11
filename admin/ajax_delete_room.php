<?php
    include "include/db_config.php";


    $db;
    function __construct()
    {
        $this->db=new mysqli(DB_SERVER,DB_USERNAME,DB_PASSWORD,'hotel');
        if(mysqli_connect_errno())
        {
            echo "Error: Could not connect to database.";
            exit;
        }
    }

//------------------------------------Dashboard Room----------------------------------------------//

    $action = $_GET[ 'action' ];
    $cust_id = $_GET[ 'cust_id'];
    $booking_id = $_GET[ 'booking_id'];


    if( $cust_id ) 
    {
        $result = delete_room_by_booking_id( $booking_id, $cust_id);
    }
   
     function delete_room_by_booking_id($booking_id, $cust_id)
                {
                    $db=new mysqli(DB_SERVER,DB_USERNAME,DB_PASSWORD,'hotel');
                    $result= mysqli_query($db,"CALL sp_delete_booked_rooms_by_booking_id($booking_id, $cust_id)");
                    $db->next_result(); 
                    
                    if($result){
                    
                    $val = (mysqli_fetch_row($result));
                    echo  $val[0];
                        //  return var_dump((mysqli_fetch_array($result)));
                    }else{
                        return false;
                    } 
                }
//------------------------------------Dashboard Room----------------------------------------------//



?>



