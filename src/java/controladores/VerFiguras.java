/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controladores;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.dao.PersonajeDAO;
import modelo.dao.figura.FiguraDAO;
import modelo.entidades.figura.Figura;

/**
 *
 * @author Angel
 */
@WebServlet(name = "VerFiguras", urlPatterns = {"/franquicias/personajes/*"})
public class VerFiguras extends HttpServlet {

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
        response.setContentType("text/html;charset=UTF-8");

        String figuraParam = request.getPathInfo();
        if (figuraParam == null || figuraParam.equals("/")) {
            response.sendRedirect("../franquicias");
            return;
        }

        String nombre = figuraParam.substring(1).replace("+", " ");

        FiguraDAO fdao = new FiguraDAO();
        PersonajeDAO pjdao = new PersonajeDAO();
        if (pjdao.getPersonajePorNombre(nombre) == null) {
            response.sendRedirect("../../error.jsp");
            return;
        } else {
            List<Figura> figuras = fdao.getListaFiguras(nombre, "no");
            if(!figuras.isEmpty()){
            request.setAttribute("figurasP", figuras);
            }
           request.setAttribute("serieP", pjdao.getSerie(nombre));
            request.setAttribute("nombre", nombre);
            fdao.cerrarConexion();
            pjdao.cerrarConexion();
            getServletContext().getRequestDispatcher("/personaje.jsp").forward(request, response);

        }
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
