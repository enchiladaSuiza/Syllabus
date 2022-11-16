<?php
$connex = mysqli_connect("localhost", "root", "", "syllabus") or die("Conexión fallida: ".mysqli_connect_error());

if (isset($_POST['calif'])) {
    $id_materia = $_POST['mandar_id_materia'];
    $id_alumno = $_POST['mandar_id_alumno'];
    $calificacion = $_POST['calif'];
    $parcial = $_POST['parcial'];
    $query_asignar = "";

    if (isset($_POST['asignar_calif'])) { 
        $query_asignar = "CALL assignCalif($id_alumno, $id_materia, $calificacion, $parcial);";
        echo "Crear";
    } else { // Actualizar
        $query_asignar = "CALL changeCal($id_alumno, $id_materia, $parcial, $calificacion);";
        echo "Actualizar";
    }
    echo "<section id=\"carta_inicio\" class=\"carta\">";

    $stmt_asignar = mysqli_query($connex, $query_asignar);
    
    if ($stmt_asignar) {
        echo "<h2 id=\"mensaje_base\">Calificación asignada correctamente.</h2>";
    } else {
        echo "<h2 id=\"mensaje_base\">Problema al asignar la calificación.</h2>";
    }
    echo "</section>";
}

mysqli_close($connex);
?>