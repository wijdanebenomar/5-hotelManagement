package servlet;

import dao.ReservationDAO;
import model.Reservation;
import model.User;
import java.io.IOException;
import java.util.List;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;

@WebServlet("/admin/reservations")
public class AdminReservationServlet extends HttpServlet {

    private boolean isAdmin(HttpServletRequest req) {
        HttpSession session = req.getSession(false);
        if (session == null) return false;
        User u = (User) session.getAttribute("loggedUser");
        return u != null && "ADMIN".equals(u.getRole());
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        if (!isAdmin(req)) {
            res.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        ReservationDAO dao = new ReservationDAO();
        String action = req.getParameter("action");
        String idStr  = req.getParameter("id");

        if (action != null && idStr != null) {
            int id = Integer.parseInt(idStr);
            if ("cancel".equals(action)) {
                dao.cancelReservation(id);
            }
        }

        List<Reservation> reservations = dao.getAllReservations();
        req.setAttribute("reservations", reservations);
        req.getRequestDispatcher("/adminReservations.jsp").forward(req, res);
    }
}
