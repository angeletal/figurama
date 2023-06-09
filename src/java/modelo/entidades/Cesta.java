/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo.entidades;

import java.util.List;

/**
 *
 * @author Angel
 */
public class Cesta {

    private List<ArticuloCesta> cesta;

    public Cesta(List<ArticuloCesta> cesta) {
        this.cesta = cesta;
    }

    public int getTamano() {
        return cesta.size();
    }

    public ArticuloCesta getArticulo(int i) {
        return cesta.get(i);
    }

    public void setArticulo(int indice, ArticuloCesta articulo) {
        cesta.set(indice, articulo);
    }

    public void anadir(ArticuloCesta articulo) {
        cesta.add(articulo);
    }

    public boolean contiene(ArticuloCesta articulo) {
        return cesta.contains(articulo);
    }

    public List<ArticuloCesta> getArticulos() {
        return cesta;
    }

    public double getPrecioTotal() {
        double total = 0;
        for (ArticuloCesta articulo : cesta) {

            total += articulo.getFigura().getPrecioConDescuento()* articulo.getCantidad();
        }

        return Math.floor(total * 100) / 100;
    }

    public double getIva() {
        return Math.floor(getPrecioTotal() * 0.21 * 100) / 100;
    }

    public double getPrecioConIva() {
        return Math.floor((getPrecioTotal() + getIva()) * 100) / 100;
    }

    public void eliminarArticulo(int i) {
        cesta.remove(i);
    }


}
