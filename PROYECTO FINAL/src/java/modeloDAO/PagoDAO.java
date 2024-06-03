package modeloDAO;

import config.Conexion;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import modelo.Pago;

public class PagoDAO {

    Connection con;
    Conexion cn = new Conexion();
    PreparedStatement ps;
    ResultSet rs;
    int r = 0;

    public Pago GenerarPago(Pago pago) {
        int idcompras;
        String sql = "INSERT INTO pago(monto)value(?)";

        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
            ps.setDouble(1, pago.getMonto());
            ps.executeUpdate();
            rs = ps.getGeneratedKeys();
            if (rs.next()) {
                int idPagoGenerado = rs.getInt(1); // Obtiene el ID generado por la base de datos
                pago.setId(idPagoGenerado);    // Asigna el ID al objeto pago
            }
        } catch (Exception e) {
            return null;
        }
        return pago;
    }
}
