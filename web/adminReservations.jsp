<%@page import="dao.ServiceDAO"%>
<%@page import="dao.RoomTypeDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, model.*"%>
<%@ page import="model.User" %>
<%
User _admin = (User) session.getAttribute("loggedUser");
if (_admin == null || !"ADMIN".equals(_admin.getRole())) {
    response.sendRedirect(request.getContextPath() + "/login"); return;
}
List<Reservation> reservations = (List<Reservation>) request.getAttribute("reservations");
if (reservations == null) reservations = new java.util.ArrayList<>();
double totalRevenue = reservations.stream().filter(r -> "CONFIRMED".equals(r.getStatus())).mapToDouble(Reservation::getTotalPrice).sum();
long confirmed = reservations.stream().filter(r -> "CONFIRMED".equals(r.getStatus())).count();
long cancelled = reservations.stream().filter(r -> "CANCELLED".equals(r.getStatus())).count();
%>
<!DOCTYPE html>
<html lang="fr">
<!-- Gestion des réservations - Yousra Benrhalem -->
<head>
<meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>BlueWave | Gestion des Réservations</title>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Playfair+Display:ital,wght@0,400;0,600;1,400&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<style>
<%@ include file="adminStyle.css" %>
</style>
</head>
<body>
<div class="layout">
<!-- SIDEBAR -->
<aside class="sidebar">
  <div class="sidebar-brand">
    <div class="brand-icon"><i class="fa-solid fa-water"></i></div>
    <div><div class="brand-name">Blue Wave</div><div class="brand-sub">Administration</div></div>
  </div>
  <div class="sidebar-admin">
    <div class="admin-avatar"><%= _admin.getName().substring(0,1).toUpperCase() %></div>
    <div><div class="admin-name"><%= _admin.getName() %></div><div class="admin-role">Administrateur</div></div>
  </div>
  <nav class="sidebar-nav">
    <div class="nav-section">Gestion</div>
    <a href="dashboard" class="nav-item"><i class="fa-solid fa-gauge-high"></i>Tableau de bord</a>
    <a href="reservations" class="nav-item active"><i class="fa-solid fa-calendar-check"></i>Réservations</a>
    <a href="rooms" class="nav-item"><i class="fa-solid fa-bed"></i>Chambres</a>
    <a href="room-types" class="nav-item"><i class="fa-solid fa-layer-group"></i>Types de chambres</a>
    <a href="services" class="nav-item"><i class="fa-solid fa-concierge-bell"></i>Services</a>
    <a href="clients" class="nav-item"><i class="fa-solid fa-users"></i>Clients</a>
    <div class="nav-section" style="margin-top:16px;">Compte</div>
    <a href="../index.jsp" class="nav-item"><i class="fa-solid fa-house"></i>Site public</a>
    <a href="../logout" class="nav-item danger"><i class="fa-solid fa-right-from-bracket"></i>Déconnexion</a>
  </nav>
</aside>
<!-- MAIN -->
<main class="main-content">
  <div class="page-header">
    <div><div class="page-eyebrow">Tableau de bord</div><h1 class="page-title">Réservations</h1></div>
  </div>
  <!-- STATS -->
  <div class="stats-row">
    <div class="stat-card"><div class="stat-icon slate"><i class="fa-solid fa-calendar-check"></i></div><div class="stat-info"><div class="stat-val"><%= reservations.size() %></div><div class="stat-lbl">Total réservations</div></div></div>
    <div class="stat-card"><div class="stat-icon green"><i class="fa-solid fa-circle-check"></i></div><div class="stat-info"><div class="stat-val"><%= confirmed %></div><div class="stat-lbl">Confirmées</div></div></div>
    <div class="stat-card"><div class="stat-icon red"><i class="fa-solid fa-circle-xmark"></i></div><div class="stat-info"><div class="stat-val"><%= cancelled %></div><div class="stat-lbl">Annulées</div></div></div>
    <div class="stat-card"><div class="stat-icon amber"><i class="fa-solid fa-coins"></i></div><div class="stat-info"><div class="stat-val"><%= String.format("%.0f", totalRevenue) %></div><div class="stat-lbl">Revenus MAD</div></div></div>
  </div>
  <!-- TABLE -->
  <div class="card">
    <div class="card-header"><h2 class="card-title"><i class="fa-solid fa-list"></i> Liste des réservations</h2></div>
    <div class="table-wrap">
      <table>
        <thead><tr><th>#</th><th>Client</th><th>Email</th><th>Téléphone</th><th>Chambre</th><th>Check-in</th><th>Check-out</th><th>Services</th><th>Total</th><th>Statut</th><th>Action</th></tr></thead>
        <tbody>
          <% if (reservations.isEmpty()) { %><tr><td colspan="11" class="empty-cell"><i class="fa-regular fa-calendar-xmark"></i><br>Aucune réservation</td></tr><% } %>
          <% for (Reservation r : reservations) { %>
          <tr>
            <td class="id-cell">#<%= r.getId() %></td>
            <td class="name-cell"><%= r.getClientName() != null ? r.getClientName() : "—" %></td>
            <td class="small-cell"><%= r.getClientEmail() != null ? r.getClientEmail() : "—" %></td>
            <td class="small-cell"><%= r.getClientPhone() != null ? r.getClientPhone() : "—" %></td>
            <td><div class="room-cell"><span class="room-type"><%= r.getRoomTypeName() != null ? r.getRoomTypeName() : "—" %></span><% if(r.getRoomNumber()!=null){ %><span class="room-num">N° <%= r.getRoomNumber() %></span><% } %></div></td>
            <td><%= r.getCheckin() %></td>
            <td><%= r.getCheckout() %></td>
            <td>
              <% if (r.getServices() != null && !r.getServices().isEmpty()) { for (Service s : r.getServices()) { %>
                <span class="svc-tag"><%= s.getName() %></span>
              <% } } else { %><span class="text-muted">—</span><% } %>
            </td>
            <td class="price-cell"><%= String.format("%.2f", r.getTotalPrice()) %> <span class="currency">MAD</span></td>
            <td>
              <% String st = r.getStatus(); if ("CONFIRMED".equals(st)) { %><span class="badge badge-confirmed">Confirmé</span>
              <% } else if ("CANCELLED".equals(st)) { %><span class="badge badge-cancelled">Annulé</span>
              <% } else { %><span class="badge badge-pending"><%= st %></span><% } %>
            </td>
            <td>
              <% if ("CONFIRMED".equals(r.getStatus())) { %>
              <a href="reservations?action=cancel&id=<%= r.getId() %>" class="btn-danger-sm" onclick="return confirm('Annuler cette réservation ?')"><i class="fa-solid fa-xmark"></i> Annuler</a>
              <% } else { %><span class="text-muted">—</span><% } %>
            </td>
          </tr>
          <% } %>
        </tbody>
      </table>
    </div>
  </div>
</main>
</div>
</body></html>
