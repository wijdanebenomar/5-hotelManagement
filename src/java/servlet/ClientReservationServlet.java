package servlet;

import dao.ReservationDAO;
import model.Reservation;
import java.io.IOException;
import java.util.List;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;

@WebServlet("/my-reservations")
public class ClientReservationServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String email  = req.getParameter("email");
        String action = req.getParameter("action");
        String idStr  = req.getParameter("id");

        ReservationDAO dao = new ReservationDAO();

        if ("cancel".equals(action) && idStr != null) {
            dao.updateStatus(Integer.parseInt(idStr), "CANCELLED");
        }

        if (email != null && !email.isEmpty()) {
            List<Reservation> reservations = dao.getByEmail(email);
            req.setAttribute("reservations", reservations);
        }

        req.setAttribute("email",   email);
        req.setAttribute("success", req.getParameter("success"));

        req.getRequestDispatcher("clientReservations.jsp").forward(req, res);
    }
}