
var tablaMostrada = document.getElementById("tablaMostrada").innerHTML;

rellenarTabla();

/*
 Función para cambiar de tabla y obtener la lista con sus artículos, la quito de momento
function cambiarTabla(nombreTabla) {
    document.getElementById(tablaMostrada).classList.remove("active");

    tablaMostrada = nombreTabla;

    document.getElementById(nombreTabla).classList.add("active");

    rellenarTabla();


}
*/

function rellenarTabla() {
    var datos;

    var xhr = new XMLHttpRequest();
    xhr.open('GET', `RellenarTabla?tabla=${tablaMostrada}`, true);
    xhr.onreadystatechange = function () {
        if (xhr.readyState === XMLHttpRequest.DONE && xhr.status === 200) {
            var respuesta = xhr.responseText;
            datos = JSON.parse(respuesta);
            mostrarTabla(datos);
        }
    };
    xhr.send();

}

function mostrarTabla(datos) {
    if (document.getElementById("tabla").classList.contains("dataTable")) {
        $("#tabla").DataTable().destroy();
    }
    $("#tabla").empty();

    switch (tablaMostrada) {

        case "Serie":
            break;

        case "Figura":
            var claves = [
                "Id",
                "Primera Imagen",
                "Segunda Imagen",
                "Tercera Imagen",
                "Personaje",
                "Nombre",
                "Descripción",
                "Fecha de salida",
                "Precio",
                "Stock",
                "Altura",
                "Descuento",
                "Proveedor",
                "Material"
            ];
            var contador = 0;

            var cabecera = "<thead><tr>";
            claves.forEach(clave => (cabecera += "<th>" + clave + "</th>"));
            cabecera += "<th>Acciones</th></tr></thead><tbody>";
            $("#tabla").append(cabecera);

            datos.forEach(function (fila) {
                var filaHtml = "<tr>";
                claves.forEach(function (clave) {
                    if (clave === "Descripción") {
                        // Agregar botón para abrir el modal con la descripción
                        filaHtml +=
                                '<td><button type="button" class="descripcionFigura" data-contador="' + contador + '"data-toggle="modal" data-target="#modalDescripcionFigura">Ver descripción</button>';

                    } else if (clave === "Descuento") {
                        // Agregar el símbolo de porcentaje al valor de descuento
                        filaHtml += "<td>" + fila[clave] + "%</td>";
                    } else if (clave === "Primera Imagen" || clave === "Segunda Imagen" || clave === "Tercera Imagen") {
                        // Obtener la URL de la imagen
                        var imagenUrl = fila[clave];
                        // Generar la etiqueta de imagen con la URL correspondiente
                        var imagenHtml =
                                "<img src='assets/images/figuras/" +
                                imagenUrl +
                                "' alt='Imagen' width='100px'>";
                        // Agregar la etiqueta de imagen a la celda de la tabla
                        filaHtml += "<td>" + imagenHtml + "</td>";
                    } else if (clave === "Precio") {
                        filaHtml += "<td>" + fila[clave] + " €</td>";

                    } else if (clave === "Altura") {
                        filaHtml += "<td>" + fila[clave] + " cm</td>";

                    } else {
                        filaHtml += "<td>" + fila[clave] + "</td>";
                    }
                });
                // Agregar botones de modificar y eliminar
                filaHtml +=
                        '<td><button type="button" class="modificarFigura mb-3 p-2" data-contador="' + contador + '"data-toggle="modal" data-target="#modalModificarFigura">Modificar</button>';



                filaHtml +=
                        '<button type="button" class="eliminarFigura p-2" data-contador="' + contador + '"data-toggle="modal" data-target="#modalEliminarFigura">Eliminar</button></td>';
                filaHtml += "</tr></tbody>";
                $("#tabla").append(filaHtml);


                contador++;
            });



            // Inicializar el DataTable después de agregar los datos a la tabla
            if (!$('#tabla').hasClass('dataTable')) {
                $('#tabla').DataTable({
                    "language": {
                        "search": "Buscar:",
                        "searchPlaceholder": "Ingrese término a buscar",
                        "lengthMenu": "Mostrar _MENU_ figuras",
                        "info": "Mostrando de la figura _START_ a la figura _END_ de un total de _TOTAL_ figuras",
                        "infoEmpty": "No se encontraron registros",
                        "infoFiltered": "(filtrado de _MAX_ registros en total)",
                        "zeroRecords": "No se encontraron registros coincidentes",
                        "paginate": {
                            "first": "Primero",
                            "last": "Último",
                            "next": "Siguiente",
                            "previous": "Anterior"
                        },
                        "aria": {
                            "sortAscending": ": activar para ordenar la columna en orden ascendente",
                            "sortDescending":
                                    ": activar para ordenar la columna en orden descendente"
                        }
                    }
                });
            }



            //Modal de la descripción las figuras
            $('#tabla').on('click', '.descripcionFigura', function () {
                // Obtener los datos de la fila seleccionada

                var contador = $(this).data("contador");

                // Obtener los valores de los campos del comentario
                var descripcion = datos[contador].Descripción;
                var nombre = datos[contador].Nombre;
                // Mostrar el modal de edición de comentario con los datos
                mostrarModalDescripcionFigura(descripcion, nombre);
            });


            //Modal de la eliminar la figura
            $('#tabla').on('click', '.eliminarFigura', function () {
                // Obtener los datos de la fila seleccionada

                var contador = $(this).data("contador");

                var id = datos[contador].Id;
                var nombre = datos[contador].Nombre;
                // Mostrar el modal de edición de comentario con los datos
                mostrarModalEliminarFigura(id, nombre);
            });

            //Modal de modificar figura
            $('#tabla').on('click', '.modificarFigura', function () {
                // Obtener los datos de la fila seleccionada

                var contador = $(this).data("contador");

                // Obtener los valores de los campos del comentario
                var id = datos[contador].Id;
                var nombre = datos[contador].Nombre;
                var descripcion = datos[contador].Descripción;
                var personaje = datos[contador].Personaje;
                var proveedor = datos[contador].Proveedor;
                var material = datos[contador].Material;
                var precio = datos[contador].Precio;
                var altura = datos[contador].Altura;
                var descuento = datos[contador].Descuento;
                var fechaSalida = datos[contador]["Fecha de salida"];

                var stock = datos[contador].Stock;
                var primeraImagen = datos[contador]["Primera Imagen"];

                var segundaImagen = datos[contador]["Segunda Imagen"];

                var terceraImagen = datos[contador]["Tercera Imagen"];

                var personajes = datos[contador].Personajes;
                var materiales = datos[contador].Materiales;
                var proveedores = datos[contador].Proveedores;

                mostrarModalModificarFigura(id, nombre, descripcion, personaje, proveedor, material, precio, altura,
                        descuento, fechaSalida, stock, primeraImagen, segundaImagen, terceraImagen, personajes, materiales, proveedores);
            });
            personajesGlobal = datos[0].Personajes;
            proveedoresGlobal = datos[0].Proveedores;
            materialesGlobal = datos[0].Materiales;






            break;
    }
}


//Listener para que cuando se clicke en añadir figura abra su modal con los selects cargados
$('#anadirFigura').on('click', function () {
    var selectPersonajes = $('#figuraPersonajeAdd');
    var selectProveedores = $('#figuraProveedorAdd');
    var selectMateriales = $('#figuraMaterialAdd');
    selectPersonajes.empty();
    selectProveedores.empty();
    selectMateriales.empty();
    for (var i = 0; i < personajesGlobal.length; i++) {
        var option = $("<option></option>").text(personajesGlobal[i].nombre).val(personajesGlobal[i].nombre);
        selectPersonajes.append(option);
    }

    for (var i = 0; i < proveedoresGlobal.length; i++) {
        var option = $("<option></option>").text(proveedoresGlobal[i].nombre).val(proveedoresGlobal[i].nombre);
        selectProveedores.append(option);
    }

    for (var i = 0; i < materialesGlobal.length; i++) {
        var option = $("<option></option>").text(materialesGlobal[i].nombre).val(materialesGlobal[i].nombre);
        selectMateriales.append(option);
    }
    $('#modalAnadirFigura').modal('show');
});

function mostrarModalDescripcionFigura(descripcion, nombre) {
    $('#figuraDescripcionModal').text(descripcion);
    $('#figuraNombreModal').text(nombre);
    $('#modalDescripcionFigura').modal('show');
}


function mostrarModalEliminarFigura(id, nombre) {
    $('#figuraIdBorrar').val(id);
    $('#figuraNombreBorrar').val(nombre);
    $('#modalEliminarFigura').modal('show');


}

// Función para mostrar el modal de editar los comentarios
function mostrarModalModificarFigura(id, nombre, descripcion, personaje, proveedor, material, precio, altura,
        descuento, fechaSalida, stock, primeraImagen, segundaImagen, terceraImagen, personajes, materiales, proveedores) {
    // Rellenar los campos del modal con los datos del comentario
    $('#figuraId').val(id);
    $('#figuraNombre').val(nombre);
    $('#figuraDescripcion').val(descripcion);
    $('#figuraPrecio').val(precio);
    $('#figuraAltura').val(altura);
    $('#figuraDescuento').val(descuento);


    var fecha = new Date(fechaSalida);

    var anio = fecha.getFullYear();
    var mes = ("0" + (fecha.getMonth() + 1)).slice(-2);
    var dia = ("0" + fecha.getDate()).slice(-2);

    var fechaFormateada = anio + "-" + mes + "-" + dia;

    $("#figuraFecha").val(fechaFormateada);



    $('#figuraStock').val(stock);
    $("#figuraImagen1Old").attr("src", "assets/images/figuras/" + primeraImagen);
    $("#figuraImagen2Old").attr("src", "assets/images/figuras/" + segundaImagen);
    $("#figuraImagen3Old").attr("src", "assets/images/figuras/" + terceraImagen);

    var selectPersonajes = $('#figuraPersonaje');
    var selectProveedores = $('#figuraProveedor');
    var selectMateriales = $('#figuraMaterial');

//Vaciamos los select de personaje
    selectPersonajes.empty();
    selectProveedores.empty();
    selectMateriales.empty();

    for (var i = 0; i < personajes.length; i++) {
        var option = $("<option></option>").text(personajes[i].nombre).val(personajes[i].nombre);

        if (personajes[i].nombre === personaje) {
            option.attr("selected", "selected");
        }

        selectPersonajes.append(option);
    }

    for (var i = 0; i < proveedores.length; i++) {
        var option = $("<option></option>").text(proveedores[i].nombre).val(proveedores[i].nombre);

        if (proveedores[i].nombre === proveedor) {
            option.attr("selected", "selected");
        }

        selectProveedores.append(option);
    }
    for (var i = 0; i < materiales.length; i++) {
        var option = $("<option></option>").text(materiales[i].nombre).val(materiales[i].nombre);

        if (materiales[i].nombre === material) {
            option.attr("selected", "selected");
        }

        selectMateriales.append(option);
    }


    // Abrir el modal para editar
    $('#modalModificarFigura').modal('show');
}


