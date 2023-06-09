<%-- 
    Document   : cesta
    Created on : 28 may 2023, 21:11:17
    Author     : Angel
--%>

<%@page import="modelo.dao.CestaDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Figurama - Cesta</title>
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <link rel="stylesheet" href="assets/css/cesta.css">    
        <link rel="stylesheet" href="assets/css/styles.css">
        <link rel="stylesheet" href="assets/css/filtro.css">

    </head>
    <body>


        <header>
            <nav class="navbar navbar-expand-md navbar-light fixed-top head">
                <div class="container-fluid">
                    <a class="navbar-brand" href="index.jsp">
                        <img src="assets/images/logomini.jpg" alt="alt" class="logo-img" title="Volver a inicio">
                    </a>

                    <!-- Contenedor búsqueda responsive -->
                    <div id="contenedor-busqueda-responsive">
                        <div class="input-container">
                            <div class="input-wrapper">
                                <input type="text" autocomplete="off" id="input-busqueda-res" placeholder="Buscar figura...">
                                    <span id="tooltip-res" class="tooltip">Ingrese al menos 3 caracteres</span>

                            </div>
                            <button id="btn-buscar-res">
                                <span class="fas fa-search"></span>
                            </button>
                        </div>

                    </div>
                    <button class="navbar-toggler collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#navbarCollapse"
                            aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse text-center" id="navbarCollapse">
                        <ul class="navbar-nav ml-auto w-100">
                            <li class="nav-item active">
                                <a class="nav-link" href="index.jsp">Inicio</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="catalogo.jsp">Catálogo</a>
                            </li>
                            
                            <li class="nav-item">
                                <a class="nav-link" href="franquicias">Franquicias</a>
                            </li>

                            <!-- Si la cesta está vacía se muestra 0, si tiene algo se muestra el valor -->
                            <li class="nav-item">
                                <c:if test="${empty sessionScope.cesta}">
                                    <a class="nav-link active" href="cesta.jsp">Cesta (0)</a>
                                </c:if>
                                <c:if test="${!empty sessionScope.cesta}">
                                    <a class="nav-link active" href="cesta.jsp">Cesta (<c:out value="${sessionScope.cesta.tamano}"/>)</a>
                                </c:if>
                            </li>

                            <!-- Si no hay sesión iniciada que de pie a hacerlo, si la hay que muestre sus opciones -->
                            <li class="nav-item dropdown">
                                <c:if test="${not empty sessionScope.usuario}">
                                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown"
                                       aria-haspopup="true" aria-expanded="false">
                                        Cuenta
                                    </a>
                                    <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                                        <a class="dropdown-item" href="#">Ver mis favoritos</a>
                                        <a class="dropdown-item" href="#">Ver mis pedidos</a>
                                        <a class="dropdown-item" href="#">Editar perfil</a>
                                        <a class="dropdown-item" href="CerrarSesion">Cerrar sesión</a>
                                    </div>
                                </c:if>
                                <!-- Al clicar en acceder guardamos la URL donde se pulsa para que cuando se loguee vuelva a donde estaba -->
                                <c:if test="${empty sessionScope.usuario}">
                                    
                                        <a id="linkAcceso" class="nav-link" href="#">Acceder</a>
                                </c:if>
                            </li>
                        </ul>

                        <!-- Contenedor búsqueda NO responsive -->
                        <div id="contenedor-busqueda">
                            <div class="input-container">
                                <div class="input-wrapper">
                                    <input type="text" autocomplete="off" id="input-busqueda" placeholder="Buscar figura...">
                                    <span id="tooltip" class="tooltip">Ingrese al menos 3 caracteres</span>
                                </div>
                                <button id="btn-buscar">
                                    <span class="fas fa-search"></span>
                                </button>                          
                            </div>
                        </div>
                    </div>
                    <ul class="text-center" id="lista-resultados"></ul>

                </div>


            </nav>

        </header>
            <div class="content">
    
 <ol class="breadcrumb mt-5 pt-5 me-5">
                    <li class="breadcrumb-item">
                        <a itemprop="item" href="index.jsp">
                            <span itemprop="name">Inicio</span>
                        </a>
                    </li>
                    <li class="breadcrumb-item active">
                        <span itemprop="name">Cesta</span>
                    </li>
                </ol>

        <c:if test="${empty sessionScope.cesta}">

            <div class="cestaVacia text-center">
                <div class="container">
                    <div class="empty-cart">
                        <h1>Su cesta está vacía</h1>
                        <p>¡Explora nuestro catálogo y encuentra las figuras que deseas!</p>
                        <a href="catalogo.jsp" class="btn btn-primary">Ir al catálogo</a>
                    </div>
                </div>
            </div>
        </c:if>

        <c:if test="${!empty sessionScope.cesta}">

            <section class="h-100">
              
                <div class="container h-100 pb-5">

                    <div class="row d-flex justify-content-center align-items-center h-100">
                        <div class="col">
                            <div class="card shopping-cart">
                                <div class="card-body text-black">

                                    <div class="row">
                                        <div class="col-md-7 ">

                                            <c:if test="${not empty sessionScope.usuario.nombre}">
                                                <h3 class="mb-5 pt-2 text-center fw-bold text-uppercase">Cesta de <c:out value="${sessionScope.usuario.nombre}"/></h3>                      
                                            </c:if>
                                            <c:if test="${empty sessionScope.usuario.nombre}">
                                                <h3 class="mb-5 pt-2 text-center fw-bold text-uppercase">Cesta de Anónimo</h3>                      
                                            </c:if>

                                            <c:forEach items="${sessionScope.cesta.articulos}" var="articulo">
                                                <div id="articulo${articulo.figura.id}">
                                                    <div class="d-flex align-items-start flex-column flex-md-row mb-5 text-center">
                                                        <div class="m-auto pb-4">
                                                            <img src="assets/images/figuras/${articulo.figura.primeraImagen}" class="img-fluid" style="width: 170px;" alt="">
                                                        </div>
                                                        <div class="ms-md-3">
                                                            <button class="ms-2 float-end text-black bg-transparent border border-white" onclick="eliminarArticulo(${articulo.figura.id})"><i class="fas fa-times ps-1"></i></button>

                                                            <h5 class="text-primary mb-3 azul"><a class="text-primary" href="figura/${articulo.figura.nombre}"><c:out value="${articulo.figura.nombre}"/></a></h5><br>


                                                            <div class="d-flex align-items-center justify-content-center mb-5 text-center">

                                                                <div>
                                                                    <p>Cantidad disponible: <span id="stock${articulo.figura.id}"><c:out value="${articulo.figura.stock}"/></p>    
                                                                    <div class="d-flex justify-content-center">
                                                                        <button class="btn btn-primary me-2" id="btn-disminuir" onclick="disminuirCantidad(${articulo.figura.id})">-</button>
                                                                        <input type="number" class="form-control text-center" value="${articulo.cantidad}" min="1" max="${articulo.figura.stock}" style="width: 10vw" id="cantidad${articulo.figura.id}" onchange="actualizarStock(${articulo.figura.id})">
                                                                        <button class="btn btn-primary ms-2" id="btn-anadir" onclick="aumentarCantidad(${articulo.figura.id})">+</button>
                                                                    </div>
                                                                </div>
                                                            </div>


                                                            <h5 class="fw-bold mb-0"><span id="precio${articulo.figura.id}"><c:out value="${articulo.figura.precioConDescuento}"/></span>€ x <span id="numeroUd${articulo.figura.id}"><c:out value="${articulo.cantidad}"/></span></h5>

                                                            <h5 class="fw-bold mb-0">Total artículo: <span id="totalArticulo${articulo.figura.id}"><c:out value="${articulo.precioTotal}"/></span>€</h5>
                                                        </div>

                                                    </div>

                                                    <hr class="mb-4">
                                                </div>

                                            </c:forEach>

                                            <div class="d-flex justify-content-between px-x">
                                                <p class="fw-bold">Precio: </p>
                                                <p class="fw-bold"><span id="precioTotal"><c:out value="${sessionScope.cesta.precioTotal}"/></span>€</p>
                                            </div>
                                            <div class="d-flex justify-content-between px-x">
                                                <p class="fw-bold">IVA (21%)</p>
                                                <p class="fw-bold"><span id="iva"><c:out value="${sessionScope.cesta.iva}"/></span>€</p>
                                            </div>
                                          
                                            <div class="d-flex justify-content-between p-2 mb-2">
                                                <h5 class="fw-bold mb-0 azul">Total:</h5>
                                                <h5 class="fw-bold mb-0 azul"><span id="precioFinal"><c:out value="${sessionScope.cesta.precioConIva}"/></span>€</h5>
                                            </div>

                                        </div>





                                        <div class="col-md-5 px-5 py-4">

                                            <button class="btn btn-primary mb-5 pt-2 text-center w-100 fw-bold">Usar dirección guardada</button>
                                            <button class="btn btn-primary mb-5 pt-2 text-center w-100 fw-bold ">Usar tarjeta guardada</button>

                                            <form class="mb-5">

                                                <div class="form-outline mb-5">
                                                    <input type="text" id="typeText" class="form-control form-control-lg" size="17"
                                                           placeholder="1234 5678 9012 3457" minlength="19" maxlength="19" />
                                                    <label class="form-label" for="typeText">Número de tarjeta</label>
                                                </div>

                                                <div class="form-outline mb-5">
                                                    <input type="text" id="typeName" class="form-control form-control-lg"
                                                           placeholder="Pepe Pérez" />
                                                    <label class="form-label" for="typeName">Nombre propietario</label>
                                                </div>

                                                <div class="row">
                                                    <div class="col-md-6 mb-4">
                                                        <div class="form-outline">
                                                            <input type="text" id="typeExp" class="form-control form-control-lg" placeholder="12/24"
                                                                   size="7" id="exp" minlength="5" maxlength="5" />
                                                            <label class="form-label" for="typeExp">Fecha caducidad</label>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <div class="form-outline">
                                                            <input type="password" id="typeText" class="form-control form-control-lg"
                                                                   placeholder="123" size="1" minlength="3" maxlength="3" />
                                                            <label class="form-label" for="typeText">CVV</label>
                                                        </div>
                                                    </div>
                                                </div>


                                                <label class="custom-checkbox w-100 text-center" for="guardarTarjeta">
                                                    <input type="checkbox" id="guardarTarjeta" name="guardarTarjeta">
                                                    <span class="checkmark"></span>
                                                    <span class="custom-label">Guardar datos de la tarjeta</span>
                                                </label>
                                            </form>
                                               
                                                <button type="button" class="btn btn-primary btn-block btn-lg w-100 m-0 mb-5" onclick="comprar()">Realizar compra</button>
                                                <button type="button" class="btn btn-primary btn-block btn-lg w-100 m-0" onclick="vaciarCesta()">Vaciar cesta</button>


                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

        </c:if>
        </div>
            <%@include file="footer.jsp"%>




        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.4.0/js/bootstrap.bundle.min.js"></script>



        <script src="assets/js/filtro.js"></script>
        <script src="assets/js/cesta.js"></script>
    </body>
</html>

