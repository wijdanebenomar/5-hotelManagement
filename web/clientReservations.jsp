<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, model.*"%>
<!DOCTYPE html>
<html lang="fr">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Blue Wave — Mes Réservations</title>
<link href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,300;0,400;1,300;1,400&family=Jost:wght@200;300;400;500&family=Cormorant+Garamond:ital,wght@0,300;1,300&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<style>
:root{
  --midnight:#004554; --midnight-2:#003040; --midnight-3:#002535;
  --moonstone:#44A6B5; --moonstone-2:#5cb8c6;
  --lightblue:#B2D5E2; --alice:#E9F1F6; --timber:#D3D0C8;
  --moon-line:rgba(68,166,181,0.28); --moon-dim:rgba(68,166,181,0.10);
  --white:#f8fbfc; --fog:rgba(233,241,246,0.65); --fog-low:rgba(178,213,226,0.45);
  --fog-ghost:rgba(178,213,226,0.08);
  --success-bg:rgba(29,158,117,0.12); --success-border:rgba(29,158,117,0.3); --success-text:#5dcaa5;
  --danger-bg:rgba(224,92,92,0.12);  --danger-border:rgba(224,92,92,0.28);  --danger-text:#f09898;
  --warn-bg:rgba(251,191,36,0.1);    --warn-border:rgba(251,191,36,0.28);   --warn-text:#fbbf24;
}
*{margin:0;padding:0;box-sizing:border-box;} html{scroll-behavior:smooth;}
body{font-family:'Jost',sans-serif;background:var(--midnight-3);color:var(--white);min-height:100vh;}

/* ── HEADER ── */
header{
  position:fixed;top:0;left:0;right:0;z-index:1000;height:88px;
  display:flex;align-items:center;justify-content:space-between;padding:0 52px;
  background:rgba(0,37,53,0.95);backdrop-filter:blur(24px);
  border-bottom:1px solid var(--moon-line);
}
.logo-wrap{text-decoration:none;}
.logo-main{font-family:'Playfair Display',serif;font-size:20px;font-weight:400;
  letter-spacing:5px;color:var(--white);text-transform:uppercase;display:block;}
.logo-sub{font-family:'Cormorant Garamond',serif;font-size:10px;font-style:italic;
  letter-spacing:4px;color:var(--moonstone);display:block;text-align:center;}
nav ul{display:flex;list-style:none;gap:32px;align-items:center;}
nav ul li a{text-decoration:none;color:var(--fog);font-size:10px;letter-spacing:2.5px;
  text-transform:uppercase;position:relative;padding-bottom:4px;transition:color .3s;}
nav ul li a::after{content:'';position:absolute;bottom:0;left:0;width:0;height:1px;
  background:var(--moonstone);transition:width .35s cubic-bezier(.25,.46,.45,.94);}
nav ul li a:hover,nav ul li a.active{color:var(--moonstone-2);}
nav ul li a:hover::after,nav ul li a.active::after{width:100%;}
.user-nav{display:flex;align-items:center;gap:14px;}
.user-avatar{width:38px;height:38px;border:1px solid var(--moon-line);
  display:flex;align-items:center;justify-content:center;
  font-size:13px;font-weight:500;color:var(--moonstone);
  background:var(--moon-dim);}
.logout-btn{background:transparent;border:1px solid var(--moon-line);color:var(--moonstone);
  padding:9px 20px;font-size:10px;letter-spacing:2px;text-transform:uppercase;
  cursor:pointer;transition:background .3s,color .3s;text-decoration:none;
  font-family:'Jost',sans-serif;display:inline-flex;align-items:center;gap:8px;}
.logout-btn:hover{background:var(--moonstone);color:var(--midnight-3);}

/* ── PAGE CONTENT ── */
.page-content{max-width:1160px;margin:0 auto;padding:120px 5% 100px;}

/* ── PAGE HEADER ── */
.page-header{display:flex;justify-content:space-between;align-items:flex-end;
  margin-bottom:44px;flex-wrap:wrap;gap:20px;}
.page-header-left .eyebrow{font-size:9px;letter-spacing:4px;text-transform:uppercase;
  color:var(--moonstone);margin-bottom:12px;display:flex;align-items:center;gap:12px;}
.page-header-left .eyebrow::before{content:'';display:inline-block;width:32px;height:1px;background:var(--moonstone);}
.page-header-left h1{font-family:'Playfair Display',serif;font-size:clamp(36px,5vw,52px);
  font-weight:300;line-height:1.1;color:var(--white);}
.page-header-left h1 em{color:var(--moonstone-2);font-style:italic;}
.new-resa-btn{padding:13px 28px;background:var(--moonstone);color:var(--midnight-3);border:none;
  font-family:'Jost',sans-serif;font-size:10px;font-weight:500;letter-spacing:2.5px;
  text-transform:uppercase;cursor:pointer;text-decoration:none;
  display:inline-flex;align-items:center;gap:8px;transition:opacity .3s;}
.new-resa-btn:hover{opacity:.85;}

/* ── SEARCH CARD ── */
.search-card{
  border:1px solid var(--moon-line);padding:28px 32px;margin-bottom:36px;
  display:flex;gap:16px;align-items:flex-end;flex-wrap:wrap;
  background:rgba(0,48,64,0.45);
}
.search-field{flex:1;min-width:240px;}
.search-field label{display:block;font-size:9px;letter-spacing:2.5px;text-transform:uppercase;
  color:var(--moonstone);font-weight:500;margin-bottom:8px;}
.search-field-wrap{position:relative;}
.search-field-wrap i{position:absolute;left:13px;top:50%;transform:translateY(-50%);
  color:var(--fog-low);font-size:13px;pointer-events:none;}
.search-field-wrap:focus-within i{color:var(--moonstone);}
.search-field input[type=email]{width:100%;padding:12px 14px 12px 40px;
  background:rgba(0,37,53,0.8);border:1px solid rgba(178,213,226,.12);
  font-size:13px;font-family:'Jost',sans-serif;color:var(--white);transition:border-color .3s;}
.search-field input[type=email]:focus{outline:none;border-color:var(--moonstone);}
.search-field input[type=email]::placeholder{color:rgba(178,213,226,.3);}
.search-btn{padding:13px 28px;background:var(--moonstone);color:var(--midnight-3);border:none;
  font-family:'Jost',sans-serif;font-size:10px;font-weight:500;letter-spacing:2.5px;
  text-transform:uppercase;cursor:pointer;transition:opacity .3s;
  display:flex;align-items:center;gap:8px;white-space:nowrap;}
.search-btn:hover{opacity:.85;}

/* ── STATS ── */
.stats-row{display:grid;grid-template-columns:repeat(4,1fr);gap:2px;margin-bottom:36px;}
.stat-card{
  background:rgba(0,48,64,0.5);border:1px solid var(--moon-line);
  padding:24px 20px;text-align:center;
  transition:background .3s;
}
.stat-card:hover{background:var(--moon-dim);}
.stat-card .s-val{font-family:'Playfair Display',serif;font-size:38px;font-weight:300;
  color:var(--moonstone-2);line-height:1;margin-bottom:8px;}
.stat-card .s-label{font-size:9px;letter-spacing:2.5px;text-transform:uppercase;color:var(--fog-low);}

/* ── FILTERS ── */
.filters{display:flex;gap:8px;margin-bottom:28px;flex-wrap:wrap;}
.filter-pill{
  padding:9px 20px;border:1px solid rgba(178,213,226,.12);
  font-size:10px;color:var(--fog-low);cursor:pointer;transition:all .3s;
  background:transparent;font-family:'Jost',sans-serif;letter-spacing:2px;text-transform:uppercase;
}
.filter-pill:hover{border-color:var(--moon-line);color:var(--moonstone-2);}
.filter-pill.active{background:var(--moon-dim);border-color:var(--moonstone);color:var(--moonstone-2);}

/* ── RESERVATION CARD ── */
.resa-card{
  border:1px solid var(--moon-line);overflow:hidden;
  margin-bottom:3px;display:flex;
  transition:transform .3s,box-shadow .3s;
  background:rgba(0,48,64,0.4);
}
.resa-card:hover{transform:translateX(4px);box-shadow:0 12px 40px rgba(0,0,0,.35);}
.resa-img{width:200px;flex-shrink:0;object-fit:cover;
  filter:brightness(.7) saturate(.85);}
.resa-img:hover{filter:brightness(.85) saturate(1);}
.resa-body{flex:1;padding:28px 32px;display:flex;flex-direction:column;justify-content:space-between;}
.resa-top{display:flex;justify-content:space-between;align-items:flex-start;
  margin-bottom:18px;flex-wrap:wrap;gap:12px;}
.resa-ref{font-size:9px;letter-spacing:3px;text-transform:uppercase;color:var(--moonstone);margin-bottom:5px;}
.resa-name{font-family:'Playfair Display',serif;font-size:24px;font-weight:300;color:var(--white);}

/* STATUS BADGES */
.status-badge{padding:5px 14px;font-size:10px;font-weight:500;letter-spacing:2px;text-transform:uppercase;}
.status-badge.CONFIRMED,.status-badge.upcoming{
  background:var(--success-bg);border:1px solid var(--success-border);color:var(--success-text);}
.status-badge.CANCELLED,.status-badge.cancelled{
  background:var(--danger-bg);border:1px solid var(--danger-border);color:var(--danger-text);}
.status-badge.PENDING,.status-badge.past{
  background:var(--warn-bg);border:1px solid var(--warn-border);color:var(--warn-text);}

.resa-details{display:flex;gap:20px;flex-wrap:wrap;margin-bottom:20px;}
.resa-detail{display:flex;align-items:center;gap:8px;font-size:13px;color:var(--fog-low);font-weight:300;}
.resa-detail i{color:var(--moonstone);font-size:12px;width:14px;}

.resa-footer{
  display:flex;justify-content:space-between;align-items:center;flex-wrap:wrap;gap:12px;
  padding-top:18px;border-top:1px solid var(--fog-ghost);
}
.resa-total{font-family:'Playfair Display',serif;font-size:28px;font-weight:300;color:var(--moonstone-2);}
.resa-total span{font-family:'Jost',sans-serif;font-size:12px;color:var(--fog-low);margin-left:4px;}
.resa-actions{display:flex;gap:8px;}
.action-btn{
  padding:9px 18px;border:1px solid var(--moon-line);color:var(--moonstone);
  background:transparent;font-size:10px;letter-spacing:2px;text-transform:uppercase;
  cursor:pointer;transition:background .3s,border-color .3s;font-family:'Jost',sans-serif;
  text-decoration:none;display:inline-flex;align-items:center;gap:6px;
}
.action-btn:hover{background:var(--moon-dim);border-color:var(--moonstone);}
.action-btn.danger{color:var(--danger-text);border-color:var(--danger-border);}
.action-btn.danger:hover{background:var(--danger-bg);}

/* ── SUCCESS BANNER ── */
.success-banner{
  background:var(--success-bg);border:1px solid var(--success-border);
  color:var(--success-text);padding:16px 24px;
  display:flex;align-items:center;gap:14px;font-size:14px;margin-bottom:28px;
}
.success-banner i{font-size:20px;}

/* ── EMPTY STATE ── */
.empty-state{
  text-align:center;padding:80px 20px;
  background:rgba(0,48,64,0.35);border:1px solid var(--moon-line);
}
.empty-icon{
  width:72px;height:72px;border:1px solid var(--moon-line);
  display:flex;align-items:center;justify-content:center;margin:0 auto 24px;
  background:var(--moon-dim);
}
.empty-icon i{font-size:28px;color:var(--moonstone);}
.empty-state h3{font-family:'Playfair Display',serif;font-size:28px;font-weight:300;
  color:var(--white);margin-bottom:12px;}
.empty-state p{font-size:14px;color:var(--fog-low);line-height:1.7;margin-bottom:28px;font-weight:300;}

/* ── CANCEL MODAL ── */
.modal-overlay{
  position:fixed;inset:0;background:rgba(0,20,30,0.88);z-index:2000;
  display:none;align-items:center;justify-content:center;padding:24px;
}
.modal-overlay.open{display:flex;}
.cancel-modal{
  background:var(--midnight-2);border:1px solid var(--moon-line);
  padding:48px;max-width:460px;width:100%;text-align:center;
}
.cancel-modal h3{font-family:'Playfair Display',serif;font-size:30px;font-weight:300;
  color:var(--white);margin-bottom:14px;}
.cancel-modal p{font-size:13px;color:var(--fog-low);line-height:1.8;margin-bottom:32px;font-weight:300;}
.modal-btns{display:flex;gap:12px;justify-content:center;}
.modal-btn-keep{
  padding:12px 24px;background:transparent;border:1px solid var(--moon-line);
  color:var(--fog-low);cursor:pointer;font-family:'Jost',sans-serif;
  font-size:10px;letter-spacing:2px;text-transform:uppercase;
  transition:border-color .3s,color .3s;
}
.modal-btn-keep:hover{border-color:var(--moonstone);color:var(--moonstone);}
.modal-btn-cancel{
  padding:12px 24px;background:var(--danger-bg);border:1px solid var(--danger-border);
  color:var(--danger-text);cursor:pointer;font-family:'Jost',sans-serif;
  font-size:10px;letter-spacing:2px;text-transform:uppercase;transition:background .3s;
}
.modal-btn-cancel:hover{background:rgba(224,92,92,0.22);}

/* ── FOOTER ── */
footer{background:var(--midnight);border-top:1px solid var(--moon-line);
  padding:28px 5%;text-align:center;font-size:11px;color:rgba(178,213,226,.2);}

@media(max-width:900px){
  .stats-row{grid-template-columns:1fr 1fr;}
  .resa-card{flex-direction:column;}
  .resa-img{width:100%;height:200px;}
  header{padding:0 24px;}
}
@media(max-width:600px){
  nav ul{display:none;}
  .page-header{flex-direction:column;align-items:flex-start;}
}
</style>
</head>
<body>

<%
List<Reservation> reservations = (List<Reservation>) request.getAttribute("reservations");
String email = (String) request.getAttribute("email");
if(email == null) email = "";
boolean success = "1".equals(String.valueOf(request.getAttribute("success")));

// Compute stats
int totalCount = 0, confirmedCount = 0; double totalSpent = 0; int totalNights = 0;
if(reservations != null) {
  totalCount = reservations.size();
  for(Reservation r : reservations) {
    if("CONFIRMED".equals(r.getStatus())) { confirmedCount++; }
    if(!"CANCELLED".equals(r.getStatus())) { totalSpent += r.getTotalPrice(); }
  }
}
%>

<header>
  <a href="index.jsp" class="logo-wrap" style="text-decoration:none;">
    <span class="logo-main">Blue Wave</span>
    <span class="logo-sub">Hôtel &amp; Spa</span>
  </a>
  <nav><ul>
    <li><a href="index.jsp">Accueil</a></li>
    <li><a href="rooms">Chambres</a></li>
    <li><a href="my-reservations" class="active">Mes réservations</a></li>
  </ul></nav>
  <div class="user-nav">
    <div class="user-avatar"><i class="fa-regular fa-user"></i></div>
    <a href="logout" class="logout-btn"
       onclick="return confirm('Se déconnecter ?')">
      <i class="fa-solid fa-right-from-bracket"></i> Déconnexion
    </a>
  </div>
</header>

<div class="page-content">

  <!-- PAGE HEADER -->
  <div class="page-header">
    <div class="page-header-left">
      <div class="eyebrow">Espace client</div>
      <h1>Mes<br><em>Réservations</em></h1>
    </div>
    <a href="rooms" class="new-resa-btn"><i class="fa-solid fa-plus"></i> Nouvelle réservation</a>
  </div>

  <!-- SEARCH FORM -->
  <form action="my-reservations" method="get">
    <div class="search-card">
      <div class="search-field">
        <label>Votre adresse email</label>
        <div class="search-field-wrap">
          <i class="fa-regular fa-envelope"></i>
          <input type="email" name="email" placeholder="votre@email.com" required
            value="<%= email %>">
        </div>
      </div>
      <button type="submit" class="search-btn">
        <i class="fa-solid fa-magnifying-glass"></i> Voir mes réservations
      </button>
    </div>
  </form>

  <% if(success) { %>
  <div class="success-banner">
    <i class="fa-solid fa-circle-check"></i>
    <span>Votre réservation a été confirmée ! Un numéro de chambre vous a été assigné.</span>
  </div>
  <% } %>

  <!-- STATS -->
  <% if(reservations != null) { %>
  <div class="stats-row">
    <div class="stat-card">
      <div class="s-val"><%= totalCount %></div>
      <div class="s-label">Réservations</div>
    </div>
    <div class="stat-card">
      <div class="s-val"><%= confirmedCount %></div>
      <div class="s-label">Confirmées</div>
    </div>
    <div class="stat-card">
      <div class="s-val"><%= totalCount - confirmedCount %></div>
      <div class="s-label">Annulées</div>
    </div>
    <div class="stat-card">
      <div class="s-val"><%= totalSpent >= 1000 ? String.format("%.1fk", totalSpent/1000) : String.valueOf((int)totalSpent) %></div>
      <div class="s-label">MAD dépensés</div>
    </div>
  </div>

  <!-- FILTERS (visual — JS driven) -->
  <div class="filters">
    <button class="filter-pill active" onclick="filterBy('all',this)">Toutes</button>
    <button class="filter-pill" onclick="filterBy('CONFIRMED',this)">Confirmées</button>
    <button class="filter-pill" onclick="filterBy('CANCELLED',this)">Annulées</button>
    <button class="filter-pill" onclick="filterBy('PENDING',this)">En attente</button>
  </div>
  <% } %>

  <!-- RESERVATION CARDS -->
  <% if(reservations != null && !reservations.isEmpty()) { %>
  <div id="resa-list">
    <% for(Reservation r : reservations) { %>
    <div class="resa-card" data-status="<%= r.getStatus() %>">
      <img class="resa-img"
        src="https://images.unsplash.com/photo-1631049307264-da0ec9d70304?q=80&w=400&auto=format&fit=crop"
        alt="<%= r.getRoomTypeName() %>">
      <div class="resa-body">
        <div class="resa-top">
          <div>
            <div class="resa-ref">#<%= r.getId() %></div>
            <div class="resa-name"><%= r.getRoomTypeName() %> · N° <%= r.getRoomNumber() %></div>
          </div>
          <span class="status-badge <%= r.getStatus() %>"><%= r.getStatus() %></span>
        </div>

        <div class="resa-details">
          <div class="resa-detail">
            <i class="fa-regular fa-calendar"></i>
            <%= r.getCheckin() %> → <%= r.getCheckout() %>
          </div>
          <div class="resa-detail">
            <i class="fa-regular fa-user"></i>
            Chambre N° <%= r.getRoomNumber() %>
          </div>
          <% if(r.getServices() != null && !r.getServices().isEmpty()) { %>
          <div class="resa-detail">
            <i class="fa-solid fa-star"></i>
            <%= r.getServices().stream().map(s -> s.getName()).collect(java.util.stream.Collectors.joining(", ")) %>
          </div>
          <% } %>
        </div>

        <div class="resa-footer">
          <div class="resa-total"><%= r.getTotalPrice() %> <span>MAD</span></div>
          <div class="resa-actions">
            <% if(!"CANCELLED".equals(r.getStatus())) { %>
            <a href="my-reservations?id=<%= r.getId() %>&action=cancel&email=<%= email %>"
               class="action-btn danger"
               onclick="return openCancelModal('<%= r.getId() %>', '<%= email %>', event)">
              <i class="fa-solid fa-xmark"></i> Annuler
            </a>
            <% } else { %>
            <a href="rooms" class="action-btn">
              <i class="fa-solid fa-rotate-right"></i> Rebooker
            </a>
            <% } %>
          </div>
        </div>
      </div>
    </div>
    <% } %>
  </div>

  <% } else if(reservations != null) { %>
  <div class="empty-state">
    <div class="empty-icon"><i class="fa-regular fa-calendar-xmark"></i></div>
    <h3>Aucune réservation</h3>
    <p>Aucune réservation trouvée pour cet email.<br>Découvrez nos chambres et suites disponibles.</p>
    <a href="rooms" class="new-resa-btn"><i class="fa-solid fa-bed"></i> Voir les chambres</a>
  </div>
  <% } %>

</div>

<!-- CANCEL MODAL -->
<div class="modal-overlay" id="cancel-modal">
  <div class="cancel-modal">
    <h3>Annuler la<br>réservation ?</h3>
    <p>Cette action est irréversible. L'annulation est gratuite si elle est effectuée plus de 48h avant l'arrivée.</p>
    <div class="modal-btns">
      <button class="modal-btn-keep" onclick="closeCancel()">Conserver</button>
      <a id="confirm-cancel-link" href="#" class="modal-btn-cancel">
        Annuler la réservation
      </a>
    </div>
  </div>
</div>

<footer>© 2026 Blue Wave Hôtel. Tous droits réservés.</footer>

<script>
/* ── FILTER ── */
function filterBy(status, btn) {
  document.querySelectorAll('.filter-pill').forEach(p => p.classList.remove('active'));
  btn.classList.add('active');
  document.querySelectorAll('.resa-card').forEach(card => {
    const s = card.dataset.status;
    card.style.display = (status === 'all' || s === status) ? 'flex' : 'none';
  });
}

/* ── CANCEL MODAL ── */
function openCancelModal(id, email, e) {
  e.preventDefault();
  document.getElementById('confirm-cancel-link').href =
    'my-reservations?id=' + id + '&action=cancel&email=' + encodeURIComponent(email);
  document.getElementById('cancel-modal').classList.add('open');
  return false;
}
function closeCancel() {
  document.getElementById('cancel-modal').classList.remove('open');
}
// Close on overlay click
document.getElementById('cancel-modal').addEventListener('click', function(e) {
  if (e.target === this) closeCancel();
});
</script>
</body>
</html>