<%-- 
    Document   : figura
    Created on : 13 may 2023, 19:09:32
    Author     : Angel
--%>

<%@page import="modelo.entidades.Figura"%>
<%@page import="java.util.List"%>
<%@page import="modelo.dao.FiguraDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="es">

    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
        <title></title>
        <link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">

        <link rel="stylesheet" href="assets/css/styles.css"> 

        <script src="assets/js/figura.js">

        </script>
    </head>

    <!-- Inicio header -->


    <body style="background-color: rgb(235, 216, 214);">

        <%
            FiguraDAO fdao = new FiguraDAO();
            fdao.getFiguraPorId(1);
            request.getSession().setAttribute("figura", fdao.getFiguraPorId(1));
        %>

        <header class="mb-5 pb-5">
            <nav class="navbar navbar-expand-md navbar-light bg-white fixed-top">
                <div class="container-fluid">
                    <a class="navbar-brand" href="index.jsp">
                        <img src="assets/images/logomini.jpg" alt="alt" class="logo-img">
                        <span class="logo-text">Figurama</span>
                    </a>
                    <button class="navbar-toggler collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#navbarCollapse"
                            aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse" id="navbarCollapse">
                        <ul class="navbar-nav ml-auto">
                            <li class="nav-item active">
                                <a class="nav-link active" href="index.jsp">Inicio</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#">Catálogo</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#">Reservas</a>
                            </li>
                            <!-- cosas -  Aquí más adelante enviarán los datos a un servlet que guarde la cesta que lleva el usuario -->
                            <li class="nav-item">

                                <c:if test="${not empty sessionScope.cesta}">
                                    <a class="nav-link" href="#">Cesta (7)</a>
                                </c:if>
                                <c:if test="${empty sessionScope.cesta}">
                                    <a class="nav-link" href="#">Cesta (0)</a>
                                </c:if>

                            </li>
                            <li class="nav-item">
                                <c:if test="${not empty sessionScope.usuario}">
                                    <a class="nav-link" href="perfil.jsp">Mi Cuenta</a>
                                </c:if>
                                <c:if test="${empty sessionScope.usuario}">
                                    <a class="nav-link" href="login.jsp">Iniciar sesión</a>
                                </c:if>
                            </li>
                        </ul>
                    </div>
                </div>
            </nav>
        </header>

        <!-- Inicio productos -->

        <c:set var="figura" value="${sessionScope.figura}"></c:set>

            <div class="container mt-5 pt-5 mb-5">
                <div class="row d-flex justify-content-center">
                    <div class="col-md-10">
                        <div class="card">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="images p-3">
                                        <div class="text-center p-4  zoom-img" onmousemove="zoom(event)" onmouseout="resetZoom(event)"> <img id="main-image" src="assets/images/figuras/${figura.primeraImagen}" width="280px"/>
                                    </div>
                                    <div class="thumbnail text-center"> 

                                        <c:forEach items="${figura.imagenes}" var="imagen">

                                            <img style="cursor:pointer" src="assets/images/figuras/${imagen.url}" width="80px" onclick="cambiarImagen('${imagen.url}')">

                                        </c:forEach>

                                    </div>
                                </div>
                            </div>


                            <div class="col-md-6">
                                <div class="product p-4">
                                    <div class="d-flex float-right">
                                        <a href="tienda.html"><i class="fa-solid fa-arrow-left"></i> Volver</a>
                                    </div>
                                    <div class="mt-4 mb-3">
                                        <h5><strong><c:out value="${figura.nombre}"/></strong></h5>
                                        <div class="price d-flex flex-row align-items-center"> <span
                                                class="act-price"><strong><c:out value="${figura.precio}"/>  €</strong></span>
                                        </div>
                                    </div>
                                    <p class="about"><c:out value="${figura.descripcion}"/>
                                    </p>

                                    <div class="cart mt-4 align-items-center"> <button
                                            class="btn btn-danger text-uppercase mr-2 px-4">Añadir a la cesta</button> <i
                                            class="fa fa-heart text-muted"></i> <i class="fa fa-share-alt text-muted"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Fin producto -->
        <div class="bg-white p-4">
            <%@include file="footer.jsp"%>
        </div>



        <script src="assets/js/jquery.min.js"></script>
        <script src="assets/bootstrap/js/bootstrap.min.js"></script>
    </body>

</html>