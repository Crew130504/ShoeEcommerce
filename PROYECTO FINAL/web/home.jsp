<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Shoe Ecommerce</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/home.css"/>
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.0/font/bootstrap-icons.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <a class="navbar-brand" href="Controlador?accion=index">Shoe Ecommerce</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item active">
                        <a class="nav-link" href="Controlador?accion=home">Home <span class="sr-only">(current)</span></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="Controlador?accion=Carrito">Carrito&nbsp<i class="fas fa-cart-plus"><label style="color: orange">&nbsp${Contador}</label></i></a>
                    </li>
                </ul>
                <form class="form-inline mx-auto my-2 my-lg-0" onsubmit="return false;">
                    <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search" id="searchInput" style="text-align: center; width: 500px;"> 
                </form>
                <ul class="navbar-nav">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <i class="bi bi-person"></i> ${usuario}
                        </a>
                        <div class="dropdown-menu dropdown-menu-right" aria-labelledby="navbarDropdown">
                            <c:if test="${usuario == null || usuario == ''}">
                                <a class="dropdown-item" href="Controlador?accion=rutaIniciarSesion">Iniciar Sesión</a>
                                <a class="dropdown-item" href="Controlador?accion=rutaRegistro">Registrarse</a>    
                            </c:if>
                            <!-- Si el usuario está autenticado, muestra opciones de perfil y cerrar sesión -->
                            <c:if test="${usuario != null && usuario != ''}">
                                <a class="dropdown-item" href="Controlador?accion=cerrarSesion">Cerrar Sesión</a>
                            </c:if>
                        </div
                    </li>
                </ul>
            </div>
        </nav>  
        <div class="container mt-4">
            <div class="row">
                <c:forEach var="p" items="${productos}">
                    <div class="col-sm-4 mb-4">
                        <div class="card">
                            <img class="card-img-top" src="ControladorIMG?id=${p.getId()}" alt="${p.getNombres()}" height="200">
                            <div class="card-body">
                                <h5 class="card-title">${p.getNombres()}</h5>
                                <p class="card-text">${p.getDescripcion()}</p>
                                <p class="card-text"><strong>$ ${p.getPrecio()}</strong></p>
                                <div class="d-flex justify-content-between">
                                    <a href="Controlador?accion=AgregarCarrito&id=${p.getId()}" class="btn btn-outline-info">Agregar a Carrito</a>
                                    <a href="Controlador?accion=Comprar&id=${p.getId()}" class="btn btn-danger">Comprar</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
            <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
            <script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.7/dist/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
            <script src="js/funciones.js"></script>
    </body>
</html>