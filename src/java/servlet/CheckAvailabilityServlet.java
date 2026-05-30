/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlet;

import dao.*;
import model.*;
import java.io.IOException;
import java.util.List;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;

@WebServlet("/check-availability")
public class CheckAvailabilityServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        int    roomTypeId = Integer.parseInt(req.getParameter("roomTypeId"));
        String checkin    = req.getParameter("checkin");
        String checkout   = req.getParameter("checkout");
        String name       = req.getParameter("name");
        String email      = req.getParameter("email");
        String phone      = req.getParameter("phone");
        String[] services = req.getParameterValues("services");

        RoomDAO roomDAO = new RoomDAO();
        boolean available = roomDAO.hasAvailableRoom(roomTypeId, checkin, checkout);

        if (!available) {
            // Pas de chambre dispo → retour rooms.jsp avec message
            req.setAttribute("errorMsg",
                "❌ Aucune chambre disponible pour ce type aux dates choisies. " +
                "Veuillez nous contacter ou choisir d'autres dates.");
            req.setAttribute("roomTypes", new RoomTypeDAO().getAllRoomTypes());
            req.setAttribute("services",  new ServiceDAO().getAllServices());
            req.setAttribute("checkin",   checkin);
            req.setAttribute("checkout",  checkout);
            req.getRequestDispatcher("rooms.jsp").forward(req, res);
            return;
        }

        // Chambre dispo → calculer le total et aller au paiement
        RoomType roomType = new RoomTypeDAO().getById(roomTypeId);

        // Calcul du nombre de nuits
        long nights = 1;
        try {
            java.time.LocalDate ci = java.time.LocalDate.parse(checkin);
            java.time.LocalDate co = java.time.LocalDate.parse(checkout);
            nights = java.time.temporal.ChronoUnit.DAYS.between(ci, co);
            if (nights <= 0) nights = 1;
        } catch (Exception ignored) {}

        double roomTotal = roomType.getPrice() * nights;
        double servicesTotal = 0;
        List<model.Service> selectedServices = new java.util.ArrayList<>();

        if (services != null) {
            selectedServices = new ServiceDAO().getByIds(services);
            for (model.Service s : selectedServices) {
                servicesTotal += s.getPrice();
            }
        }

        double total = roomTotal + servicesTotal;

        // Mettre tout en session pour l'étape paiement
        HttpSession session = req.getSession();
        session.setAttribute("pay_roomTypeId",  roomTypeId);
        session.setAttribute("pay_checkin",     checkin);
        session.setAttribute("pay_checkout",    checkout);
        session.setAttribute("pay_name",        name);
        session.setAttribute("pay_email",       email);
        session.setAttribute("pay_phone",       phone);
        session.setAttribute("pay_services",    services);
        session.setAttribute("pay_roomType",    roomType);
        session.setAttribute("pay_selServices", selectedServices);
        session.setAttribute("pay_nights",      nights);
        session.setAttribute("pay_total",       total);

        res.sendRedirect("payment.jsp");
    }
}