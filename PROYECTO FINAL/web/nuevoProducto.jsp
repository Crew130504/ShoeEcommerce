<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Administrar Productos</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/nuevoProducto.css"/>
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.0/font/bootstrap-icons.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <a class="navbar-brand" href="ControladorAdmin?accion=adminHome">Shoe Ecommerce<label style="color: orange">&nbsp;ADMIN PANEL</label></a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav mx-auto">
                    <li class="nav-item active">
                        <a class="nav-link" href="ControladorAdmin?accion=adminHome">Productos &nbsp;<i class="bi bi-box-seam"></i></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="ControladorAdmin?accion=rutaHistorial">Historial&nbsp;&nbsp;<i class="bi bi-clock-history"></i></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="ControladorAdmin?accion=rutaClientes">Clientes&nbsp;&nbsp;<i class="bi bi-person"></i></a>
                    </li>
                </ul>
                <ul class="navbar-nav ml-auto">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <i class="bi bi-person"></i> Admin
                        </a>
                        <div class="dropdown-menu dropdown-menu-right" aria-labelledby="navbarDropdown">
                            <a class="dropdown-item" href="ControladorAdmin?accion=default">Cerrar Sesión</a>                           
                        </div>
                    </li>
                </ul>
            </div>
        </nav>
        <div class="container mt-5">
            <h2>Agregar Producto</h2>
            <form action="ControladorAdmin" method="post" enctype="multipart/form-data">
                <input type="hidden" name="accion" value="Confirmar">
                <div class="form-group">
                    <label for="nombres">Nombre del Producto</label>
                    <input value="<%= request.getAttribute("nombreE") != null ? request.getAttribute("nombreE") : "" %>" type="text" class="form-control" id="nombres" name="nombres" required>
                </div>
                <div class="form-group">
                    <label for="foto">Foto del Producto</label>
                    <input type="file" class="form-control-file" id="foto" name="foto" required>
                </div>
                <div class="form-group">
                    <label for="descripcion">Descripción</label>
                    <textarea class="form-control" id="descripcion" name="descripcion" rows="3" required><%= request.getAttribute("descripcionE") != null ? request.getAttribute("descripcionE") : "" %></textarea>
                </div>
                <div class="form-group">
                    <label for="precio">Precio</label>
                    <input value="<%= request.getAttribute("precioE") != null ? request.getAttribute("precioE") : "" %>" type="number" step="0.01" class="form-control" id="precio" name="precio" required>
                </div>
                <button type="submit" class="btn btn-primary">Confirmar</button>
            </form>
        </div>
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.7/dist/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
        <script src="js/funciones.js"></script>
    </body>
</html>
