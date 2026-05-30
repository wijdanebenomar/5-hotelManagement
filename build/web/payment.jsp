<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, model.*"%>
<!DOCTYPE html>
<html lang="fr">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Blue Wave — Paiement Sécurisé</title>
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
*{margin:0;padding:0;box-sizing:border-box;}
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
  text-transform:uppercase;transition:color .3s;}
nav ul li a:hover{color:var(--moonstone-2);}

/* ── PAGE WRAP ── */
.page-wrap{
  max-width:1100px;margin:0 auto;padding:130px 5% 100px;
  display:grid;grid-template-columns:1.15fr 1fr;gap:48px;align-items:start;
}
.eyebrow{font-size:9px;letter-spacing:4px;text-transform:uppercase;color:var(--moonstone);
  margin-bottom:12px;display:flex;align-items:center;gap:12px;}
.eyebrow::before{content:'';display:inline-block;width:32px;height:1px;background:var(--moonstone);}
.page-title{margin-bottom:36px;}
.page-title h1{font-family:'Playfair Display',serif;font-size:48px;font-weight:300;line-height:1.1;color:var(--white);}
.page-title h1 em{color:var(--moonstone-2);font-style:italic;}

/* ── CARD VISUAL ── */
.card-preview{
  background:linear-gradient(135deg, var(--midnight-2), var(--midnight-3));
  border:1px solid var(--moon-line);padding:28px 32px;margin-bottom:32px;
  position:relative;overflow:hidden;
}
.card-preview::before{
  content:'';position:absolute;top:-50px;right:-50px;
  width:180px;height:180px;border-radius:50%;
  background:radial-gradient(circle, rgba(68,166,181,.12), transparent 70%);
}
.card-preview::after{
  content:'';position:absolute;bottom:-30px;left:-30px;
  width:120px;height:120px;border-radius:50%;
  background:radial-gradient(circle, rgba(68,166,181,.08), transparent 70%);
}
.cv-bank{font-size:10px;letter-spacing:3px;text-transform:uppercase;
  color:var(--moonstone);margin-bottom:20px;}
.cv-number{font-family:'Playfair Display',serif;font-size:22px;letter-spacing:5px;
  color:var(--fog);margin-bottom:20px;}
.cv-row{display:flex;justify-content:space-between;font-size:11px;color:var(--fog-low);}
.cv-row span{color:var(--fog);}

/* ── FIELDS ── */
.field{margin-bottom:20px;}
.field label{display:block;font-size:9px;letter-spacing:2.5px;text-transform:uppercase;
  color:var(--moonstone);font-weight:500;margin-bottom:8px;}
.field-wrap{position:relative;}
.field-wrap i.icon{position:absolute;left:14px;top:50%;transform:translateY(-50%);
  color:var(--fog-low);font-size:13px;pointer-events:none;}
.field-wrap:focus-within i.icon{color:var(--moonstone);}
.field input{
  width:100%;padding:13px 14px 13px 42px;
  border:1px solid rgba(178,213,226,.12);font-size:13px;
  font-family:'Jost',sans-serif;background:rgba(0,37,53,0.8);color:var(--white);
  transition:border-color .3s,box-shadow .3s;letter-spacing:1px;
}
.field input:focus{outline:none;border-color:var(--moonstone);box-shadow:0 0 0 3px rgba(68,166,181,.1);}
.field input::placeholder{color:rgba(178,213,226,.3);}
.card-row{display:grid;grid-template-columns:1fr 1fr;gap:16px;}
.pay-btn{
  width:100%;padding:16px;background:var(--moonstone);color:var(--midnight-3);border:none;
  font-family:'Jost',sans-serif;font-weight:500;font-size:11px;
  letter-spacing:3px;text-transform:uppercase;cursor:pointer;transition:opacity .3s;
  margin-top:8px;display:flex;align-items:center;justify-content:center;gap:10px;
}
.pay-btn:hover{opacity:.85;}
.lock-msg{text-align:center;font-size:11px;color:var(--fog-low);margin-top:14px;
  display:flex;align-items:center;justify-content:center;gap:8px;}
.lock-msg i{color:var(--moonstone);}

/* ── RECAP CARD ── */
.recap-card{
  border:1px solid var(--moon-line);overflow:hidden;
  background:rgba(0,48,64,0.5);position:sticky;top:110px;
}
.recap-img{width:100%;height:200px;object-fit:cover;display:block;
  filter:brightness(.7) saturate(.9);}
.recap-body{padding:28px;}
.recap-badge{font-size:9px;letter-spacing:4px;text-transform:uppercase;
  color:var(--moonstone);margin-bottom:8px;}
.recap-title{font-family:'Playfair Display',serif;font-size:24px;font-weight:300;
  color:var(--white);margin-bottom:24px;}
.r-row{display:flex;justify-content:space-between;align-items:baseline;
  padding:10px 0;border-bottom:1px solid var(--fog-ghost);font-size:13px;}
.r-row:last-of-type{border-bottom:none;}
.r-row .lbl{color:var(--fog-low);font-weight:300;}
.r-row .val{color:var(--fog);font-weight:400;}
.svc-list-inline{font-size:12px;color:var(--fog-low);text-align:right;}
.total-row{display:flex;justify-content:space-between;align-items:center;
  margin-top:20px;padding-top:20px;border-top:1px solid var(--moon-line);}
.t-lbl{font-size:10px;letter-spacing:3px;text-transform:uppercase;color:var(--moonstone);}
.t-amt{font-family:'Playfair Display',serif;font-size:32px;font-weight:300;color:var(--moonstone-2);}
.badges{display:flex;gap:8px;justify-content:center;margin-top:20px;flex-wrap:wrap;}
.badge-item{padding:8px 14px;background:rgba(0,37,53,0.6);border:1px solid var(--moon-line);
  font-size:10px;color:var(--fog-low);letter-spacing:1px;}

/* ── FOOTER ── */
footer{background:var(--midnight);border-top:1px solid var(--moon-line);
  padding:28px 5%;text-align:center;font-size:11px;color:rgba(178,213,226,.2);}

@media(max-width:900px){
  .page-wrap{grid-template-columns:1fr;padding-top:120px;}
  .recap-card{position:static;}
  header{padding:0 24px;}
}
@media(max-width:600px){nav ul{display:none;}.card-row{grid-template-columns:1fr;}}
</style>
</head>
<body>

<%
RoomType         roomType    = (RoomType)         session.getAttribute("pay_roomType");
List<Service>    selServices = (List<Service>)    session.getAttribute("pay_selServices");
long             nights      = (long)             session.getAttribute("pay_nights");
double           total       = (double)           session.getAttribute("pay_total");
String           checkin     = (String)           session.getAttribute("pay_checkin");
String           checkout    = (String)           session.getAttribute("pay_checkout");
String           name        = (String)           session.getAttribute("pay_name");
if(roomType == null) { response.sendRedirect("index.jsp"); return; }
%>

<header>
  <a href="index.jsp" style="text-decoration:none;">
    <span class="logo-main">Blue Wave</span>
    <span class="logo-sub">Hôtel &amp; Spa</span>
  </a>
  <nav><ul>
    <li><a href="rooms">Chambres</a></li>
    <li><a href="my-reservations">Mes réservations</a></li>
  </ul></nav>
</header>

<div class="page-wrap">

  <!-- LEFT — PAIEMENT -->
  <div>
    <div class="page-title">
      <div class="eyebrow">Blue Wave — Paiement</div>
      <h1>Paiement<br><em>Sécurisé</em></h1>
    </div>

    <div class="card-preview">
      <div class="cv-bank">Blue Wave Hôtel &nbsp;◈&nbsp; Carte de paiement</div>
      <div class="cv-number" id="cv-num">•••• &nbsp;•••• &nbsp;•••• &nbsp;••••</div>
      <div class="cv-row">
        <div>
          <div style="font-size:9px;letter-spacing:2px;margin-bottom:4px;color:var(--fog-low);">TITULAIRE</div>
          <span id="cv-name"><%= name != null ? name.toUpperCase() : "NOM PRÉNOM" %></span>
        </div>
        <div>
          <div style="font-size:9px;letter-spacing:2px;margin-bottom:4px;color:var(--fog-low);">EXPIRATION</div>
          <span id="cv-exp">MM / AA</span>
        </div>
        <div style="font-size:26px;color:var(--moonstone);opacity:.6;">
          <i class="fa-solid fa-credit-card"></i>
        </div>
      </div>
    </div>

    <form action="pay" method="post">
      <div class="field">
        <label>Nom sur la carte</label>
        <div class="field-wrap">
          <i class="fa-regular fa-id-card icon"></i>
          <input type="text" name="cardName" placeholder="Ex: Mohamed Alami"
            value="<%= name != null ? name : "" %>" required
            oninput="document.getElementById('cv-name').textContent=this.value.toUpperCase()||'NOM PRÉNOM'">
        </div>
      </div>
      <div class="field">
        <label>Numéro de carte</label>
        <div class="field-wrap">
          <i class="fa-solid fa-credit-card icon"></i>
          <input type="text" name="cardNumber" placeholder="1234 5678 9012 3456"
            maxlength="19" required
            oninput="this.value=this.value.replace(/[^0-9]/g,'').replace(/(.{4})/g,'$1 ').trim();document.getElementById('cv-num').textContent=this.value||'•••• •••• •••• ••••'">
        </div>
      </div>
      <div class="card-row">
        <div class="field">
          <label>Date d'expiration</label>
          <div class="field-wrap">
            <i class="fa-regular fa-calendar icon"></i>
            <input type="text" name="cardExpiry" placeholder="MM / AA" maxlength="5" required
              oninput="let v=this.value.replace(/\D/g,'');if(v.length>=2)v=v.substring(0,2)+'/'+v.substring(2,4);this.value=v;"
              onchange="document.getElementById('cv-exp').textContent=this.value||'MM / AA'">
          </div>
        </div>
        <div class="field">
          <label>CVV</label>
          <div class="field-wrap">
            <i class="fa-solid fa-lock icon"></i>
            <input type="text" name="cardCvv" placeholder="123" maxlength="3" required
              oninput="this.value=this.value.replace(/\D/g,'')">
          </div>
        </div>
      </div>
      <button type="submit" class="pay-btn">
        <i class="fa-solid fa-lock"></i>
        Confirmer et payer <%= total %> MAD
      </button>
      <div class="lock-msg">
        <i class="fa-solid fa-shield-halved"></i>
        Paiement 100% sécurisé — vos données sont protégées
      </div>
    </form>
  </div>

  <!-- RIGHT — RECAP -->
  <div>
    <div class="recap-card">
      <img class="recap-img" src="https://images.unsplash.com/photo-1631049307264-da0ec9d70304?q=80&w=700&auto=format&fit=crop" alt="">
      <div class="recap-body">
        <div class="recap-badge">Récapitulatif</div>
        <div class="recap-title"><%= roomType.getName() %></div>
        <div class="r-row"><span class="lbl">Client</span><span class="val"><%= name %></span></div>
        <div class="r-row"><span class="lbl">Type</span><span class="val"><%= roomType.getName() %></span></div>
        <div class="r-row"><span class="lbl">Check-in</span><span class="val"><%= checkin %></span></div>
        <div class="r-row"><span class="lbl">Check-out</span><span class="val"><%= checkout %></span></div>
        <div class="r-row">
          <span class="lbl">Durée</span>
          <span class="val"><%= nights %> nuit(s) × <%= roomType.getPrice() %> MAD = <%= (nights * roomType.getPrice()) %> MAD</span>
        </div>
        <% if(selServices != null && !selServices.isEmpty()) { %>
        <div class="r-row">
          <span class="lbl">Services</span>
          <span class="val svc-list-inline">
            <% double svcTotal = 0; for(Service s : selServices) { svcTotal += s.getPrice(); %>
              <%= s.getName() %> (<%= s.getPrice() %> MAD)<br>
            <% } %>
            = <strong style="color:var(--moonstone-2);"><%= svcTotal %> MAD</strong>
          </span>
        </div>
        <% } %>
        <div class="total-row">
          <span class="t-lbl">Total</span>
          <span class="t-amt"><%= total %> MAD</span>
        </div>
      </div>
    </div>
    <div class="badges">
      <div class="badge-item">🔒 SSL Sécurisé</div>
      <div class="badge-item">🛡 3D Secure</div>
      <div class="badge-item">✓ PCI DSS</div>
    </div>
  </div>

</div>
<footer>© 2026 Blue Wave Hôtel. Tous droits réservés.</footer>
</body>
</html>