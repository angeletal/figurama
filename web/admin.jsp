<%-- 
    Document   : admin
    Created on : 12 jun 2023, 0:29:19
    Author     : Angel
--%>

<%@page import="modelo.entidades.Usuario"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    if (request.getSession().getAttribute("usuario") == null || !((Usuario) request.getSession().getAttribute("usuario")).getRol().equals("Admin")) {
        response.sendRedirect("index.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Figurama - Administración</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.1.1/css/bootstrap.css"/>
        <link rel="stylesheet" href="https://cdn.datatables.net/1.10.19/css/dataTables.bootstrap4.min.css"/>
        <link rel="stylesheet" href="assets/css/admin.css">
        <link rel="stylesheet" href="assets/css/styles.css">

    </head>
    <body>



        <nav class="mt-4">
            <ul>
                <li onclick="cambiarTabla('Usuario')" id="Usuario" <c:if test="${tablaMostrada eq 'Usuario'}">class="active"</c:if>>Usuarios</li>
                <li onclick="cambiarTabla('Serie')" id="Serie"<c:if test="${tablaMostrada eq 'Serie'}">class="active"</c:if>>Series</li>
                <li onclick="cambiarTabla('Personaje')" id="Personaje"<c:if test="${tablaMostrada eq 'Personaje'}">class="active"</c:if>>Personajes</li>
                <li onclick="cambiarTabla('Figura')" id="Figura" <c:if test="${tablaMostrada eq 'Figura'}">class="active"</c:if>>Figuras</li>
                <li onclick="cambiarTabla('Pedido')" id="Pedido"<c:if test="${tablaMostrada eq 'Pedido'}">class="active"</c:if>>Pedidos</li>
                <li onclick="cambiarTabla('Proveedor')" id="Proveedor"<c:if test="${tablaMostrada eq 'Proveedor'}">class="active"</c:if>>Proveedores</li>
                <li onclick="cambiarTabla('Material')" id="Material"<c:if test="${tablaMostrada eq 'Material'}">class="active"</c:if>>Materiales</li>
                    <li onclick="location.href = 'index.jsp'" style="float:right">Ir a la tienda</li>

                </ul>
            </nav>



            <span id="tablaMostrada" style="display:none">${tablaMostrada}</span>

        <div class="container mb-5 text-center" style="margin-top:10px; width: 100%">



            <button class="btn btn-primary mb-5 mt-3" id="anadirFigura">Añadir ${tablaMostrada}</button>



            <table id="tabla" class="table table-striped table-bordered table-hover table-responsive" style="width:100%">



            </table>
        </div>



        <div class="modal fade" id="modalDescripcionFigura" tabindex="-1" aria-labelledby="modalDescripcionFiguraLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Descripción de la figura:<br> <span id="figuraNombreModal"></span></h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">&times;</button>
                    </div>
                    <div class="modal-body">
                        <p id="figuraDescripcionModal"></p>


                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade" id="modalEliminarFigura" tabindex="-1" aria-labelledby="modalEliminarFiguraLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Descripción de la figura:<br> <span id="figuraNombreModal"></span></h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">&times;</button>
                    </div>
                    <form action="CrudFigura?accion=eliminar" method="POST" enctype="multipart/form-data">
                        <input type="hidden" id="figuraIdBorrar" name="id">

                        <div class="modal-body">
                            ¿Está seguro/a de que desea eliminar la figura <span id="figuraNombreBorrar"></span>?
                        </div>
                        <div class="modal-footer">
                            <input type="submit" id="eliminarFigura" class="btn btn-primary" value="Eliminar figura"/>
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                        </div>
                    </form>

                </div>
            </div>
        </div>

        <div class="modal fade" id="modalModificarFigura" tabindex="-1" aria-labelledby="modalModificarFiguraLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Modificar Figura</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">&times;</button>
                    </div>
                    <form action="CrudFigura?accion=modificar" method="POST" enctype="multipart/form-data">
                        <input type="hidden" id="figuraId" name="figuraId">

                        <div class="modal-body">
                            <div class="form-group">
                                <label for="figuraImagen1Old">Primera Imagen Actual:</label>
                                <div class="text-center">
                                    <img id="figuraImagen1Old" alt="Imagen 1" class="img-responsive img-preview">
                                </div>
                                <br>
                                <label for="figuraImagen1">Nueva Primera Imagen:</label>
                                <input type="file" class="form-control" name="figuraImagen1" accept="image/*">
                            </div>

                            <div class="form-group">
                                <label for="figuraImagen2Old">Segunda Imagen Actual:</label>
                                <div class="text-center">
                                    <img id="figuraImagen2Old"  alt="Imagen 1" class="img-responsive img-preview">
                                </div>
                                <br>
                                <label for="figuraImagen2">Nueva Segunda Imagen:</label>
                                <input type="file" class="form-control" name="figuraImagen2" accept="image/*">
                            </div>
                            <div class="form-group">
                                <label for="figuraImagen3Old">Tercera Imagen Actual:</label>
                                <div class="text-center">
                                    <img id="figuraImagen3Old"  alt="Imagen 1" class="img-responsive img-preview">
                                </div>
                                <br>
                                <label for="figuraImagen3">Nueva Tercera Imagen:</label>
                                <input type="file" class="form-control" name="figuraImagen3" accept="image/*">
                            </div>

                            <div class="form-group">
                                <label for="personaje">Personaje</label>
                                <select id="figuraPersonaje"class="form-control" name="figuraPersonaje">

                                </select>
                            </div>

                            <div class="form-group">
                                <label for="nombre">Nombre</label>
                                <input type="text" readonly="readonly" class="form-control" id="figuraNombre" name="figuraNombre">
                            </div>

                            <div class="form-group">
                                <label for="descripcion">Descripción</label>
                                <textarea id="figuraDescripcion"class="form-control" name="figuraDescripcion"></textarea>
                            </div>

                            <div class="form-group">
                                <label for="fecha">Fecha de salida</label>
                                <input type="date"class="form-control" id="figuraFecha" name="figuraFecha">
                            </div>

                            <div class="form-group">
                                <label for="precio">Precio (€)</label>
                                <input type="number"class="form-control" id="figuraPrecio" name="figuraPrecio" step="0.01">
                            </div>

                            <div class="form-group">
                                <label for="stock">Stock</label>
                                <input type="number"class="form-control" id="figuraStock" name="figuraStock">
                            </div>

                            <div class="form-group">
                                <label for="altura">Altura (cm)</label>
                                <input type="number"class="form-control" id="figuraAltura" name="figuraAltura">
                            </div>

                            <div class="form-group">
                                <label for="descuento">Descuento (%)</label>
                                <input type="number"class="form-control" id="figuraDescuento" name="figuraDescuento">
                            </div>

                            <div class="form-group">
                                <label for="proveedor">Proveedor</label>
                                <select id="figuraProveedor"class="form-control" name="figuraProveedor">

                                </select>
                            </div>

                            <div class="form-group">
                                <label for="material">Material</label>
                                <select id="figuraMaterial"class="form-control" name="figuraMaterial">

                                </select>
                            </div>

                        </div>
                        <div class="modal-footer">
                            <input type="submit" id="modificarFigura" class="btn btn-primary" value="Modificar figura"/>
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                        </div>
                    </form>

                </div>
            </div>
        </div>



        <div class="modal fade" id="modalAnadirFigura" tabindex="-1" role="dialog" aria-labelledby="modalAnadirUsuarioLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Añadir Figura</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">&times;</button>
                    </div>
                    <form action="CrudFigura?accion=anadir" method="POST" id="formAnadirFigura" enctype="multipart/form-data">

                        <div class="modal-body">
                            <div class="form-group">

                                <label for="figuraImagen1">Primera Imagen:</label>
                                <input type="file" id="figuraImagen1" class="form-control" name="figuraImagen1" accept="image/*">
                                <p class="text-center w-100 text-danger" id="errorImagen1"></p>

                            </div>

                            <div class="form-group">

                                <label for="figuraImagen2">Segunda Imagen:</label>
                                <input type="file" id="figuraImagen1" class="form-control" name="figuraImagen2" accept="image/*">
                                <p class="text-center w-100 text-danger" id="errorImagen2"></p>

                            </div>
                            <div class="form-group">

                                <label for="figuraImagen3">Tercera Imagen:</label>
                                <input type="file" id="figuraImagen1"  class="form-control" name="figuraImagen3" accept="image/*">
                                <p class="text-center w-100 text-danger" id="errorImagen3"></p>

                            </div>

                            <div class="form-group">
                                <label for="personaje">Personaje</label>
                                <select id="figuraPersonajeAdd"class="form-control" name="figuraPersonaje">

                                </select>
                            </div>

                            <div class="form-group">
                                <label for="nombre">Nombre</label>
                                <input type="text" class="form-control" id="figuraNombre" name="figuraNombre">
                                <p class="text-center w-100 text-danger" id="errorNombre"></p>
                            </div>

                            <div class="form-group">
                                <label for="descripcion">Descripción</label>
                                <textarea id="figuraDescripcion"class="form-control" name="figuraDescripcion"></textarea>
                                <p class="text-center w-100 text-danger" id="errorDescripcion"></p>

                            </div>

                            <div class="form-group">
                                <label for="fecha">Fecha de salida</label>
                                <input type="date"class="form-control" id="figuraFecha" name="figuraFecha">
                                <p class="text-center w-100 text-danger" id="errorFecha"></p>

                            </div>

                            <div class="form-group">
                                <label for="precio">Precio (€)</label>
                                <input type="number"class="form-control" id="figuraPrecio" name="figuraPrecio" step="0.01">
                                <p class="text-center w-100 text-danger" id="errorPrecio"></p>
                            </div>

                            <div class="form-group">
                                <label for="stock">Stock</label>
                                <input type="number"class="form-control" id="figuraStock"  name="figuraStock">
                                <p class="text-center w-100 text-danger" id="errorStock"></p>

                            </div>

                            <div class="form-group">
                                <label for="altura">Altura (cm)</label>
                                <input type="number"class="form-control" id="figuraAltura" name="figuraAltura">
                                <p class="text-center w-100 text-danger" id="errorAltura"></p>

                            </div>

                            <div class="form-group">
                                <label for="descuento">Descuento (%)</label>
                                <input type="number"class="form-control" id="figuraDescuento" name="figuraDescuento">
                                <p class="text-center w-100 text-danger" id="errorDescuento"></p>

                            </div>

                            <div class="form-group">
                                <label for="proveedor">Proveedor</label>
                                <select id="figuraProveedorAdd"class="form-control" name="figuraProveedor">

                                </select>
                            </div>

                            <div class="form-group">
                                <label for="material">Material</label>
                                <select id="figuraMaterialAdd"class="form-control" name="figuraMaterial">

                                </select>
                            </div>

                        </div>
                        <div class="modal-footer">
                            <input type="submit" id="btnAnadirFigura" class="btn btn-primary" value="Añadir figura"/>
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                        </div>
                    </form>

                </div>
            </div>
        </div>





        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/2.10.2/umd/popper.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.3.0/js/bootstrap.min.js"></script>
        <script src="https://cdn.datatables.net/1.10.19/js/dataTables.bootstrap4.min.js"></script>

        <script src="assets/js/admin.js"></script>
        <c:if test="${not empty mensaje}">

            <script>
                        alert("${mensaje}");
            </script>
        </c:if>


    </body>

</html>