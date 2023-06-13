
package modelo.entidades;

import modelo.dao.PersonajeDAO;

/**
 *
 * @author Angel
 */
public class Personaje {
    
    private int id;
    private String nombre;
    private int idSerie;
    private String url;

    public Personaje(int id, String nombre, int idSerie, String url) {
        this.id = id;
        this.nombre = nombre;
        this.idSerie = idSerie;
        this.url = url;
    }

    public Personaje(String nombre, int idSerie, String url) {
        this.nombre = nombre;
        this.idSerie = idSerie;
        this.url = url;
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

    public int getIdSerie() {
        return idSerie;
    }

    public void setIdSerie(int idSerie) {
        this.idSerie = idSerie;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }
   
    public String getNombreSerie(){
        PersonajeDAO pjdao = new PersonajeDAO();
        String serie = pjdao.getSerie(nombre);
        pjdao.cerrarConexion();
        return serie;
    }
    
}


