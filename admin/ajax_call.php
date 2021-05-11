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

//------------------------------------Banquet----------------------------------------------//

    $action = $_GET[ 'action' ];
    $banquet_capacity_price_id = $_GET[ 'banquet_capacity_price_id'];
    

    if( $banquet_capacity_price_id ) 
    {
        $result = get_banquet_capacity_price_by_id( $banquet_capacity_price_id );
    }
   
     function get_banquet_capacity_price_by_id($banquet_capacity_price_id)
                {
                    $db=new mysqli(DB_SERVER,DB_USERNAME,DB_PASSWORD,'hotel');
                    $result= mysqli_query($db,"CALL sp_get_banquet_capacity_price_by_id($banquet_capacity_price_id)");
                    $db->next_result(); 
                    // $result = mysqli_query($db,"SELECT banquet_capacity_price
                    // FROM t_banquet_capacity_price
                    // WHERE banquet_capacity_price_id = $banquet_capacity_price_id
                    // AND is_active = 1");
                    if($result){
                    $val = (mysqli_fetch_row($result));
                    echo  $val[0];
                        //  return var_dump((mysqli_fetch_array($result)));
                    }else{
                        return false;
                    } 
                }
//------------------------------------Banquet----------------------------------------------//



?>



