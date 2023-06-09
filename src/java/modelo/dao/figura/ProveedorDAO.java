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
import modelo.entidades.figura.Proveedor;

/**
 *
 * @author Angel
 */
public class ProveedorDAO {

    private Connection conexion;

    public ProveedorDAO() {
        this.conexion = new Conexion().getConexion();
    }

    //Método para obtener los datos de un proveedor en base a su id
    public Proveedor getProveedorPorId(int id) {
        Proveedor proveedor = null;
        try {
            PreparedStatement ps = conexion.prepareStatement("SELECT * FROM proveedor WHERE id = ?");
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                proveedor = new Proveedor(id, rs.getString("nombre"), rs.getString("imagenUrl"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return proveedor;
    }

    //Método que devuelve una lista con todos los proveedores existentes
    public List<Proveedor> getListaProveedores() {
        List<Proveedor> proveedores = new ArrayList();
        Proveedor proveedor;
        try {
            PreparedStatement ps = conexion.prepareStatement("SELECT * FROM proveedor");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                proveedor = new Proveedor(rs.getInt("id"), rs.getString("nombre"), rs.getString("imagenUrl"));
                proveedores.add(proveedor);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return proveedores;
    }
}
