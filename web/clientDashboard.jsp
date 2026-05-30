.<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, model.*, model.User"%>
<%
User loggedUser = (User) session.getAttribute("loggedUser");
if (loggedUser == null) {
    response.sendRedirect(request.getContextPath() + "/login");
    return;
}
List<Reservation> reservations = (List<Reservation>) request.getAttribute("reservations");
if (reservations == null) reservations = new java.util.ArrayList<>();
double totalSpent = request.getAttribute("totalSpent") != null ? (double) request.getAttribute("totalSpent") : 0;
long confirmedCount = request.getAttribute("confirmedCount") != null ? (long) request.getAttribute("confirmedCount") : 0;
%>
<!DOCTYPE html>
<html lang="fr">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Blue Wave — Mon Espace Client</title>
<link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:ital,wght@0,300;0,400;0,600;1,300;1,400&family=DM+Sans:wght@300;400;500&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<style>
:root{
  --black:#0a0a0a;--black-mid:#111111;--black-soft:#1a1a1a;--black-card:#161616;
  --gold:#c9a45c;--gold-light:#e8d5a3;--gold-dim:rgba(201,164,92,0.12);
  --white:#ffffff;--white-85:rgba(255,255,255,0.85);--white-50:rgba(255,255,255,0.5);
  --white-15:rgba(255,255,255,0.08);--border:rgba(201,164,92,0.25);--border-soft:rgba(201,164,92,0.1);
  --success:#4ade80;--warning:#fbbf24;--danger:#f87171;--sidebar-w:260px;
}
*{margin:0;padding:0;box-sizing:border-box;}
html{scroll-behavior:smooth;}
body{font-family:'DM Sans',sans-serif;background:var(--black);color:var(--white);display:flex;min-height:100vh;}
::-webkit-scrollbar{width:4px;background:var(--black);}
::-webkit-scrollbar-thumb{background:var(--border);border-radius:2px;}

/* SIDEBAR */
.sidebar{
  width:var(--sidebar-w);min-height:100vh;background:var(--black-card);
  border-right:1px solid var(--border-soft);display:flex;flex-direction:column;
  position:fixed;top:0;left:0;z-index:100;
}
.sidebar-logo{padding:28px 28px 22px;border-bottom:1px solid var(--border-soft);}
.sidebar-logo h1{font-family:'Cormorant Garamond',serif;font-size:22px;font-weight:600;color:var(--gold);letter-spacing:2px;}
.sidebar-logo span{font-size:9px;letter-spacing:3px;text-transform:uppercase;color:var(--white-50);display:block;margin-top:4px;}

/* User info card in sidebar */
.sidebar-user{
  margin:16px 20px;padding:16px;background:var(--black-soft);
  border:1px solid var(--border-soft);border-radius:10px;
}
.sidebar-user .user-avatar{
  width:44px;height:44px;border-radius:50%;background:var(--gold-dim);border:1px solid var(--border);
  display:flex;align-items:center;justify-content:center;margin-bottom:10px;
  font-family:'Cormorant Garamond',serif;font-size:20px;font-weight:600;color:var(--gold);
}
.sidebar-user .user-name{font-size:13px;font-weight:500;color:var(--white-85);margin-bottom:3px;}
.sidebar-user .user-email{font-size:11px;color:var(--white-50);word-break:break-all;}
.sidebar-user .user-phone{font-size:11px;color:var(--white-50);margin-top:3px;}
.sidebar-user .user-badge{
  display:inline-block;margin-top:8px;padding:3px 10px;background:var(--gold-dim);
  border:1px solid var(--border);border-radius:4px;font-size:9px;letter-spacing:2px;
  text-transform:uppercase;color:var(--gold);
}

.sidebar-nav{flex:1;padding:14px 0;overflow-y:auto;}
.nav-label{font-size:9px;letter-spacing:3px;text-transform:uppercase;color:var(--white-50);
  padding:16px 24px 8px;font-weight:500;}
.nav-item{
  display:flex;align-items:center;gap:13px;padding:11px 24px;cursor:pointer;
  color:var(--white-50);text-decoration:none;font-size:13px;font-weight:400;
  letter-spacing:.3px;transition:background .2s,color .2s;border:none;background:none;width:100%;
}
.nav-item:hover{background:rgba(255,255,255,.04);color:var(--white-85);}
.nav-item.active{background:var(--gold-dim);color:var(--gold);border-right:2px solid var(--gold);}
.nav-item i{font-size:14px;width:18px;text-align:center;}
.sidebar-footer{padding:20px 24px;border-top:1px solid var(--border-soft);}

/* MAIN */
.main{margin-left:var(--sidebar-w);flex:1;padding:40px 44px;min-height:100vh;}
.page-header{margin-bottom:36px;}
.page-header h1{
  font-family:'Cormorant Garamond',serif;font-size:38px;font-weight:300;
  color:var(--white);margin-bottom:6px;
}
.page-header h1 em{color:var(--gold);font-style:italic;}
.page-header p{font-size:13px;color:var(--white-50);}

/* STATS */
.stats-grid{display:grid;grid-template-columns:repeat(4,1fr);gap:18px;margin-bottom:36px;}
.stat-card{
  background:var(--black-card);border:1px solid var(--border-soft);border-radius:14px;
  padding:22px 24px;position:relative;overflow:hidden;
}
.stat-card::before{
  content:'';position:absolute;top:-20px;right:-20px;width:80px;height:80px;
  border-radius:50%;background:var(--gold-dim);
}
.stat-icon{
  width:38px;height:38px;border-radius:9px;display:flex;align-items:center;
  justify-content:center;margin-bottom:14px;font-size:16px;position:relative;z-index:1;
}
.stat-icon.gold{background:var(--gold-dim);border:1px solid var(--border);color:var(--gold);}
.stat-icon.green{background:rgba(74,222,128,.1);border:1px solid rgba(74,222,128,.2);color:var(--success);}
.stat-icon.blue{background:rgba(96,165,250,.1);border:1px solid rgba(96,165,250,.2);color:#60a5fa;}
.stat-icon.amber{background:rgba(251,191,36,.1);border:1px solid rgba(251,191,36,.2);color:var(--warning);}
.stat-label{font-size:10px;letter-spacing:2px;text-transform:uppercase;color:var(--white-50);margin-bottom:6px;}
.stat-value{font-family:'Cormorant Garamond',serif;font-size:30px;font-weight:400;color:var(--white);}
.stat-sub{font-size:11px;color:var(--white-50);margin-top:3px;}

/* ALERT */
.alert-success{
  background:rgba(74,222,128,.08);border:1px solid rgba(74,222,128,.2);color:var(--success);
  border-radius:10px;padding:14px 20px;display:flex;align-items:center;gap:12px;
  font-size:13px;margin-bottom:28px;
}

/* TABLE */
.section-header{display:flex;align-items:center;justify-content:space-between;margin-bottom:18px;}
.section-title-block .eyebrow{font-size:9px;letter-spacing:3px;text-transform:uppercase;color:var(--gold);margin-bottom:4px;}
.section-title-block h2{font-family:'Cormorant Garamond',serif;font-size:24px;font-weight:300;color:var(--white);}
.new-booking-btn{
  display:inline-flex;align-items:center;gap:8px;padding:10px 22px;
  background:var(--gold);color:var(--black);border-radius:8px;text-decoration:none;
  font-size:11px;font-weight:700;letter-spacing:2px;text-transform:uppercase;
  transition:opacity .2s,transform .2s;
}
.new-booking-btn:hover{opacity:.87;transform:translateY(-1px);}

.table-wrap{
  background:var(--black-card);border:1px solid var(--border-soft);border-radius:16px;
  overflow:hidden;overflow-x:auto;
}
table{width:100%;border-collapse:collapse;min-width:800px;}
thead tr{background:rgba(201,164,92,0.06);border-bottom:1px solid var(--border-soft);}
th{
  padding:14px 18px;font-size:9px;letter-spacing:2.5px;text-transform:uppercase;
  color:var(--gold);font-weight:500;text-align:left;
}
td{padding:16px 18px;font-size:13px;color:var(--white-85);border-bottom:1px solid var(--white-15);}
tr:last-child td{border-bottom:none;}
tr:hover td{background:rgba(255,255,255,.02);}

.badge{
  display:inline-flex;align-items:center;gap:5px;padding:4px 10px;
  border-radius:5px;font-size:10px;font-weight:600;letter-spacing:1.5px;text-transform:uppercase;
}
.badge-confirmed{background:rgba(74,222,128,.1);color:var(--success);border:1px solid rgba(74,222,128,.25);}
.badge-cancelled{background:rgba(248,113,113,.1);color:var(--danger);border:1px solid rgba(248,113,113,.25);}
.badge-pending{background:rgba(251,191,36,.1);color:var(--warning);border:1px solid rgba(251,191,36,.25);}

.cancel-btn{
  display:inline-flex;align-items:center;gap:6px;padding:6px 14px;
  border:1px solid rgba(248,113,113,.3);background:transparent;color:var(--danger);
  border-radius:6px;font-size:10px;font-weight:600;letter-spacing:1px;text-transform:uppercase;
  cursor:pointer;text-decoration:none;transition:background .2s;
}
.cancel-btn:hover{background:rgba(248,113,113,.1);}

.empty-state{
  text-align:center;padding:72px 20px;
}
.empty-state i{font-size:48px;color:var(--border);margin-bottom:16px;display:block;}
.empty-state h3{font-family:'Cormorant Garamond',serif;font-size:26px;font-weight:300;color:var(--white-50);margin-bottom:8px;}
.empty-state p{font-size:13px;color:rgba(255,255,255,.3);margin-bottom:24px;}

.total-banner{
  background:linear-gradient(135deg,var(--black-card),var(--black-soft));
  border:1px solid var(--border);border-radius:14px;padding:24px 30px;
  display:flex;align-items:center;justify-content:space-between;margin-top:24px;
  flex-wrap:wrap;gap:16px;
}
.total-banner .t-label{font-size:10px;letter-spacing:3px;text-transform:uppercase;color:var(--gold);margin-bottom:6px;}
.total-banner .t-amount{font-family:'Cormorant Garamond',serif;font-size:36px;color:var(--gold);}
.total-banner .t-note{font-size:12px;color:var(--white-50);margin-top:4px;}
.total-banner .t-right{text-align:right;}
.total-banner .t-detail{font-size:13px;color:var(--white-85);}
.total-banner .t-detail span{color:var(--gold);}

@media(max-width:1100px){.stats-grid{grid-template-columns:repeat(2,1fr);}}
@media(max-width:860px){
  .sidebar{display:none;}
  .main{margin-left:0;padding:30px 20px;}
}
</style>
</head>
<body>

<!-- SIDEBAR -->
<aside class="sidebar">
  <div class="sidebar-logo">
    <h1>Blue Wave</h1>
    <span>Espace Client</span>
  </div>

  <div class="sidebar-user">
    <div class="user-avatar"><%= loggedUser.getName().substring(0,1).toUpperCase() %></div>
    <div class="user-name"><%= loggedUser.getName() %></div>
    <div class="user-email"><i class="fa-regular fa-envelope" style="margin-right:5px;font-size:10px;"></i><%= loggedUser.getEmail() %></div>
    <% if (loggedUser.getPhone() != null && !loggedUser.getPhone().isEmpty()) { %>
    <div class="user-phone"><i class="fa-solid fa-phone" style="margin-right:5px;font-size:10px;"></i><%= loggedUser.getPhone() %></div>
    <% } %>
    <span class="user-badge">Client</span>
  </div>

  <nav class="sidebar-nav">
    <div class="nav-label">Navigation</div>
    <a href="client/dashboard" class="nav-item active">
      <i class="fa-solid fa-layer-group"></i> Mes Réservations
    </a>
    <a href="index.jsp" class="nav-item">
      <i class="fa-solid fa-hotel"></i> Accueil
    </a>
    <a href="rooms" class="nav-item">
      <i class="fa-solid fa-bed"></i> Chambres disponibles
    </a>
  </nav>

  <div class="sidebar-footer">
    <a href="logout" class="nav-item" style="padding:11px 0;border-radius:6px;">
      <i class="fa-solid fa-right-from-bracket" style="color:var(--danger);"></i>
      <span style="color:var(--danger);">Se déconnecter</span>
    </a>
  </div>
</aside>

<!-- MAIN CONTENT -->
<main class="main">
  <div class="page-header">
    <h1>Bonjour, <em><%= loggedUser.getName().split(" ")[0] %></em></h1>
    <p>Gérez vos réservations et suivez vos dépenses depuis votre espace personnel.</p>
  </div>

  <% if ("1".equals(request.getAttribute("success"))) { %>
  <div class="alert-success">
    <i class="fa-solid fa-circle-check"></i>
    Votre réservation a été confirmée avec succès ! Merci de votre confiance.
  </div>
  <% } %>

  <!-- STATS -->
  <div class="stats-grid">
    <div class="stat-card">
      <div class="stat-icon gold"><i class="fa-solid fa-calendar-check"></i></div>
      <div class="stat-label">Total réservations</div>
      <div class="stat-value"><%= reservations.size() %></div>
      <div class="stat-sub">Tous statuts confondus</div>
    </div>
    <div class="stat-card">
      <div class="stat-icon green"><i class="fa-solid fa-circle-check"></i></div>
      <div class="stat-label">Confirmées</div>
      <div class="stat-value"><%= confirmedCount %></div>
      <div class="stat-sub">Réservations actives</div>
    </div>
    <div class="stat-card">
      <div class="stat-icon amber"><i class="fa-solid fa-coins"></i></div>
      <div class="stat-label">Total dépensé</div>
      <div class="stat-value"><%= String.format("%.0f", totalSpent) %></div>
      <div class="stat-sub">MAD (réservations actives)</div>
    </div>
    <div class="stat-card">
      <div class="stat-icon blue"><i class="fa-regular fa-envelope"></i></div>
      <div class="stat-label">Email</div>
      <div class="stat-value" style="font-size:13px;font-family:'DM Sans',sans-serif;margin-top:4px;"><%= loggedUser.getEmail() %></div>
      <div class="stat-sub"><%= loggedUser.getPhone() != null ? loggedUser.getPhone() : "—" %></div>
    </div>
  </div>

  <!-- RESERVATIONS TABLE -->
  <div class="section-header">
    <div class="section-title-block">
      <div class="eyebrow">Historique</div>
      <h2>Mes Réservations</h2>
    </div>
    <a href="rooms" class="new-booking-btn">
      <i class="fa-solid fa-plus"></i> Nouvelle réservation
    </a>
  </div>

  <% if (reservations.isEmpty()) { %>
  <div class="table-wrap">
    <div class="empty-state">
      <i class="fa-regular fa-calendar-xmark"></i>
      <h3>Aucune réservation</h3>
      <p>Vous n'avez pas encore effectué de réservation.</p>
      <a href="rooms" class="new-booking-btn">
        <i class="fa-solid fa-bed"></i> Réserver une chambre
      </a>
    </div>
  </div>
  <% } else { %>
  <div class="table-wrap">
    <table>
      <thead>
        <tr>
          <th>#</th>
          <th>Chambre</th>
          <th>Check-in</th>
          <th>Check-out</th>
          <th>Services</th>
          <th>Total</th>
          <th>Statut</th>
          <th>Action</th>
        </tr>
      </thead>
      <tbody>
        <% for (Reservation r : reservations) { %>
        <tr>
          <td style="color:var(--white-50);">#<%= r.getId() %></td>
          <td>
            <div style="font-weight:500;"><%= r.getRoomTypeName() != null ? r.getRoomTypeName() : "—" %></div>
            <% if (r.getRoomNumber() != null) { %>
            <div style="font-size:11px;color:var(--white-50);">Chambre <%= r.getRoomNumber() %></div>
            <% } %>
          </td>
          <td><%= r.getCheckin() %></td>
          <td><%= r.getCheckout() %></td>
          <td>
            <% if (r.getServices() != null && !r.getServices().isEmpty()) { %>
              <% for (model.Service s : r.getServices()) { %>
                <span style="font-size:11px;background:var(--gold-dim);border:1px solid var(--border);
                  color:var(--gold-light);border-radius:4px;padding:2px 8px;margin:1px;display:inline-block;">
                  <%= s.getName() %>
                </span>
              <% } %>
            <% } else { %>
              <span style="color:var(--white-50);">—</span>
            <% } %>
          </td>
          <td>
            <span style="font-family:'Cormorant Garamond',serif;font-size:18px;color:var(--gold);">
              <%= String.format("%.2f", r.getTotalPrice()) %>
            </span>
            <span style="font-size:11px;color:var(--white-50);"> MAD</span>
          </td>
          <td>
            <% String st = r.getStatus(); %>
            <% if ("CONFIRMED".equals(st)) { %>
              <span class="badge badge-confirmed"><i class="fa-solid fa-circle" style="font-size:6px;"></i>Confirmé</span>
            <% } else if ("CANCELLED".equals(st)) { %>
              <span class="badge badge-cancelled"><i class="fa-solid fa-circle" style="font-size:6px;"></i>Annulé</span>
            <% } else { %>
              <span class="badge badge-pending"><i class="fa-solid fa-circle" style="font-size:6px;"></i><%= st %></span>
            <% } %>
          </td>
          <td>
            <% if ("CONFIRMED".equals(r.getStatus())) { %>
            <a href="client/dashboard?action=cancel&id=<%= r.getId() %>"
               class="cancel-btn"
               onclick="return confirm('Annuler cette réservation ?')">
              <i class="fa-solid fa-xmark"></i> Annuler
            </a>
            <% } else { %>
            <span style="color:var(--white-50);font-size:12px;">—</span>
            <% } %>
          </td>
        </tr>
        <% } %>
      </tbody>
    </table>
  </div>

  <!-- TOTAL BANNER -->
  <div class="total-banner">
    <div>
      <div class="t-label">Récapitulatif financier</div>
      <div class="t-amount"><%= String.format("%.2f", totalSpent) %> <span style="font-size:18px;color:var(--gold-light);">MAD</span></div>
      <div class="t-note">Total des réservations confirmées</div>
    </div>
    <div class="t-right">
      <div class="t-detail">Email : <span><%= loggedUser.getEmail() %></span></div>
      <div class="t-detail" style="margin-top:6px;">Téléphone : <span><%= loggedUser.getPhone() != null ? loggedUser.getPhone() : "—" %></span></div>
      <div class="t-detail" style="margin-top:6px;"><%= reservations.size() %> réservation<%= reservations.size() > 1 ? "s" : "" %> au total · <span><%= confirmedCount %> active<%= confirmedCount > 1 ? "s" : "" %></span></div>
    </div>
  </div>
  <% } %>
</main>

</body>
</html>
