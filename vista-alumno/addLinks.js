window.onload = () => {
    let mat = document.getElementsByName('materia');
    let links = ["http://127.0.0.1"]; // Aqui van los links de las paginas de las vistas de materias

    for (let i = 0; i < mat.length; ++i) {
        mat[i].href = links[i];
        mat[i].target = "_self";
        mat[i].style.color = "black";
    }
}