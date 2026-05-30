<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, model.*, model.User" %>
<%
User _admin = (User) session.getAttribute("loggedUser");
if (_admin == null || !"ADMIN".equals(_admin.getRole())) { response.sendRedirect(request.getContextPath() + "/login"); return; }
Map<String, Map<String,Object>> clientMap = (Map<String, Map<String,Object>>) request.getAttribute("clientMap");
if (clientMap == null) clientMap = new java.util.LinkedHashMap<>();
double grandTotal = 0;
for (Map<String,Object> c : clientMap.values()) grandTotal += (double) c.get("total");
%>
<!DOCTYPE html><html lang="fr"><head>
<meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>BlueWave | Gestion des Clients</title>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Playfair+Display:ital,wght@0,400;0,600;1,400&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<style><%@ include file="adminStyle.css" %></style>
<!-- Gestion des clients - Yousra Benrhalem -->
</head><body><div class="layout">
<aside class="sidebar">
  <div class="sidebar-brand"><div class="brand-icon"><i class="fa-solid fa-water"></i></div><div><div class="brand-name">Blue Wave</div><div class="brand-sub">Administration</div></div></div>
  <div class="sidebar-admin"><div class="admin-avatar"><%= _admin.getName().substring(0,1).toUpperCase() %></div><div><div class="admin-name"><%= _admin.getName() %></div><div class="admin-role">Administrateur</div></div></div>
  <nav class="sidebar-nav">
    <div class="nav-section">Gestion</div>
    <a href="dashboard" class="nav-item"><i class="fa-solid fa-gauge-high"></i>Tableau de bord</a>
    <a href="reservations" class="nav-item"><i class="fa-solid fa-calendar-check"></i>Réservations</a>
    <a href="rooms" class="nav-item"><i class="fa-solid fa-bed"></i>Chambres</a>
    <a href="room-types" class="nav-item"><i class="fa-solid fa-layer-group"></i>Types de chambres</a>
    <a href="services" class="nav-item"><i class="fa-solid fa-concierge-bell"></i>Services</a>
    <a href="clients" class="nav-item active"><i class="fa-solid fa-users"></i>Clients</a>
    <div class="nav-section" style="margin-top:16px;">Compte</div>
    <a href="../index.jsp" class="nav-item"><i class="fa-solid fa-house"></i>Site public</a>
    <a href="../logout" class="nav-item danger"><i class="fa-solid fa-right-from-bracket"></i>Déconnexion</a>
  </nav>
</aside>
<main class="main-content">
  <div class="page-header">
    <div><div class="page-eyebrow">Gestion</div><h1 class="page-title">Clients</h1></div>
  </div>

  <!-- STATS -->
  <div class="stats-row" style="grid-template-columns:repeat(3,1fr);">
    <div class="stat-card"><div class="stat-icon slate"><i class="fa-solid fa-users"></i></div><div class="stat-info"><div class="stat-val"><%= clientMap.size() %></div><div class="stat-lbl">Clients uniques</div></div></div>
    <div class="stat-card"><div class="stat-icon amber"><i class="fa-solid fa-coins"></i></div><div class="stat-info"><div class="stat-val"><%= String.format("%.0f", grandTotal) %></div><div class="stat-lbl">Revenus totaux (MAD)</div></div></div>
    <div class="stat-card"><div class="stat-icon glacier"><i class="fa-solid fa-chart-line"></i></div><div class="stat-info"><div class="stat-val"><%= clientMap.size() > 0 ? String.format("%.0f", grandTotal / clientMap.size()) : "0" %></div><div class="stat-lbl">Dépense moyenne / client</div></div></div>
  </div>

  <!-- SEARCH -->
  <div class="card" style="margin-bottom:20px;">
    <div class="card-body" style="padding:16px 22px;">
      <div class="form-group" style="max-width:360px;">
        <label>Rechercher un client</label>
        <div style="position:relative;">
          <i class="fa-solid fa-magnifying-glass" style="position:absolute;left:12px;top:50%;transform:translateY(-50%);color:var(--text-light);font-size:13px;"></i>
          <input type="text" id="searchInput" placeholder="Nom ou email..." oninput="filterClients(this.value)"
            style="padding-left:36px;width:100%;padding:10px 10px 10px 36px;border:1px solid var(--border);border-radius:8px;font-family:Inter,sans-serif;font-size:13px;color:var(--text-dark);">
        </div>
      </div>
    </div>
  </div>

  <!-- CLIENTS GRID -->
  <% if (clientMap.isEmpty()) { %>
  <div class="card">
    <div class="empty-cell" style="padding:60px;"><i class="fa-solid fa-users" style="font-size:40px;color:var(--glacier);display:block;margin-bottom:12px;"></i>Aucun client pour le moment.</div>
  </div>
  <% } else { %>
  <div class="clients-grid" id="clientsGrid">
    <% for (Map<String,Object> client : clientMap.values()) {
      String cName  = (String) client.get("name");
      String cEmail = (String) client.get("email");
      String cPhone = (String) client.get("phone");
      double cTotal = (double) client.get("total");
      List<Reservation> cRes = (List<Reservation>) client.get("reservations");
      long cConfirmed = cRes.stream().filter(r -> "CONFIRMED".equals(r.getStatus())).count();
      String initials = cName != null && cName.length() > 0 ? cName.substring(0,1).toUpperCase() : "?";
    %>
    <div class="client-card" data-search="<%= (cName != null ? cName.toLowerCase() : "") + " " + cEmail.toLowerCase() %>">
      <div class="client-avatar"><%= initials %></div>
      <div style="flex:1;min-width:0;">
        <div class="client-name"><%= cName != null ? cName : "—" %></div>
        <div class="client-info"><i class="fa-regular fa-envelope"></i><span style="overflow:hidden;text-overflow:ellipsis;white-space:nowrap;"><%= cEmail %></span></div>
        <% if (cPhone != null && !cPhone.isEmpty()) { %>
        <div class="client-info"><i class="fa-solid fa-phone"></i><span><%= cPhone %></span></div>
        <% } %>
        <div style="margin-top:8px;display:flex;gap:6px;flex-wrap:wrap;">
          <span class="badge badge-confirmed"><%= cRes.size() %> réservation<%= cRes.size() > 1 ? "s" : "" %></span>
          <% if (cConfirmed > 0) { %><span class="svc-tag"><%= cConfirmed %> active<%= cConfirmed > 1 ? "s" : "" %></span><% } %>
        </div>
        <div class="client-total">
          <div><div class="client-total-label">Total dépensé</div><div class="client-total-sub">réservations confirmées</div></div>
          <div style="text-align:right;"><div class="client-total-amount"><%= String.format("%.2f", cTotal) %></div><div class="client-total-sub">MAD</div></div>
        </div>
        <div style="margin-top:10px;">
          <a href="reservations" class="btn-edit-sm" style="font-size:11px;"><i class="fa-solid fa-list"></i> Voir réservations</a>
        </div>
      </div>
    </div>
    <% } %>
  </div>
  <% } %>
</main>
</div>
<script>
function filterClients(val) {
  const q = val.toLowerCase();
  document.querySelectorAll('.client-card').forEach(c => {
    c.style.display = c.dataset.search.includes(q) ? '' : 'none';
  });
}
</script>
</body></html>
