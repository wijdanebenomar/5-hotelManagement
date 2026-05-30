package servlet;

import dao.UserDAO;
import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        req.getRequestDispatcher("/register.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String name     = req.getParameter("name");
        String email    = req.getParameter("email");
        String phone    = req.getParameter("phone");
        String password = req.getParameter("password");
        String confirm  = req.getParameter("confirmPassword");

        // Validation
        if (name == null || email == null || phone == null || password == null
                || name.isEmpty() || email.isEmpty() || phone.isEmpty() || password.isEmpty()) {
            req.setAttribute("error", "Tous les champs sont obligatoires.");
            req.setAttribute("nameVal", name);
            req.setAttribute("emailVal", email);
            req.setAttribute("phoneVal", phone);
            req.getRequestDispatcher("/register.jsp").forward(req, res);
            return;
        }

        if (!password.equals(confirm)) {
            req.setAttribute("error", "Les mots de passe ne correspondent pas.");
            req.setAttribute("nameVal", name);
            req.setAttribute("emailVal", email);
            req.setAttribute("phoneVal", phone);
            req.getRequestDispatcher("/register.jsp").forward(req, res);
            return;
        }

        if (password.length() < 6) {
            req.setAttribute("error", "Le mot de passe doit contenir au moins 6 caractères.");
            req.setAttribute("nameVal", name);
            req.setAttribute("emailVal", email);
            req.setAttribute("phoneVal", phone);
            req.getRequestDispatcher("/register.jsp").forward(req, res);
            return;
        }

        UserDAO dao = new UserDAO();

        if (dao.emailExists(email.trim())) {
            req.setAttribute("error", "Un compte existe déjà avec cet email.");
            req.setAttribute("nameVal", name);
            req.setAttribute("phoneVal", phone);
            req.getRequestDispatcher("/register.jsp").forward(req, res);
            return;
        }

        boolean success = dao.register(name.trim(), email.trim(), phone.trim(), password);

        if (success) {
            res.sendRedirect(req.getContextPath() + "/login?registered=1");
        } else {
            req.setAttribute("error", "Erreur lors de la création du compte. Réessayez.");
            req.getRequestDispatcher("/register.jsp").forward(req, res);
        }
    }
}
