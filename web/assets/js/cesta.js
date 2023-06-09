
//Métodos de la cesta

var btnCesta = document.getElementById("btn-cesta");
var inputCantidad = document.getElementById("cantidad");

function anadirArticulo() {
    var id = btnCesta.value;
    var cantidad = inputCantidad.value;

    if (cantidad === "") {
        alert("Debe seleccionar al menos una unidad para añadir el artículo a la cesta");
    } else {
        // Realizar la solicitud AJAX al servlet de búsqueda
        var xhr = new XMLHttpRequest();
        xhr.open('GET', `../ActualizarCesta?id=${id}&cantidad=${cantidad}&accion=anadir`, true);
        xhr.onreadystatechange = function () {
            if (xhr.readyState === XMLHttpRequest.DONE && xhr.status === 200) {
                // Obtener la respuesta del servidor
                var respuesta = xhr.responseText;


                if (respuesta.trim() === '-1') { //-1 es si no hay stock
                    alert("No se ha podido añadir porque supera el stock máximo");
                } else if (respuesta.trim() === '-2') {
                    alert("No se ha podido añadir porque supera el stock mínimo");
                } else {
                    alert("Artículo añadido correctamente a la cesta");
                    document.getElementById("botonAccesoCesta").innerHTML = "Cesta (" + respuesta.trim() + ")";
                }
            }
        };
        xhr.send();
    }
}

function eliminarArticulo(idFigura) {
    var res = confirm("seguro?");
    if (res) {

        var xhr = new XMLHttpRequest();
        xhr.open('GET', `ActualizarCesta?id=${idFigura}&accion=eliminar`, true);
        xhr.onreadystatechange = function () {
            if (xhr.readyState === XMLHttpRequest.DONE && xhr.status === 200) {
                // Obtener la respuesta del servidor
                var respuesta = xhr.responseText;
                if (respuesta.trim() !== '0') {

                    $("#articulo" + idFigura).fadeOut("slow", function () {
                        $(this).remove();
                    });

                    var totalArticulo = document.getElementById("totalArticulo" + idFigura);

                    var precioTotal = document.getElementById("precioTotal");
                    var iva = document.getElementById("iva");
                    var precioFinal = document.getElementById("precioFinal");
                    precioTotal.innerHTML = (parseFloat(precioTotal.innerHTML) - parseFloat(totalArticulo.innerHTML)).toFixed(2);

                    iva.innerHTML = (parseFloat(precioTotal.innerHTML) * 0.21).toFixed(2);
                    precioFinal.innerHTML = (parseFloat(precioTotal.innerHTML) + (parseFloat(iva.innerHTML))).toFixed(2);

                    document.getElementById("valorCesta").innerHTML = respuesta.trim();

                    alert("Articulo eliminado con exito");

                } else {
                    alert("Articulo eliminado con exito");

                    window.location.href = "cesta.jsp";
                }
            }


        }
        ;
        xhr.send();
    }
    ;
}

function vaciarCesta() {
    var res = confirm("seguro?");
    if (res) {

        var xhr = new XMLHttpRequest();
        xhr.open('GET', `ActualizarCesta?id=1&accion=vaciar`, true);
        xhr.onreadystatechange = function () {
            if (xhr.readyState === XMLHttpRequest.DONE && xhr.status === 200) {

                alert("La cesta se ha vaciado correctamente");
                window.location.href = "cesta.jsp";

            }
        };
        xhr.send();
    }


}

//Función para validar que la cantidad no se pase del límite cargado previamente
function validarCantidad() {
    var cantidad = document.getElementById("cantidad");

    var valor = parseInt(cantidad.value);
    var max = parseInt(cantidad.max);

    if (valor > max) {
        cantidad.value = max; // Establece el valor máximo si se excede 
        alert("nourrrr max");
    }
    if (valor <= 0) {
        cantidad.value = 1; // Establece el valor mínimo si se excede
        alert("nourrrr min");
    }
}


//Función para validar que la cantidad no se pase del límite cargado previamente
function actualizarStock(idFigura) {
    var cantidad = document.getElementById("cantidad" + idFigura);

    var valor = parseInt(cantidad.value);
    var max = parseInt(cantidad.max);

    if (isNaN(valor) || valor <= 0) {
        cantidad.value = 1; // Establece el valor máximo si se excede
        alert("nourrrr min");
    } else if (valor > max) {
        cantidad.value = max; // Establece el valor máximo si se excede
        alert("nourrrr max");
    } else {
        //Si el valor es válido, que actualice el stock en la BD y en sesión mediante AJAX
        var stock = document.getElementById("stock" + idFigura);

        // Realizar la solicitud AJAX al servlet de búsqueda
        var xhr = new XMLHttpRequest();
        xhr.open('GET', `ActualizarCesta?id=${idFigura}&cantidad=${cantidad.value}&accion=modificar&&stock=${stock.innerHTML}`, true);
        xhr.onreadystatechange = function () {
            if (xhr.readyState === XMLHttpRequest.DONE && xhr.status === 200) {
                // Obtener la respuesta del servidor
                var respuesta = xhr.responseText;


                if (respuesta.trim() === '0') {
                    alert("Vaya... el stock de la figura X se ha terminado :( ");
                    stock.innerHTML = respuesta.trim();
                    //cosas activar clase para ponerle como que no hay stock y quitar precio
                }
                //Modificar valores en JSP si no ha devuelto menos stock del que ha solicitado comprar el usuario
                else if (parseInt(respuesta.trim()) >= cantidad.value) {

                    actualizarPrecio(idFigura, parseInt(respuesta.trim()));

                } else {
                    alert("Vaya... el stock máximo de la figura X ha cambiado, ahora es de " + respuesta.trim() + " unidades");
                    cantidad.value = parseInt(respuesta.trim());

                    actualizarPrecio(idFigura, parseInt(respuesta.trim()));

                }
            }
        };
        xhr.send();
    }
}


function actualizarPrecio(idFigura, cantidad2) {
    var cantidad = document.getElementById("cantidad" + idFigura);
    cantidad.innerHTML = cantidad2;
    cantidad.max = parseInt(cantidad2);


    document.getElementById("stock" + idFigura).innerHTML = cantidad2;


    var precioUd = document.getElementById("precio" + idFigura);
    var totalArticulo = document.getElementById("totalArticulo" + idFigura);
    var cantActual = document.getElementById("numeroUd" + idFigura);




    var precioTotal = document.getElementById("precioTotal");
    var iva = document.getElementById("iva");
    var precioFinal = document.getElementById("precioFinal");

    cantActual.innerHTML = cantidad.value;
    var totalArticuloFinal = (parseInt(cantActual.innerHTML) * parseFloat(precioUd.innerHTML)).toFixed(2);

    precioTotal.innerHTML = (parseFloat(precioTotal.innerHTML) - parseFloat(totalArticulo.innerHTML) + parseFloat(totalArticuloFinal)).toFixed(2);

    iva.innerHTML = (parseFloat(precioTotal.innerHTML) * 0.21).toFixed(2);
    precioFinal.innerHTML = (parseFloat(precioTotal.innerHTML) + (parseFloat(iva.innerHTML))).toFixed(2);
    totalArticulo.innerHTML = totalArticuloFinal;
}

function aumentarCantidad(idFigura) {
    var cantidadInput = document.getElementById("cantidad" + idFigura);
    cantidadInput.value = parseInt(cantidadInput.value) + 1;
    actualizarStock(idFigura);
}

function disminuirCantidad(idFigura) {
    var cantidadInput = document.getElementById("cantidad" + idFigura);
    var cantidad = parseInt(cantidadInput.value);
    cantidadInput.value = cantidad - 1;
    actualizarStock(idFigura);
}


function comprar() {
    var xhr = new XMLHttpRequest();
    xhr.open('GET', `Comprar`, true);
    xhr.onreadystatechange = function () {
        if (xhr.readyState === XMLHttpRequest.DONE && xhr.status === 200) {
            // Obtener la respuesta del servidor
            var respuesta = JSON.parse(xhr.responseText);
            if (respuesta.length === 0) {
                alert("Compra realizada satisfactoriamente");
            } else {
                alert("Ha ocurrido un fallo en su compra, el stock de los productos sera actualizado al maximo disponible");
            }
                window.location.href = "cesta.jsp";

        }
    };
    xhr.send();
}



