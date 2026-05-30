package servlet;

import dao.RoomDAO;
import model.Room;
import model.User;
import java.io.IOException;
import java.util.List;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;

@WebServlet("/admin/rooms")
public class AdminRoomServlet extends HttpServlet {

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

        RoomDAO dao   = new RoomDAO();
        String idStr  = req.getParameter("id");
        String status = req.getParameter("status");

        if (idStr != null && status != null) {
            dao.updateRoomStatus(Integer.parseInt(idStr), status);
        }

        List<Room> rooms = dao.getAllRoomsWithType();
        req.setAttribute("rooms", rooms);
        req.getRequestDispatcher("/adminRooms.jsp").forward(req, res);
    }
}
