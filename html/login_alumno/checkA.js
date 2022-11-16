window.onload = () => {
	document.getElementById('enter').addEventListener('click', enterPressed, false);
}

let conexion;

function enterPressed(e) {
	let i = document.getElementById('id_alumno').value;
	let p = document.getElementById('nip').value;

	e.preventDefault();
	let url = `conexion.php?i=${i}&p='${p}'`;
	check(url);
}

function check(u) {
	conexion = new XMLHttpRequest();
	conexion.onreadystatechange = openSyllabus;
	conexion.open("GET", u, true);
	conexion.send();
}

// let syllabus;
function openSyllabus() {
	if (conexion.readyState === XMLHttpRequest.DONE) {
		let res = conexion.responseText;
		let passw = document.getElementById('nip').value;
		res = Number(res);
		passw = Number(passw);

		if (res == passw) {
			// syllabus = new XMLHttpRequest();
			// syllabus.onreadystatechange = openNW;
			// syllabus.open("POST", "../vista-alumno/", true);
			// syllabus.send(`<input type='text' name='id_alumno' value'${res}' hidden>`);

			let form = document.getElementById('carta_login_alumno_contenido');
			form.method = "post";
			form.action = "../../vista-alumno/";
			console.log(form);
			form.submit();
		} else {
			alert("Datos de acceso incorrectos!");
			console.log("No entro");
		}
	}
}

/*function openNW() {
	if (syllabus.readyState === XMLHttpRequest.DONE) {
		let nw = window.open("../vista-alumno/", "_self");
	}
}*/
