
var tablaMostrada = document.getElementById("tablaMostrada").innerHTML;
rellenarTabla();
var botonAnadir = document.getElementById("anadir");
// Función para cambiar de tabla y obtener la lista con sus artículos, la quito de momento
function cambiarTabla(nombreTabla) {
    document.getElementById(tablaMostrada).classList.remove("active");
    if (nombreTabla === "Pedido") {
        botonAnadir.style.visibility = "hidden";
    } else {
        botonAnadir.style.visibility = "visible";
    }
    botonAnadir.innerHTML = "Añadir " + nombreTabla;
    tablaMostrada = nombreTabla;
    document.getElementById(nombreTabla).classList.add("active");
    rellenarTabla();
}


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

                if (fila.Baja === 0) {
                    filaHtml +=
                            '<button type="button" class="modificarBaja p-2" data-contador="' + contador + '"data-toggle="modal" data-target="#mostrarModalBajaFigura">Dar de Baja</button></td>';
                } else {
                    filaHtml +=
                            '<button type="button" class="modificarBaja p-2" data-contador="' + contador + '"data-toggle="modal" data-target="#mostrarModalBajaFigura">Dar de Alta</button></td>';
                }
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
                var descripcion = datos[contador].Descripción;
                var nombre = datos[contador].Nombre;
                mostrarModalDescripcionFigura(descripcion, nombre);
            });



            //Modal de dar de baja o alta una figura
            $('#tabla').on('click', '.modificarBaja', function () {
                var contador = $(this).data("contador");
                var id = datos[contador].Id;
                var nombre = datos[contador].Nombre;
                var bajaActual = datos[contador].Baja;
                mostrarModalBajaFigura(id, nombre, bajaActual);
            });



            //Modal de modificar figura
            $('#tabla').on('click', '.modificarFigura', function () {
// Obtener los datos de la fila seleccionada

                var contador = $(this).data("contador");
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
        case "Pedido":
            var claves = [
                "Id",
                "Fecha",
                "Comprador",
                "Dirección",
                "Total",
                "Estado",
                "Detalles"
            ];
            var contador = 0;
            var cabecera = "<thead><tr>";
            claves.forEach(clave => (cabecera += "<th>" + clave + "</th>"));
            cabecera += "</tr></thead><tbody>";
            $("#tabla").append(cabecera);
            datos.forEach(function (fila) {
                var filaHtml = "<tr>";
                claves.forEach(function (clave) {
                    if (clave === "Detalles") {
                        // Agregar botón para abrir el modal con la descripción
                        filaHtml +=
                                '<td><button type="button" class="detallesPedido" data-contador="' + contador + '"data-toggle="modal" data-target="#modalDetallesPedido">Ver detalles</button></td>';
                    } else if (clave === "Estado") {
                        var selectHtml = '<select id="Pedido' + fila.Id + '" name="envio" data-contador="' + contador + '" class="selectEnvio">';
                        if (fila[clave] === "Pendiente de envío") {
                            selectHtml += '<option value="Pendiente de envío" selected>Pendiente de envío</option>';
                        } else {
                            selectHtml += '<option value="Pendiente de envío">Pendiente de envío</option>';
                        }

                        if (fila[clave] === "Enviado") {
                            selectHtml += '<option value="Enviado" selected>Enviado</option>';
                        } else {
                            selectHtml += '<option value="Enviado">Enviado</option>';
                        }

                        if (fila[clave] === "Entregado") {
                            selectHtml += '<option value="Entregado" selected>Entregado</option>';
                        } else {
                            selectHtml += '<option value="Entregado">Entregado</option>';
                        }

                        if (fila[clave] === "Cancelado") {
                            selectHtml += '<option value="Cancelado" selected>Cancelado</option>';
                        } else {
                            selectHtml += '<option value="Cancelado">Cancelado</option>';
                        }

                        selectHtml += '</select>';
                        filaHtml += '<td>' + selectHtml + '</td>';
                    } else if (clave === "Total") {
                        filaHtml += "<td>" + fila[clave] + "€</td>";
                    } else {
                        filaHtml += "<td>" + fila[clave] + "</td>";
                    }
                });
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
                        "lengthMenu": "Mostrar _MENU_ pedidos",
                        "info": "Mostrando de el pedido _START_ a el pedido _END_ de un total de _TOTAL_ pedidos",
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
            $('#tabla').on('click', '.detallesPedido', function () {
                // Obtener los datos de la fila seleccionada

                var contador = $(this).data("contador");
                var descripcion = datos[contador].Detalles;
                var id = datos[contador].Id;
                mostrarModalDetallesPedido(descripcion, id);
            });
            //Actualizar estado
            $('#tabla').on('change', '.selectEnvio', function () {
                // Obtener los datos de la fila seleccionada

                var contador = $(this).data("contador");
                var id = datos[contador].Id;
                var estado = document.getElementById("Pedido" + id).value;

                var xhr = new XMLHttpRequest();
                xhr.open('GET', `EditarEstado?estado=${estado}&id=${id}`, true);
                xhr.onreadystatechange = function () {
                    if (xhr.readyState === XMLHttpRequest.DONE && xhr.status === 200) {
                        var respuesta = xhr.responseText;
                    }
                };
                xhr.send();
            });
            break;
    }
}


//Listener para que cuando se clicke en añadir figura abra su modal con los selects cargados
$('#anadir').on('click', function () {
    if (tablaMostrada === "Figura") {
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
    }

});
function mostrarModalDescripcionFigura(descripcion, nombre) {
    $('#figuraDescripcionModal').text(descripcion);
    $('#figuraNombreModal').text(nombre);
    $('#modalDescripcionFigura').modal('show');
}


function mostrarModalBajaFigura(id, nombre, bajaActual) {
    $('#figuraIdBaja').val(id);
    $('#figuraNombreBaja').text(nombre);
    if(bajaActual===0){
    $('#preguntaBajaActual').text("dar de baja");
        $('#submitBaja').val("Dar de baja");
    }else{
         $('#preguntaBajaActual').text("dar de alta");
        $('#submitBaja').val("Dar de alta");
    }
    $('#figuraBajaActual').val(bajaActual);
    $('#modalBajaFigura').modal('show');
}

function mostrarModalModificarFigura(id, nombre, descripcion, personaje, proveedor, material, precio, altura,
        descuento, fechaSalida, stock, primeraImagen, segundaImagen, terceraImagen, personajes, materiales, proveedores) {


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

function mostrarModalDetallesPedido(descripcion, numero)
{
    var detalles = "";
    descripcion.forEach(function (articulo) {
        detalles += "<br>- Nombre Figura: <br>" + articulo.figura.nombre +
                "<br>- Cantidad: " + articulo.cantidad +
                "<br>- Precio: " + (articulo.precio * articulo.cantidad) +
                "€<br>"; // Agregamos dos saltos de línea después de cada artículo
    });
    $('#pedidoDetallesArticulos').html(detalles);
    $('#pedidoDetallesNumero').text(" " + numero);
    $('#modalDetallesPedido').modal('show');
}


