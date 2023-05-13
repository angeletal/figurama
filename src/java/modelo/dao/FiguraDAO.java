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
import modelo.entidades.Figura;

/**
 *
 * @author Angel
 */
public class FiguraDAO {

    private Connection conexion;

    public FiguraDAO() {
        this.conexion = new Conexion().getConexion();
    }

    public Figura getFiguraPorId(int id) {
        Figura figura = null;
        try {
            PreparedStatement ps = conexion.prepareStatement("SELECT * FROM figura WHERE id = ?");
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                figura = new Figura(id,rs.getString("nombre"),rs.getString("descripcion"), rs.getDate("fechaSalida"), rs.getDouble("precio") , rs.getInt("stock"), rs.getInt("altura"), rs.getInt("idPersonaje"), rs.getInt("idProveedor"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return figura;
    }
    
    public List<Figura> getListaFiguras(){
        List<Figura> figuras = new ArrayList();
        Figura f=null;
        try {
            PreparedStatement ps = conexion.prepareStatement("SELECT * FROM figura");
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                f = new Figura(rs.getInt("id"),rs.getString("nombre"),rs.getString("descripcion"), rs.getDate("fechaSalida"), rs.getDouble("precio") , rs.getInt("stock"), rs.getInt("altura"), rs.getInt("idPersonaje"), rs.getInt("idProveedor"));
                figuras.add(f);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return figuras;
    
    }
}
