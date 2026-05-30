package servlet;

import dao.RoomTypeDAO;
import model.RoomType;
import model.User;
import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;

@WebServlet("/admin/room-types")
public class RoomTypeServlet extends HttpServlet {

    private RoomTypeDAO dao = new RoomTypeDAO();

    private boolean isAdmin(HttpServletRequest req) {
        HttpSession session = req.getSession(false);
        if (session == null) return false;
        User u = (User) session.getAttribute("loggedUser");
        return u != null && "ADMIN".equals(u.getRole());
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        if (!isAdmin(req)) { res.sendRedirect(req.getContextPath() + "/login"); return; }
        req.setAttribute("roomTypes", dao.getAllRoomTypes());
        req.getRequestDispatcher("/adminRoomTypes.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        if (!isAdmin(req)) { res.sendRedirect(req.getContextPath() + "/login"); return; }

        String action = req.getParameter("action");
        if ("delete".equals(action)) {
            dao.delete(Integer.parseInt(req.getParameter("id")));
        } else {
            RoomType r = new RoomType();
            r.setName(req.getParameter("name"));
            r.setPrice(Double.parseDouble(req.getParameter("price")));
            r.setImage(req.getParameter("image"));
            r.setDescription(req.getParameter("description"));
            if ("add".equals(action)) {
                dao.add(r);
            } else if ("update".equals(action)) {
                r.setId(Integer.parseInt(req.getParameter("id")));
                dao.update(r);
            }
        }
        res.sendRedirect(req.getContextPath() + "/admin/room-types");
    }
}
