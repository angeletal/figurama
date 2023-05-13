package modelo.entidades;

/**
 *
 * @author Angel
 */
public class Usuario {

    private int id;
    private String nombre;
    private String apellidos;
    private String contra;
    private String email;
    private String direccion;
    private String telefono;
    private int puntos;
    private boolean esBaja;
    private String rol;

    
    // Constructor vacio, se usa a la hora de guardar un usuario
    public Usuario() {
    }

    public Usuario(String nombre, String apellidos, String contra, String email, String direccion, String telefono, int puntos, boolean esBaja, String rol) {
        this.nombre = nombre;
        this.apellidos = apellidos;
        this.contra = contra;
        this.email = email;
        this.direccion = direccion;
        this.telefono = telefono;
        this.puntos = puntos;
        this.esBaja = esBaja;
        this.rol = rol;
    }
    
    // Constructor usado a la hora de guardar un usuario en la BD

    public Usuario(int id, String nombre, String apellidos, String contra, String email, String direccion, String telefono, int puntos, boolean esBaja, String rol) {
        this.id = id;
        this.nombre = nombre;
        this.apellidos = apellidos;
        this.contra = contra;
        this.email = email;
        this.direccion = direccion;
        this.telefono = telefono;
        this.puntos = puntos;
        this.esBaja = esBaja;
        this.rol = rol;
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

    public String getApellidos() {
        return apellidos;
    }

    public void setApellidos(String apellidos) {
        this.apellidos = apellidos;
    }

    public String getContra() {
        return contra;
    }

    public void setContra(String contra) {
        this.contra = contra;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public int getPuntos() {
        return puntos;
    }

    public void setPuntos(int puntos) {
        this.puntos = puntos;
    }

    public boolean isEsBaja() {
        return esBaja;
    }
    
    public void setEsBaja(boolean esBaja) {
        this.esBaja = esBaja;
    }

    public String getRol() {
        return rol;
    }

    public void setRol(String rol) {
        this.rol = rol;
    }
}    
