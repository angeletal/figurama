<%-- 
    Document   : index
    Created on : 26 abr 2023, 17:18:56
    Author     : Angel
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="es">

    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Figurama</title>
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@5.15.4/css/all.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">

        <link href="assets/css/styles.css" rel="stylesheet">



    </head>

    <body>
        <header>
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
                            <li class="nav-item">
                                <a class="nav-link" href="#">Cesta (0)</a>
                            </li>
                            <li class="nav-item">
                                <!--cosas -  Aquí más adelante enviarán los datos a un servlet que guarde la cesta que lleva el usuario -->
                                <a class="nav-link" href="login.jsp">Iniciar sesión</a>
                            </li>
                        </ul>
                    </div>
                </div>
            </nav>

        </header>

        <div class="container">
            <section class="jumbotron text-center">
                <div class="container">
                    <h1 class="jumbotron-heading">Figurama</h1>
                    <p class="lead">¡La tienda en línea de figuras más completa! Encuentra la figura que estás buscando,
                        desde las más económicas hasta ediciones limitadas de alta calidad.</p>
                    <a href="#" class="btn btn-primary my-2">Ver catálogo</a>
                    <a href="#" class="btn btn-secondary my-2">Ver novedades</a>
                </div>
            </section>

            <div id="myCarousel" class="carousel slide" data-bs-ride="carousel">
                <div class="carousel-inner">
                    <div class="carousel-item active">
                        <img src="assets/images/slider1.jpg" class="d-block w-100" alt="Slider 1">
                    </div>
                    <div class="carousel-item">
                        <img src="assets/images/slider2.jpg" class="d-block w-100" alt="Slider 2">
                    </div>
                    <div class="carousel-item">
                        <img src="assets/images/slider3.jpg" class="d-block w-100" alt="Slider 3">
                    </div>
                    <div class="carousel-item">
                        <img src="assets/images/slider4.jpg" class="d-block w-100" alt="Slider 4">
                    </div>
                    <div class="carousel-item">
                        <img src="assets/images/slider5.jpg" class="d-block w-100" alt="Slider 5">
                    </div>
                </div>
                <button class="carousel-control-prev" type="button" data-bs-target="#myCarousel" data-bs-slide="prev">
                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                    <span class="sr-only">Previous</span>
                </button>
                <button class="carousel-control-next" type="button" data-bs-target="#myCarousel" data-bs-slide="next">
                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                    <span class="sr-only">Next</span>
                </button>
            </div>





<!-- Esta parte va a cambiar de debajo, irá en el apartado de ver catálogo, lo pongo para que veais
más o menos como será el filtrado, además de este tendrá uno donde el usuario escriba lo
que desea buscar y mediante ajax vaya mostrando lás principales concordancias -->


            <div class="row text-center mt-5 mb-5">
                <div class="col-md-4">
                    <h2>Series</h2>
                    <ul class="list-unstyled">
                        <li><a href="#">Naruto</a></li>
                        <li><a href="#">Dragon Ball</a></li>
                        <li><a href="#">One Piece</a></li>
                        <li><a href="#">Sailor Moon</a></li>
                        <li><a href="#">My Hero Academia</a></li>
                    </ul>
                </div>
                <div class="col-md-4">
                    <h2>Personajes</h2>
                    <ul class="list-unstyled">
                        <li><a href="#">Naruto</a></li>
                        <li><a href="#">Sasuke</a></li>
                        <li><a href="#">Goku</a></li>
                        <li><a href="#">Vegeta</a></li>
                        <li><a href="#">Luffy</a></li>
                    </ul>
                </div>

                <div class="col-md-4">
                    <h2>Marcas</h2>
                    <ul class="list-unstyled">
                        <li><a href="#">Banpresto</a></li>
                        <li><a href="#">Bandai</a></li>
                        <li><a href="#">Funko</a></li>
                        <li><a href="#">Kotobukiya</a></li>
                        <li><a href="#">S.H. Figuarts</a></li>
                    </ul>
                </div>
            </div>
        </div>
        
        <%@include file="footer.jsp"%>

        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>
        <script src="https://code.jquery.com/jquery-3.6.4.slim.js" integrity="sha256-dWvV84T6BhzO4vG6gWhsWVKVoa4lVmLnpBOZh/CAHU4=" crossorigin="anonymous"></script>
    </body>
</html>
