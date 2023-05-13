/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;
import modelo.entidades.Conexion;
import modelo.entidades.Figura;

/**
 *
 * @author Angel
 */
public class CestaDAO {

    private Connection conexion;

    public CestaDAO() {
        this.conexion = new Conexion().getConexion();
    }

    public Map<Figura, Integer> obtenerCesta(int idUsu) {
        Map<Figura, Integer> cesta = new HashMap();

        Figura figura = null;
        FiguraDAO fdao = new FiguraDAO();
        int cantidad = -1;
        try {
            PreparedStatement ps = conexion.prepareStatement("SELECT * FROM articulosCesta WHERE idUsuario = ?");
            ps.setInt(1, idUsu);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                figura = fdao.getFiguraPorId(rs.getInt("idFigura"));
                cantidad = rs.getInt("cantidad");
                cesta.put(figura, cantidad);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        cesta.put(new Figura(), 1);
        return cesta;
    }
}

