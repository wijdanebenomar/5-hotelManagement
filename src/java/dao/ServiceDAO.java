package dao;

import java.sql.*;
import java.util.*;
import model.Service;

public class ServiceDAO {

    public List<Service> getAllServices() {
        List<Service> list = new ArrayList<>();
        try {
            Connection con = DBConnection.getConnection();
            ResultSet rs = con.prepareStatement("SELECT * FROM services").executeQuery();
            while (rs.next()) list.add(map(rs));
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    public List<Service> getByIds(String[] ids) {
        List<Service> list = new ArrayList<>();
        if (ids == null || ids.length == 0) return list;
        try {
            Connection con = DBConnection.getConnection();
            StringBuilder sb = new StringBuilder("SELECT * FROM services WHERE id IN (");
            for (int i = 0; i < ids.length; i++) sb.append(i > 0 ? ",?" : "?");
            sb.append(")");
            PreparedStatement ps = con.prepareStatement(sb.toString());
            for (int i = 0; i < ids.length; i++) ps.setInt(i + 1, Integer.parseInt(ids[i]));
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(map(rs));
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    public List<Service> getByReservationId(int reservationId) {
        List<Service> list = new ArrayList<>();
        try {
            Connection con = DBConnection.getConnection();
            String sql =
                "SELECT s.* FROM services s " +
                "JOIN reservation_services rs ON s.id = rs.service_id " +
                "WHERE rs.reservation_id = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, reservationId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(map(rs));
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    private Service map(ResultSet rs) throws SQLException {
        Service s = new Service();
        s.setId(rs.getInt("id"));
        s.setName(rs.getString("name"));
        s.setPrice(rs.getDouble("price"));
        return s;
    }

    public void add(Service s) {
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO services(name, price) VALUES (?,?)"
            );
            ps.setString(1, s.getName());
            ps.setDouble(2, s.getPrice());
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    public void update(Service s) {
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(
                "UPDATE services SET name=?, price=? WHERE id=?"
            );
            ps.setString(1, s.getName());
            ps.setDouble(2, s.getPrice());
            ps.setInt(3, s.getId());
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    public void delete(int id) {
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement("DELETE FROM services WHERE id=?");
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }
}
