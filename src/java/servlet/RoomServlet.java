/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package servlet;

import dao.*;
import model.*;
import java.io.IOException;
import java.util.List;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;

@WebServlet("/rooms")
public class RoomServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String checkin  = req.getParameter("checkin");
        String checkout = req.getParameter("checkout");

        List<RoomType> types = new RoomTypeDAO().getAllRoomTypes();
        List<Service>  services = new ServiceDAO().getAllServices();

        req.setAttribute("roomTypes", types);
        req.setAttribute("services",  services);
        req.setAttribute("checkin",   checkin);
        req.setAttribute("checkout",  checkout);

        req.getRequestDispatcher("rooms.jsp").forward(req, res);
    }
}