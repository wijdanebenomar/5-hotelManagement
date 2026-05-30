package servlet;

import dao.UserDAO;
import dao.ReservationDAO;
import model.User;
import model.Reservation;
import java.io.IOException;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;

@WebServlet("/admin/clients")
public class AdminClientServlet extends HttpServlet {

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

        // Get all reservations grouped by client email
        ReservationDAO resDAO = new ReservationDAO();
        List<Reservation> allRes = resDAO.getAllReservations();

        // Build client summary: email -> {name, phone, reservations, total}
        Map<String, Map<String,Object>> clientMap = new LinkedHashMap<>();
        for (Reservation r : allRes) {
            String email = r.getClientEmail();
            if (email == null) continue;
            if (!clientMap.containsKey(email)) {
                Map<String,Object> m = new LinkedHashMap<>();
                m.put("name",  r.getClientName());
                m.put("email", email);
                m.put("phone", r.getClientPhone());
                m.put("reservations", new ArrayList<Reservation>());
                m.put("total", 0.0);
                clientMap.put(email, m);
            }
            @SuppressWarnings("unchecked")
            List<Reservation> list = (List<Reservation>) clientMap.get(email).get("reservations");
            list.add(r);
            if (!"CANCELLED".equals(r.getStatus())) {
                double cur = (double) clientMap.get(email).get("total");
                clientMap.get(email).put("total", cur + r.getTotalPrice());
            }
        }

        req.setAttribute("clientMap", clientMap);
        req.getRequestDispatcher("/adminClients.jsp").forward(req, res);
    }
}
