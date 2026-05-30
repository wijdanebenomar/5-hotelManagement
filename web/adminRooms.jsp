<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, model.*, model.User"%>
<%
User _admin = (User) session.getAttribute("loggedUser");
if (_admin == null || !"ADMIN".equals(_admin.getRole())) { response.sendRedirect(request.getContextPath() + "/login"); return; }
List<Room> rooms = (List<Room>) request.getAttribute("rooms");
if (rooms == null) rooms = new java.util.ArrayList<>();
java.util.LinkedHashSet<String> typeSet = new java.util.LinkedHashSet<>();
for (Room r : rooms) if (r.getTypeName() != null) typeSet.add(r.getTypeName());
long libre       = rooms.stream().filter(r -> "LIBRE".equals(r.getStatus())).count();
long occupee     = rooms.stream().filter(r -> "OCCUPEE".equals(r.getStatus())).count();
long nettoyage   = rooms.stream().filter(r -> "NETTOYAGE".equals(r.getStatus())).count();
long maintenance = rooms.stream().filter(r -> "MAINTENANCE".equals(r.getStatus())).count();
%>
<!DOCTYPE html>
<html lang="fr">
<!-- Gestion des chambres - Yousra Benrhalem -->
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>BlueWave | Gestion des Chambres</title>
<link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@300;400;500;600&family=DM+Serif+Display:ital@0;1&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<style>
<%@ include file="adminStyle.css" %>

/* ── FILTER TABS ── */
.filter-bar {
  display: flex; align-items: center; gap: 12px;
  margin-bottom: 20px; flex-wrap: wrap;
}
.search-wrap {
  position: relative; flex: 1; max-width: 300px;
}
.search-wrap i {
  position: absolute; left: 13px; top: 50%; transform: translateY(-50%);
  color: var(--text-light); font-size: 13px; pointer-events: none;
}
.search-wrap input {
  width: 100%; padding: 10px 14px 10px 38px;
  background: var(--white); border: 1px solid var(--border);
  border-radius: var(--radius-sm); color: var(--text-dark); font-size: 13px;
  font-family: 'DM Sans', sans-serif; transition: border-color .2s, box-shadow .2s;
}
.search-wrap input:focus { outline: none; border-color: var(--teal); box-shadow: 0 0 0 3px rgba(69,166,181,.12); }
.search-wrap input::placeholder { color: var(--text-light); }

.filter-tabs {
  display: flex; background: var(--white); border: 1px solid var(--border);
  border-radius: var(--radius-sm); overflow: hidden;
}
.ftab {
  padding: 9px 14px; font-size: 11px; font-weight: 600;
  letter-spacing: .3px; color: var(--text-light); cursor: pointer;
  transition: all .18s; border: none; background: none;
  font-family: 'DM Sans', sans-serif; white-space: nowrap;
  display: flex; align-items: center; gap: 6px;
}
.ftab:hover { color: var(--text-dark); background: var(--bg-2); }
.ftab.active { background: var(--navy); color: var(--white); }
.ftab .cnt {
  background: rgba(0,0,0,0.08); color: inherit;
  font-size: 10px; padding: 1px 6px; border-radius: 10px;
}
.ftab.active .cnt { background: rgba(255,255,255,0.2); }

.status-dot {
  width: 7px; height: 7px; border-radius: 50%; display: inline-block; flex-shrink: 0;
}

/* type select */
.type-select {
  padding: 9px 14px; background: var(--white); border: 1px solid var(--border);
  border-radius: var(--radius-sm); color: var(--text-dark); font-size: 12px;
  font-family: 'DM Sans', sans-serif; cursor: pointer; outline: none;
  transition: border-color .2s;
}
.type-select:focus { border-color: var(--teal); }

/* room number cell */
.rnum {
  font-family: 'DM Serif Display', serif;
  font-size: 20px; color: var(--navy); font-weight: 400;
}

/* type pill */
.type-pill {
  display: inline-block; padding: 4px 10px; border-radius: var(--radius-sm);
  background: var(--teal-dim); border: 1px solid var(--teal-border);
  color: var(--navy); font-size: 11px; font-weight: 600;
}

/* status badges */
.sbadge {
  display: inline-flex; align-items: center; gap: 6px;
  padding: 5px 12px; border-radius: 20px; font-size: 11px; font-weight: 600;
}
.sbadge.LIBRE       { background: var(--success-bg); color: var(--success); border: 1px solid var(--success-border); }
.sbadge.OCCUPEE     { background: var(--danger-bg);  color: var(--danger);  border: 1px solid var(--danger-border); }
.sbadge.NETTOYAGE   { background: var(--warning-bg); color: var(--warning); border: 1px solid var(--warning-border); }
.sbadge.MAINTENANCE { background: var(--bg-2); color: var(--text-mid); border: 1px solid var(--border); }

/* reservable */
.res-yes { color: var(--success); font-size: 12px; font-weight: 500; display: flex; align-items: center; gap: 5px; }
.res-no  { color: var(--danger);  font-size: 12px; font-weight: 500; display: flex; align-items: center; gap: 5px; }

/* action btns */
.action-btns { display: flex; gap: 6px; flex-wrap: wrap; }


.abtn {
  display: inline-flex; align-items: center; gap: 5px;
  padding: 6px 12px; border-radius: var(--radius-sm); font-size: 10px;
  font-weight: 700; letter-spacing: .3px; text-transform: uppercase;
  transition: all .18s; white-space: nowrap; cursor: pointer;
  font-family: 'DM Sans', sans-serif; border: none; text-decoration: none;
}
.abtn.off { opacity: .25; pointer-events: none; }
.abtn-libre     { background: var(--success-bg); color: var(--success); border: 1px solid var(--success-border); }
.abtn-libre:hover     { background: rgba(26,158,109,.2); }
.abtn-occupee   { background: var(--danger-bg);  color: var(--danger);  border: 1px solid var(--danger-border); }
.abtn-occupee:hover   { background: rgba(201,61,61,.2); }
.abtn-nettoyage { background: var(--warning-bg); color: var(--warning); border: 1px solid var(--warning-border); }
.abtn-nettoyage:hover { background: rgba(201,125,26,.2); }
.abtn-maint     { background: var(--bg-2); color: var(--text-mid); border: 1px solid var(--border); }
.abtn-maint:hover     { background: var(--border); }

.empty-row td { text-align: center; padding: 60px; color: var(--text-light); }
.empty-row td i { font-size: 36px; display: block; margin-bottom: 12px; color: var(--border); }

@media(max-width:1200px){ .stats-row{ grid-template-columns:repeat(3,1fr); } }
@media(max-width:600px) { .action-btns{ flex-direction:column; } .filter-tabs{ flex-wrap:wrap; } }
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
    <a href="<%= request.getContextPath() %>/admin/dashboard"   class="nav-item"><i class="fa-solid fa-gauge-high"></i>Tableau de bord</a>
    <a href="<%= request.getContextPath() %>/admin/reservations" class="nav-item"><i class="fa-solid fa-calendar-check"></i>Réservations</a>
    <a href="<%= request.getContextPath() %>/admin/rooms"        class="nav-item active"><i class="fa-solid fa-bed"></i>Chambres</a>
    <a href="<%= request.getContextPath() %>/admin/room-types"   class="nav-item"><i class="fa-solid fa-layer-group"></i>Types de chambres</a>
    <a href="<%= request.getContextPath() %>/admin/services"     class="nav-item"><i class="fa-solid fa-concierge-bell"></i>Services</a>
    <a href="<%= request.getContextPath() %>/admin/clients"      class="nav-item"><i class="fa-solid fa-users"></i>Clients</a>
    <div class="nav-section">Compte</div>
    <a href="<%= request.getContextPath() %>/index.jsp" class="nav-item"><i class="fa-solid fa-house"></i>Site public</a>
    <a href="<%= request.getContextPath() %>/logout"    class="nav-item danger"><i class="fa-solid fa-right-from-bracket"></i>Déconnexion</a>
  </nav>
</aside>

<!-- MAIN -->
<main class="main-content">

  <div class="page-header">
    <div>
      <div class="page-eyebrow">Gestion</div>
      <h1 class="page-title">Chambres</h1>
    </div>
  </div>

  <!-- STATS -->
  <div class="stats-row" style="grid-template-columns:repeat(5,1fr); margin-bottom:24px;">
    <div class="stat-card">
      <div class="stat-icon navy"><i class="fa-solid fa-bed"></i></div>
      <div class="stat-info"><div class="stat-val"><%= rooms.size() %></div><div class="stat-lbl">Total</div></div>
    </div>
    <div class="stat-card">
      <div class="stat-icon green"><i class="fa-solid fa-circle-check"></i></div>
      <div class="stat-info"><div class="stat-val"><%= libre %></div><div class="stat-lbl">Libres</div></div>
    </div>
    <div class="stat-card">
      <div class="stat-icon red"><i class="fa-solid fa-door-closed"></i></div>
      <div class="stat-info"><div class="stat-val"><%= occupee %></div><div class="stat-lbl">Occupées</div></div>
    </div>
    <div class="stat-card">
      <div class="stat-icon amber"><i class="fa-solid fa-broom"></i></div>
      <div class="stat-info"><div class="stat-val"><%= nettoyage %></div><div class="stat-lbl">Nettoyage</div></div>
    </div>
    <div class="stat-card">
      <div class="stat-icon slate"><i class="fa-solid fa-screwdriver-wrench"></i></div>
      <div class="stat-info"><div class="stat-val"><%= maintenance %></div><div class="stat-lbl">Maintenance</div></div>
    </div>
  </div>

  <!-- FILTER BAR -->
  <div class="filter-bar">
    <div class="search-wrap">
      <i class="fa-solid fa-magnifying-glass"></i>
      <input type="text" id="searchInput" placeholder="Rechercher par n° ou type..." oninput="filterTable()">
    </div>

    <div class="filter-tabs">
      <button class="ftab active" data-status="ALL" onclick="setStatusFilter('ALL',this)">
        Toutes <span class="cnt" id="cnt-all"><%= rooms.size() %></span>
      </button>
      <button class="ftab" data-status="LIBRE" onclick="setStatusFilter('LIBRE',this)">
        <span class="status-dot" style="background:#1a9e6d;"></span>
        Libres <span class="cnt" id="cnt-libre"><%= libre %></span>
      </button>
      <button class="ftab" data-status="OCCUPEE" onclick="setStatusFilter('OCCUPEE',this)">
        <span class="status-dot" style="background:#c93d3d;"></span>
        Occupées <span class="cnt" id="cnt-occupee"><%= occupee %></span>
      </button>
      <button class="ftab" data-status="NETTOYAGE" onclick="setStatusFilter('NETTOYAGE',this)">
        <span class="status-dot" style="background:#c97d1a;"></span>
        Nettoyage <span class="cnt" id="cnt-nettoyage"><%= nettoyage %></span>
      </button>
      <button class="ftab" data-status="MAINTENANCE" onclick="setStatusFilter('MAINTENANCE',this)">
        <span class="status-dot" style="background:#6b8fa0;"></span>
        Maintenance <span class="cnt" id="cnt-maint"><%= maintenance %></span>
      </button>
    </div>

    <select id="typeFilter" class="type-select" onchange="filterTable()">
      <option value="">Tous les types</option>
      <% for (String type : typeSet) { %>
      <option value="<%= type %>"><%= type %></option>
      <% } %>
    </select>
  </div>

  <!-- TABLE -->
  <div class="card">
    <div class="card-header">
      <h2 class="card-title"><i class="fa-solid fa-list-ul"></i> Liste des chambres</h2>
      <span style="font-size:12px; color:var(--text-light);" id="visibleCount"><%= rooms.size() %> chambre(s) affichée(s)</span>
    </div>
    <div class="table-wrap">
      <table id="roomsTable">
        <thead>
          <tr>
            <th style="width:40px;">#</th>
            <th>N° Chambre</th>
            <th>Type</th>
            <th>Statut</th>
            <th>Réservable</th>
            <th>Changer statut</th>
          </tr>
        </thead>
        <tbody id="roomsTbody">
          <% if (rooms.isEmpty()) { %>
          <tr class="empty-row">
            <td colspan="6"><i class="fa-solid fa-bed"></i>Aucune chambre enregistrée</td>
          </tr>
          <% } %>
          <% int idx = 1; for (Room r : rooms) { boolean isLibre = "LIBRE".equals(r.getStatus()); %>
          <tr data-status="<%= r.getStatus() %>"
              data-type="<%= r.getTypeName() != null ? r.getTypeName() : "" %>"
              data-num="<%= r.getRoomNumber() != null ? r.getRoomNumber().toLowerCase() : "" %>">
            <td class="id-cell"><%= idx++ %></td>
            <td><div class="rnum">N° <%= r.getRoomNumber() %></div></td>
            <td><span class="type-pill"><%= r.getTypeName() != null ? r.getTypeName() : "—" %></span></td>
            <td>
              <span class="sbadge <%= r.getStatus() %>">
                <% if("LIBRE".equals(r.getStatus()))       { %><i class="fa-solid fa-circle-check" style="font-size:10px;"></i> Libre
                <% } else if("OCCUPEE".equals(r.getStatus())) { %><i class="fa-solid fa-circle-dot" style="font-size:10px;"></i> Occupée
                <% } else if("NETTOYAGE".equals(r.getStatus())) { %><i class="fa-solid fa-broom" style="font-size:10px;"></i> Nettoyage
                <% } else if("MAINTENANCE".equals(r.getStatus())) { %><i class="fa-solid fa-screwdriver-wrench" style="font-size:10px;"></i> Maintenance
                <% } else { %><%= r.getStatus() %><% } %>
              </span>
            </td>
            <td>
              <% if (isLibre) { %>
                <span class="res-yes"><i class="fa-solid fa-circle-check"></i> Oui</span>
              <% } else { %>
                <span class="res-no"><i class="fa-solid fa-circle-xmark"></i> Non</span>
              <% } %>
            </td>
            <td>
              <div class="action-btns">
                <a href="<%= request.getContextPath() %>/admin/rooms?id=<%= r.getId() %>&status=LIBRE"
                   class="abtn abtn-libre <%= isLibre ? "off" : "" %>"
                   onclick="<%= !isLibre ? "return confirm('Marquer comme LIBRE ?')" : "return false" %>">
                  <i class="fa-solid fa-circle-check"></i> Libre
                </a>
                <a href="<%= request.getContextPath() %>/admin/rooms?id=<%= r.getId() %>&status=OCCUPEE"
                   class="abtn abtn-occupee <%= "OCCUPEE".equals(r.getStatus()) ? "off" : "" %>"
                   onclick="return confirm('Marquer comme OCCUPÉE ?')">
                  <i class="fa-solid fa-door-closed"></i> Occupée
                </a>
                <a href="<%= request.getContextPath() %>/admin/rooms?id=<%= r.getId() %>&status=NETTOYAGE"
                   class="abtn abtn-nettoyage <%= "NETTOYAGE".equals(r.getStatus()) ? "off" : "" %>"
                   onclick="return confirm('Marquer en NETTOYAGE ?')">
                  <i class="fa-solid fa-broom"></i> Nettoyage
                </a>
                <a href="<%= request.getContextPath() %>/admin/rooms?id=<%= r.getId() %>&status=MAINTENANCE"
                   class="abtn abtn-maint <%= "MAINTENANCE".equals(r.getStatus()) ? "off" : "" %>"
                   onclick="return confirm('Marquer en MAINTENANCE ?')">
                  <i class="fa-solid fa-screwdriver-wrench"></i> Maintenance
                </a>
              </div>
            </td>
          </tr>
          <% } %>
        </tbody>
      </table>
    </div>
  </div>

</main>
</div>

<script>
let currentStatus = 'ALL';

function setStatusFilter(status, btn) {
  currentStatus = status;
  document.querySelectorAll('.ftab').forEach(t => t.classList.remove('active'));
  btn.classList.add('active');
  filterTable();
}

function filterTable() {
  const search  = document.getElementById('searchInput').value.toLowerCase().trim();
  const typeVal = document.getElementById('typeFilter').value;
  const rows    = document.querySelectorAll('#roomsTbody tr[data-status]');
  let visible   = 0;

  rows.forEach(row => {
    const st   = row.dataset.status;
    const type = row.dataset.type;
    const num  = row.dataset.num;

    const statusOk = currentStatus === 'ALL' || st === currentStatus;
    const typeOk   = !typeVal || type === typeVal;
    const searchOk = !search  || num.includes(search) || type.toLowerCase().includes(search);

    if (statusOk && typeOk && searchOk) {
      row.style.display = '';
      visible++;
    } else {
      row.style.display = 'none';
    }
  });

  document.getElementById('visibleCount').textContent = visible + ' chambre(s) affichée(s)';

  let n = 1;
  rows.forEach(row => {
    if (row.style.display !== 'none') row.querySelector('.id-cell').textContent = n++;
  });
}
</script>
</body>
</html>

