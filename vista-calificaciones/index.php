<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Calificaciones - Alumno</title>
        <link rel="stylesheet" href="estilo.css">
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
            <section class="carta">
                <h1>
                    <?php
                        $cnx = mysqli_connect("localhost", "root", "", "syllabus") or die("Conexión fallida al servidor: ".mysqli_connect_error());

                        $id_materia = $_POST['mandar_id_materia'];
                        $query_nombre = "SELECT nombre FROM materia WHERE id_materia = $id_materia;";
                        $resultado_nombre = mysqli_fetch_array(mysqli_query($cnx, $query_nombre));
                        $nombre_materia = $resultado_nombre['nombre'];

                        $id_alumno = $_POST['mandar_id_alumno'];
                        $query_alumno = "SELECT * FROM alumno WHERE id_alumno = $id_alumno;";
                        $resultado_alumno = mysqli_fetch_array(mysqli_query($cnx, $query_alumno));
                        
                        echo "$nombre_materia";
                    ?>
                </h1>
                <div class="contenedor_inf">
                    <p>Periodos de evaluación</p><br>
                    <p class="first">Elige un periodo para consultar sus detalles</p>
                    <!-- <div class="contenedor_btn">
                        <a href="" class="boton_regular">Primer Parcial</a>
                        <a href="" class="boton_regular">Segundo Parcial</a>
                        <a href="" class="boton_regular">Ordinario Parcial</a>
                    </div> -->
                    <form action="<?php echo htmlspecialchars($_SERVER['PHP_SELF']) ?>" method="post">
                        <div class="contenedor_btn">
                            <input class="boton_regular" type="submit" value="Primer Parcial" name="pr_p">
                            <input class="boton_regular" type="submit" value="Segundo Parcial" name="sg_p">
                            <input class="boton_regular" type="submit" value="Tercer Parcial" name="tr_p">
                            <input type="text" name="mandar_id_materia" value="<?php echo $id_materia?>" hidden>
                            <input type="text" name="mandar_id_alumno" value="<?php echo $id_alumno?>" hidden>
                        </div>
                    </form>

                    <?php
                        $id_materia = $_POST['mandar_id_materia'];
                        $id_alumno = $_POST['mandar_id_alumno'];
                        if (isset($_POST['pr_p'])) {
                            $query_calif = "SELECT readCalif($id_alumno, $id_materia, 1);";
                            $calif_1p = mysqli_fetch_array(mysqli_query($cnx, $query_calif));
                            echo "<p class='first'>Calificación 1er parcial: " . "$calif_1p[0]" . "</p>";
                        } else if (isset($_POST['sg_p'])) {
                            $query_calif = "SELECT readCalif($id_alumno, $id_materia, 2);";
                            $calif = mysqli_fetch_array(mysqli_query($cnx, $query_calif));
                            echo "<p class='first'>Calificación 2do parcial: " . "$calif[0]" . "</p>";
                        } else if (isset($_POST['tr_p'])) {
                            $query_calif = "SELECT readCalif($id_alumno, $id_materia, 3);";
                            $calif = mysqli_fetch_array(mysqli_query($cnx, $query_calif));
                            echo "<p class='first'>Calificación 3er parcial: " . "$calif[0]" . "</p>";
                        }
                    ?>

                    <?php
                        /*$calif_mat = "SELECT calificacion FROM calificacion WHERE id_calif = $id_calif;";
                        $res_cal = mysqli_fetch_array(mysqli_query($cnx, $calif_mat));
                        $cal_mat = $res_cal['calificacion'];
                        echo "Calificación: " . "$cal_mat";*/
                    ?>
                    <p>
                    </p>
                </div>
            </section>
        </main>
    </body>
</html>
