// RoomDAO - Accès aux données des chambres
// Auteur : Yousra Benrhalem
// Description : Gestion CRUD des chambres hotel BlueWave
package dao;

import java.sql.*;
import java.util.*;
import model.Room;

public class RoomDAO {

    // Vérifie dispo : chambre LIBRE + pas de résa active sur ces dates
    public boolean hasAvailableRoom(int typeId, String checkin, String checkout) {
        return findAvailableRoom(typeId, checkin, checkout) != null;
    }

    public Room findAvailableRoom(int typeId, String checkin, String checkout) {
        try {
            Connection con = DBConnection.getConnection();
            String sql =
                "SELECT * FROM rooms r " +
                "WHERE r.type_id = ? " +
                "AND r.status = 'LIBRE' " +
                "AND r.id NOT IN (" +
                "  SELECT room_id FROM reservations " +
                "  WHERE room_id IS NOT NULL " +
                "  AND status != 'CANCELLED' " +
                "  AND (? < checkout AND ? > checkin)" +
                ") LIMIT 1";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, typeId);
            ps.setString(2, checkout);
            ps.setString(3, checkin);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Room r = new Room();
                r.setId(rs.getInt("id"));
                r.setRoomNumber(rs.getString("room_number"));
                r.setTypeId(rs.getInt("type_id"));
                r.setStatus(rs.getString("status"));
                return r;
            }
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }

    // ✅ Avec connexion partagée (pour transaction)
    public void updateRoomStatus(int roomId, String status, Connection con) throws Exception {
        PreparedStatement ps = con.prepareStatement(
            "UPDATE rooms SET status=? WHERE id=?"
        );
        ps.setString(1, status);
        ps.setInt(2, roomId);
        ps.executeUpdate();
    }

    // Sans connexion partagée (pour appel admin direct)
    public void updateRoomStatus(int roomId, String status) {
        try {
            Connection con = DBConnection.getConnection();
            updateRoomStatus(roomId, status, con);
        } catch (Exception e) { e.printStackTrace(); }
    }

    public List<Room> getAllRoomsWithType() {
        List<Room> list = new ArrayList<>();
        try {
            Connection con = DBConnection.getConnection();
            String sql =
                "SELECT r.*, rt.name as type_name " +
                "FROM rooms r " +
                "JOIN room_types rt ON r.type_id = rt.id " +
                "ORDER BY r.type_id, r.room_number";
            ResultSet rs = con.prepareStatement(sql).executeQuery();
            while (rs.next()) {
                Room r = new Room();
                r.setId(rs.getInt("id"));
                r.setRoomNumber(rs.getString("room_number"));
                r.setTypeId(rs.getInt("type_id"));
                r.setStatus(rs.getString("status"));
                r.setTypeName(rs.getString("type_name"));
                list.add(r);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }
}