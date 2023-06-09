package modelo.dao;

import modelo.dao.figura.FiguraDAO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpSession;
import modelo.entidades.ArticuloCesta;
import modelo.entidades.Cesta;
import modelo.entidades.Conexion;
import modelo.entidades.Usuario;
import modelo.entidades.figura.Figura;

/**
 *
 * @author Angel
 */
public class CestaDAO {

    private Connection conexion;

    public CestaDAO() {
        this.conexion = new Conexion().getConexion();
    }

    public List<ArticuloCesta> obtenerCesta(int idUsu) {
        List<ArticuloCesta> listaDeseos = new ArrayList();

        Figura figura;
        FiguraDAO fdao = new FiguraDAO();
        int cantidad;
        try {
            PreparedStatement ps = conexion.prepareStatement("SELECT * FROM cesta WHERE idUsuario = ?");
            ps.setInt(1, idUsu);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                figura = fdao.getFiguraPorId(rs.getInt("idFigura"));
                cantidad = rs.getInt("cantidad");
                listaDeseos.add(new ArticuloCesta(figura, cantidad));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return listaDeseos;
    }

    // Método para añadir una figura a la cesta de un usuario
    public boolean anadirArticuloCesta(ArticuloCesta articulo, int idUsuario) {
        boolean resultado = false;
        String sql = "INSERT INTO cesta (idFigura, idUsuario, cantidad) VALUES (?, ?, ?)";
        try {
            PreparedStatement ps = conexion.prepareStatement(sql);
            ps.setInt(1, articulo.getFigura().getId());
            ps.setInt(2, idUsuario);
            ps.setInt(3, articulo.getCantidad());

            resultado = ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return resultado;
    }

    // Método para modificar el stock de una figura existente en la cesta de un usuario
    public void actualizarCantidad(ArticuloCesta articulo, int idUsuario) {

        String sql = "UPDATE cesta SET cantidad = ? WHERE idFigura = ? AND idUsuario = ?";
        try {
            PreparedStatement ps = conexion.prepareStatement(sql);
            ps.setInt(1, articulo.getCantidad());
            ps.setInt(2, articulo.getFigura().getId());
            ps.setInt(3, idUsuario);

            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

// Método para eliminar una figura de la lista de deseos de un usuario
    public boolean eliminarArticuloCesta(ArticuloCesta articulo, int idUsuario) {
        boolean resultado = false;

        String sql = "DELETE FROM cesta WHERE idFigura = ? AND idUsuario = ?";
        try {
            PreparedStatement ps = conexion.prepareStatement(sql);
            ps.setInt(1, articulo.getFigura().getId());
            ps.setInt(2, idUsuario);

            resultado = ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return resultado;
    }

    // Método para guardar la cesta entera del usuario, este se usa cuando un usuario
    // sin logarse añade articulos a la cesta y despues inicia sesión
    public void guardarCesta(List<ArticuloCesta> cesta, int idUsuario) {
        List<ArticuloCesta> yaEnCesta = obtenerCesta(idUsuario);

        try {
            PreparedStatement ps = conexion.prepareStatement("INSERT INTO cesta (idFigura, idUsuario, cantidad) VALUES (?, ?, ?)");
            PreparedStatement ps2 = conexion.prepareStatement("UPDATE cesta SET cantidad = LEAST(cantidad + ?, (SELECT stock FROM figura WHERE id = ?)) WHERE idFigura = ? AND idUsuario = ?");

            for (ArticuloCesta articulo : cesta) {
                if (!yaEnCesta.contains(articulo)) {
                    ps.setInt(1, articulo.getFigura().getId());
                    ps.setInt(2, idUsuario);
                    ps.setInt(3, articulo.getCantidad());
                    ps.executeUpdate();
                } else {
                    ps2.setInt(1, articulo.getCantidad());
                    ps2.setInt(2, articulo.getFigura().getId());
                    ps2.setInt(3, articulo.getFigura().getId());
                    ps2.setInt(4, idUsuario);
                    ps2.executeUpdate();
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Método para consultar si el stock que se quiere añadir esta disponible o no
    public boolean stockDisponible(ArticuloCesta articulo) {
        boolean disponible = false;
        int cantidad = articulo.getCantidad();

        String sql = "SELECT stock FROM figura WHERE id = ?";
        try {
            PreparedStatement ps = conexion.prepareStatement(sql);
            ps.setInt(1, articulo.getFigura().getId());
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                int stock = rs.getInt("stock");
                disponible = stock >= cantidad;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return disponible;
    }

    public void vaciarCesta(int idUsuario) {
        String sql = "DELETE from cesta WHERE idUsuario = ?";
        try {
            PreparedStatement ps = conexion.prepareStatement(sql);
            ps.setInt(1, idUsuario);

            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Figura> comprar(Cesta cesta, Usuario usuario) {
        List<Figura> figuras = new ArrayList();
        boolean ventaExitosa = true;

        try {
            conexion.setAutoCommit(false); // Iniciar la transacción
            FiguraDAO fdao = new FiguraDAO();

            // Verificar si hay suficiente stock para todos los productos en la cesta
            for (ArticuloCesta articulo : cesta.getArticulos()) {
                int cantidadCesta = articulo.getCantidad();
                int stock = fdao.getFiguraPorId(articulo.getFigura().getId()).getStock();
                if (cantidadCesta > stock) {
                    // No hay suficiente stock para realizar la venta
                    Figura figura = new Figura();
                    figura.setId(articulo.getFigura().getId());
                    figura.setStock(stock);
                    figura.setNombre(articulo.getFigura().getNombre());
                    figuras.add(figura);
                    ventaExitosa = false;
                }
            }

            if (ventaExitosa) {

                if (usuario != null) {
                    venderProductos(usuario.getId(), cesta);
                } else {
                    venderProductos(0, cesta);
                }
            }

            if (ventaExitosa) {
                conexion.commit(); // Confirmar la transacción
            } else {
                conexion.rollback(); // Deshacer la transacción
            }
        } catch (SQLException e) {
            // Manejar la excepción según corresponda
            e.printStackTrace();
        }

        return figuras;
    }

    private void venderProductos(int idUsuario, Cesta cesta) throws SQLException {
        List<ArticuloCesta> articulos = cesta.getArticulos(); // Obtener todos los artículos de la cesta
        FiguraDAO fdao = new FiguraDAO();

        // Si hay suficiente stock, proceder a realizar la venta
        PreparedStatement psFigura = null;
        PreparedStatement psVenta = null;

        try {
            // Desactivar el autocommit para realizar una transacción
            conexion.setAutoCommit(false);

            // Actualizar el stock de cada producto en la base de datos
            for (ArticuloCesta articulo : articulos) {
                int cantidadCesta = articulo.getCantidad();
                int stock = fdao.getFiguraPorId(articulo.getFigura().getId()).getStock();
                int nuevoStock = stock - cantidadCesta;

                // Actualizar el stock de la figura en la base de datos
                String updateStock = "UPDATE Figura SET stock = ? WHERE id = ?";
                psFigura = conexion.prepareStatement(updateStock);
                psFigura.setInt(1, nuevoStock);
                psFigura.setInt(2, articulo.getFigura().getId());
                psFigura.executeUpdate();

                // Insertar la venta en la base de datos
                String insertVenta = "INSERT INTO Venta (fecha, cantidad, precioUd,idUsuario,  idFigura) VALUES (NOW(), ? , ?, ?, ?)";
                psVenta = conexion.prepareStatement(insertVenta);
                psVenta.setInt(1, articulo.getCantidad());
                psVenta.setDouble(2, articulo.getFigura().getPrecioConIva());
                psVenta.setInt(3, idUsuario);
                psVenta.setInt(4, articulo.getFigura().getId());

                psVenta.executeUpdate();
            }
            // Confirmar la transacción
            conexion.commit();

        } catch (SQLException e) {
            // Ocurrió un error, realizar rollback de la transacción
            if (conexion != null) {
                conexion.rollback();
            }

            e.printStackTrace();
        } finally {
            // Cerrar los recursos
            if (psFigura != null) {
                psFigura.close();
            }

            if (psVenta != null) {
                psVenta.close();
            }

        }
    }
}
