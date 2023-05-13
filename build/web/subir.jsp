<%-- 
    Document   : subir
    Created on : 13 may 2023, 22:21:30
    Author     : Angel
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
       <form action="uploadServlet" method="post" enctype="multipart/form-data">
  <input type="file" name="file" accept="image/*">
  <input type="submit" value="Subir imagen">
</form>

    </body>
</html>
