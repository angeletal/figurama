/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo.dao.figura;

import java.sql.Connection;
import modelo.entidades.Conexion;

/**
 *
 * @author Angel
 */
public class FiguraMaterialDAO {
     private Connection conexion;

    public FiguraMaterialDAO() {
        this.conexion = new Conexion().getConexion();
    }
}
