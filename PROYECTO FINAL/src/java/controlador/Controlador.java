package controlador;

import config.Fecha;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.swing.JOptionPane;
import modelo.Carrito;
import modelo.Cliente;
import modelo.Compra;
import modelo.Pago;
import modelo.Producto;
import modeloDAO.ClienteDAO;
import modeloDAO.CompraDAO;
import modeloDAO.PagoDAO;
import modeloDAO.ProductoDAO;

@WebServlet(name = "Controlador", urlPatterns = {"/Controlador"})
public class Controlador extends HttpServlet {

    ClienteDAO cdao = new ClienteDAO();
    Cliente cliente = new Cliente();
    ProductoDAO pdao = new ProductoDAO();
    Producto p = new Producto();
    List<Producto> productos = new ArrayList<>();
    List<Carrito> listaCarrito = new ArrayList<>();
    ArrayList<Cliente> listaClientes = new ArrayList<>();
    int item;
    double totalPagar = 0.0;
    int cantidad = 1;

    int idp;
    Carrito car;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String accion = request.getParameter("accion");
        productos = pdao.listar();
        switch (accion) {
            case "Comprar":
                totalPagar = 0;
                idp = Integer.parseInt(request.getParameter("id"));
                p = pdao.listarId(idp);
                item = item + 1;
                car = new Carrito();
                car.setItem(item);
                car.setIdProducto(p.getId());
                car.setNombres(p.getNombres());
                car.setDescripcion(p.getDescripcion());
                car.setPrecioCompra(p.getPrecio());
                car.setCantidad(cantidad);
                car.setSubTotal(cantidad * p.getPrecio());
                listaCarrito.add(car);
                for (int i = 0; i < listaCarrito.size(); i++) {
                    totalPagar = totalPagar + listaCarrito.get(i).getSubTotal();
                }
                request.setAttribute("carrito", listaCarrito);
                request.setAttribute("contador", listaCarrito.size());
                request.setAttribute("totalPagar", totalPagar);
                request.getRequestDispatcher("carrito.jsp").forward(request, response);
                break;
            case "AgregarCarrito":
                int pos = 0;
                cantidad = 1;
                idp = Integer.parseInt(request.getParameter("id"));
                p = pdao.listarId(idp);
                if (listaCarrito.size() > 0) {
                    for (int i = 0; i < listaCarrito.size(); i++) {
                        if (idp == listaCarrito.get(i).getIdProducto()) {
                            pos = i;
                        }
                    }
                    if (idp == listaCarrito.get(pos).getIdProducto()) {
                        cantidad = listaCarrito.get(pos).getCantidad() + cantidad;
                        double subtotal = listaCarrito.get(pos).getPrecioCompra() * cantidad;
                        listaCarrito.get(pos).setCantidad(cantidad);
                        listaCarrito.get(pos).setSubTotal(subtotal);
                    } else {
                        item = item + 1;
                        car = new Carrito();
                        car.setItem(item);
                        car.setIdProducto(p.getId());
                        car.setNombres(p.getNombres());
                        car.setDescripcion(p.getDescripcion());
                        car.setPrecioCompra(p.getPrecio());
                        car.setCantidad(cantidad);
                        car.setSubTotal(cantidad * p.getPrecio());
                        listaCarrito.add(car);

                    }
                } else {
                    item = item + 1;
                    car = new Carrito();
                    car.setItem(item);
                    car.setIdProducto(p.getId());
                    car.setNombres(p.getNombres());
                    car.setDescripcion(p.getDescripcion());
                    car.setPrecioCompra(p.getPrecio());
                    car.setCantidad(cantidad);
                    car.setSubTotal(cantidad * p.getPrecio());
                    listaCarrito.add(car);
                }
                request.setAttribute("Contador", listaCarrito.size());
                request.getRequestDispatcher("Controlador?accion=home").forward(request, response);
                break;
            case "Delete":
                idp = Integer.parseInt(request.getParameter("idp"));
                for (int i = 0; i < listaCarrito.size(); i++) {
                    if (listaCarrito.get(i).getIdProducto() == idp) {
                        listaCarrito.remove(i);
                    }
                }
                request.setAttribute("carrito", listaCarrito);
                request.getRequestDispatcher("carrito.jsp").forward(request, response);
                break;
            case "ActualizarCantidad":
                int idpro = Integer.parseInt(request.getParameter("idp"));
                int cant = Integer.parseInt(request.getParameter("Cantidad"));
                for (int i = 0; i < listaCarrito.size(); i++) {
                    if (listaCarrito.get(i).getIdProducto() == idpro) {
                        listaCarrito.get(i).setCantidad(cant);
                        double st = listaCarrito.get(i).getPrecioCompra() * cant;
                        listaCarrito.get(i).setSubTotal(st);
                    }
                }

            case "Carrito":
                if (cliente == null) {
                    request.setAttribute("usuario", null);
                } else {
                    request.setAttribute("usuario", cliente.getNombre());
                }
                totalPagar = 0.0;
                request.setAttribute("carrito", listaCarrito);
                for (int i = 0; i < listaCarrito.size(); i++) {
                    totalPagar = totalPagar + listaCarrito.get(i).getSubTotal();
                }
                request.setAttribute("totalPagar", totalPagar);
                request.getRequestDispatcher("carrito.jsp").forward(request, response);
                break;
            case "GenerarCompra":
                Pago pago = new Pago();
                PagoDAO daoPago = new PagoDAO();
                pago.setMonto(totalPagar);
                pago = daoPago.GenerarPago(pago);
                CompraDAO dao = new CompraDAO();
                if (cliente == null || pago == null) {
                    // mensaje que mande a registrar o iniciar sesion al cliente
                    request.getRequestDispatcher("error.jsp").forward(request, response);
                } else {
                    Compra compra = new Compra(cliente, pago.getId(), Fecha.FechaBD(), totalPagar, "Cancelado", listaCarrito);
                    int res = dao.GenerarCompra(compra);
                    if (res != 0 && totalPagar > 0) {
                        request.setAttribute("mensaje", "COMPRA REALIZADA");
                        request.getRequestDispatcher("mensaje.jsp").forward(request, response);
                        listaCarrito.clear();
                    } else {
                        request.getRequestDispatcher("error.jsp").forward(request, response);
                    }
                }
                break;
            case "rutaRegistro":
                request.getRequestDispatcher("registro.jsp").forward(request, response);
                break;
            case "rutaIniciarSesion":
                request.getRequestDispatcher("login.jsp").forward(request, response);
                break;
            case "registrar":
                String dni = request.getParameter("dniRegis");
                String nombres = request.getParameter("nombresRegis");
                String direccion = request.getParameter("direccionRegis");
                String correo = request.getParameter("correoRegis");
                String password = request.getParameter("passwordRegis");

                int resultado = cdao.registrarCliente(dni, nombres, direccion, correo, password);

                if (resultado == 0) {
                    request.setAttribute("usuarioDuplicado", "El usuario ya se encuentra registrado");
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                } else if (resultado > 0) {
                    Cliente cliente = new Cliente(resultado, dni, nombres, direccion, correo, password);
                    request.setAttribute("mensaje", "Gracias por Registrarse");
                    System.out.println("id: " + cliente.getId());
                    request.getRequestDispatcher("mensaje.jsp").forward(request, response);
                } else {
                    System.out.println("ERROR DE SQL");
                }
                break;

            case "iniciarSesion":
                String correoLog = request.getParameter("correoLog");
                String passwordLog = request.getParameter("passwordLog");
                cliente = cdao.autenticarCliente(correoLog, passwordLog);
                if (cliente == null) {
                    request.setAttribute("usuarioNoRegistrado", "Debe Registrarse Previamente");
                    request.getRequestDispatcher("registro.jsp").forward(request, response);
                } else {
                    request.setAttribute("mensaje", "BIENVENIDO DE NUEVO");
                    request.getRequestDispatcher("mensaje.jsp").forward(request, response);
                }
                break;
            case "cerrarSesion":
                cliente = null;
            default:
                request.setAttribute("productos", productos);
                if (cliente == null) {
                    request.setAttribute("usuario", null);
                } else {
                    request.setAttribute("usuario", cliente.getNombre());
                }

                request.getRequestDispatcher("home.jsp").forward(request, response);
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
