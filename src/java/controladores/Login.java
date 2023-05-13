package controladores;

import java.io.IOException;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.dao.CestaDAO;
import modelo.dao.UsuarioDAO;
import modelo.entidades.Figura;
import modelo.entidades.Usuario;

/**
 *
 * @author Angel
 */
@WebServlet(name = "Login", urlPatterns = {"/login2.jsp"})
public class Login extends HttpServlet {

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
        String error;
        if (!request.getParameter("email").isBlank() && !request.getParameter("contra").isBlank()) {
            String email = request.getParameter("email");
            String contra = request.getParameter("contra");

            //Se obtienen los usuarios de la lista obtenida por el DAO
            UsuarioDAO udao = new UsuarioDAO();
            List<Usuario> usuarios = udao.getListaUsuarios();

            for (Usuario usuario : usuarios) {
                if (usuario.getEmail().equalsIgnoreCase(email)
                        && usuario.getContra().equals(contra)) {
                    //Añado a la sesion el usuario que accede para saber en todo momento quien es
                    request.getSession().setAttribute("usuario", usuario);
                    //Si el usuario es admin que vaya al menu de admin, sino al de árbitros
                    if (udao.getUsuario(email).getRol().equals("Admin")) {
                        response.sendRedirect("pepe.jsp");
                        return;
                    } else {
                           
                      /*  cosas continuar cesta */
                        CestaDAO cdao = new CestaDAO();
                     //   if(cdao.obtenerCantidadArticulosCesta(usuario.getId())!=0){
                        Map<Figura, Integer> cesta = cdao.obtenerCesta(usuario.getId());
                        
                        request.getSession().setAttribute("cesta", cesta);
                        response.sendRedirect("index.jsp");
                        return;
                    }
                }
            }
            error = "Email o contraseña incorrectos";
            request.setAttribute("email", email);
        } else {
            if (request.getParameter("email") != null) {
                String email = request.getParameter("email");
                request.setAttribute("email", email);
            }
            error = "Debe rellenar todos los campos";
        }
        request.setAttribute("error", error);

        getServletContext().getRequestDispatcher("/login.jsp").forward(request, response);
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
