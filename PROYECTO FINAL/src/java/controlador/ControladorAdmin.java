package controlador;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.Producto;
import modeloDAO.ProductoDAO;

/**
 *
 * @author nous_
 */
@WebServlet(name = "ControladorAdmin", urlPatterns = {"/ControladorAdmin"})
public class ControladorAdmin extends HttpServlet {

    ProductoDAO pdao = new ProductoDAO();
    Producto p = new Producto();
    List<Producto> productos = new ArrayList<>();

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        productos = pdao.listar();
        String accion = request.getParameter("accion");
        switch (accion) {
            case "rutaAdmin":
                request.getRequestDispatcher("loginAdmin.jsp").forward(request, response);
                break;
            case "rutaInsertarProducto":
                request.getRequestDispatcher("nuevoProducto.jsp").forward(request, response);
                break;
            case "rutaHistorial":
                request.getRequestDispatcher("historial.jsp").forward(request, response);
                break;
            case "rutaClientes":
                request.getRequestDispatcher("clientesAdmin.jsp").forward(request, response);
                break;
            case "adminHome":
                request.setAttribute("productos", productos);
                request.getRequestDispatcher("adminHome.jsp").forward(request, response);
                break;
            case "iniciarSesion":
                String correoLog = request.getParameter("correoLog");
                String passwordLog = request.getParameter("passwordLog");
                
                if ("admin@shoeecommerce.com".equals(correoLog)&&"123".equals(passwordLog)) {
                    request.setAttribute("productos", productos);
                    request.getRequestDispatcher("adminHome.jsp").forward(request, response);
                } else {
                    request.setAttribute("usuarioNoRegistrado", "Credenciales Incorrectas");
                    request.getRequestDispatcher("loginAdmin.jsp").forward(request, response);
                }
                break;
            default:
                request.getRequestDispatcher("index.jsp").forward(request, response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
