package modeloDAO;

import modelo.Cliente;
import config.Conexion;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

public class ClienteDAO {

    private Connection con;
    private Statement st;
    private ResultSet rs;
    private PreparedStatement ps;
    Cliente objCliente = new Cliente();
    ArrayList<Cliente> listaClientes = new ArrayList<>();
    int r = 0;

    public ClienteDAO() {
        // Inicializa las variables de conexión y resultados a null
        this.con = null;
        this.st = null;
        this.rs = null;
    }

    public ArrayList<Cliente> listaDeClientes() {
        String consulta = "SELECT * FROM cliente";
        try {
            // Obtiene una conexión a la base de datos
            con = Conexion.getConnection();
            // Crea una declaración SQL
            st = con.createStatement();
            // Ejecuta la consulta
            rs = st.executeQuery(consulta);

            while (rs.next()) {
                // Crea objetos Cliente y los agrega a la lista
                listaClientes.add(new Cliente(rs.getInt("idCliente"), rs.getString("Dni"), rs.getString("Nombres"), rs.getString("Direccion"), rs.getString("Email"), rs.getString("Password")));
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Imprime el error en la consola para diagnóstico
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (st != null) {
                    st.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return listaClientes;
    }
    public int registrarCliente(String dni, String nombre, String direccion, String correo, String password) {
        String sqlCheck = "SELECT COUNT(*) FROM cliente WHERE Email = ? OR Dni = ?";
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = Conexion.getConnection();
            ps = con.prepareStatement(sqlCheck);
            ps.setString(1, correo);
            ps.setString(2, dni);
            rs = ps.executeQuery();

            if (rs.next() && rs.getInt(1) > 0) {
                // Si el cliente ya existe por correo o DNI (COUNT > 0), no realizar la inserción
                return 0; // Indicar que no se realizó la inserción debido a duplicado
            }

            // Si no existe, procede a insertar el nuevo cliente
            String sqlInsert = "INSERT INTO cliente (Dni, Nombres, Direccion, Email, Password) VALUES (?, ?, ?, ?, ?)";
            ps = con.prepareStatement(sqlInsert, Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, dni);
            ps.setString(2, nombre);
            ps.setString(3, direccion);
            ps.setString(4, correo);
            ps.setString(5, password);
            int r = ps.executeUpdate();

            if (r > 0) { // Verificar que se insertó el registro
                rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    int idCliente = rs.getInt(1);
                    return idCliente; // Retorna el cliente con ID asignado
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // Cerrar todos los recursos para evitar leaks
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
        return -1; // En caso de fallo o que no se haya generado una clave
    }

    public Cliente autenticarCliente(String correo, String password) {
        Cliente cliente = null;
        String sql = "SELECT * FROM cliente WHERE Email = ? AND Password = ?";
        try {
            con = Conexion.getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, correo);
            ps.setString(2, password);

            rs = ps.executeQuery();

            if (rs.next()) {
                cliente = new Cliente(
                        rs.getInt("idCliente"),
                        rs.getString("Dni"),
                        rs.getString("Nombres"),
                        rs.getString("Direccion"),
                        rs.getString("Email"),
                        rs.getString("Password")
                );
            }
            rs.close();
        } catch (SQLException e) {
        }

        return cliente;
    }

    public Cliente iniciarSesion(String correo, String password) {
        Cliente cliente = null;
        String sql = "SELECT * FROM cliente WHERE Email = ? AND Password = ?";
        try {
            con = Conexion.getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, correo);
            ps.setString(2, password);
            rs = ps.executeQuery();
            if (rs.next()) {
                cliente = new Cliente(
                        rs.getInt("idCliente"),
                        rs.getString("Dni"),
                        rs.getString("Nombres"),
                        rs.getString("Direccion"),
                        rs.getString("Email"),
                        rs.getString("Password")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Imprime el error en la consola para diagnóstico
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return cliente;
    }
}
