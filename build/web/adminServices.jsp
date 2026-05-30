<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, model.Service, model.User" %>
<%
User _admin = (User) session.getAttribute("loggedUser");
if (_admin == null || !"ADMIN".equals(_admin.getRole())) { response.sendRedirect(request.getContextPath() + "/login"); return; }
List<Service> services = (List<Service>) request.getAttribute("services");
if (services == null) services = new java.util.ArrayList<>();
double totalRevenue = 0;
for(Service s : services) totalRevenue += s.getPrice();
%>
<!DOCTYPE html>
<html lang="fr">
<head>
<meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Blue Wave Admin — Services</title>
<link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@300;400;500;600&family=DM+Serif+Display:ital@0;1&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<style>
<%@ include file="adminStyle.css" %>
/* Services-specific */
.svc-list { display:flex; flex-direction:column; gap:10px; }
.svc-row {
  display:flex; align-items:center; gap:16px;
  background:var(--white); border:1px solid var(--border); border-radius:var(--radius-lg);
  padding:16px 20px; box-shadow:var(--shadow-xs);
  transition:box-shadow .2s, transform .2s, border-color .2s;
}
.svc-row:hover { box-shadow:var(--shadow-md); transform:translateX(3px); border-color:var(--teal-border); }
.svc-icon-wrap {
  width:46px; height:46px; border-radius:var(--radius); flex-shrink:0;
  background:var(--teal-dim); border:1px solid var(--teal-border);
  display:flex; align-items:center; justify-content:center;
  color:var(--teal); font-size:18px;
}
.svc-info { flex:1; min-width:0; }
.svc-name-row { display:flex; align-items:center; gap:10px; flex-wrap:wrap; }
.svc-name { font-size:14px; font-weight:600; color:var(--text-dark); }
.svc-type-tag {
  font-size:10px; font-weight:600; letter-spacing:1.5px; text-transform:uppercase;
  color:var(--teal); background:var(--teal-dim); border:1px solid var(--teal-border);
  padding:2px 8px; border-radius:20px;
}
.svc-id { font-size:11px; color:var(--text-light); }
.svc-price-col { display:flex; align-items:baseline; gap:4px; flex-shrink:0; min-width:100px; justify-content:flex-end; }
.svc-price { font-family:'DM Serif Display',serif; font-size:22px; color:var(--navy); }
.svc-unit { font-size:11px; color:var(--text-light); }
.svc-actions-col { display:flex; gap:8px; flex-shrink:0; }
.search-bar {
  display:flex; align-items:center; gap:12px;
  background:var(--white); border:1px solid var(--border); border-radius:var(--radius);
  padding:10px 16px; margin-bottom:20px; box-shadow:var(--shadow-xs);
}
.search-bar i { color:var(--text-light); font-size:14px; flex-shrink:0; }
.search-bar input {
  border:none; background:transparent; font-size:13px; color:var(--text-dark);
  font-family:'DM Sans',sans-serif; width:100%; outline:none;
}
.search-bar input::placeholder { color:var(--text-light); }
</style>
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
    <a href="dashboard" class="nav-item"><i class="fa-solid fa-gauge-high"></i>Tableau de bord</a>
    <a href="reservations" class="nav-item"><i class="fa-solid fa-calendar-check"></i>Réservations</a>
    <a href="rooms" class="nav-item"><i class="fa-solid fa-bed"></i>Chambres</a>
    <a href="room-types" class="nav-item"><i class="fa-solid fa-layer-group"></i>Types de chambres</a>
    <a href="services" class="nav-item active"><i class="fa-solid fa-concierge-bell"></i>Services</a>
    <a href="clients" class="nav-item"><i class="fa-solid fa-users"></i>Clients</a>
    <div class="nav-section">Compte</div>
    <a href="../index.jsp" class="nav-item"><i class="fa-solid fa-house"></i>Site public</a>
    <a href="../logout" class="nav-item danger"><i class="fa-solid fa-right-from-bracket"></i>Déconnexion</a>
  </nav>
</aside>

<main class="main-content">
  <div class="page-header">
    <div>
      <div class="page-eyebrow">Gestion</div>
      <h1 class="page-title">Services</h1>
    </div>
    <button class="btn btn-primary" onclick="openModal('addModal')">
      <i class="fa-solid fa-plus"></i> Ajouter un service
    </button>
  </div>

  <!-- STATS -->
  <div class="stats-row" style="grid-template-columns:repeat(3,1fr); margin-bottom:24px;">
    <div class="stat-card">
      <div class="stat-icon slate"><i class="fa-solid fa-concierge-bell"></i></div>
      <div class="stat-info">
        <div class="stat-val"><%= services.size() %></div>
        <div class="stat-lbl">Services actifs</div>
      </div>
    </div>
    <div class="stat-card">
      <div class="stat-icon green"><i class="fa-solid fa-tag"></i></div>
      <div class="stat-info">
        <div class="stat-val"><%= services.size() > 0 ? String.format("%.0f", services.stream().mapToDouble(Service::getPrice).min().orElse(0)) : "—" %></div>
        <div class="stat-lbl">Prix minimum (MAD)</div>
      </div>
    </div>
    <div class="stat-card">
      <div class="stat-icon amber"><i class="fa-solid fa-arrow-up-wide-short"></i></div>
      <div class="stat-info">
        <div class="stat-val"><%= services.size() > 0 ? String.format("%.0f", services.stream().mapToDouble(Service::getPrice).average().orElse(0)) : "—" %></div>
        <div class="stat-lbl">Prix moyen (MAD)</div>
      </div>
    </div>
  </div>

  <!-- SEARCH BAR -->
  <div class="search-bar">
    <i class="fa-solid fa-magnifying-glass"></i>
    <input type="text" id="searchInput" placeholder="Rechercher un service par nom..." oninput="filterServices(this.value)">
  </div>

  <!-- SERVICES LIST -->
  <% if (services.isEmpty()) { %>
  <div class="card">
    <div class="card-body" style="text-align:center; padding:60px 22px;">
      <i class="fa-solid fa-concierge-bell" style="font-size:40px; color:var(--teal); opacity:.4; display:block; margin-bottom:12px;"></i>
      <div style="color:var(--text-light); font-size:14px;">Aucun service pour le moment</div>
      <button class="btn btn-primary" style="margin-top:16px;" onclick="openModal('addModal')"><i class="fa-solid fa-plus"></i> Ajouter le premier service</button>
    </div>
  </div>
  <% } else { %>
  <div class="svc-list" id="svcList">
  <%
    for(Service s : services) {
      String sName = s.getName().toLowerCase();
      String typeLabel = "Service";
      String icon = "fa-star";
      if(sName.contains("spa")||sName.contains("massag")||sName.contains("wellness")){icon="fa-spa";typeLabel="Bien-être";}
      else if(sName.contains("breakfast")||sName.contains("petit")||sName.contains("repas")||sName.contains("dîner")||sName.contains("restaurant")){icon="fa-utensils";typeLabel="Restauration";}
      else if(sName.contains("transfert")||sName.contains("airport")||sName.contains("navette")){icon="fa-car";typeLabel="Transport";}
      else if(sName.contains("excursion")||sName.contains("tour")||sName.contains("visite")){icon="fa-map-location-dot";typeLabel="Excursion";}
      else if(sName.contains("piscine")||sName.contains("pool")){icon="fa-water-ladder";typeLabel="Piscine";}
      else if(sName.contains("vin")||sName.contains("wine")||sName.contains("champagne")){icon="fa-wine-bottle";typeLabel="Boissons";}
      else if(sName.contains("déco")||sName.contains("romantique")||sName.contains("fleur")){icon="fa-heart";typeLabel="Décoration";}
      else if(sName.contains("parking")){icon="fa-square-parking";typeLabel="Parking";}
      else if(sName.contains("gym")||sName.contains("fitness")||sName.contains("sport")){icon="fa-dumbbell";typeLabel="Sport";}
  %>
    <div class="svc-row" data-search="<%= s.getName().toLowerCase() %>">
      <div class="svc-icon-wrap"><i class="fa-solid <%= icon %>"></i></div>
      <div class="svc-info">
        <div class="svc-name-row">
          <span class="svc-name"><%= s.getName() %></span>
          <span class="svc-type-tag"><%= typeLabel %></span>
        </div>
        <div class="svc-id" style="margin-top:3px;">ID #<%= s.getId() %></div>
      </div>
      <div class="svc-price-col">
        <span class="svc-price"><%= String.format("%.0f", s.getPrice()) %></span>
        <span class="svc-unit">MAD</span>
      </div>
      <div class="svc-actions-col">
        <button class="icon-btn icon-btn-edit"
          onclick="openEditModal(<%= s.getId() %>,'<%= s.getName().replace("'", "\\'") %>',<%= s.getPrice() %>)"
          title="Modifier">
          <i class="fa-solid fa-pen"></i>
        </button>
        <form method="post" action="<%= request.getContextPath() %>/admin/services" style="display:inline;"
          onsubmit="return confirm('Supprimer « <%= s.getName() %> » ?')">
          <input type="hidden" name="action" value="delete">
          <input type="hidden" name="id" value="<%= s.getId() %>">
          <input type="hidden" name="name" value="x">
          <input type="hidden" name="price" value="0">
          <button type="submit" class="icon-btn icon-btn-delete" title="Supprimer">
            <i class="fa-solid fa-trash"></i>
          </button>
        </form>
      </div>
    </div>
  <% } %>
  </div>
  <% } %>
</main>
</div>

<!-- ADD MODAL -->
<div class="modal-overlay" id="addModal">
  <div class="modal">
    <div class="modal-header">
      <span class="modal-title"><i class="fa-solid fa-plus"></i>Nouveau service</span>
      <button class="modal-close" onclick="closeModal('addModal')"><i class="fa-solid fa-xmark"></i></button>
    </div>
    <form method="post" action="<%= request.getContextPath() %>/admin/services">
      <input type="hidden" name="action" value="add">
      <div class="modal-body">
        <div class="form-row">
          <div class="form-group">
            <label>Nom du service *</label>
            <div class="field-w">
              <i class="fa-solid fa-concierge-bell ico"></i>
              <input type="text" name="name" required placeholder="Ex: Petit-déjeuner">
            </div>
          </div>
          <div class="form-group">
            <label>Prix (MAD) *</label>
            <div class="field-w">
              <i class="fa-solid fa-tag ico"></i>
              <input type="number" name="price" step="0.01" min="0" required placeholder="150.00">
            </div>
          </div>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-outline" onclick="closeModal('addModal')">Annuler</button>
        <button type="submit" class="btn btn-primary"><i class="fa-solid fa-plus"></i> Ajouter</button>
      </div>
    </form>
  </div>
</div>

<!-- EDIT MODAL -->
<div class="modal-overlay" id="editModal">
  <div class="modal">
    <div class="modal-header">
      <span class="modal-title"><i class="fa-solid fa-pen"></i>Modifier le service</span>
      <button class="modal-close" onclick="closeModal('editModal')"><i class="fa-solid fa-xmark"></i></button>
    </div>
    <form method="post" action="<%= request.getContextPath() %>/admin/services">
      <input type="hidden" name="action" value="update">
      <input type="hidden" name="id" id="editId">
      <div class="modal-body">
        <div class="form-row">
          <div class="form-group">
            <label>Nom *</label>
            <div class="field-w">
              <i class="fa-solid fa-concierge-bell ico"></i>
              <input type="text" name="name" id="editName" required>
            </div>
          </div>
          <div class="form-group">
            <label>Prix (MAD) *</label>
            <div class="field-w">
              <i class="fa-solid fa-tag ico"></i>
              <input type="number" name="price" id="editPrice" step="0.01" min="0" required>
            </div>
          </div>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-outline" onclick="closeModal('editModal')">Annuler</button>
        <button type="submit" class="btn btn-primary"><i class="fa-solid fa-save"></i> Enregistrer</button>
      </div>
    </form>
  </div>
</div>

<script>
function openModal(id){ document.getElementById(id).classList.add('open'); }
function closeModal(id){ document.getElementById(id).classList.remove('open'); }
function openEditModal(id, name, price){
  document.getElementById('editId').value = id;
  document.getElementById('editName').value = name;
  document.getElementById('editPrice').value = price;
  openModal('editModal');
}
function filterServices(q) {
  const rows = document.querySelectorAll('.svc-row');
  rows.forEach(r => {
    r.style.display = r.dataset.search.includes(q.toLowerCase()) ? '' : 'none';
  });
}
document.querySelectorAll('.modal-overlay').forEach(o =>
  o.addEventListener('click', function(e){ if(e.target === this) this.classList.remove('open'); })
);
</script>
</body>
</html>
