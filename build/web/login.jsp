<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="fr">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Blue Wave — Connexion</title>
<link href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,300;0,400;1,300;1,400&family=Jost:wght@200;300;400;500&family=Cormorant+Garamond:ital,wght@0,300;1,300&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<style>
:root{
  --midnight:#004554; --midnight-2:#003040; --midnight-3:#002535;
  --moonstone:#44A6B5; --moonstone-2:#5cb8c6;
  --lightblue:#B2D5E2; --timber:#D3D0C8;
  --moon-line:rgba(68,166,181,0.28); --moon-dim:rgba(68,166,181,0.10);
  --white:#f8fbfc; --fog:rgba(233,241,246,0.65); --fog-low:rgba(178,213,226,0.45);
  --success:#1d9e75; --danger:#e05c5c;
}
*{margin:0;padding:0;box-sizing:border-box;}
body{
  font-family:'Jost',sans-serif;background:var(--midnight-3);color:var(--white);
  min-height:100vh;display:grid;grid-template-columns:1fr 1fr;
}

/* ── LEFT PANEL ── */
.left-panel{
  position:relative;overflow:hidden;
  background-image:url('https://images.unsplash.com/photo-1578683010236-d716f9a3f461?q=80&w=1400&auto=format&fit=crop');
  background-size:cover;background-position:center;
  display:flex;flex-direction:column;justify-content:flex-end;padding:52px;
}
.left-panel::after{
  content:'';position:absolute;inset:0;
  background:linear-gradient(to top,rgba(0,37,53,.92) 0%,rgba(0,37,53,.35) 55%,rgba(0,37,53,.1) 100%);
}
.left-panel::before{
  content:'';position:absolute;inset:0;
  background:linear-gradient(135deg, rgba(0,69,84,0.35), transparent 55%);
}
.panel-content{position:relative;z-index:2;}
.hotel-logo{
  position:absolute;top:52px;left:52px;z-index:3;
  font-family:'Playfair Display',serif;font-size:24px;font-weight:400;
  color:var(--white);letter-spacing:5px;text-decoration:none;text-transform:uppercase;
}
.hotel-logo span{color:var(--moonstone);}

.panel-badge{
  font-size:9px;letter-spacing:4px;text-transform:uppercase;color:var(--moonstone);
  margin-bottom:16px;display:flex;align-items:center;gap:12px;
}
.panel-badge::before{content:'';width:32px;height:1px;background:var(--moonstone);}
.panel-content h2{
  font-family:'Playfair Display',serif;font-size:clamp(36px,4vw,52px);font-weight:300;
  color:var(--white);line-height:1.15;margin-bottom:18px;
}
.panel-content h2 em{color:var(--moonstone-2);font-style:italic;}
.panel-content p{font-size:14px;color:var(--fog-low);line-height:1.8;max-width:340px;font-weight:300;}

/* ── DECORATIVE DOTS ── */
.panel-dots{display:flex;gap:8px;margin-top:32px;}
.panel-dots span{
  width:24px;height:2px;background:rgba(178,213,226,.25);
}
.panel-dots span.active{background:var(--moonstone);width:40px;}

/* ── RIGHT PANEL ── */
.right-panel{
  display:flex;flex-direction:column;justify-content:center;align-items:center;
  padding:60px 52px;background:var(--midnight-2);
}
.form-box{width:100%;max-width:400px;}
.form-eyebrow{font-size:9px;letter-spacing:4px;text-transform:uppercase;color:var(--moonstone);margin-bottom:12px;}
.form-title{font-family:'Playfair Display',serif;font-size:42px;font-weight:300;color:var(--white);margin-bottom:8px;}
.form-title em{color:var(--moonstone-2);font-style:italic;}
.form-subtitle{font-size:13px;color:var(--fog-low);margin-bottom:36px;line-height:1.7;font-weight:300;}

/* ── TEAL LINE ── */
.teal-line{width:40px;height:1px;background:var(--moonstone);display:inline-block;margin-bottom:28px;}

/* ── ALERTS ── */
.alert{padding:14px 18px;font-size:13px;margin-bottom:22px;display:flex;align-items:center;gap:10px;}
.alert-error{background:rgba(68,100,130,.12);border:1px solid rgba(68,166,181,.25);color:var(--lightblue);}
.alert-success{background:rgba(29,158,117,.1);border:1px solid rgba(29,158,117,.3);color:var(--success);}

/* ── ROLE TABS ── */
.role-tabs{
  display:flex;gap:0;margin-bottom:32px;background:rgba(0,37,53,0.6);
  border:1px solid var(--moon-line);padding:4px;
}
.role-tab{
  flex:1;text-align:center;padding:10px 14px;font-size:10px;
  font-weight:500;letter-spacing:2px;text-transform:uppercase;cursor:pointer;
  transition:background .25s,color .25s;color:var(--fog-low);border:none;
  background:none;font-family:'Jost',sans-serif;
}
.role-tab.active{background:var(--moonstone);color:var(--midnight-3);}

/* ── FIELDS ── */
.field{margin-bottom:20px;}
.field label{display:block;font-size:9px;letter-spacing:2.5px;text-transform:uppercase;
  color:var(--moonstone);font-weight:500;margin-bottom:8px;}
.field-wrap{position:relative;}
.field-wrap i{position:absolute;left:14px;top:50%;transform:translateY(-50%);
  color:var(--fog-low);font-size:13px;pointer-events:none;}
.field-wrap:focus-within i{color:var(--moonstone);}
.field input{
  width:100%;padding:13px 14px 13px 42px;
  border:1px solid rgba(178,213,226,.12);font-size:13px;
  font-family:'Jost',sans-serif;background:rgba(0,37,53,0.8);color:var(--white);
  transition:border-color .3s,box-shadow .3s;
}
.field input:focus{outline:none;border-color:var(--moonstone);box-shadow:0 0 0 3px rgba(68,166,181,.1);}
.field input::placeholder{color:rgba(178,213,226,.3);}

/* ── SUBMIT ── */
.submit-btn{
  width:100%;padding:15px;background:var(--moonstone);color:var(--midnight-3);border:none;
  font-family:'Jost',sans-serif;font-weight:500;font-size:10px;
  letter-spacing:3px;text-transform:uppercase;cursor:pointer;transition:opacity .3s,transform .2s;
  display:flex;align-items:center;justify-content:center;gap:10px;margin-top:4px;
}
.submit-btn:hover{opacity:.85;transform:translateY(-1px);}

/* ── DIVIDER ── */
.or-divider{
  display:flex;align-items:center;gap:14px;margin:24px 0;
  font-size:10px;color:var(--fog-low);letter-spacing:2px;text-transform:uppercase;
}
.or-divider::before,.or-divider::after{content:'';flex:1;height:1px;background:rgba(178,213,226,.1);}

/* ── LINKS ── */
.form-links{text-align:center;margin-top:20px;font-size:13px;color:var(--fog-low);}
.form-links a{color:var(--moonstone-2);text-decoration:none;}
.form-links a:hover{text-decoration:underline;}
.back-home{
  display:inline-flex;align-items:center;gap:8px;font-size:10px;letter-spacing:2px;
  text-transform:uppercase;color:var(--fog-low);text-decoration:none;margin-top:28px;transition:color .2s;
}
.back-home:hover{color:var(--moonstone);}

@media(max-width:860px){
  body{grid-template-columns:1fr;}
  .left-panel{display:none;}
  .right-panel{padding:50px 28px;}
}
</style>
</head>
<body>

<!-- LEFT PANEL -->
<div class="left-panel">
  <a href="index.jsp" class="hotel-logo">Blue <span>Wave</span></a>
  <div class="panel-content">
    <div class="panel-badge">Votre espace privilégié</div>
    <h2>Bienvenue<br>sur <em>Blue Wave</em></h2>
    <p>Connectez-vous pour accéder à vos réservations, gérer vos séjours et profiter d'une expérience personnalisée.</p>
    <div class="panel-dots">
      <span class="active"></span><span></span><span></span>
    </div>
  </div>
</div>

<!-- RIGHT PANEL -->
<div class="right-panel">
  <div class="form-box">
    <div class="teal-line"></div>
    <div class="form-eyebrow">Connexion</div>
    <h1 class="form-title">Accéder à<br>votre <em>espace</em></h1>
    <p class="form-subtitle">Entrez vos identifiants pour vous connecter.</p>

    <% String error = (String) request.getAttribute("error"); %>
    <% if (error != null) { %>
      <div class="alert alert-error"><i class="fa-solid fa-circle-info"></i><%= error %></div>
    <% } %>
    <% if ("1".equals(request.getParameter("registered"))) { %>
      <div class="alert alert-success"><i class="fa-solid fa-circle-check"></i>Compte créé avec succès ! Connectez-vous.</div>
    <% } %>
    <% if ("1".equals(request.getParameter("logout"))) { %>
      <div class="alert alert-success"><i class="fa-solid fa-circle-check"></i>Vous avez été déconnecté.</div>
    <% } %>

    <div class="role-tabs">
      <button class="role-tab active" onclick="setHint('client',this)">
        <i class="fa-regular fa-user" style="margin-right:6px;"></i>Client
      </button>
      <button class="role-tab" onclick="setHint('admin',this)">
        <i class="fa-solid fa-shield-halved" style="margin-right:6px;"></i>Admin
      </button>
    </div>

    <form action="login" method="post">
      <div class="field">
        <label>Adresse e-mail</label>
        <div class="field-wrap">
          <i class="fa-regular fa-envelope"></i>
          <input type="email" name="email" placeholder="votre@email.com"
                 value="<%= request.getAttribute("emailVal") != null ? request.getAttribute("emailVal") : "" %>" required autofocus>
        </div>
      </div>
      <div class="field">
        <label>Mot de passe</label>
        <div class="field-wrap">
          <i class="fa-solid fa-lock"></i>
          <input type="password" name="password" placeholder="••••••••" required>
        </div>
      </div>
      <button type="submit" class="submit-btn">
        <i class="fa-solid fa-right-to-bracket"></i> Se connecter
      </button>
    </form>

    <div class="or-divider">ou</div>
    <div class="form-links">Pas encore de compte ? <a href="register">Créer un compte</a></div>
    <div style="text-align:center;">
      <a href="index.jsp" class="back-home"><i class="fa-solid fa-arrow-left"></i> Retour à l'accueil</a>
    </div>
  </div>
</div>

<script>
function setHint(role, btn) {
  document.querySelectorAll('.role-tab').forEach(t => t.classList.remove('active'));
  btn.classList.add('active');
}
</script>
</body>
</html>