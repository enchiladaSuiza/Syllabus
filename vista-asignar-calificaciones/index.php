<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Asignar calificaciones</title>
    <link rel="stylesheet" href="../css/estilos.css"/>
    <link rel="stylesheet" href="./calificar.css"/>
</head>
<body>
    <header>
        <nav class="nav_contenedor">
             <div class="nav_menu" id="nav_menu">
                <ul class="nav_lista">
                    <li class="nav_item"><a href="../index.html" class="nav_link">Syllabus</a></li>
                </ul>
             </div>
        </nav>
    </header>

    <main class="flex_row">
        <?php
            $connex = mysqli_connect("localhost", "root", "", "syllabus") or die("Conexión fallida: ".mysqli_connect_error());

            $id_materia = $_POST['mandar_id_materia'];

            $query_nombre = "SELECT nombre FROM materia WHERE id_materia = $id_materia;";

            $resultado_nombre = mysqli_fetch_array(mysqli_query($connex, $query_nombre));
            
            $nombre_materia = $resultado_nombre['nombre'];

            $id_alumno = $_POST['mandar_id_alumno'];

            $query_alumno = "SELECT * FROM alumno WHERE id_alumno = $id_alumno;";

            $resultado_alumno = mysqli_fetch_array(mysqli_query($connex, $query_alumno));

            echo "<div class=\"flex_col\">";
            echo "<section id=\"carta_inicio\" class=\"carta animar\">";
            echo "<h1 id=\"nombre_materia\">$nombre_materia</h1>";
            echo "<h2 id=\"nombre_alumno\">".$resultado_alumno['apellido_p']." ".$resultado_alumno['apellido_m']." ".$resultado_alumno['nombre']."</h2>";
            echo "<h2 id=\"id_alumno\">$id_alumno</h2>";
            echo "</section>";

            if (isset($_POST['calif'])) {
                $id_materia = $_POST['mandar_id_materia'];
                $id_alumno = $_POST['mandar_id_alumno'];
                $calificacion = $_POST['calif'];
                $parcial = $_POST['parcial'];
                $query_asignar = "";
            
                if (isset($_POST['asignar_calif'])) { 
                    $query_asignar = "CALL assignCalif($id_alumno, $id_materia, $calificacion, $parcial);";
                } else { // Actualizar
                    $query_asignar = "CALL changeCal($id_alumno, $id_materia, $parcial, $calificacion);";
                }
                echo "<section id=\"carta_mensaje\" class=\"carta_inicio carta animar\">";
            
                $stmt_asignar = mysqli_query($connex, $query_asignar);
                
                if ($stmt_asignar) {
                    echo "<h2 id=\"mensaje_base\">Calificación asignada correctamente.</h2>";
                } else {
                    echo "<h2 id=\"mensaje_base\">Problema al asignar la calificación.</h2>";
                }
                echo "</section>";

                while (mysqli_next_result($connex)) {
                    mysqli_use_result($connex);
                    mysqli_free_result($stmt_asignar);
                }
            }

            echo "</div>";

            $query_calif_1p = "SELECT readCalif($id_alumno, $id_materia, 1);";
            $calif_1p = mysqli_fetch_array(mysqli_query($connex, $query_calif_1p));

            echo "<div class=\"flex_col\">";
            echo "<section class=\"carta parcial flex_col animar retardo-1\">";
            echo "<h1 class=\"titulo_parcial\">Primer Parcial</h1>";
            echo "<form action=\"index.php\" method=\"POST\" class=\"flex_row\">";
            echo "<label class=\"etiqueta_para_texto\" for=\"calif\">Calificación</label>"; 
            echo "<input class=\"campo_de_texto\" name=\"calif\" type=\"text\" value=\"$calif_1p[0]\">";
            if (is_null($calif_1p[0])) {
                echo "<input name=\"asignar_calif\" type=\"submit\" class=\"boton_regular boton_asignar\" value=\"Asignar\">";
            } else {
                echo "<input name=\"actualizar_calif\" type=\"submit\" class=\"boton_regular boton_asignar\" value=\"Asignar\">";
            }
            echo "<input name=\"parcial\" value=\"1\" hidden>";
            echo "<input type=\"text\" name=\"mandar_id_materia\" value=\"$id_materia\" hidden>";
            echo "<input type=\"text\" name=\"mandar_id_alumno\" value=\"$id_alumno\" hidden>";
            echo "</form>";
            echo "</section>";

            $query_calif_2p = "SELECT readCalif($id_alumno, $id_materia, 2);";
            $calif_2p = mysqli_fetch_array(mysqli_query($connex, $query_calif_2p));
            echo "<section class=\"carta parcial flex_col animar retardo-2\">";
            echo "<h1 class=\"titulo_parcial\">Segundo Parcial</h1>";
            echo "<form action=\"index.php\" method=\"POST\" class=\"flex_row\">";
            echo "<label class=\"etiqueta_para_texto\" for=\"calif\">Calificación</label>"; 
            echo "<input class=\"campo_de_texto\" name=\"calif\" type=\"text\" value=\"$calif_2p[0]\">";
            if (is_null($calif_2p[0])) {
                echo "<input name=\"asignar_calif\" type=\"submit\" class=\"boton_regular boton_asignar\" value=\"Asignar\">";
            } else {
                echo "<input name=\"actualizar_calif\" type=\"submit\" class=\"boton_regular boton_asignar\" value=\"Asignar\">";
            }
            echo "<input name=\"parcial\" value=\"2\" hidden>";
            echo "<input type=\"text\" name=\"mandar_id_materia\" value=\"$id_materia\" hidden>";
            echo "<input type=\"text\" name=\"mandar_id_alumno\" value=\"$id_alumno\" hidden>";
            echo "</form>";
            echo "</section>";

            $query_calif_3p = "SELECT readCalif($id_alumno, $id_materia, 3);";
            $calif_3p = mysqli_fetch_array(mysqli_query($connex, $query_calif_3p));
            echo "<section class=\"carta parcial flex_col animar retardo-3\">";
            echo "<h1 class=\"titulo_parcial\">Ordinario</h1>";
            echo "<form action=\"index.php\" method=\"POST\" class=\"flex_row\">";
            echo "<label class=\"etiqueta_para_texto\" for=\"calif\">Calificación</label>";
            echo "<input class=\"campo_de_texto\" name=\"calif\" type=\"text\" value=\"$calif_3p[0]\">";
            if (is_null($calif_3p[0])) {
                echo "<input name=\"asignar_calif\" type=\"submit\" class=\"boton_regular boton_asignar\" value=\"Asignar\">";
            } else {
                echo "<input name=\"actualizar_calif\" type=\"submit\" class=\"boton_regular boton_asignar\" value=\"Asignar\">";
            }
            echo "<input name=\"parcial\" value=\"3\" hidden>";
            echo "<input type=\"text\" name=\"mandar_id_materia\" value=\"$id_materia\" hidden>";
            echo "<input type=\"text\" name=\"mandar_id_alumno\" value=\"$id_alumno\" hidden>";
            echo "</form>";
            echo "</section>";
            echo "</div>";

            mysqli_close($connex);
        ?>
    </main>
</body>
</html>
