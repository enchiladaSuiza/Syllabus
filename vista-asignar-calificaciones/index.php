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

    <main class="flex_col">
        <?php
            $connex = mysqli_connect("localhost", "root", "", "syllabus") or die("Conexión fallida: ".mysqli_connect_error());

            $id_materia = 1;

            $query_nombre = "SELECT nombre FROM materia WHERE id_materia = $id_materia;";

            $resultado_nombre = mysqli_fetch_array(mysqli_query($connex, $query_nombre));
            
            $nombre_materia = $resultado_nombre['nombre'];

            $id_alumno = $_POST['mandar_id'];

            $query_alumno = "SELECT * FROM alumno WHERE id_alumno = $id_alumno;";

            $resultado_alumno = mysqli_fetch_array(mysqli_query($connex, $query_alumno));

            echo "<section id=\"carta_inicio\" class=\"carta\">";
            echo "<h1 id=\"nombre_materia\">$nombre_materia</h1>";
            echo "<h2 id=\"nombre_alumno\">".$resultado_alumno['apellido_p']." ".$resultado_alumno['apellido_m']." ".$resultado_alumno['nombre']."</h2>";
            echo "<h2 id=\"id_alumno\">$id_alumno</h2>";
            echo "</section>";

            echo "<section class=\"carta parcial flex_col\">";
            echo "<h1 class=\"titulo_parcial\">Primer Parcial</h1>";
            echo "<div class=\"flex_row\">";
            echo "<label class=\"etiqueta_para_texto\" for=\"calif_1p\">Calificación</label>"; 
            echo "<input class=\"campo_de_texto\" name=\"calif_1p\" type=\"text\">";
            echo "<a class=\"boton_regular boton_asignar\">Asignar</a>";
            echo "</div>";
            echo "</section>";

            echo "<section class=\"carta parcial flex_col\">";
            echo "<h1 class=\"titulo_parcial\">Segundo Parcial</h1>";
            echo "<div class=\"flex_row\">";
            echo "<label class=\"etiqueta_para_texto\" for=\"calif_2p\">Calificación</label>"; 
            echo "<input class=\"campo_de_texto\" name=\"calif_2p\" type=\"text\">";
            echo "<a class=\"boton_regular boton_asignar\">Asignar</a>";
            echo "</div>";
            echo "</section>";

            echo "<section class=\"carta parcial flex_col\">";
            echo "<h1 class=\"titulo_parcial\">Ordinario Parcial</h1>";
            echo "<div class=\"flex_row\">";
            echo "<label class=\"etiqueta_para_texto\" for=\"calif_3p\">Calificación</label>"; 
            echo "<input class=\"campo_de_texto\" name=\"calif_3p\" type=\"text\">";
            echo "<a class=\"boton_regular boton_asignar\">Asignar</a>";
            echo "</div>";
            echo "</section>";
        ?>
    </main>
</body>
</html>