package servlet;

import dao.ServiceDAO;
import model.Service;
import model.User;
import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;

@WebServlet("/admin/services")
public class ServiceServlet extends HttpServlet {

    private ServiceDAO dao = new ServiceDAO();

    private boolean isAdmin(HttpServletRequest req) {
        HttpSession session = req.getSession(false);
        if (session == null) return false;
        User u = (User) session.getAttribute("loggedUser");
        return u != null && "ADMIN".equals(u.getRole());
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        if (!isAdmin(req)) { res.sendRedirect(req.getContextPath() + "/login"); return; }
        req.setAttribute("services", dao.getAllServices());
        req.getRequestDispatcher("/adminServices.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        if (!isAdmin(req)) { res.sendRedirect(req.getContextPath() + "/login"); return; }
        String action = req.getParameter("action");
        if ("delete".equals(action)) {
            dao.delete(Integer.parseInt(req.getParameter("id")));
        } else {
            Service s = new Service();
            s.setName(req.getParameter("name"));
            s.setPrice(Double.parseDouble(req.getParameter("price")));
            if ("add".equals(action)) {
                dao.add(s);
            } else if ("update".equals(action)) {
                s.setId(Integer.parseInt(req.getParameter("id")));
                dao.update(s);
            }
        }
        res.sendRedirect(req.getContextPath() + "/admin/services");
    }
}
