/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import modelo.entidades.Conexion;
import modelo.entidades.ImagenFigura;

/**
 *
 * @author Angel
 */
public class ImagenFiguraDAO {

    private Connection conexion;

    public ImagenFiguraDAO() {
        this.conexion = new Conexion().getConexion();
    }

    public boolean guardarImagen(ImagenFigura imagen) {
        boolean resultado = false;

        String sql = "INSERT INTO articulosCesta (url, idFigura) VALUES (?, ?)";
        try {
            PreparedStatement ps = conexion.prepareStatement(sql);
            ps.setString(1, imagen.getUrl());
            ps.setInt(2, imagen.getIdFigura());
            resultado = ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return resultado;
    }

    public List<ImagenFigura> obtenerImagenes(int idFigura) {
        List<ImagenFigura> imagenes = new ArrayList();
        try {
            PreparedStatement ps = conexion.prepareStatement("SELECT * FROM imagen WHERE idFigura = ?");
            ps.setInt(1, idFigura);
            ResultSet rs = ps.executeQuery();
            ImagenFigura imagenF;
            while (rs.next()) {
                imagenF = new ImagenFigura(rs.getInt("id"), rs.getString("url"), rs.getInt("idFigura"));
                imagenes.add(imagenF);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return imagenes;
    }
    
    //cosas modificar imagen
}
