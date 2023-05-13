
package modelo.entidades;

import java.util.Date;
import java.util.List;
import modelo.dao.ImagenFiguraDAO;

/**
 *
 * @author Angel
 */
public class Figura {

    private int id;
    private String nombre;
    private String descripcion;
    private Date fechaSalida;
    private double precio;
    private int stock;
    private int altura;
    private int idPersonaje;
    private int idProveedor;
    private List<ImagenFigura> imagenes;

    public Figura(){};
    
    public Figura(int id, String nombre, String descripcion, Date fechaSalida, double precio, int stock, int altura, int idPersonaje, int idProveedor) {
        this.id = id;
        this.nombre = nombre;
        this.descripcion = descripcion;
        this.fechaSalida = fechaSalida;
        this.precio = precio;
        this.stock = stock;
        this.altura = altura;
        this.idPersonaje = idPersonaje;
        this.idProveedor = idProveedor;
        
        ImagenFiguraDAO ifd = new ImagenFiguraDAO();
        imagenes = ifd.obtenerImagenes(id);
       
    }
    
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public Date getFechaSalida() {
        return fechaSalida;
    }

    public void setFechaSalida(Date fechaSalida) {
        this.fechaSalida = fechaSalida;
    }

    public double getPrecio() {
        return precio;
    }

    public void setPrecio(double precio) {
        this.precio = precio;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    public int getAltura() {
        return altura;
    }

    public void setAltura(int altura) {
        this.altura = altura;
    }

    public int getIdPersonaje() {
        return idPersonaje;
    }

    public void setIdPersonaje(int idPersonaje) {
        this.idPersonaje = idPersonaje;
    }

    public int getIdProveedor() {
        return idProveedor;
    }

    public void setIdProveedor(int idProveedor) {
        this.idProveedor = idProveedor;
    }

    public List<ImagenFigura> getImagenes() {
        return imagenes;
    }

    public void setImagenes(List<ImagenFigura> imagenes) {
        this.imagenes = imagenes;
    }

    // Función para obtener la primera imagen de la figura y usarla como miniatura
    public String getPrimeraImagen(){
        return imagenes.get(0).getUrl();
    }
    
}
