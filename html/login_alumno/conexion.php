<?php
    $i = $_REQUEST['i'];
    $p = $_REQUEST['p'];

    $cnx = mysqli_connect("localhost", "root", "31delfinZYTO!", "syllabus") or die("Fallo en la conexión con el servidor".mysqli_connect_error());

    $result = mysqli_fetch_array(mysqli_query($cnx, "select cred from cred_a where id_alumno = $i"));

    echo $result['cred'];

    mysqli_close($cnx);
?>  