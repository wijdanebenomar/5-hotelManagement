/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.*;
import java.util.*;
import model.RoomType;

public class RoomTypeDAO {

    public List<RoomType> getAllRoomTypes() {
        List<RoomType> list = new ArrayList<>();
        try {
            Connection con = DBConnection.getConnection();
            ResultSet rs = con.prepareStatement("SELECT * FROM room_types").executeQuery();
            while (rs.next()) list.add(map(rs));
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    public RoomType getById(int id) {
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT * FROM room_types WHERE id=?");
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return map(rs);
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }

    private RoomType map(ResultSet rs) throws SQLException {
        RoomType rt = new RoomType();
        rt.setId(rs.getInt("id"));
        rt.setName(rs.getString("name"));
        rt.setDescription(rs.getString("description"));
        rt.setPrice(rs.getDouble("price"));
        rt.setImage(rs.getString("image"));
        return rt;
    }
    
    
    public void add(RoomType r) {
    try {
        Connection con = DBConnection.getConnection();
        PreparedStatement ps = con.prepareStatement(
            "INSERT INTO room_types(name, price, image, description) VALUES (?,?,?,?)"
        );
        ps.setString(1, r.getName());
        ps.setDouble(2, r.getPrice());
        ps.setString(3, r.getImage());
        ps.setString(4, r.getDescription());
        ps.executeUpdate();
    } catch (Exception e) { e.printStackTrace(); }
}

public void update(RoomType r) {
    try {
        Connection con = DBConnection.getConnection();
        PreparedStatement ps = con.prepareStatement(
            "UPDATE room_types SET name=?, price=?, image=?, description=? WHERE id=?"
        );
        ps.setString(1, r.getName());
        ps.setDouble(2, r.getPrice());
        ps.setString(3, r.getImage());
        ps.setString(4, r.getDescription());
        ps.setInt(5, r.getId());
        ps.executeUpdate();
    } catch (Exception e) { e.printStackTrace(); }
}

public void delete(int id) {
    try {
        Connection con = DBConnection.getConnection();
        PreparedStatement ps = con.prepareStatement("DELETE FROM room_types WHERE id=?");
        ps.setInt(1, id);
        ps.executeUpdate();
    } catch (Exception e) { e.printStackTrace(); }
}


}
