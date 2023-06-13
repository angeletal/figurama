/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import modelo.entidades.Conexion;
import modelo.entidades.Personaje;

/**
 *
 * @author Angel
 */
public class PersonajeDAO {

    private Connection conexion;

    public PersonajeDAO() {
        this.conexion = new Conexion().getConexion();
    }
    
    public void cerrarConexion() {
        try {
            conexion.close();
        } catch (SQLException e) {
            System.err.println("Error al cerrar la conexión: " + e.getMessage());
        }
    }

    //Método para obtener los datos de un personaje en base a su id
    public Personaje getPersonajePorId(int id) {
        Personaje personaje = null;
        try {
            PreparedStatement ps = conexion.prepareStatement("SELECT * FROM personaje WHERE id = ?");
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                personaje = new Personaje(rs.getString("nombre"), rs.getInt("idSerie"), rs.getString("imagenURL"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return personaje;
    }

    //Método para obtener los datos de un personaje en base a su nombre
    public Personaje getPersonajePorNombre(String nombre) {
        Personaje personaje = null;
        try {
            PreparedStatement ps = conexion.prepareStatement("SELECT * FROM personaje WHERE LOWER(nombre) = ?");
            ps.setString(1, nombre);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                personaje = new Personaje(rs.getInt("id"),rs.getString("nombre"), rs.getInt("idSerie"), rs.getString("imagenURL"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return personaje;
    }

    //Método para obtener los personajes de una serie en base a su nombre
    public List<Personaje> getPersonajesPorSerie(String nombreSerie) {
        List<Personaje> personajes = new ArrayList();
        try {
            PreparedStatement ps = conexion.prepareStatement("SELECT p.* FROM personaje p JOIN serie s ON p.idSerie = s.id WHERE s.nombre = ?");
            ps.setString(1, nombreSerie.toLowerCase());
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                personajes.add(new Personaje(rs.getString("nombre"), rs.getInt("idSerie"), rs.getString("imagenURL")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return personajes;
    }
    
    
     //Método para obtener la seria a la que pertenece un personaje
    public String getSerie(String nombrePersonaje) {
        String nombre="";
        try {
            PreparedStatement ps = conexion.prepareStatement("SELECT s.nombre FROM serie s JOIN personaje p ON p.idSerie = s.id WHERE p.nombre = ?");
            ps.setString(1, nombrePersonaje.toLowerCase());
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                nombre=rs.getString(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return nombre;
    }
    
     public List<Personaje> getListaPersonajes() {
        List<Personaje> personajes = new ArrayList();
        Personaje personaje;
        try {
            PreparedStatement ps = conexion.prepareStatement("SELECT * FROM personaje");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                personaje = new Personaje(rs.getInt("id"), rs.getString("nombre"),rs.getInt("idSerie") , rs.getString("imagenUrl"));
                personajes.add(personaje);
                }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return personajes;

    }


}
