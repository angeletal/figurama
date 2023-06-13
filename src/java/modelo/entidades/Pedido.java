package modelo.entidades;

import java.util.Date;
import java.util.List;
import modelo.dao.PedidoDAO;

/**
 *
 * @author Angel
 */
public class Pedido {

    private int id;
    private Date fecha;
    private String estado;
    private int idUsuario;
    private String direccion;

    public Pedido(int id, Date fecha, String estado, int idUsuario, String direccion) {
        this.id = id;
        this.fecha = fecha;
        this.estado = estado;
        this.idUsuario = idUsuario;
        this.direccion = direccion;

    }

    public Pedido(Date fecha, String estado, int idUsuario, String direccion) {
        this.fecha = fecha;
        this.estado = estado;
        this.idUsuario = idUsuario;
        this.direccion = direccion;

    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public int getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
    }

    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    public List<ArticuloPedido> getArticulos() {
        PedidoDAO pdao = new PedidoDAO();
        List<ArticuloPedido> articulos = pdao.obtenerDatosPedido(id);
        pdao.cerrarConexion();
        return articulos;
    }

   

}
