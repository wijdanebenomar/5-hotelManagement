package servlet;

import dao.*;
import model.*;
import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;

@WebServlet("/pay")
public class PaymentServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession();

        if (session.getAttribute("pay_roomTypeId") == null) {
            res.sendRedirect("index.jsp");
            return;
        }

        int      roomTypeId = (int)      session.getAttribute("pay_roomTypeId");
        String   checkin    = (String)   session.getAttribute("pay_checkin");
        String   checkout   = (String)   session.getAttribute("pay_checkout");
        String   services[] = (String[]) session.getAttribute("pay_services");
        double   total      = (double)   session.getAttribute("pay_total");

        // Use logged-in user data if available, else use session form data
        User loggedUser = (User) session.getAttribute("loggedUser");
        String name, email, phone;
        if (loggedUser != null) {
            name  = loggedUser.getName();
            email = loggedUser.getEmail();
            phone = loggedUser.getPhone() != null ? loggedUser.getPhone() : "";
        } else {
            name  = (String) session.getAttribute("pay_name");
            email = (String) session.getAttribute("pay_email");
            phone = (String) session.getAttribute("pay_phone");
        }

        String cardNumber = req.getParameter("cardNumber");
        if (cardNumber == null) cardNumber = "";
        cardNumber = cardNumber.replace(" ", "");
        String cardLast4 = cardNumber.length() >= 4
            ? cardNumber.substring(cardNumber.length() - 4) : "0000";

        Reservation reservation = new Reservation();
        reservation.setClientName(name);
        reservation.setClientEmail(email);
        reservation.setClientPhone(phone);
        reservation.setRoomTypeId(roomTypeId);
        reservation.setCheckin(checkin);
        reservation.setCheckout(checkout);
        reservation.setTotalPrice(total);
        reservation.setCardLast4(cardLast4);
        reservation.setStatus("CONFIRMED");

        int[] serviceIds = null;
        if (services != null && services.length > 0) {
            serviceIds = new int[services.length];
            for (int i = 0; i < services.length; i++)
                serviceIds[i] = Integer.parseInt(services[i]);
        }

        int reservationId = new ReservationDAO().createReservation(reservation, serviceIds);

        // Cleanup session
        session.removeAttribute("pay_roomTypeId");
        session.removeAttribute("pay_checkin");
        session.removeAttribute("pay_checkout");
        session.removeAttribute("pay_name");
        session.removeAttribute("pay_email");
        session.removeAttribute("pay_phone");
        session.removeAttribute("pay_services");
        session.removeAttribute("pay_roomType");
        session.removeAttribute("pay_selServices");
        session.removeAttribute("pay_nights");
        session.removeAttribute("pay_total");

        if (reservationId > 0) {
            if (loggedUser != null) {
                // Logged-in client → go to their dashboard
                res.sendRedirect("client/dashboard?success=1");
            } else {
                // Guest → go to reservations by email
                res.sendRedirect("my-reservations?email=" + email + "&success=1");
            }
        } else {
            res.sendRedirect("index.jsp?error=1");
        }
    }
}
