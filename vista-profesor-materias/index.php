<!DOCTYPE html>
<html lang="es">
    <head>
        <title>
        	Profesor No.: 
                <?php 
                    $id_profesor = $_POST['id_profesor'];
                    echo $id_profesor;
                ?>
        </title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="./estilo.css"/>
        <script src="addLinks.js"></script>
    </head>
    
    <body>
        <header>
            <a href="../" target="_self" id="salir">Salir</a>
        </header>
        <div id="content">
            <p id="title">Syllabus Profesor</p>
            <p id="infoContacto">
                <?php
                    $cnx = mysqli_connect("localhost","root","","syllabus") or die("No se pudo conectar al servidor");
                    
                    $infor_profe = mysqli_query($cnx, "select * from profesor where id_profesor = $id_profesor");
                    
                    $v = mysqli_fetch_array($infor_profe);
                    
                    echo "Cuenta de profesor: " . $id_profesor . "<br><br>";
                    echo "Correo institucional: " . $v['correo']; 
                ?>
            </p>
            <p id="infoProfe">
                <?php
                    echo "Profesor: " . $v['nombre'] . " " . $v['apellido_p'] . " " . $v['apellido_m'] . "<br><br>";
                ?>
            </p>
            <div id="listMatBack" class="back animar"></div>
            <table id="listMat">
                <tr>
                    <td class="title"><b>Materia Impartida</b></td>
                    <td class="title"><b>Semestre</b></td>
                </tr>
                <?php                        
                    $sql = "select m.id_materia, m.nombre, m.no_semestre from profesor as p, materia as m " .
                    "where m.id_profesor = p.id_profesor and p.id_profesor = $id_profesor";
                        
                    $resultSet = mysqli_query($cnx, $sql);
                        
                    $no_mat = 1;
                    while ($row = mysqli_fetch_array($resultSet)) {
                        echo "<tr>";
                        echo "<td class='cell'>";
                        echo "<form method='post' action='../vista-alumnos-materia/'>";
                        echo "<button id='m$no_mat' name='materia'>" . $row['nombre'] . "</button>";
                        echo "<input type='text' name='id_materia' value='".$row['id_materia']."' hidden>";
                        echo "</form>";
                        echo "</td>";
                        echo "<td class='cell'>" . $row['no_semestre'] . "° Semestre </td>";
                        echo "</tr>";
                        $no_mat ++;
                    }
                        
                    mysqli_close($cnx);
                ?>
            </table>
        </div>
    </body>
</html>
