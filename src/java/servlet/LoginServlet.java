package servlet;

import dao.UserDAO;
import model.User;
import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        // If already logged in, redirect
        HttpSession session = req.getSession(false);
        if (session != null && session.getAttribute("loggedUser") != null) {
            User u = (User) session.getAttribute("loggedUser");
            if ("ADMIN".equals(u.getRole())) {
                res.sendRedirect(req.getContextPath() + "/admin/reservations");
            } else {
                res.sendRedirect(req.getContextPath() + "/client/dashboard");
            }
            return;
        }
        req.getRequestDispatcher("/login.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String email    = req.getParameter("email");
        String password = req.getParameter("password");

        if (email == null || password == null || email.isEmpty() || password.isEmpty()) {
            req.setAttribute("error", "Veuillez remplir tous les champs.");
            req.getRequestDispatcher("/login.jsp").forward(req, res);
            return;
        }

        UserDAO dao = new UserDAO();
        User user = dao.findByEmailAndPassword(email.trim(), password);

        if (user == null) {
            req.setAttribute("error", "Email ou mot de passe incorrect.");
            req.setAttribute("emailVal", email);
            req.getRequestDispatcher("/login.jsp").forward(req, res);
            return;
        }

        HttpSession session = req.getSession(true);
        session.setAttribute("loggedUser", user);
        session.setMaxInactiveInterval(3600); // 1 hour

        if ("ADMIN".equals(user.getRole())) {
            res.sendRedirect(req.getContextPath() + "/admin/reservations");
        } else {
            res.sendRedirect(req.getContextPath() + "/client/dashboard");
        }
    }
}
