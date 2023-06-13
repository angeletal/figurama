
package modelo.entidades;

/**
 *
 * @author Angel
 */
public class Serie {
private int id;
private String url;
private String nombre;

    public Serie(int id, String url, String nombre) {
        this.id = id;
        this.url = url;
        this.nombre = nombre;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }


}

