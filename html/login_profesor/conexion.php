<?php
    $i = $_REQUEST['i'];
    $p = $_REQUEST['p'];

    $cnx = mysqli_connect("localhost", "root", "", "syllabus") or die("Fallo en la conexión con el servidor".mysqli_connect_error());

    $result = mysqli_fetch_array(mysqli_query($cnx, "select cred from cred_p where id_profesor = $i"));

    echo $result['cred'];

    mysqli_close($cnx);
?>  
