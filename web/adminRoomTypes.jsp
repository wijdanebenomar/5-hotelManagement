<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, model.RoomType, model.User" %>
<%
User _admin = (User) session.getAttribute("loggedUser");
if (_admin == null || !"ADMIN".equals(_admin.getRole())) { response.sendRedirect(request.getContextPath() + "/login"); return; }
List<RoomType> roomTypes = (List<RoomType>) request.getAttribute("roomTypes");
if (roomTypes == null) roomTypes = new java.util.ArrayList<>();
double minPrice = roomTypes.stream().mapToDouble(RoomType::getPrice).min().orElse(0);
double maxPrice = roomTypes.stream().mapToDouble(RoomType::getPrice).max().orElse(0);
%>
<!DOCTYPE html>
<html lang="fr">
<!-- Gestion des types de chambres -->
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>BlueWave | Gestion des Types de Chambres</title>
<link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@300;400;500;600&family=DM+Serif+Display:ital@0;1&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<style>
<%@ include file="adminStyle.css" %>

/* ── ROOM TYPE CARDS ── */
.rt-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
  gap: 20px;
}

.rt-card {
  background: var(--white);
  border: 1px solid var(--border);
  border-radius: var(--radius-xl);
  overflow: hidden;
  box-shadow: var(--shadow-xs);
  transition: transform .25s, box-shadow .25s, border-color .25s;
  cursor: pointer;
}
.rt-card:hover {
  transform: translateY(-4px);
  box-shadow: var(--shadow-lg);
  border-color: var(--teal-border);
}

/* image area */
.rt-img {
  position: relative;
  width: 100%; height: 190px;
  overflow: hidden;
  background: var(--bg-2);
}
.rt-img img {
  width: 100%; height: 100%;
  object-fit: cover; display: block;
  transition: transform .45s ease;
}
.rt-card:hover .rt-img img { transform: scale(1.06); }
.rt-img-placeholder {
  width: 100%; height: 100%;
  background: linear-gradient(135deg, var(--bg-2), var(--border));
  display: flex; align-items: center; justify-content: center;
}
.rt-img-placeholder i { font-size: 44px; color: var(--border); }

/* status pill on image */
.rt-status {
  position: absolute; top: 12px; right: 12px; z-index: 2;
  background: var(--success-bg);
  border: 1px solid var(--success-border);
  color: var(--success);
  font-size: 10px; font-weight: 700; letter-spacing: 1.5px;
  text-transform: uppercase;
  padding: 5px 12px; border-radius: 99px;
  display: flex; align-items: center; gap: 5px;
}
.rt-status::before {
  content: ''; width: 6px; height: 6px;
  border-radius: 50%; background: var(--success);
}

/* body */
.rt-body { padding: 20px 22px 0; }
.rt-cat {
  font-size: 10px; letter-spacing: 2.5px; text-transform: uppercase;
  color: var(--teal); font-weight: 600; margin-bottom: 6px;
}
.rt-name {
  font-family: 'DM Serif Display', serif;
  font-size: 20px; color: var(--text-dark); margin-bottom: 10px;
}
.rt-desc {
  font-size: 12px; color: var(--text-light); line-height: 1.65;
  display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical;
  overflow: hidden; margin-bottom: 14px;
}
.rt-specs {
  display: flex; gap: 14px; flex-wrap: wrap; margin-bottom: 16px;
}
.rt-spec {
  display: flex; align-items: center; gap: 5px;
  font-size: 12px; color: var(--text-light);
}
.rt-spec i { font-size: 11px; color: var(--teal); }

/* footer */
.rt-footer {
  display: flex; align-items: center; justify-content: space-between;
  padding: 14px 22px 18px;
  border-top: 1px solid var(--border-soft);
}
.rt-price {
  display: flex; align-items: baseline; gap: 4px;
}
.rt-price .amount {
  font-family: 'DM Serif Display', serif;
  font-size: 26px; color: var(--navy);
}
.rt-price .unit { font-size: 11px; color: var(--text-light); }

.rt-actions { display: flex; gap: 8px; }

/* add card */
.rt-add {
  background: transparent;
  border: 2px dashed var(--teal-border);
  border-radius: var(--radius-xl);
  display: flex; flex-direction: column;
  align-items: center; justify-content: center;
  gap: 14px; min-height: 320px; cursor: pointer;
  transition: border-color .25s, background .25s;
  color: var(--text-light);
}
.rt-add:hover {
  border-color: var(--teal);
  background: var(--teal-dim);
  color: var(--teal);
}
.rt-add .add-ring {
  width: 52px; height: 52px; border-radius: 50%;
  border: 1.5px solid currentColor;
  display: flex; align-items: center; justify-content: center;
  font-size: 20px; transition: transform .25s;
}
.rt-add:hover .add-ring { transform: scale(1.1); }
.rt-add span { font-size: 12px; font-weight: 500; letter-spacing: .5px; text-align: center; }
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
    <a href="dashboard"  class="nav-item"><i class="fa-solid fa-gauge-high"></i>Tableau de bord</a>
    <a href="reservations" class="nav-item"><i class="fa-solid fa-calendar-check"></i>Réservations</a>
    <a href="rooms"      class="nav-item"><i class="fa-solid fa-bed"></i>Chambres</a>
    <a href="room-types" class="nav-item active"><i class="fa-solid fa-layer-group"></i>Types de chambres</a>
    <a href="services"   class="nav-item"><i class="fa-solid fa-concierge-bell"></i>Services</a>
    <a href="clients"    class="nav-item"><i class="fa-solid fa-users"></i>Clients</a>
    <div class="nav-section">Compte</div>
    <a href="../index.jsp" class="nav-item"><i class="fa-solid fa-house"></i>Site public</a>
    <a href="../logout"    class="nav-item danger"><i class="fa-solid fa-right-from-bracket"></i>Déconnexion</a>
  </nav>
</aside>

<!-- MAIN -->
<main class="main-content">

  <div class="page-header">
    <div>
      <div class="page-eyebrow">Gestion</div>
      <h1 class="page-title">Types de chambres</h1>
    </div>
    <button class="btn btn-primary" onclick="openModal('addModal')">
      <i class="fa-solid fa-plus"></i> Ajouter un type
    </button>
  </div>

  <!-- STATS -->
  <div class="stats-row" style="grid-template-columns:repeat(3,1fr); margin-bottom:28px;">
    <div class="stat-card">
      <div class="stat-icon slate"><i class="fa-solid fa-layer-group"></i></div>
      <div class="stat-info">
        <div class="stat-val"><%= roomTypes.size() %></div>
        <div class="stat-lbl">Types de chambres</div>
      </div>
    </div>
    <div class="stat-card">
      <div class="stat-icon green"><i class="fa-solid fa-arrow-down-wide-short"></i></div>
      <div class="stat-info">
        <div class="stat-val"><%= roomTypes.size() > 0 ? String.format("%.0f", minPrice) : "—" %></div>
        <div class="stat-lbl">Prix min / nuit (MAD)</div>
      </div>
    </div>
    <div class="stat-card">
      <div class="stat-icon amber"><i class="fa-solid fa-arrow-up-wide-short"></i></div>
      <div class="stat-info">
        <div class="stat-val"><%= roomTypes.size() > 0 ? String.format("%.0f", maxPrice) : "—" %></div>
        <div class="stat-lbl">Prix max / nuit (MAD)</div>
      </div>
    </div>
  </div>

  <!-- CARDS GRID -->
  <div class="rt-grid">

    <% for (RoomType rt : roomTypes) {
      String img  = rt.getImage();
      boolean hasImg = img != null && !img.trim().isEmpty();
      String name = rt.getName() != null ? rt.getName() : "—";
      String desc = rt.getDescription();
      String cat  = name.toUpperCase().contains("SUITE")     ? "Suite" :
                    name.toUpperCase().contains("PRESTIGE")  ? "Prestige" :
                    name.toUpperCase().contains("DELUXE")    ? "Deluxe" :
                    name.toUpperCase().contains("FAMILI")    ? "Familiale" :
                    name.toUpperCase().contains("STANDARD")  ? "Standard" :
                    name.toUpperCase().contains("ROYAL")     ? "Suite Royale" : "Chambre";
      String safeDesc = desc != null ? desc.replace("'", "\\'").replace("\r","").replace("\n"," ") : "";
      String safeName = name.replace("'", "\\'");
    %>
    <div class="rt-card" onclick="openEditModal(<%= rt.getId() %>,'<%= safeName %>',<%= rt.getPrice() %>,'<%= hasImg ? img.replace("'","\\'") : "" %>','<%= safeDesc %>')">
      <div class="rt-img">
        <% if (hasImg) { %>
          <img src="<%= img %>" alt="<%= name %>">
        <% } else { %>
          <div class="rt-img-placeholder"><i class="fa-regular fa-image"></i></div>
        <% } %>
        <span class="rt-status">Actif</span>
      </div>
      <div class="rt-body">
        <div class="rt-cat"><%= cat.toUpperCase() %></div>
        <div class="rt-name"><%= name %></div>
        <% if (desc != null && !desc.trim().isEmpty()) { %>
        <div class="rt-desc"><%= desc %></div>
        <% } %>
        <div class="rt-specs">
          <div class="rt-spec"><i class="fa-regular fa-user"></i> 2 personnes</div>
          <div class="rt-spec"><i class="fa-solid fa-bed"></i> 1 lit</div>
          <div class="rt-spec"><i class="fa-solid fa-id-badge"></i> ID #<%= rt.getId() %></div>
        </div>
      </div>
      <div class="rt-footer">
        <div class="rt-price">
          <span class="amount"><%= String.format("%.0f", rt.getPrice()) %></span>
          <span class="unit">MAD / nuit</span>
        </div>
        <div class="rt-actions" onclick="event.stopPropagation()">
          <button class="icon-btn icon-btn-edit" title="Modifier"
            onclick="openEditModal(<%= rt.getId() %>,'<%= safeName %>',<%= rt.getPrice() %>,'<%= hasImg ? img.replace("'","\\'") : "" %>','<%= safeDesc %>')">
            <i class="fa-solid fa-pen"></i>
          </button>
          <form method="post" action="<%= request.getContextPath() %>/admin/room-types" style="display:contents;"
            onsubmit="return confirm('Supprimer le type « <%= name %> » ?')">
            <input type="hidden" name="action" value="delete">
            <input type="hidden" name="id" value="<%= rt.getId() %>">
            <input type="hidden" name="name" value="x">
            <input type="hidden" name="price" value="0">
            <input type="hidden" name="image" value="">
            <input type="hidden" name="description" value="">
            <button type="submit" class="icon-btn icon-btn-delete" title="Supprimer">
              <i class="fa-solid fa-trash"></i>
            </button>
          </form>
        </div>
      </div>
    </div>
    <% } %>

    <!-- ADD CARD -->
    <div class="rt-add" onclick="openModal('addModal')">
      <div class="add-ring"><i class="fa-solid fa-plus"></i></div>
      <span>Ajouter un nouveau<br>type de chambre</span>
    </div>

  </div>
</main>
</div>

<!-- ADD MODAL -->
<div class="modal-overlay" id="addModal">
  <div class="modal">
    <div class="modal-header">
      <span class="modal-title"><i class="fa-solid fa-plus"></i>Nouveau type de chambre</span>
      <button class="modal-close" onclick="closeModal('addModal')"><i class="fa-solid fa-xmark"></i></button>
    </div>
    <form method="post" action="<%= request.getContextPath() %>/admin/room-types">
      <input type="hidden" name="action" value="add">
      <div class="modal-body">
        <div class="form-row">
          <div class="form-group">
            <label>Nom *</label>
            <div class="field-w">
              <i class="fa-solid fa-layer-group ico"></i>
              <input type="text" name="name" required placeholder="Ex: Suite Panorama">
            </div>
          </div>
          <div class="form-group">
            <label>Prix / nuit (MAD) *</label>
            <div class="field-w">
              <i class="fa-solid fa-tag ico"></i>
              <input type="number" name="price" step="0.01" min="0" required placeholder="1200">
            </div>
          </div>
        </div>
        <div class="form-group">
          <label>URL Image</label>
          <div class="field-w">
            <i class="fa-solid fa-image ico"></i>
            <input type="text" name="image" placeholder="https://images.unsplash.com/...">
          </div>
        </div>
        <div class="form-group">
          <label>Description</label>
          <div class="field-w">
            <i class="fa-solid fa-align-left ico"></i>
            <input type="text" name="description" placeholder="Vue mer, terrasse privée, jacuzzi...">
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
      <span class="modal-title"><i class="fa-solid fa-pen"></i>Modifier le type</span>
      <button class="modal-close" onclick="closeModal('editModal')"><i class="fa-solid fa-xmark"></i></button>
    </div>
    <form method="post" action="<%= request.getContextPath() %>/admin/room-types">
      <input type="hidden" name="action" value="update">
      <input type="hidden" name="id" id="editId">
      <div class="modal-body">
        <div class="form-row">
          <div class="form-group">
            <label>Nom *</label>
            <div class="field-w">
              <i class="fa-solid fa-layer-group ico"></i>
              <input type="text" name="name" id="editName" required>
            </div>
          </div>
          <div class="form-group">
            <label>Prix / nuit (MAD) *</label>
            <div class="field-w">
              <i class="fa-solid fa-tag ico"></i>
              <input type="number" name="price" id="editPrice" step="0.01" min="0" required>
            </div>
          </div>
        </div>
        <div class="form-group">
          <label>URL Image</label>
          <div class="field-w">
            <i class="fa-solid fa-image ico"></i>
            <input type="text" name="image" id="editImage">
          </div>
        </div>
        <div class="form-group">
          <label>Description</label>
          <div class="field-w">
            <i class="fa-solid fa-align-left ico"></i>
            <input type="text" name="description" id="editDesc">
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
function openModal(id)  { document.getElementById(id).classList.add('open'); }
function closeModal(id) { document.getElementById(id).classList.remove('open'); }
function openEditModal(id, name, price, image, desc) {
  document.getElementById('editId').value    = id;
  document.getElementById('editName').value  = name;
  document.getElementById('editPrice').value = price;
  document.getElementById('editImage').value = image;
  document.getElementById('editDesc').value  = desc;
  openModal('editModal');
}
document.querySelectorAll('.modal-overlay').forEach(o =>
  o.addEventListener('click', function(e){ if(e.target===this) this.classList.remove('open'); })
);
</script>
</body>
</html>