package servlet;

import dao.ReservationDAO;
import model.Reservation;
import model.User;
import java.io.IOException;
import java.util.List;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;

@WebServlet("/client/dashboard")
public class ClientDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("loggedUser") == null) {
            res.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("loggedUser");
        if ("ADMIN".equals(user.getRole())) {
            res.sendRedirect(req.getContextPath() + "/admin/reservations");
            return;
        }

        String action = req.getParameter("action");
        String idStr  = req.getParameter("id");

        ReservationDAO dao = new ReservationDAO();

        if ("cancel".equals(action) && idStr != null) {
            dao.updateStatus(Integer.parseInt(idStr), "CANCELLED");
        }

        List<Reservation> reservations = dao.getByEmail(user.getEmail());

        double totalSpent = reservations.stream()
            .filter(r -> !"CANCELLED".equals(r.getStatus()))
            .mapToDouble(Reservation::getTotalPrice)
            .sum();

        long confirmedCount = reservations.stream()
            .filter(r -> "CONFIRMED".equals(r.getStatus()))
            .count();

        req.setAttribute("reservations", reservations);
        req.setAttribute("totalSpent", totalSpent);
        req.setAttribute("confirmedCount", confirmedCount);
        req.setAttribute("success", req.getParameter("success"));

        req.getRequestDispatcher("/clientDashboard.jsp").forward(req, res);
    }
}
