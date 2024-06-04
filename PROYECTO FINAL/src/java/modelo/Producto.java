package modelo;

import java.io.InputStream;

public class Producto {
    int id;
    String nombres;
    InputStream foto;
    String descripcion;
    double precio;

    public Producto() {
    }

    public Producto(int id, String nombres, InputStream foto, String descripcion, double precio) {
        this.id = id;
        this.nombres = nombres;
        this.foto = foto;
        this.descripcion = descripcion;
        this.precio = precio;
    }
    public Producto( String nombres, InputStream foto, String descripcion, double precio) {
        this.nombres = nombres;
        this.foto = foto;
        this.descripcion = descripcion;
        this.precio = precio;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNombres() {
        return nombres;
    }

    public void setNombres(String nombres) {
        this.nombres = nombres;
    }

    public InputStream getFoto() {
        return foto;
    }

    public void setFoto(InputStream foto) {
        this.foto = foto;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public double getPrecio() {
        return precio;
    }

    public void setPrecio(double precio) {
        this.precio = precio;
    }              
}
