<%-- 
    Document   : login
    Created on : 26 abr 2023, 17:46:26
    Author     : Angel
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Figurama - Login</title>

        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@5.15.4/css/all.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <link href="assets/css/styles.css" rel="stylesheet">
        <link href="assets/css/login.css" rel="stylesheet">

    </head>
    <body>

        <div class="container-fluid" >
            <div class="row mh-100vh">
                <div class="col-10 col-sm-8 col-md-6 col-lg-6 offset-1 offset-sm-2 offset-md-3 offset-lg-0 align-self-center d-lg-flex align-self-lg-stretch p-5 rounded rounded-lg-0 my-5 my-lg-0"  style="background-color: rgb(235, 216, 214)" 
                     id="login-block">
                    <div class="m-auto w-lg-75 w-xl-50">
                        <a href="index.jsp"><img src="assets/images/logo.jpg" alt="alt" class="img-fluid d-flex"/></a>
                        <form class="align-items-center">
                            <div class="form-group mb-3"><label class="form-label">Email</label><input class="form-control" type="email"></div>
                            <div class="form-group mb-3"><label class="form-label">Contraseña</label><input class="form-control" type="password" ></div>

                            <div class="d-flex flex-column">
                                <!-- cosas - Aquí se enviarán los datos a un servlet que compruebe que el usuario es correcto
                                o no, en caso de que no lo sea vuelve a esta página indicando algún mensaje de error-->
                                <a class="btn btn-primary mt-2 p-2" type="submit" href="index.jsp">Acceder</a>
                                <a class="btn btn-primary mt-2 p-2" type="submit" href="register.jsp">¿Eres nuevo/a? Regístrate aquí</a>

                        </form>
                    </div>
                </div>
            </div>

            <!-- Div que contiene la imagen de la zona derecha, esta imagen se pone fixed al hacerse responsive  -->


            <div class="col-lg-6 d-flex align-items-end" id="bg-block" 
                 <div style='background-image:url("assets/images/bg.jpg");background-size:cover;background-position:center center;background-repeat:no-repeat;'>
            </div>
        </div>
    </div>


    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.6.4.slim.js" integrity="sha256-dWvV84T6BhzO4vG6gWhsWVKVoa4lVmLnpBOZh/CAHU4=" crossorigin="anonymous"></script>

</body>
</html>
