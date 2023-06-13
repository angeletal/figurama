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
import modelo.entidades.Serie;

/**
 *
 * @author Angel
 */
public class SerieDAO {

    private Connection conexion;

    public SerieDAO() {
        this.conexion = new Conexion().getConexion();
    }
    
    public void cerrarConexion() {
        try {
            conexion.close();
        } catch (SQLException e) {
            System.err.println("Error al cerrar la conexión: " + e.getMessage());
        }
    }

    public Serie getSeriePorId(int id) {
        Serie serie = null;
        try {
            PreparedStatement ps = conexion.prepareStatement("SELECT * FROM serie WHERE id = ?");
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                serie = new Serie(id, rs.getString("imagenURL"), rs.getString("nombre"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return serie;
    }
    
      public Serie getSeriePorNombre(String nombre) {
        Serie serie = null;
        try {
            PreparedStatement ps = conexion.prepareStatement("SELECT * FROM serie WHERE LOWER(nombre) = ?");
            ps.setString(1, nombre.toLowerCase());
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                serie = new Serie(rs.getInt("id"), rs.getString("imagenURL"), rs.getString("nombre"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return serie;
    }

    public List<Serie> getListaSeries() {
        List<Serie> series = new ArrayList();
        Serie serie;
        try {
            PreparedStatement ps = conexion.prepareStatement("SELECT * FROM serie");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                serie = new Serie(rs.getInt("id"), rs.getString("imagenUrl"), rs.getString("nombre"));
                series.add(serie);
                }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return series;

    }
}
