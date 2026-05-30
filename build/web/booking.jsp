```jsp
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, dao.*, model.*"%>

<%
String rtId = request.getParameter("roomTypeId");
String checkin = request.getParameter("checkin");
String checkout = request.getParameter("checkout");

RoomTypeDAO roomDao = new RoomTypeDAO();
RoomType room = roomDao.getById(Integer.parseInt(rtId));

ServiceDAO serviceDao = new ServiceDAO();
List<Service> services = serviceDao.getAllServices();
%>

<!DOCTYPE html>
<html lang="fr">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Blue Wave — Réservation</title>

<link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@300;400;600&family=DM+Sans:wght@300;400;500;700&display=swap" rel="stylesheet">

<link rel="stylesheet"
href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>

<style>

:root{
 --black:#0d0d0d;
 --black2:#161616;
 --gold:#c9a45c;
 --white:#fff;
 --border:rgba(201,164,92,.25);
}

*{
 margin:0;
 padding:0;
 box-sizing:border-box;
}

body{
 background:var(--black);
 color:white;
 font-family:'DM Sans',sans-serif;
}

/* HEADER */

header{
 width:94%;
 height:76px;
 position:fixed;
 top:16px;
 left:50%;
 transform:translateX(-50%);
 display:flex;
 justify-content:space-between;
 align-items:center;
 padding:0 32px;
 background:rgba(0,0,0,.72);
 backdrop-filter:blur(18px);
 border:1px solid var(--border);
 border-radius:16px;
 z-index:999;
}

.logo{
 text-decoration:none;
 color:var(--gold);
 font-size:26px;
 font-family:'Cormorant Garamond',serif;
 font-weight:600;
}

nav ul{
 display:flex;
 gap:24px;
 list-style:none;
}

nav a{
 text-decoration:none;
 color:rgba(255,255,255,.7);
 font-size:12px;
 letter-spacing:2px;
 text-transform:uppercase;
}

/* PAGE */

.page-wrap{
 width:92%;
 max-width:1300px;
 margin:auto;
 padding-top:140px;
 padding-bottom:80px;
 display:grid;
 grid-template-columns:1.3fr 420px;
 gap:40px;
}

/* LEFT */

.form-card{
 background:var(--black2);
 border:1px solid var(--border);
 border-radius:24px;
 padding:40px;
}

.eyebrow{
 color:var(--gold);
 font-size:11px;
 letter-spacing:4px;
 text-transform:uppercase;
 margin-bottom:14px;
}

.page-title{
 font-family:'Cormorant Garamond',serif;
 font-size:56px;
 font-weight:300;
 margin-bottom:40px;
}

.page-title em{
 color:var(--gold);
 font-style:italic;
}

/* STEPS */

.steps{
 display:flex;
 margin-bottom:40px;
 border:1px solid var(--border);
 border-radius:12px;
 overflow:hidden;
}

.step{
 flex:1;
 padding:16px;
 text-align:center;
 background:#141414;
 color:rgba(255,255,255,.4);
 font-size:11px;
 letter-spacing:2px;
 text-transform:uppercase;
}

.step.active{
 background:var(--gold);
 color:black;
 font-weight:700;
}

/* SECTION */

.section{
 margin-bottom:40px;
}

.sec-title{
 color:var(--gold);
 font-size:12px;
 letter-spacing:3px;
 text-transform:uppercase;
 margin-bottom:22px;
}

/* FIELDS */

.fields-2{
 display:grid;
 grid-template-columns:1fr 1fr;
 gap:18px;
}

.field{
 margin-bottom:18px;
}

.field label{
 display:block;
 margin-bottom:8px;
 font-size:12px;
 color:rgba(255,255,255,.7);
}

.field input,
.field textarea{
 width:100%;
 padding:15px;
 border:none;
 border-radius:10px;
 background:#111;
 color:white;
 font-size:14px;
 border:1px solid rgba(255,255,255,.08);
}

.field textarea{
 resize:none;
 min-height:100px;
}

.field input:focus,
.field textarea:focus{
 outline:none;
 border-color:var(--gold);
}

/* SERVICES */

.services-grid{
 display:grid;
 grid-template-columns:1fr 1fr;
 gap:14px;
}

.service-card{
 background:#111;
 border:1px solid rgba(255,255,255,.08);
 border-radius:14px;
 padding:18px;
 cursor:pointer;
 transition:.3s;
 display:flex;
 justify-content:space-between;
 align-items:center;
}

.service-card:hover{
 border-color:var(--gold);
}

.service-card input{
 width:auto;
}

/* PAYMENT */

.pay-grid{
 display:grid;
 grid-template-columns:2fr 1fr 1fr;
 gap:16px;
}

/* BUTTON */

.pay-btn{
 width:100%;
 margin-top:20px;
 padding:18px;
 border:none;
 border-radius:14px;
 background:var(--gold);
 color:black;
 font-size:13px;
 font-weight:700;
 letter-spacing:2px;
 text-transform:uppercase;
 cursor:pointer;
 transition:.3s;
}

.pay-btn:hover{
 opacity:.88;
 transform:translateY(-2px);
}

/* RIGHT */

.summary{
 background:var(--black2);
 border:1px solid var(--border);
 border-radius:24px;
 overflow:hidden;
 position:sticky;
 top:120px;
 height:fit-content;
}

.summary img{
 width:100%;
 height:260px;
 object-fit:cover;
}

.summary-body{
 padding:28px;
}

.sum-type{
 color:var(--gold);
 font-size:11px;
 letter-spacing:3px;
 text-transform:uppercase;
 margin-bottom:10px;
}

.sum-name{
 font-family:'Cormorant Garamond',serif;
 font-size:36px;
 margin-bottom:24px;
}

.sum-row{
 display:flex;
 justify-content:space-between;
 padding:12px 0;
 border-bottom:1px solid rgba(255,255,255,.05);
}

.sum-row span:first-child{
 color:rgba(255,255,255,.55);
}

.total{
 margin-top:24px;
 display:flex;
 justify-content:space-between;
 align-items:center;
}

.total-label{
 color:var(--gold);
 letter-spacing:2px;
 text-transform:uppercase;
 font-size:12px;
}

.total-price{
 font-family:'Cormorant Garamond',serif;
 font-size:40px;
 color:var(--gold);
}

@media(max-width:980px){

 .page-wrap{
  grid-template-columns:1fr;
 }

 .fields-2,
 .services-grid,
 .pay-grid{
  grid-template-columns:1fr;
 }

}

</style>
</head>

<body>

<header>

  <a href="index.jsp" class="logo">
    Blue Wave
  </a>

  <nav>
    <ul>
      <li><a href="index.jsp">Accueil</a></li>
      <li><a href="rooms">Chambres</a></li>
    </ul>
  </nav>

</header>

<div class="page-wrap">

  <!-- LEFT -->

  <div class="form-card">

    <div class="eyebrow">
      Blue Wave — Booking
    </div>

    <div class="page-title">
      Votre <em>Réservation</em>
    </div>

    <div class="steps">
      <div class="step active">1 — Séjour</div>
      <div class="step active">2 — Extras</div>
      <div class="step active">3 — Paiement</div>
    </div>

    <form action="pay" method="post">

      <!-- HIDDEN -->

      <input type="hidden"
      name="roomTypeId"
      value="<%= room.getId() %>">

      <input type="hidden"
      name="checkin"
      value="<%= checkin %>">

      <input type="hidden"
      name="checkout"
      value="<%= checkout %>">

      <!-- CLIENT -->

      <div class="section">

        <div class="sec-title">
          Informations client
        </div>

        <div class="fields-2">

          <div class="field">
            <label>Nom complet</label>

            <input type="text"
            name="name"
            required>
          </div>

          <div class="field">
            <label>Email</label>

            <input type="email"
            name="email"
            required>
          </div>

        </div>

        <div class="field">
          <label>Téléphone</label>

          <input type="text"
          name="phone">
        </div>

        <div class="field">
          <label>Demandes spéciales</label>

          <textarea
          name="notes"></textarea>
        </div>

      </div>

      <!-- SERVICES -->

      <div class="section">

        <div class="sec-title">
          Services optionnels
        </div>

        <div class="services-grid">

          <% for(Service s : services) { %>

          <label class="service-card">

            <div>
              <strong><%= s.getName() %></strong>
            </div>

            <div>
              <%= s.getPrice() %> MAD

              <input type="checkbox"
              name="services"
              value="<%= s.getId() %>">
            </div>

          </label>

          <% } %>

        </div>

      </div>

      <!-- PAYMENT -->

      <div class="section">

        <div class="sec-title">
          Paiement sécurisé
        </div>

        <div class="field">
          <label>Nom sur la carte</label>

          <input type="text"
          name="cardName"
          required>
        </div>

        <div class="field">
          <label>Numéro de carte</label>

          <input type="text"
          name="cardNumber"
          maxlength="19"
          required>
        </div>

        <div class="pay-grid">

          <div class="field">
            <label>Date expiration</label>

            <input type="text"
            name="expiry"
            placeholder="MM/AA"
            required>
          </div>

          <div class="field">
            <label>CVV</label>

            <input type="text"
            name="cvv"
            maxlength="3"
            required>
          </div>

        </div>

      </div>

      <button class="pay-btn"
      type="submit">

        Confirmer & Payer

      </button>

    </form>

  </div>

  <!-- RIGHT -->

  <div class="summary">

    <img src="<%= room.getImage() %>">

    <div class="summary-body">

      <div class="sum-type">
        Chambre sélectionnée
      </div>

      <div class="sum-name">
        <%= room.getName() %>
      </div>

      <div class="sum-row">
        <span>Check-in</span>
        <span><%= checkin %></span>
      </div>

      <div class="sum-row">
        <span>Check-out</span>
        <span><%= checkout %></span>
      </div>

      <div class="sum-row">
        <span>Prix / nuit</span>
        <span><%= room.getPrice() %> MAD</span>
      </div>

      <div class="total">

        <div class="total-label">
          Total estimé
        </div>

        <div class="total-price">
          <%= room.getPrice() %> MAD
        </div>

      </div>

    </div>

  </div>

</div>

</body>
</html>
```

