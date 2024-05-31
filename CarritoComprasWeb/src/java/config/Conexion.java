package config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class Conexion {
    private static Connection cn = null;
    private static final String driver="com.mysql.jdbc.Driver";
    private static String URLDB = "jdbc:mysql://localhost:3306/shoeecommerce";
    private static String usuario = "root";
    private static String contrasena = "";
    
    public static Connection getConnection () {
        try {
            Class.forName(driver);
            cn = DriverManager.getConnection(URLDB, usuario, contrasena);
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } catch (ClassNotFoundException ex) {
            ex.printStackTrace();
        }
        return cn;
    }
    public static void desconectar () {
        cn = null;
    }
    
}