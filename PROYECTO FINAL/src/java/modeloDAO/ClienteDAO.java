package modeloDAO;

import modelo.Cliente;
import config.Conexion;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

public class ClienteDAO {

    private Connection con;
    private Statement st;
    private ResultSet rs;
    Cliente objCliente = new Cliente();
    ArrayList<Cliente> listaClientes = new ArrayList<>();

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
            st = (Statement) con.createStatement();
            // Ejecuta la consulta
            rs = st.executeQuery(consulta);

            while (rs.next()) {
                // Crea objetos ClienteVO y los agrega a la lista
                listaClientes.add(new Cliente(rs.getInt("idCliente"), rs.getString("Dni"), rs.getString("Nombres"), rs.getString("Direccion"), rs.getString("Email"), rs.getString("Password")));
            }
            // Cierra la declaración y desconecta de la base de datos
            st.close();
            Conexion.desconectar();
        } catch (Exception e) {
        }
        return listaClientes;
    }
}