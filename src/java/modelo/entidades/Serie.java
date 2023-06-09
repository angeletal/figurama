/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo.entidades;

/**
 *
 * @author Angel
 */
public class Serie {
private int id;
private String url;
private String nombre;
private String descripcion;

    public Serie(int id, String url, String nombre, String descripcion) {
        this.id = id;
        this.url = url;
        this.nombre = nombre;
        this.descripcion = descripcion;
    }

    public Serie(String url, String nombre, String descripcion) {
        this.url = url;
        this.nombre = nombre;
        this.descripcion = descripcion;
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

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }


}

//