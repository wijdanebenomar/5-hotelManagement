/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.List;

public class Reservation {
    private int id;
    private String clientName;
    private String clientEmail;
    private String clientPhone;
    private int roomTypeId;
    private int roomId;
    private String checkin;
    private String checkout;
    private String status;
    private double totalPrice;
    private String cardLast4;
    private String createdAt;
private String roomStatus;

    // Pour affichage (jointures)
    private String roomTypeName;
    private String roomNumber;
    private double roomTypePrice;
    private List<Service> services;

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getClientName() { return clientName; }
    public void setClientName(String n) { this.clientName = n; }
    public String getClientEmail() { return clientEmail; }
    public void setClientEmail(String e) { this.clientEmail = e; }
    public String getClientPhone() { return clientPhone; }
    public void setClientPhone(String p) { this.clientPhone = p; }
    public int getRoomTypeId() { return roomTypeId; }
    public void setRoomTypeId(int id) { this.roomTypeId = id; }
    public int getRoomId() { return roomId; }
    public void setRoomId(int id) { this.roomId = id; }
    public String getCheckin() { return checkin; }
    public void setCheckin(String c) { this.checkin = c; }
    public String getCheckout() { return checkout; }
    public void setCheckout(String c) { this.checkout = c; }
    public String getStatus() { return status; }
    public void setStatus(String s) { this.status = s; }
    public double getTotalPrice() { return totalPrice; }
    public void setTotalPrice(double t) { this.totalPrice = t; }
    public String getCardLast4() { return cardLast4; }
    public void setCardLast4(String c) { this.cardLast4 = c; }
    public String getCreatedAt() { return createdAt; }
    public void setCreatedAt(String c) { this.createdAt = c; }
    public String getRoomTypeName() { return roomTypeName; }
    public void setRoomTypeName(String n) { this.roomTypeName = n; }
    public String getRoomNumber() { return roomNumber; }
    public void setRoomNumber(String n) { this.roomNumber = n; }
    public double getRoomTypePrice() { return roomTypePrice; }
    public void setRoomTypePrice(double p) { this.roomTypePrice = p; }
    public List<Service> getServices() { return services; }
    public void setServices(List<Service> s) { this.services = s; }
    public String getRoomStatus() { return roomStatus; }
public void setRoomStatus(String roomStatus) { this.roomStatus = roomStatus; }
}