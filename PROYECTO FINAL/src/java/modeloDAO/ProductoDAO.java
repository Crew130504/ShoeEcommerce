package modeloDAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import config.Conexion;
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletResponse;
import modelo.Producto;

public class ProductoDAO {

    Connection con;
    Conexion cn = new Conexion();
    PreparedStatement ps;
    ResultSet rs;

    public Producto listarId(int id) {
        String sql = "select * from producto where idProducto=" + id;
        Producto p = new Producto();
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                p.setId(rs.getInt(1));
                p.setNombres(rs.getString(2));
                p.setFoto(rs.getBinaryStream(3));
                p.setDescripcion(rs.getString(4));
                p.setPrecio(rs.getDouble(5));
            }
        } catch (Exception e) {

        }
        return p;
    }

    public int eliminarProducto(int id) {
        String sql = "DELETE FROM producto WHERE idProducto = ?";
        int resultado = 0; // Variable para controlar el número de filas afectadas

        try {
            con = cn.getConnection(); // Obtener la conexión
            ps = con.prepareStatement(sql); // Preparar la sentencia SQL
            ps.setInt(1, id); // Asignar el id al parámetro de la consulta

            resultado = ps.executeUpdate(); // Ejecutar la actualización

        } catch (Exception e) {
            e.printStackTrace(); // Imprimir la excepción en caso de error
        } finally {
            try {
                if (ps != null) {
                    ps.close(); // Cerrar PreparedStatement
                }
                if (con != null) {
                    con.close(); // Cerrar la conexión
                }
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }

        return resultado; // Devolver el número de filas afectadas
    }

    public List listar() {
        List<Producto> productos = new ArrayList();
        String sql = "SELECT * FROM producto";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Producto p = new Producto();
                p.setId(rs.getInt(1));
                p.setNombres(rs.getString(2));
                p.setFoto(rs.getBinaryStream(3));
                p.setDescripcion(rs.getString(4));
                p.setPrecio(rs.getDouble(5));
                productos.add(p);
            }
        } catch (Exception e) {
        }
        return productos;
    }

    public void listarImg(int id, HttpServletResponse response) {
        String sql = "SELECT * FROM producto WHERE idProducto=" + id;
        InputStream inputStream = null;
        OutputStream outputStream = null;
        BufferedInputStream bufferedInputStream = null;
        BufferedOutputStream bufferedOutputStream = null;

        try {
            outputStream = response.getOutputStream();
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            if (rs.next()) {
                inputStream = rs.getBinaryStream("Foto");
            }
            bufferedInputStream = new BufferedInputStream(inputStream);
            bufferedOutputStream = new BufferedOutputStream(outputStream);
            int i = 0;
            while ((i = bufferedInputStream.read()) != -1) {
                bufferedOutputStream.write(i);
            }
        } catch (Exception e) {
        }
    }

    public int guardarOActualizarProducto(Producto producto) {
        int resultado = 0;
        String sqlExistencia = "SELECT COUNT(*) FROM producto WHERE idProducto = ?";
        String sqlUpdate = "UPDATE producto SET nombres = ?, foto = ?, descripcion = ?, precio = ? WHERE idProducto = ?";
        String sqlInsert = "INSERT INTO producto (nombres, foto, descripcion, precio) VALUES (?, ?, ?, ?, ?)";

        try {
            con = cn.getConnection(); // Obtener la conexión
            
            // Primero, verificar si el producto existe
            ps = con.prepareStatement(sqlExistencia);
            ps.setInt(1, producto.getId());
            rs = ps.executeQuery();
            int count = 0;
            if (rs.next()) {
                count = rs.getInt(1);
            }
            rs.close();
            ps.close();

            if (count == 0) {
                // Si el producto no existe, insertarlo
                ps = con.prepareStatement(sqlInsert);
                ps.setString(1, producto.getNombres());
                ps.setBinaryStream(2, producto.getFoto());
                ps.setString(3, producto.getDescripcion());
                ps.setDouble(4, producto.getPrecio());
                resultado = ps.executeUpdate();
            } else {
                // Si el producto existe, actualizarlo
                ps = con.prepareStatement(sqlUpdate);
                ps.setString(1, producto.getNombres());
                ps.setBinaryStream(2, producto.getFoto());
                ps.setString(3, producto.getDescripcion());
                ps.setDouble(4, producto.getPrecio()); 
                ps.setInt(5, producto.getId());
                resultado = ps.executeUpdate();
            }
        } catch (Exception e) {
            e.printStackTrace(); // Imprimir la excepción en caso de error
        } finally {
            try {
                if (ps != null) {
                    ps.close(); // Cerrar PreparedStatement
                }
                if (con != null) {
                    con.close(); // Cerrar la conexión
                }
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }

        return resultado; // Devolver el número de filas afectadas
    }

}
