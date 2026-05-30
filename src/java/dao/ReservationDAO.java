// ReservationDAO - Accès aux données des réservations
// Auteur : Yousra Benrhalem
// Description : Gestion CRUD des réservations hotel BlueWave

package dao;

import java.sql.*;
import java.util.*;
import model.*;

public class ReservationDAO {

    public int createReservation(Reservation res, int[] serviceIds) {
        Connection con = null;
        try {
            con = DBConnection.getConnection();
            con.setAutoCommit(false);

            // 1. Trouver une chambre LIBRE pour ce type et ces dates
            RoomDAO roomDAO = new RoomDAO();
            Room room = roomDAO.findAvailableRoom(
                res.getRoomTypeId(), res.getCheckin(), res.getCheckout()
            );
            if (room == null) return -1;

            // 2. Créer la réservation avec statut CONFIRMED
            String sql =
                "INSERT INTO reservations " +
                "(client_name, client_email, client_phone, room_type_id, room_id, " +
                "checkin, checkout, status, total_price, card_last4) " +
                "VALUES (?,?,?,?,?,?,?,'CONFIRMED',?,?)";

            PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, res.getClientName());
            ps.setString(2, res.getClientEmail());
            ps.setString(3, res.getClientPhone());
            ps.setInt(4, res.getRoomTypeId());
            ps.setInt(5, room.getId());
            ps.setString(6, res.getCheckin());
            ps.setString(7, res.getCheckout());
            ps.setDouble(8, res.getTotalPrice());
            ps.setString(9, res.getCardLast4());
            ps.executeUpdate();

            ResultSet keys = ps.getGeneratedKeys();
            int reservationId = 0;
            if (keys.next()) reservationId = keys.getInt(1);

            // 3. ✅ Bloquer la chambre → statut OCCUPEE
            roomDAO.updateRoomStatus(room.getId(), "OCCUPEE", con);

            // 4. Sauvegarder les services
            if (serviceIds != null && serviceIds.length > 0 && reservationId > 0) {
                PreparedStatement psSvc = con.prepareStatement(
                    "INSERT INTO reservation_services(reservation_id, service_id) VALUES(?,?)"
                );
                for (int svcId : serviceIds) {
                    psSvc.setInt(1, reservationId);
                    psSvc.setInt(2, svcId);
                    psSvc.addBatch();
                }
                psSvc.executeBatch();
            }

            con.commit();
            return reservationId;

        } catch (Exception e) {
            try { if (con != null) con.rollback(); } catch (Exception ignored) {}
            e.printStackTrace();
            return -1;
        }
    }

    // Admin annule → chambre redevient LIBRE
    public void cancelReservation(int reservationId) {
        try {
            Connection con = DBConnection.getConnection();
            con.setAutoCommit(false);

            // Récupérer l'ID de la chambre liée
            PreparedStatement psGet = con.prepareStatement(
                "SELECT room_id FROM reservations WHERE id = ?"
            );
            psGet.setInt(1, reservationId);
            ResultSet rs = psGet.executeQuery();

            int roomId = 0;
            if (rs.next()) roomId = rs.getInt("room_id");

            // Annuler la réservation
            PreparedStatement psUpd = con.prepareStatement(
                "UPDATE reservations SET status='CANCELLED' WHERE id=?"
            );
            psUpd.setInt(1, reservationId);
            psUpd.executeUpdate();

            // ✅ Libérer la chambre
            if (roomId > 0) {
                new RoomDAO().updateRoomStatus(roomId, "LIBRE", con);
            }

            con.commit();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<Reservation> getAllReservations() {
        List<Reservation> list = new ArrayList<>();
        try {
            Connection con = DBConnection.getConnection();
            String sql =
                "SELECT res.*, rt.name as type_name, rt.price as type_price, " +
                "r.room_number, r.status as room_status " +
                "FROM reservations res " +
                "LEFT JOIN room_types rt ON res.room_type_id = rt.id " +
                "LEFT JOIN rooms r ON res.room_id = r.id " +
                "ORDER BY res.id DESC";
            ResultSet rs = con.prepareStatement(sql).executeQuery();
            ServiceDAO svcDAO = new ServiceDAO();
            while (rs.next()) {
                Reservation r = map(rs);
                r.setServices(svcDAO.getByReservationId(r.getId()));
                list.add(r);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    public List<Reservation> getByEmail(String email) {
        List<Reservation> list = new ArrayList<>();
        try {
            Connection con = DBConnection.getConnection();
            String sql =
                "SELECT res.*, rt.name as type_name, rt.price as type_price, " +
                "r.room_number, r.status as room_status " +
                "FROM reservations res " +
                "LEFT JOIN room_types rt ON res.room_type_id = rt.id " +
                "LEFT JOIN rooms r ON res.room_id = r.id " +
                "WHERE res.client_email = ? ORDER BY res.id DESC";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            ServiceDAO svcDAO = new ServiceDAO();
            while (rs.next()) {
                Reservation r = map(rs);
                r.setServices(svcDAO.getByReservationId(r.getId()));
                list.add(r);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    public void updateStatus(int id, String status) {
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(
                "UPDATE reservations SET status=? WHERE id=?"
            );
            ps.setString(1, status);
            ps.setInt(2, id);
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    private Reservation map(ResultSet rs) throws SQLException {
        Reservation r = new Reservation();
        r.setId(rs.getInt("id"));
        r.setClientName(rs.getString("client_name"));
        r.setClientEmail(rs.getString("client_email"));
        r.setClientPhone(rs.getString("client_phone"));
        r.setRoomTypeId(rs.getInt("room_type_id"));
        r.setRoomId(rs.getInt("room_id"));
        r.setCheckin(rs.getString("checkin"));
        r.setCheckout(rs.getString("checkout"));
        r.setStatus(rs.getString("status"));
        r.setTotalPrice(rs.getDouble("total_price"));
        r.setCardLast4(rs.getString("card_last4"));
        r.setCreatedAt(rs.getString("created_at"));
        r.setRoomTypeName(rs.getString("type_name"));
        r.setRoomNumber(rs.getString("room_number"));
        r.setRoomTypePrice(rs.getDouble("type_price"));
        r.setRoomStatus(rs.getString("room_status"));
        return r;
    }
}