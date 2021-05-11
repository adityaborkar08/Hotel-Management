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

//------------------------------------Conferencce----------------------------------------------//

    $action = $_GET[ 'action' ];
    $conf_type_id = $_GET[ 'conf_type_id'];
    

    if( $conf_type_id ) 
    {
        $result = get_conf_price_by_id( $conf_type_id );
    }
   
     function get_conf_price_by_id($conf_type_id)
                {
                    $db=new mysqli(DB_SERVER,DB_USERNAME,DB_PASSWORD,'hotel');
                    $result= mysqli_query($db,"CALL sp_get_conf_price_by_id($conf_type_id)");
                    $db->next_result(); 
                    if($result){
                    $val = (mysqli_fetch_row($result));
                    echo  $val[0];
                        //  return var_dump((mysqli_fetch_array($result)));
                    }
                    else{
                        return false;
                    } 
                }
//------------------------------------Conferencce----------------------------------------------//



?>



