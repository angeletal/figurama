/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo.entidades;

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
   

    
}


