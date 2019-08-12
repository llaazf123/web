	<?php 

    error_reporting(E_ALL); 
    ini_set('display_errors',1); 

    include('dbcon.php');


    if( ($_SERVER['REQUEST_METHOD'] == 'POST') && isset($_POST['submit']))
    {

        $u_id=$_POST['u_id'];
        $u_pwd=$_POST['u_pwd'];

        if(empty($u_id)){
            $errMSG = "이름을 입력하세요.";
        }
        else if(empty($u_pwd)){
            $errMSG = "비밀번호를 입력하세요.";
        }

        if(!isset($errMSG))
        {
            try{
                $stmt = $con->prepare('INSERT INTO custom_info(u_id, u_pwd) VALUES(:u_id, :u_pwd)');
                $stmt->bindParam(':u_id', $u_id);
                $stmt->bindParam(':u_pwd', $u_pwd);

                if($stmt->execute())
                {
                    $successMSG = "새로운 사용자를 추가했습니다.";
                }
                else
                {
                    $errMSG = "사용자 추가 에러";
                }

            } catch(PDOException $e) {
                die("Database error: " . $e->getMessage()); 
            }
        }

    }
?>
<?php 
    if (isset($errMSG)) echo $errMSG;
    if (isset($successMSG)) echo $successMSG;

	$android = strpos($_SERVER['HTTP_USER_AGENT'], "Android");
   
    if( !$android )
    {
?>


<html>
   <body>
        <?php 
        if (isset($errMSG)) echo $errMSG;
        if (isset($successMSG)) echo $successMSG;
        ?>
        
        <form action="<?php $_PHP_SELF ?>" method="POST">
            u_id: <input type = "text" name = "u_id" />
            u_pwd: <input type = "text" name = "u_pwd" />
            <input type = "submit" name = "submit" />
        </form>
   
   </body>
</html>



<?php 
    }
?>
