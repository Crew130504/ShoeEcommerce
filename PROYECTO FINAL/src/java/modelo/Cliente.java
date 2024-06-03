package modelo;

public class Cliente extends Persona {
    private int id;
    private String correo;
    private String password;

    public Cliente() {
    }

    public Cliente(int id, String dni, String nombre, String direccion, String correo, String password) {
        super(dni,nombre,direccion);
        this.id = id;
        this.correo = correo;
        this.password = password;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCorreo() {
        return correo;
    }

    public void setCorreo(String correo) {
        this.correo = correo;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
    
    
    
}
