<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, model.*, model.User" %>
<%
User _admin = (User) session.getAttribute("loggedUser");
if (_admin == null || !"ADMIN".equals(_admin.getRole())) { response.sendRedirect(request.getContextPath() + "/login"); return; }
List<Reservation> reservations = (List<Reservation>) request.getAttribute("reservations");
if (reservations == null) reservations = new java.util.ArrayList<>();
double totalRevenue = reservations.stream().filter(r -> "CONFIRMED".equals(r.getStatus())).mapToDouble(Reservation::getTotalPrice).sum();
long confirmed = reservations.stream().filter(r -> "CONFIRMED".equals(r.getStatus())).count();
long cancelled = reservations.stream().filter(r -> "CANCELLED".equals(r.getStatus())).count();
long pending   = reservations.stream().filter(r -> "PENDING".equals(r.getStatus())).count();
// latest 8
List<Reservation> recent = reservations.size() > 8 ? reservations.subList(0, 8) : reservations;
%>
<!DOCTYPE html>
<html lang="fr">
<head>
<meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>BlueWave | Tableau de bord Admin</title><link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@300;400;500;600&family=DM+Serif+Display:ital@0;1&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<style><%@ include file="adminStyle.css" %></style>
</head>
<body>
<div class="layout">
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
    <a href="dashboard" class="nav-item active"><i class="fa-solid fa-gauge-high"></i>Tableau de bord</a>
    <a href="reservations" class="nav-item"><i class="fa-solid fa-calendar-check"></i>Réservations</a>
    <a href="rooms" class="nav-item"><i class="fa-solid fa-bed"></i>Chambres</a>
    <a href="room-types" class="nav-item"><i class="fa-solid fa-layer-group"></i>Types de chambres</a>
    <a href="services" class="nav-item"><i class="fa-solid fa-concierge-bell"></i>Services</a>
    <a href="clients" class="nav-item"><i class="fa-solid fa-users"></i>Clients</a>
    <div class="nav-section">Compte</div>
    <a href="../index.jsp" class="nav-item"><i class="fa-solid fa-house"></i>Site public</a>
    <a href="../logout" class="nav-item danger"><i class="fa-solid fa-right-from-bracket"></i>Déconnexion</a>
  </nav>
</aside>
<main class="main-content">
  <div class="page-header">
    <div>
      <div class="page-eyebrow">Vue d'ensemble</div>
      <h1 class="page-title">Tableau de bord</h1>
    </div>
    <a href="reservations" class="btn btn-primary"><i class="fa-solid fa-calendar-plus"></i> Voir toutes les réservations</a>
  </div>

  <!-- KPI STATS -->
  <div class="stats-row" style="grid-template-columns:repeat(4,1fr);">
    <div class="stat-card">
      <div class="stat-icon navy"><i class="fa-solid fa-calendar-check"></i></div>
      <div class="stat-info">
        <div class="stat-val"><%= reservations.size() %></div>
        <div class="stat-lbl">Total réservations</div>
      </div>
    </div>
    <div class="stat-card">
      <div class="stat-icon green"><i class="fa-solid fa-circle-check"></i></div>
      <div class="stat-info">
        <div class="stat-val"><%= confirmed %></div>
        <div class="stat-lbl">Confirmées</div>
      </div>
    </div>
    <div class="stat-card">
      <div class="stat-icon amber"><i class="fa-solid fa-clock"></i></div>
      <div class="stat-info">
        <div class="stat-val"><%= pending %></div>
        <div class="stat-lbl">En attente</div>
      </div>
    </div>
    <div class="stat-card">
      <div class="stat-icon slate"><i class="fa-solid fa-coins"></i></div>
      <div class="stat-info">
        <div class="stat-val"><%= String.format("%.0f", totalRevenue) %></div>
        <div class="stat-lbl">Revenus MAD (confirmés)</div>
      </div>
    </div>
  </div>

  <!-- SECONDARY STATS ROW -->
  <div class="stats-row" style="grid-template-columns:repeat(3,1fr); margin-bottom:28px;">
    <div class="stat-card">
      <div class="stat-icon red"><i class="fa-solid fa-ban"></i></div>
      <div class="stat-info">
        <div class="stat-val"><%= cancelled %></div>
        <div class="stat-lbl">Annulées</div>
      </div>
    </div>
    <div class="stat-card">
      <div class="stat-icon slate"><i class="fa-solid fa-percent"></i></div>
      <div class="stat-info">
        <div class="stat-val"><%= reservations.size() > 0 ? String.format("%.0f", (confirmed * 100.0 / reservations.size())) : "0" %>%</div>
        <div class="stat-lbl">Taux de confirmation</div>
      </div>
    </div>
    <div class="stat-card">
      <div class="stat-icon green"><i class="fa-solid fa-arrow-trend-up"></i></div>
      <div class="stat-info">
        <div class="stat-val"><%= confirmed > 0 ? String.format("%.0f", totalRevenue / confirmed) : "0" %></div>
        <div class="stat-lbl">Revenu moy. / réservation</div>
      </div>
    </div>
  </div>

  <!-- RECENT RESERVATIONS -->
  <div class="card">
    <div class="card-header">
      <h2 class="card-title"><i class="fa-solid fa-clock-rotate-left"></i> Dernières réservations</h2>
      <a href="reservations" class="btn-edit-sm"><i class="fa-solid fa-arrow-right"></i> Tout voir</a>
    </div>
    <div class="table-wrap">
      <table>
        <thead>
          <tr>
            <th>#</th>
            <th>Client</th>
            <th>Chambre</th>
            <th>Check-in</th>
            <th>Check-out</th>
            <th>Total</th>
            <th>Statut</th>
          </tr>
        </thead>
        <tbody>
          <% if (recent.isEmpty()) { %>
          <tr><td colspan="7" class="empty-cell"><i class="fa-regular fa-calendar-xmark" style="font-size:32px;display:block;margin-bottom:10px;"></i>Aucune réservation pour le moment</td></tr>
          <% } %>
          <% for (Reservation r : recent) {
            String statusClass = "CONFIRMED".equals(r.getStatus()) ? "badge-confirmed" : "CANCELLED".equals(r.getStatus()) ? "badge-cancelled" : "badge-pending";
            String statusLabel = "CONFIRMED".equals(r.getStatus()) ? "Confirmée" : "CANCELLED".equals(r.getStatus()) ? "Annulée" : "En attente";
          %>
          <tr>
            <td class="id-cell">#<%= r.getId() %></td>
            <td class="name-cell"><%= r.getClientName() != null ? r.getClientName() : "—" %></td>
            <td>
              <span class="room-type"><%= r.getRoomTypeName() != null ? r.getRoomTypeName() : "—" %></span>
              <% if(r.getRoomNumber() != null) { %><span class="room-num">N° <%= r.getRoomNumber() %></span><% } %>
            </td>
            <td class="small-cell"><%= r.getCheckin() %></td>
            <td class="small-cell"><%= r.getCheckout() %></td>
            <td class="price-cell"><%= String.format("%.0f", r.getTotalPrice()) %> <span class="currency">MAD</span></td>
            <td><span class="badge <%= statusClass %>"><%= statusLabel %></span></td>
          </tr>
          <% } %>
        </tbody>
      </table>
    </div>
  </div>

  <!-- QUICK LINKS -->
  <div style="display:grid; grid-template-columns:repeat(4,1fr); gap:14px; margin-top:8px;">
    <a href="reservations" style="text-decoration:none;">
      <div class="card" style="margin-bottom:0; padding:20px 22px; display:flex; align-items:center; gap:14px; cursor:pointer; transition:box-shadow .2s,transform .2s;" onmouseover="this.style.boxShadow='0 4px 20px rgba(2,39,54,0.10)';this.style.transform='translateY(-2px)'" onmouseout="this.style.boxShadow='';this.style.transform=''">
        <div class="stat-icon navy"><i class="fa-solid fa-calendar-check"></i></div>
        <div><div style="font-weight:600;font-size:13px;color:var(--text-dark);">Réservations</div><div style="font-size:11px;color:var(--text-light);margin-top:2px;">Gérer</div></div>
      </div>
    </a>
    <a href="rooms" style="text-decoration:none;">
      <div class="card" style="margin-bottom:0; padding:20px 22px; display:flex; align-items:center; gap:14px; cursor:pointer; transition:box-shadow .2s,transform .2s;" onmouseover="this.style.boxShadow='0 4px 20px rgba(2,39,54,0.10)';this.style.transform='translateY(-2px)'" onmouseout="this.style.boxShadow='';this.style.transform=''">
        <div class="stat-icon slate"><i class="fa-solid fa-bed"></i></div>
        <div><div style="font-weight:600;font-size:13px;color:var(--text-dark);">Chambres</div><div style="font-size:11px;color:var(--text-light);margin-top:2px;">Gérer</div></div>
      </div>
    </a>
    <a href="services" style="text-decoration:none;">
      <div class="card" style="margin-bottom:0; padding:20px 22px; display:flex; align-items:center; gap:14px; cursor:pointer; transition:box-shadow .2s,transform .2s;" onmouseover="this.style.boxShadow='0 4px 20px rgba(2,39,54,0.10)';this.style.transform='translateY(-2px)'" onmouseout="this.style.boxShadow='';this.style.transform=''">
        <div class="stat-icon green"><i class="fa-solid fa-concierge-bell"></i></div>
        <div><div style="font-weight:600;font-size:13px;color:var(--text-dark);">Services</div><div style="font-size:11px;color:var(--text-light);margin-top:2px;">Gérer</div></div>
      </div>
    </a>
    <a href="clients" style="text-decoration:none;">
      <div class="card" style="margin-bottom:0; padding:20px 22px; display:flex; align-items:center; gap:14px; cursor:pointer; transition:box-shadow .2s,transform .2s;" onmouseover="this.style.boxShadow='0 4px 20px rgba(2,39,54,0.10)';this.style.transform='translateY(-2px)'" onmouseout="this.style.boxShadow='';this.style.transform=''">
        <div class="stat-icon amber"><i class="fa-solid fa-users"></i></div>
        <div><div style="font-weight:600;font-size:13px;color:var(--text-dark);">Clients</div><div style="font-size:11px;color:var(--text-light);margin-top:2px;">Gérer</div></div>
      </div>
    </a>
  </div>
</main>
</div>
</body>
</html>
