/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo.entidades;

import modelo.entidades.figura.Figura;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import modelo.dao.CestaDAO;
import modelo.dao.figura.FiguraDAO;
import modelo.dao.ListaDeseosDAO;
import modelo.dao.SerieDAO;
import modelo.dao.figura.ProveedorDAO;
import modelo.entidades.figura.Proveedor;

/**
 *
 * @author Angel
 */
public class CargarDatos {

    HttpSession sesion;

    public CargarDatos(HttpServletRequest request) {
        this.sesion = request.getSession();
    }

    public void iniciarDatos() {

    }

    public void cargarFiguras() {
        FiguraDAO fdao = new FiguraDAO();
        List<Figura> figuras = fdao.getListaFiguras();
        sesion.setAttribute("figuras", figuras);
    }

    public void cargarProveedores() {
        ProveedorDAO pdao = new ProveedorDAO();
        List<Proveedor> proveedores = pdao.getListaProveedores();
        sesion.setAttribute("proveedores", proveedores);
    }

    public void cargarFranquicias() {
        SerieDAO sdao = new SerieDAO();
        List<Serie> series = sdao.getListaSeries();
        sesion.setAttribute("franquicias", series);
    }

    public void cargarListaDeseos() {
        if (sesion.getAttribute("usuario") != null) {
            ListaDeseosDAO lddao = new ListaDeseosDAO();
            List<ArticuloListaDeseos> listaDeseos = lddao.obtenerListaDeseos(((Usuario) sesion.getAttribute("usuario")).getId());
            //cosas
            sesion.setAttribute("listaDeseos", listaDeseos);
        }
    }

    public void cargarCesta() {
        if (sesion.getAttribute("usuario") != null) {
            CestaDAO cdao = new CestaDAO();
            List<ArticuloCesta> articulos = cdao.obtenerCesta(((Usuario) sesion.getAttribute("usuario")).getId());
            if(!articulos.isEmpty()){
            Cesta cesta = new Cesta(articulos);
            sesion.setAttribute("cesta", cesta);
        }}
    }

}
