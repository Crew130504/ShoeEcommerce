<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Inicio de Sesión</title>
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.0/font/bootstrap-icons.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/login.css"/>
    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-custom">
            <a class="navbar-brand" href="ControladorAdmin?accion=index">Shoe Ecommerce</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
        </nav>

        <div class="bg-cover">
            <div class="custom-container">
                <div class="card">
                    <div class="card-header card-header-custom">
                        <h4 class="card-title mb-0">Inicio de Sesión</h4>
                    </div>
                    <div class="card-body card-body-custom">
                        <form action="ControladorAdmin?accion=iniciarSesion" method="post">
                            <div class="form-group">
                                <label   for="email">Email</label>
                                <input type="email" class="form-control" name="correoLog" required>
                            </div>
                            <div class="form-group">
                                <label for="password">Contraseña</label>
                                <input type="password" class="form-control" name="passwordLog" required>
                            </div>
                            <button  href="ControladorAdmin?accion=iniciarSesion" class="btn btn-primary btnLogin btn-block">Iniciar Sesión</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <div id="userNoSignin" style="display:none;" data-msg="${usuarioNoRegistrado}"></div>  
        <div id="userDuplicateMsg" style="display:none;" data-msg="${not empty usuarioDuplicado ? usuarioDuplicado : ''}"></div>
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.7/dist/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
        <script src="js/funciones.js"></script>
    </body>
</html>
