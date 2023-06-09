/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo.dao.figura;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import modelo.entidades.Conexion;
import modelo.entidades.figura.Material;

/**
 *
 * @author Angel
 */
public class MaterialDAO {

    private Connection conexion;

    public MaterialDAO() {
        this.conexion = new Conexion().getConexion();
    }

    //Método para obtener los datos de un material en base a su id
    public Material getMaterialPorId(int id) {
        Material material = null;
        try {
            PreparedStatement ps = conexion.prepareStatement("SELECT * FROM material WHERE id = ?");
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                material = new Material(id, rs.getString("nombre"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
         }
        return material;
    }

    //Método que devuelve una lista con todos los materiales existentes
    public List<Material> getListaMateriales() {
        List<Material> materiales = new ArrayList();
        Material material;
        try {
            PreparedStatement ps = conexion.prepareStatement("SELECT * FROM material");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                material = new Material(rs.getInt("id"), rs.getString("nombre"));
                materiales.add(material);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return materiales;
    }
    
    //Método que devuelve una lista de los materiales que componen la figura en base al id de la misma
      public List<Material> getListaMateriales(int idFigura) {
        List<Material> materiales = new ArrayList();
        Material material;
        try {
           PreparedStatement ps = conexion.prepareStatement("SELECT m.nombre " +
                     "FROM Figura f JOIN FiguraMaterial fm ON f.id = fm.idFigura " +
                     "JOIN Material m ON fm.idMaterial = m.id WHERE f.id = ?");
           
            ps.setInt(1, idFigura);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                material = new Material(rs.getString("nombre"));
                materiales.add(material);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return materiales;

    }
}
