<?php  
 
$link=mysqli_connect("192.168.23.104", "root", "kopo17", "android_test");  
if (!$link)
{  
    echo "MySQL 접속 에러 : ";
    echo mysqli_connect_error();
    exit();  
}  
 
mysqli_set_charset($link,"utf8"); 
 
$sql="select * from custom_info";
 
$result=mysqli_query($link,$sql);
$data = array();   
if($result){  
    
    while($row=mysqli_fetch_array($result)){
        array_push($data, 
            array('ID'=>$row[0], 'Password'=>$row[1])
         );
    }
 
    header('Content-Type: application/json; charset=utf8');
$json = json_encode(array("results"=>$data), JSON_PRETTY_PRINT+JSON_UNESCAPED_UNICODE);
echo $json;
 
}  
else{  
    echo "SQL문 처리중 에러 발생 : "; 
    echo mysqli_error($link);
} 

mysqli_close($link); 
   
?>