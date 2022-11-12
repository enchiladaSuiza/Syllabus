<!DOCTYPE html>
<html lang="es">
    <head>
        <title>
        	Cuenta de alumno: 
                <?php 
                    $id_alumno = $_POST['id_alumno'];
                    echo $id_alumno;
                ?>
        </title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="estilo.css"/>
    </head>
    <body>
        <header>
            <a href="../" target="_self" id="salir">Salir</a>
        </header>
        <div id="content">
            <p id="title">Syllabus Alumno</p>
            <p id="infoContacto">
                <?php
                    $cnx = mysqli_connect("localhost","root","31delfinZYTO!","syllabus") or die("No se pudo conectar al servidor");
                    
                    $info_alum = mysqli_query($cnx, "select * from alumno where id_alumno = $id_alumno");
                    
                    $v = mysqli_fetch_array($info_alum);
                    
                    echo "Cuenta de alumno: " . $id_alumno . "<br><br>";
                    echo "Correo institucional: " . $v['correo']; 
                ?>
            </p>
            <p id="infoAlumno">
                <?php
                    echo "Alumno: " . $v['nombre'] . " " . $v['apellido_p'] . " " . $v['apellido_m'] . "<br><br>";
                    echo "Semestre: " . $v['no_semestre'] . "°<br>";
                ?>
            </p>
            <table id="listMat">
                <tr>
                    <td><b>Materia</b></td>
                    <td><b>Profesor</b></td>
                </tr>
                <?php                
                    // $sem_alumno = 1; // Aqui hay que obtener el semestre del alumno que inició sesión
                    
                    $sem_alumno = mysqli_fetch_array(mysqli_query($cnx, "select no_semestre from alumno where id_alumno = $id_alumno"))['no_semestre'];
                    
                    $sql = "select m.nombre as materia, m.no_semestre, p.nombre, p.apellido_p, " .
                    "p.apellido_m from materia as m, profesor as p where m.no_semestre = $sem_alumno " .
                    "and m.id_profesor = p.id_profesor";
                    
                    $resultSet = mysqli_query($cnx, $sql);
                    
                    while ($row = mysqli_fetch_array($resultSet)) {
                        echo "<tr>";
                        echo "<td style='font-weight: normal'>" . $row['materia'] . " (" . $row['no_semestre'] . "° Sem)</td>";
                        echo "<td>" . $row['nombre'] . " " . $row['apellido_p'] . " " .
                        $row['apellido_m'] . "</td>";
                        echo "</tr>";
                    }
                    
                    mysqli_close($cnx);
                ?>
            </table>
        </div>
    </body>
</html>
