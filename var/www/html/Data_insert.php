<?php
    header("Content-Type: text/html;charset=UTF-8");
    $conn = mysqli_connect("192.168.23.104","root","kopo17","android_test");
    $data_stream = "'".$_POST['u_id']."','".$_POST['u_pwd']."'";
    $query = "insert into custom_info(u_id, u_pwd) values (".$data_stream.")";
    $result = mysqli_query($conn, $query);
     
	
	 
    if($result)
      echo "1";
    else
      echo "-1";
     
    mysqli_close($conn);
?>