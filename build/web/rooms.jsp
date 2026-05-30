<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, model.*"%>
<!DOCTYPE html>
<html lang="fr">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Blue Wave — Chambres disponibles</title>
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
.logo-main{font-family:'Playfair Display',serif;font-size:22px;font-weight:400;
  letter-spacing:6px;color:var(--white);text-transform:uppercase;text-decoration:none;display:block;}
.logo-sub{font-family:'Cormorant Garamond',serif;font-size:11px;font-style:italic;
  letter-spacing:4px;color:var(--moonstone);display:block;text-align:center;}
nav ul{display:flex;list-style:none;gap:32px;align-items:center;}
nav ul li a{text-decoration:none;color:var(--fog);font-size:10px;letter-spacing:2.5px;
  text-transform:uppercase;position:relative;padding-bottom:4px;transition:color .3s;}
nav ul li a::after{content:'';position:absolute;bottom:0;left:0;width:0;height:1px;
  background:var(--moonstone);transition:width .35s cubic-bezier(.25,.46,.45,.94);}
nav ul li a:hover,nav ul li a.active{color:var(--moonstone-2);}
nav ul li a:hover::after,nav ul li a.active::after{width:100%;}
.nav-cta{background:transparent!important;border:1px solid var(--moon-line)!important;
  color:var(--moonstone)!important;padding:9px 22px;border-radius:2px;font-size:9px!important;
  letter-spacing:2.5px;transition:background .3s!important,color .3s!important;}
.nav-cta:hover{background:var(--moonstone)!important;color:var(--midnight-3)!important;}
.nav-cta::after{display:none!important;}

/* ── HERO BANNER ── */
.hero-banner{
  width:100%;height:380px;position:relative;
  background-image:url('https://images.unsplash.com/photo-1631049307264-da0ec9d70304?q=80&w=1600&auto=format&fit=crop');
  background-size:cover;background-position:center;
  display:flex;align-items:flex-end;padding-bottom:60px;margin-top:88px;
}
.hero-banner::after{content:'';position:absolute;inset:0;
  background:linear-gradient(to bottom,rgba(0,37,53,.4),rgba(0,37,53,.92));}
.hero-banner-content{position:relative;z-index:2;padding:0 7%;}
.eyebrow{font-size:9px;letter-spacing:4px;text-transform:uppercase;color:var(--moonstone);
  margin-bottom:12px;display:flex;align-items:center;gap:12px;}
.eyebrow::before{content:'';display:inline-block;width:32px;height:1px;background:var(--moonstone);}
.hero-banner-content h1{font-family:'Playfair Display',serif;font-size:clamp(38px,5vw,58px);
  font-weight:300;line-height:1.1;color:var(--white);}
.hero-banner-content h1 em{font-style:italic;color:var(--moonstone-2);}

/* ── WAVE SVG ── */
.wave-sep{display:block;width:100%;height:60px;margin-top:-2px;}
.wave-sep svg{width:100%;height:100%;}

/* ── PAGE BODY ── */
.page-body{max-width:1160px;margin:0 auto;padding:20px 5% 100px;}

/* ── ALERTS ── */
.alert-error{
  background:rgba(68,100,130,0.15);border:1px solid rgba(68,166,181,0.3);
  color:var(--lightblue);border-radius:4px;padding:18px 24px;
  display:flex;align-items:center;gap:14px;font-size:14px;margin-bottom:36px;
}
.alert-error i{font-size:20px;flex-shrink:0;color:var(--moonstone);}
.empty-state{text-align:center;padding:100px 20px;color:var(--fog-low);}
.empty-state i{font-size:52px;color:var(--moon-line);display:block;margin-bottom:20px;}
.empty-state p{font-family:'Playfair Display',serif;font-size:22px;font-weight:300;}

/* ── ROOM CARD ── */
.room-card{
  border:1px solid var(--moon-line);overflow:hidden;
  margin-bottom:3px;transition:transform .3s,box-shadow .3s;
  background:rgba(0,48,64,0.5);
}
.room-card:hover{transform:translateY(-3px);box-shadow:0 24px 60px rgba(0,0,0,.45);}
.card-grid{display:grid;grid-template-columns:360px 1fr;min-height:280px;}

/* IMAGE */
.card-img{position:relative;overflow:hidden;}
.card-img img{width:100%;height:100%;object-fit:cover;transition:transform .6s;
  display:block;filter:brightness(.75) saturate(.9);}
.room-card:hover .card-img img{transform:scale(1.06);filter:brightness(.85) saturate(1);}
.card-badge{
  position:absolute;top:20px;left:20px;
  background:var(--moonstone);color:var(--midnight-3);
  font-size:9px;font-weight:500;letter-spacing:2.5px;text-transform:uppercase;
  padding:6px 14px;border-radius:1px;
}

/* BODY */
.card-body{padding:32px 36px;display:flex;flex-direction:column;justify-content:space-between;gap:24px;}
.card-type{font-size:9px;letter-spacing:4px;text-transform:uppercase;color:var(--moonstone);font-weight:500;}
.card-title{font-family:'Playfair Display',serif;font-size:28px;font-weight:300;
  color:var(--white);margin:6px 0 10px;}
.card-desc{font-size:13px;color:var(--fog-low);line-height:1.8;font-weight:300;}
.card-price{
  font-family:'Playfair Display',serif;font-size:36px;font-weight:300;
  color:var(--moonstone-2);margin:4px 0;
}
.card-price small{font-size:14px;color:var(--fog-low);font-family:'Jost',sans-serif;}

/* ── BOOKING FORM INSIDE CARD ── */
.resa-form{
  background:rgba(0,69,84,0.3);border:1px solid var(--moon-line);
  padding:24px 26px;
}
.form-section-title{
  font-size:9px;letter-spacing:3px;text-transform:uppercase;color:var(--moonstone);
  font-weight:500;margin-bottom:20px;display:flex;align-items:center;gap:12px;
}
.form-section-title::after{content:'';flex:1;height:1px;background:var(--moon-line);}
.fields-row{display:grid;grid-template-columns:1fr 1fr;gap:14px;margin-bottom:16px;}
.field{display:flex;flex-direction:column;gap:6px;}
.field label{font-size:9px;letter-spacing:2.5px;text-transform:uppercase;color:var(--moonstone);font-weight:500;}
.field-wrap{position:relative;}
.field-wrap i.ico{position:absolute;left:13px;top:50%;transform:translateY(-50%);
  color:var(--fog-low);font-size:12px;pointer-events:none;}
.field-wrap:focus-within i.ico{color:var(--moonstone);}
.field input,.field select{
  width:100%;padding:11px 14px 11px 36px;
  border:1px solid rgba(178,213,226,0.12);font-size:13px;
  font-family:'Jost',sans-serif;background:rgba(0,37,53,0.8);color:var(--white);
  transition:border-color .3s;
}
.field input:focus,.field select:focus{outline:none;border-color:var(--moonstone);}
.field input::placeholder{color:rgba(178,213,226,.3);}
.field select option{background:#002535;color:var(--white);}

/* SERVICES */
.svc-section{margin-bottom:18px;}
.svc-title{font-size:9px;letter-spacing:2.5px;text-transform:uppercase;
  color:var(--moonstone);font-weight:500;margin-bottom:12px;
  display:flex;align-items:center;gap:10px;}
.svc-title::after{content:'';flex:1;height:1px;background:var(--moon-line);}
.svc-grid{display:grid;grid-template-columns:1fr 1fr;gap:6px;}
.svc-item{
  display:flex;align-items:center;gap:8px;padding:10px 12px;
  background:rgba(0,37,53,0.6);border:1px solid rgba(178,213,226,.08);
  cursor:pointer;transition:border-color .3s,background .3s;
}
.svc-item:hover{border-color:var(--moon-line);background:var(--moon-dim);}
.svc-item input[type=checkbox]{accent-color:var(--moonstone);}
.svc-item span{font-size:12px;color:var(--fog);font-weight:300;}
.svc-price{font-size:11px;color:var(--moonstone-2);margin-left:auto;white-space:nowrap;}

/* SUBMIT */
.submit-btn{
  width:100%;padding:14px;background:var(--moonstone);color:var(--midnight-3);border:none;
  font-family:'Jost',sans-serif;font-size:10px;font-weight:500;
  letter-spacing:3px;text-transform:uppercase;cursor:pointer;transition:opacity .3s;
  display:flex;align-items:center;justify-content:center;gap:10px;
}
.submit-btn:hover{opacity:.85;}

/* ── FOOTER ── */
footer{
  background:var(--midnight);border-top:1px solid var(--moon-line);
  padding:32px 5%;text-align:center;
  font-size:11px;color:rgba(178,213,226,.2);letter-spacing:.5px;
}

@media(max-width:900px){
  .card-grid{grid-template-columns:1fr;}
  .card-img{height:220px;}
  .fields-row,.svc-grid{grid-template-columns:1fr;}
  header{padding:0 24px;}
}
@media(max-width:600px){nav ul{display:none;}.hero-banner-content h1{font-size:32px;}}
</style>
</head>
<body>

<%
List<RoomType> roomTypes = (List<RoomType>) request.getAttribute("roomTypes");
List<Service>  services  = (List<Service>)  request.getAttribute("services");
String checkin  = (String) request.getAttribute("checkin");
String checkout = (String) request.getAttribute("checkout");
String errorMsg = (String) request.getAttribute("errorMsg");
if(checkin  == null) checkin  = "";
if(checkout == null) checkout = "";
%>

<header>
  <a href="index.jsp" style="text-decoration:none;">
    <span class="logo-main">Blue Wave</span>
    <span class="logo-sub">Hôtel &amp; Spa</span>
  </a>
  <nav><ul>
    <li><a href="index.jsp">Accueil</a></li>
    <li><a href="rooms" class="active">Chambres</a></li>
    <li><a href="my-reservations">Mes réservations</a></li>
    <li><a href="admin/reservations" class="nav-cta">Admin</a></li>
  </ul></nav>
</header>

<div class="hero-banner">
  <div class="hero-banner-content">
    <div class="eyebrow">Blue Wave — Disponibilités</div>
    <h1>Chambres <em>&amp; Suites</em><br>disponibles</h1>
  </div>
</div>

<svg class="wave-sep" viewBox="0 0 1440 60" preserveAspectRatio="none" xmlns="http://www.w3.org/2000/svg">
  <path d="M0,30 C360,60 720,0 1080,30 C1260,45 1380,20 1440,30 L1440,60 L0,60 Z" fill="#002535"/>
</svg>

<div class="page-body">

  <% if(errorMsg != null) { %>
  <div class="alert-error">
    <i class="fa-solid fa-circle-info"></i>
    <span><%= errorMsg %></span>
  </div>
  <% } %>

  <% if(roomTypes == null || roomTypes.isEmpty()) { %>
  <div class="empty-state">
    <i class="fa-regular fa-face-sad-tear"></i>
    <p>Aucune chambre disponible.<br><span style="font-family:'Jost',sans-serif;font-size:14px;color:var(--fog-low);">Veuillez modifier vos critères de recherche.</span></p>
  </div>
  <% } else { for(RoomType rt : roomTypes) { %>

  <div class="room-card">
    <div class="card-grid">
      <div class="card-img">
        <img src="https://images.unsplash.com/photo-1631049307264-da0ec9d70304?q=80&w=700&auto=format&fit=crop" alt="<%= rt.getName() %>">
        <div class="card-badge">Disponible</div>
      </div>
      <div class="card-body">
        <div>
          <div class="card-type">Type de chambre</div>
          <div class="card-title"><%= rt.getName() %></div>
          <div class="card-desc"><%= rt.getDescription() %></div>
          <div class="card-price"><%= rt.getPrice() %> MAD <small>/ nuit</small></div>
        </div>

        <div class="resa-form">
          <div class="form-section-title">Réserver cette chambre</div>
          <form action="check-availability" method="post">
            <input type="hidden" name="roomTypeId" value="<%= rt.getId() %>">
            <input type="hidden" name="checkin"    value="<%= checkin %>">
            <input type="hidden" name="checkout"   value="<%= checkout %>">

            <div class="fields-row">
              <div class="field">
                <label>Nom complet</label>
                <div class="field-wrap">
                  <i class="fa-regular fa-user ico"></i>
                  <input type="text" name="name" placeholder="Votre nom complet" required>
                </div>
              </div>
              <div class="field">
                <label>Email</label>
                <div class="field-wrap">
                  <i class="fa-regular fa-envelope ico"></i>
                  <input type="email" name="email" placeholder="Votre email" required>
                </div>
              </div>
            </div>
            <div class="fields-row" style="grid-template-columns:1fr;">
              <div class="field">
                <label>Téléphone</label>
                <div class="field-wrap">
                  <i class="fa-solid fa-phone ico"></i>
                  <input type="text" name="phone" placeholder="Votre téléphone">
                </div>
              </div>
            </div>

            <div class="svc-section">
              <div class="svc-title">Services optionnels</div>
              <div class="svc-grid">
                <% for(Service s : services) { %>
                <label class="svc-item">
                  <input type="checkbox" name="services" value="<%= s.getId() %>">
                  <span><%= s.getName() %></span>
                  <span class="svc-price"><%= s.getPrice() %> MAD</span>
                </label>
                <% } %>
              </div>
            </div>

            <button type="submit" class="submit-btn">
              <i class="fa-solid fa-arrow-right"></i> Vérifier la disponibilité
            </button>
          </form>
        </div>
      </div>
    </div>
  </div>

  <% } } %>
</div>

<footer>© 2026 Blue Wave Hôtel. Tous droits réservés.</footer>
</body>
</html>