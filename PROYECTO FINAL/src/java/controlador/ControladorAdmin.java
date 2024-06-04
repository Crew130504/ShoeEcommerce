package controlador;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import modelo.Producto;
import modeloDAO.ClienteDAO;
import modeloDAO.CompraDAO;
import modeloDAO.ProductoDAO;

@WebServlet(name = "ControladorAdmin", urlPatterns = {"/ControladorAdmin"})
@MultipartConfig
public class ControladorAdmin extends HttpServlet {

    ProductoDAO pdao = new ProductoDAO();
    CompraDAO cdao = new CompraDAO();
    ClienteDAO clidao = new ClienteDAO();
    Producto p = new Producto();
    List<Producto> productos = new ArrayList<>();
    int idE = -1;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("compras",cdao.listar() );
        productos = pdao.listar();
        String accion = request.getParameter("accion");
        if (accion == null || accion.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Parámetro de acción requerido");
            return;
        }

        switch (accion) {
            case "rutaAdmin":
                request.getRequestDispatcher("loginAdmin.jsp").forward(request, response);
                break;
            case "rutaInsertarProducto":
                request.setAttribute("nombreE", "");
                request.setAttribute("descripcionE", "");
                request.setAttribute("precioE", "");
                request.setAttribute("stockE", "");
                request.getRequestDispatcher("nuevoProducto.jsp").forward(request, response);
                break;
            case "rutaHistorial":
                request.setAttribute("compras",cdao.listar() );
                request.getRequestDispatcher("historial.jsp").forward(request, response);
                break;
            case "rutaClientes":
                request.setAttribute("clientes",clidao.listaDeClientes());
                request.getRequestDispatcher("clientesAdmin.jsp").forward(request, response);
                break;
            case "adminHome":
                request.setAttribute("productos", productos);
                request.getRequestDispatcher("adminHome.jsp").forward(request, response);
                break;
            case "rutaEditarProducto":
                idE = Integer.parseInt(request.getParameter("idE"));
                Producto productoE = pdao.listarId(idE);
                request.setAttribute("nombreE", productoE.getNombres());
                request.setAttribute("descripcionE", productoE.getDescripcion());
                request.setAttribute("precioE", productoE.getPrecio());
                request.getRequestDispatcher("nuevoProducto.jsp").forward(request, response);
                break;
            case "iniciarSesion":
                String correoLog = request.getParameter("correoLog");
                String passwordLog = request.getParameter("passwordLog");

                if ("admin@shoeecommerce.com".equals(correoLog) && "123".equals(passwordLog)) {
                    request.setAttribute("productos", productos);
                    request.getRequestDispatcher("adminHome.jsp").forward(request, response);
                } else {
                    request.setAttribute("error", "Credenciales incorrectas");
                    request.getRequestDispatcher("loginAdmin.jsp").forward(request, response);
                }
                break;
            case "Confirmar":
                String nombre = request.getParameter("nombres");
                String descripcion = request.getParameter("descripcion");
                double precio = Double.parseDouble(request.getParameter("precio"));
                int stock = Integer.parseInt(request.getParameter("stock"));
                Part part = request.getPart("foto");
                InputStream inputStream = part.getInputStream();
                
                    p.setId(idE);
                    p.setNombres(nombre);
                    p.setFoto(inputStream);
                    p.setDescripcion(descripcion);
                    p.setPrecio(precio);
                pdao.guardarOActualizarProducto(p);
                request.setAttribute("productos", pdao.listar());
                request.getRequestDispatcher("adminHome.jsp").forward(request, response);
                break;
            case "Eliminar":
                int idD = Integer.parseInt(request.getParameter("idD"));
                pdao.eliminarProducto(idD);
                request.setAttribute("productos", pdao.listar());
                request.getRequestDispatcher("adminHome.jsp").forward(request, response);
                break; 
            default:
                request.getRequestDispatcher("index.jsp").forward(request, response);
                
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
