
package controladores;

import com.google.gson.Gson;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.dao.PersonajeDAO;
import modelo.dao.figura.FiguraDAO;
import modelo.dao.figura.MaterialDAO;
import modelo.dao.figura.ProveedorDAO;
import modelo.entidades.figura.Figura;

/**
 *
 * @author Angel
 */
@WebServlet(name = "RellenarTabla", urlPatterns = {"/RellenarTabla"})
public class RellenarTabla extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String tablaAMostrar = request.getParameter("tabla");
        Gson gson = new Gson();

        String resultado = "";

        switch (tablaAMostrar) {

            case "Figura":
                FiguraDAO fdao = new FiguraDAO();
                PersonajeDAO pjdao = new PersonajeDAO();
                ProveedorDAO pdao = new ProveedorDAO();
                MaterialDAO mdao = new MaterialDAO();
                List<Figura> figuras = fdao.getListaFiguras();

                List<Map<String, Object>> nuevaListaFiguras = new ArrayList();

                for (Figura figura : figuras) {

                    Map<String, Object> nuevaFigura = new HashMap();
                    nuevaFigura.put("Id", figura.getId());
                    nuevaFigura.put("Primera Imagen", figura.getImagenes().get(0).getUrl());
                    nuevaFigura.put("Segunda Imagen", figura.getImagenes().get(1).getUrl());
                    nuevaFigura.put("Tercera Imagen", figura.getImagenes().get(2).getUrl());
                    nuevaFigura.put("Personaje", figura.getPersonaje().getNombre());
                    nuevaFigura.put("Nombre", figura.getNombre());
                    nuevaFigura.put("Descripción", figura.getDescripcion());
                    nuevaFigura.put("Fecha de salida", figura.getFechaSalida());
                    nuevaFigura.put("Precio", figura.getPrecio());
                    nuevaFigura.put("Stock", figura.getStock());
                    nuevaFigura.put("Altura", figura.getAltura());
                    nuevaFigura.put("Descuento", figura.getPorcentajeDescuento());
                    nuevaFigura.put("Proveedor", figura.getProveedor().getNombre());
                    nuevaFigura.put("Material", figura.getMaterial().getNombre());
                    nuevaFigura.put("Personajes", pjdao.getListaPersonajes());
                    nuevaFigura.put("Materiales", mdao.getListaMateriales());
                    nuevaFigura.put("Proveedores", pdao.getListaProveedores());

                    nuevaListaFiguras.add(nuevaFigura);
                }

                resultado = gson.toJson(nuevaListaFiguras);
                pdao.cerrarConexion();
                fdao.cerrarConexion();
                pjdao.cerrarConexion();
                mdao.cerrarConexion();
                break;
           /* case "Pedido":
                PedidoDAO pedidos = new PedidoDAO();

                List<Map<String, Object>> nuevaListaPedidos = new ArrayList();

                for (Figura figura : figuras) {

                   
                    nuevaListaFiguras.add(nuevaFigura);
                }

                resultado = gson.toJson(nuevaListaFiguras);
                
                break;*/
        }

        // Configura la respuesta como JSON
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        // Envía la respuesta JSON al cliente
        PrintWriter out = response.getWriter();
        out.print(resultado);
        out.flush();
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
