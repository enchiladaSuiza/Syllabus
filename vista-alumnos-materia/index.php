<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Alumnos</title>
    <link rel="stylesheet" href="../css/estilos.css"/>
    <link rel="stylesheet" href="./alumnos.css"/>
    <script defer src="alumnos.js"></script>
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

    <main>
        <section class="carta animar" id="alumnos-grid">
            <h1 id="nombre-materia">
                <?php
                    $connex = mysqli_connect("localhost", "root", "", "syllabus") or die("Conexión fallida: ".mysqli_connect_error());

                    $id_materia = $_POST['id_materia'];

                    $query_nombre = "SELECT nombre FROM materia WHERE id_materia = $id_materia;";
                    $resultado_nombre = mysqli_fetch_array(mysqli_query($connex, $query_nombre));

                    $nombre_materia = $resultado_nombre['nombre'];

                    echo "$nombre_materia";

                    $query_alumnos = "SELECT alumno.* FROM alumno JOIN materia ON materia.id_materia = $id_materia AND alumno.no_semestre = materia.no_semestre;";

                    $resultado_alumnos = mysqli_query($connex, $query_alumnos);
                    
                ?>
            </h1>
            <p id="alumnos-inscritos">
                Alumnos inscritos:
                <u id="numero-alumnos">
                    <?php
                        $num_alumnos = mysqli_num_rows($resultado_alumnos);
                        echo "$num_alumnos";
                    ?>
                </u>
            </p>
            <h2 class="subtitulo" id="numero-cuenta">No. de cuenta</h2>
            <h2 class="subtitulo" id="nombre">Nombre</h2>
            <h2 class="subtitulo" id="apellido-paterno">Apellido parterno</h2>
            <h2 class="subtitulo" id="apellido-materno">Apellido materno</h2>
            <h2 class="subtitulo" id="correo">Correo electrónico</h2>
            <?php
                $fila = 4;
                $numeros_de_cuenta = [];
                $indice = 0;
                while ($alumno = mysqli_fetch_array($resultado_alumnos)) {
                    array_push($numeros_de_cuenta, $alumno['id_alumno']);

                    echo "<p name=\"".$alumno['id_alumno']."\" class=\"tupla\" style=\"grid-row: $fila; grid-column: 1\">".$alumno['id_alumno']."</p>\n";
                    echo "<p class=\"tupla\" style=\"grid-row: $fila; grid-column: 2\">".$alumno['nombre']."</p>\n";
                    echo "<p class=\"tupla\" style=\"grid-row: $fila; grid-column: 3\">".$alumno['apellido_p']."</p>\n";
                    echo "<p class=\"tupla\" style=\"grid-row: $fila; grid-column: 4\">".$alumno['apellido_m']."</p>\n";
                    echo "<p class=\"tupla\" style=\"grid-row: $fila; grid-column: 5\">".$alumno['correo']."</p>\n";

                    echo "<form style=\"grid-row: $fila; grid-column: 6\" class=\"flex_col\" method=\"post\" action=\"../vista-asignar-calificaciones/\">";
                    echo "<button class=\"boton_regular boton_calificar\" onclick=\"calificar(".$alumno['id_alumno'].")\">Calificar</button>";
                    echo "<input type=\"text\" name=\"mandar_id_alumno\" value=\"".$alumno['id_alumno']."\" hidden>";
                    echo "<input type=\"text\" name=\"mandar_id_materia\" value=\"".$id_materia."\" hidden>";
                    echo "</form>";

                    $fila++;
                }

                mysqli_close($connex);
            ?>
            <script src="alumnos.js"></script>
            <h2></h2>
        </section>
    </main>
</body>
</html>
