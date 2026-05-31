<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="fr">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Blue Wave — Créer un compte</title>
<link href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,300;0,400;1,300;1,400&family=Jost:wght@200;300;400;500&family=Cormorant+Garamond:ital,wght@0,300;1,300&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<style>
:root{
  --midnight:#004554; --midnight-2:#003040; --midnight-3:#002535;
  --moonstone:#44A6B5; --moonstone-2:#5cb8c6;
  --lightblue:#B2D5E2; --alice:#E9F1F6; --timber:#D3D0C8;
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
  background-image:url('https://images.pexels.com/photos/338504/pexels-photo-338504.jpeg?auto=compress&cs=tinysrgb&w=1200');
  background-size:cover;background-position:center;
  display:flex;flex-direction:column;justify-content:flex-end;padding:52px;
}
.left-panel::after{
  content:'';position:absolute;inset:0;
  background:linear-gradient(to top,rgba(0,37,53,.92) 0%,rgba(0,37,53,.4) 50%,rgba(0,37,53,.15) 100%);
}
.left-panel::before{
  content:'';position:absolute;inset:0;
  background:linear-gradient(135deg, rgba(0,69,84,0.3), transparent 60%);
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
  font-family:'Playfair Display',serif;font-size:clamp(36px,4vw,50px);font-weight:300;
  color:var(--white);line-height:1.2;margin-bottom:18px;
}
.panel-content h2 em{color:var(--moonstone-2);font-style:italic;}
.panel-content p{font-size:14px;color:var(--fog-low);line-height:1.8;max-width:340px;font-weight:300;}
.benefits{margin-top:32px;display:flex;flex-direction:column;gap:14px;}
.benefit{display:flex;align-items:center;gap:14px;font-size:13px;color:var(--fog-low);font-weight:300;}
.benefit-icon{
  width:28px;height:28px;border:1px solid var(--moon-line);
  display:flex;align-items:center;justify-content:center;flex-shrink:0;
}
.benefit-icon i{color:var(--moonstone);font-size:11px;}

/* ── RIGHT PANEL ── */
.right-panel{
  display:flex;flex-direction:column;justify-content:center;align-items:center;
  padding:60px 52px;background:var(--midnight-2);overflow-y:auto;
}
.form-box{width:100%;max-width:420px;}
.form-eyebrow{font-size:9px;letter-spacing:4px;text-transform:uppercase;color:var(--moonstone);margin-bottom:12px;}
.form-title{font-family:'Playfair Display',serif;font-size:40px;font-weight:300;color:var(--white);margin-bottom:8px;}
.form-title em{color:var(--moonstone-2);font-style:italic;}
.form-subtitle{font-size:13px;color:var(--fog-low);margin-bottom:36px;line-height:1.7;font-weight:300;}

/* ── ALERT ── */
.alert{padding:14px 18px;font-size:13px;margin-bottom:22px;display:flex;align-items:center;gap:10px;}
.alert-error{background:rgba(68,100,130,.12);border:1px solid rgba(68,166,181,.25);color:var(--lightblue);}

/* ── FIELDS ── */
.field{margin-bottom:18px;}
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

/* ── PASSWORD STRENGTH ── */
.pwd-strength{margin-top:7px;display:flex;gap:4px;}
.pwd-bar{flex:1;height:2px;background:rgba(178,213,226,.12);border-radius:2px;transition:background .3s;}
.pwd-bar.weak{background:#e05c5c;}
.pwd-bar.medium{background:#f0a540;}
.pwd-bar.strong{background:var(--moonstone);}

/* ── SUBMIT ── */
.submit-btn{
  width:100%;padding:15px;background:var(--moonstone);color:var(--midnight-3);border:none;
  font-family:'Jost',sans-serif;font-weight:500;font-size:10px;
  letter-spacing:3px;text-transform:uppercase;cursor:pointer;transition:opacity .3s,transform .2s;
  display:flex;align-items:center;justify-content:center;gap:10px;margin-top:8px;
}
.submit-btn:hover{opacity:.85;transform:translateY(-1px);}

.terms{font-size:11px;color:var(--fog-low);text-align:center;margin-top:16px;line-height:1.7;}
.terms a{color:var(--moonstone);text-decoration:none;}

.form-links{text-align:center;margin-top:20px;font-size:13px;color:var(--fog-low);}
.form-links a{color:var(--moonstone-2);text-decoration:none;font-weight:400;}
.form-links a:hover{text-decoration:underline;}

.back-home{
  display:inline-flex;align-items:center;gap:8px;font-size:10px;letter-spacing:2px;
  text-transform:uppercase;color:var(--fog-low);text-decoration:none;margin-top:24px;
  transition:color .2s;
}
.back-home:hover{color:var(--moonstone);}

/* ── DIVIDER ── */
.teal-line{width:40px;height:1px;background:var(--moonstone);display:inline-block;margin-bottom:28px;}

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
    <div class="panel-badge">Rejoignez-nous</div>
    <h2>Créez votre<br>compte <em>Blue Wave</em></h2>
    <p>Accédez à votre espace personnel et retrouvez toutes vos réservations en un clin d'œil.</p>
    <div class="benefits">
      <div class="benefit">
        <div class="benefit-icon"><i class="fa-solid fa-check"></i></div>
        Historique complet de vos séjours
      </div>
      <div class="benefit">
        <div class="benefit-icon"><i class="fa-solid fa-check"></i></div>
        Suivi en temps réel des réservations
      </div>
      <div class="benefit">
        <div class="benefit-icon"><i class="fa-solid fa-check"></i></div>
        Récapitulatif de vos dépenses
      </div>
      <div class="benefit">
        <div class="benefit-icon"><i class="fa-solid fa-check"></i></div>
        Annulation en ligne simplifiée
      </div>
    </div>
  </div>
</div>

<!-- RIGHT PANEL -->
<div class="right-panel">
  <div class="form-box">
    <div class="teal-line"></div>
    <div class="form-eyebrow">Inscription</div>
    <h1 class="form-title">Nouveau<br><em>compte</em></h1>
    <p class="form-subtitle">Remplissez le formulaire pour créer votre espace client.</p>

    <% String error = (String) request.getAttribute("error"); %>
    <% if (error != null) { %>
      <div class="alert alert-error"><i class="fa-solid fa-circle-info"></i><%= error %></div>
    <% } %>

    <form action="register" method="post">
      <div class="field">
        <label>Nom complet</label>
        <div class="field-wrap">
          <i class="fa-regular fa-user" required></i>
          <input type="text" name="name" placeholder="your name" maxlength="100"
                 value="<%= request.getAttribute("nameVal") != null ? request.getAttribute("nameVal") : "" %>" required autofocus >
        </div>
      </div>
      <div class="field">
        <label>Adresse e-mail</label>
        <div class="field-wrap">
          <i class="fa-regular fa-envelope"></i>
          <input type="email" name="email" placeholder="ex (votre@email.com)"
                 value="<%= request.getAttribute("emailVal") != null ? request.getAttribute("emailVal") : "" %>">
        </div>
      </div>
      <div class="field">
        <label>Téléphone</label>
        <div class="field-wrap">
          <i class="fa-solid fa-phone"></i>
          <input type="tel" name="phone" placeholder="+212 6XX XXX XXX"
                 value="<%= request.getAttribute("phoneVal") != null ? request.getAttribute("phoneVal") : "" %>" required>
        </div>
      </div>
      <div class="field">
        <label>Mot de passe</label>
        <div class="field-wrap">
          <i class="fa-solid fa-lock"></i>
          <input type="password" name="password"  minlength="6" id="pwd" placeholder="Minimum 6 caractères" required oninput="checkStrength(this.value)">
        </div>
        <div class="pwd-strength">
          <div class="pwd-bar" id="b1"></div>
          <div class="pwd-bar" id="b2"></div>
          <div class="pwd-bar" id="b3"></div>
          <div class="pwd-bar" id="b4"></div>
        </div>
      </div>
      <div class="field">
        <label>Confirmer le mot de passe</label>
        <div class="field-wrap">
          <i class="fa-solid fa-lock"></i>
          <input type="password" name="confirmPassword" placeholder="Répétez le mot de passe" required>
        </div>
      </div>
      <button type="submit" class="submit-btn">
        <i class="fa-solid fa-user-plus"></i> Créer mon compte
      </button>
    </form>

    <p class="terms">En créant un compte, vous acceptez nos <a href="#">Conditions d'utilisation</a>.</p>
    <div class="form-links">Déjà un compte ? <a href="login">Se connecter</a></div>
    <div style="text-align:center;">
      <a href="index.jsp" class="back-home"><i class="fa-solid fa-arrow-left"></i> Retour à l'accueil</a>
    </div>
  </div>
</div>

<script>
function checkStrength(v) {
  const bars = ['b1','b2','b3','b4'].map(id => document.getElementById(id));
  bars.forEach(b => { b.className='pwd-bar'; });
  if (!v) return;
  let score = 0;
  if (v.length >= 6) score++;
  if (v.length >= 10) score++;
  if (/[A-Z]/.test(v) || /[0-9]/.test(v)) score++;
  if (/[^a-zA-Z0-9]/.test(v)) score++;
  const cls = score <= 1 ? 'weak' : score <= 2 ? 'medium' : 'strong';
  for (let i = 0; i < score; i++) bars[i].classList.add(cls);
}
</script>
</body>
</html>