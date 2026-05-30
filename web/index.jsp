<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="fr">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Blue Wave Hôtel — Luxe & Sérénité</title>
<link href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,300;0,400;0,500;1,300;1,400&family=Jost:wght@200;300;400;500&family=Cormorant+Garamond:ital,wght@0,300;1,300;1,400&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<style>
:root {
  /* ── Ocean Palette ── */
  --midnight:   #004554;   /* deep ocean base */
  --midnight-2: #003040;   /* darker bg */
  --midnight-3: #002535;   /* deepest bg */
  --moonstone:  #44A6B5;   /* primary accent */
  --moonstone-2:#5cb8c6;   /* lighter accent */
  --lightblue:  #B2D5E2;   /* soft accent */
  --alice:      #E9F1F6;   /* near-white tint */
  --timber:     #D3D0C8;   /* warm sand neutral */
  --timber-dim: rgba(211,208,200,0.12);
  --moon-line:  rgba(68,166,181,0.28);
  --moon-dim:   rgba(68,166,181,0.10);
  --white:      #f8fbfc;
  --fog:        rgba(233,241,246,0.65);
  --fog-low:    rgba(178,213,226,0.45);
  --fog-ghost:  rgba(178,213,226,0.08);
}

*, *::before, *::after { margin:0; padding:0; box-sizing:border-box; }
html { scroll-behavior:smooth; }
body {
  font-family:'Jost', sans-serif;
  background:var(--midnight-3);
  color:var(--white);
  overflow-x:hidden;
  cursor:none;
}

/* ── GRAIN ── */
body::before {
  content:''; position:fixed; inset:0; z-index:9997; pointer-events:none;
  opacity:.022;
  background-image:url("data:image/svg+xml,%3Csvg viewBox='0 0 200 200' xmlns='http://www.w3.org/2000/svg'%3E%3Cfilter id='n'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='0.9' numOctaves='4' stitchTiles='stitch'/%3E%3C/filter%3E%3Crect width='100%25' height='100%25' filter='url(%23n)'/%3E%3C/svg%3E");
  background-repeat:repeat; background-size:180px;
}

/* ── CURSOR ── */
.cursor-dot {
  width:6px; height:6px; background:var(--moonstone); border-radius:50%;
  position:fixed; pointer-events:none; z-index:9999;
  transform:translate(-50%,-50%);
}
.cursor-ring {
  width:36px; height:36px; border:1px solid var(--moon-line); border-radius:50%;
  position:fixed; pointer-events:none; z-index:9998;
  transform:translate(-50%,-50%);
  transition:transform .18s cubic-bezier(.25,.46,.45,.94), width .25s, height .25s, border-color .25s;
}

/* ── HEADER ── */
header {
  position:fixed; top:0; left:0; right:0; z-index:1000;
  height:88px;
  display:flex; align-items:center; justify-content:space-between;
  padding:0 52px;
  background:transparent;
  transition:background .6s, border-color .6s;
  border-bottom:1px solid transparent;
}
header.scrolled {
  background:rgba(0,37,53,0.95);
  backdrop-filter:blur(24px);
  border-bottom-color:var(--moon-line);
}
.logo { display:flex; flex-direction:column; gap:2px; }
.logo-main {
  font-family:'Playfair Display', serif;
  font-size:22px; font-weight:400; letter-spacing:6px;
  color:var(--white); text-transform:uppercase;
}
.logo-sub {
  font-family:'Cormorant Garamond', serif;
  font-size:11px; font-style:italic; letter-spacing:4px;
  color:var(--moonstone); text-align:center;
}
nav ul { display:flex; list-style:none; gap:36px; align-items:center; }
nav ul li a {
  text-decoration:none; color:var(--fog);
  font-size:10px; font-weight:400; letter-spacing:2.5px; text-transform:uppercase;
  position:relative; padding-bottom:4px; transition:color .3s;
}
nav ul li a::after {
  content:''; position:absolute; bottom:0; left:0;
  width:0; height:1px; background:var(--moonstone);
  transition:width .35s cubic-bezier(.25,.46,.45,.94);
}
nav ul li a:hover, nav ul li a.active { color:var(--moonstone-2); }
nav ul li a:hover::after, nav ul li a.active::after { width:100%; }
.nav-cta {
  background:transparent !important;
  border:1px solid var(--moon-line) !important;
  color:var(--moonstone) !important;
  padding:9px 24px; border-radius:2px;
  font-size:9px !important; letter-spacing:2.5px;
  transition:background .3s !important, color .3s !important;
}
.nav-cta:hover { background:var(--moonstone) !important; color:var(--midnight-3) !important; }
.nav-cta::after { display:none !important; }

/* ── HERO ── */
.hero {
  position:relative; width:100%; height:100vh;
  display:flex; align-items:center; justify-content:center; overflow:hidden;
}
.hero-bg {
  position:absolute; inset:0;
  background-image:url('https://dynamic-media-cdn.tripadvisor.com/media/photo-o/30/b0/1d/03/caption.jpg?w=1200&h=-1&s=1');
  background-size:cover; background-position:center;
  transform:scale(1.06);
  animation:heroZoom 18s ease-out forwards;
}
@keyframes heroZoom { to { transform:scale(1); } }
.hero-vignette {
  position:absolute; inset:0;
  background:
    radial-gradient(ellipse at 50% 0%, rgba(0,37,53,0.25) 0%, transparent 60%),
    linear-gradient(to bottom, rgba(0,37,53,.55) 0%, rgba(0,37,53,.1) 45%, rgba(0,37,53,.92) 100%);
}
.hero-wave-overlay {
  position:absolute; bottom:-2px; left:0; right:0; z-index:3;
  height:120px; overflow:hidden;
}
.hero-wave-overlay svg { width:100%; height:100%; }

/* tinted side bars */
.hero-side-lines {
  position:absolute; inset:0; pointer-events:none;
  border-left:1px solid rgba(68,166,181,0.12);
  border-right:1px solid rgba(68,166,181,0.12);
  margin:0 80px;
}
.hero-content {
  position:relative; z-index:2;
  text-align:center; padding:0 20px;
  display:flex; flex-direction:column; align-items:center;
}
.hero-eyebrow {
  display:flex; align-items:center; gap:18px; margin-bottom:32px;
  opacity:0; animation:fadeUp .8s .4s forwards;
}
.hero-eyebrow .rule { width:48px; height:1px; background:var(--moonstone); }
.hero-eyebrow span {
  font-family:'Cormorant Garamond', serif;
  font-size:15px; font-style:italic; letter-spacing:4px; color:var(--lightblue);
}
.hero h1 {
  font-family:'Playfair Display', serif;
  font-size:clamp(52px, 9vw, 108px); font-weight:300; line-height:.95;
  letter-spacing:4px; color:var(--white);
  opacity:0; animation:fadeUp .9s .65s forwards;
}
.hero h1 em {
  font-style:italic; color:transparent;
  -webkit-text-stroke:1px var(--lightblue);
}
.hero-tagline {
  margin-top:28px; font-size:11px; letter-spacing:5px; text-transform:uppercase;
  color:var(--fog-low); font-weight:300;
  opacity:0; animation:fadeUp .8s .9s forwards;
}
.hero-ctas {
  display:flex; gap:16px; align-items:center; margin-top:52px;
  opacity:0; animation:fadeUp .8s 1.1s forwards;
}
.btn-primary {
  display:inline-flex; align-items:center; gap:10px;
  background:var(--moonstone); color:var(--midnight-3);
  padding:14px 36px; text-decoration:none;
  font-size:10px; font-weight:500; letter-spacing:3px; text-transform:uppercase;
  border-radius:1px; transition:opacity .3s, transform .3s;
}
.btn-primary:hover { opacity:.85; transform:translateY(-2px); }
.btn-ghost {
  display:inline-flex; align-items:center; gap:10px;
  color:var(--fog); padding:14px 36px; text-decoration:none;
  font-size:10px; letter-spacing:3px; text-transform:uppercase;
  border:1px solid rgba(178,213,226,0.25); border-radius:1px;
  transition:border-color .3s, color .3s;
}
.btn-ghost:hover { border-color:var(--moonstone); color:var(--moonstone-2); }
.hero-scroll {
  position:absolute; bottom:36px; left:50%; transform:translateX(-50%);
  z-index:3; display:flex; flex-direction:column; align-items:center; gap:10px;
  opacity:0; animation:fadeUp .8s 1.4s forwards;
}
.hero-scroll span { font-size:9px; letter-spacing:3px; text-transform:uppercase; color:var(--moonstone); }
.scroll-line {
  width:1px; height:48px;
  background:linear-gradient(to bottom, var(--moonstone), transparent);
  animation:scrollPulse 2.2s ease-in-out infinite;
}
@keyframes scrollPulse { 0%,100%{transform:scaleY(1);opacity:1;} 50%{transform:scaleY(.6);opacity:.4;} }
@keyframes fadeUp { from{opacity:0;transform:translateY(28px);} to{opacity:1;transform:translateY(0);} }

/* ── BOOKING ── */
.booking-section {
  position:relative; z-index:5; padding:0 5%; margin-top:-1px;
  background:var(--midnight-3);
}
.booking-wrap { max-width:1160px; margin:0 auto; transform:translateY(-48px); }
.booking-label {
  font-size:9px; letter-spacing:4px; text-transform:uppercase;
  color:var(--moonstone); margin-bottom:16px; padding-left:4px;
}
.booking-form {
  display:flex; gap:0; align-items:stretch;
  border:1px solid var(--moon-line);
  background:rgba(0,40,60,0.96); backdrop-filter:blur(20px); overflow:hidden;
}
.form-field {
  flex:1; display:flex; flex-direction:column;
  padding:24px 28px; gap:8px;
  border-right:1px solid var(--moon-line);
  transition:background .3s;
}
.form-field:hover { background:rgba(68,166,181,0.06); }
.form-field:last-child { border-right:none; }
.form-field label {
  font-size:9px; letter-spacing:2.5px; text-transform:uppercase;
  color:var(--moonstone); font-weight:500;
  display:flex; align-items:center; gap:8px;
}
.form-field input, .form-field select {
  background:transparent; border:none; outline:none;
  color:var(--white); font-size:14px; font-family:'Jost', sans-serif; font-weight:300;
}
.form-field input::placeholder { color:var(--fog-low); }
.form-field select { color:var(--fog); cursor:pointer; }
.form-field select option { background:#003040; color:var(--white); }
.form-field input[type="number"] { -moz-appearance:textfield; }
.form-field input[type="number"]::-webkit-inner-spin-button,
.form-field input[type="number"]::-webkit-outer-spin-button { -webkit-appearance:none; }
input[type="date"]::-webkit-calendar-picker-indicator { filter:invert(.5) sepia(1) saturate(3) hue-rotate(170deg); cursor:pointer; }
.book-submit {
  padding:0 40px; background:var(--moonstone); border:none;
  color:var(--midnight-3); font-family:'Jost', sans-serif;
  font-size:10px; font-weight:500; letter-spacing:3px; text-transform:uppercase;
  cursor:pointer; transition:opacity .3s, transform .2s; white-space:nowrap;
}
.book-submit:hover { opacity:.85; transform:translateY(-1px); }

/* ── SECTION COMMONS ── */
.section-eyebrow {
  display:flex; align-items:center; gap:14px; margin-bottom:28px;
}
.section-eyebrow .dot { width:4px; height:4px; background:var(--moonstone); border-radius:50%; }
.section-eyebrow span {
  font-size:9px; letter-spacing:4px; text-transform:uppercase; color:var(--moonstone); font-weight:500;
}
.section-eyebrow .rule { flex:1; height:1px; background:var(--moon-line); }
h2.display {
  font-family:'Playfair Display', serif;
  font-size:clamp(38px, 5vw, 60px); font-weight:300; line-height:1.1;
  color:var(--white); margin-bottom:32px;
}
h2.display em { font-style:italic; color:var(--moonstone-2); }
.body-text {
  font-size:15px; line-height:1.95; color:var(--fog-low); font-weight:300; margin-bottom:24px;
}
.gold-divider {
  display:flex; align-items:center; gap:16px; margin:36px 0;
}
.gold-divider .line { width:40px; height:1px; background:var(--moonstone); }
.gold-divider .diamond {
  width:7px; height:7px; background:transparent;
  border:1px solid var(--moonstone); transform:rotate(45deg);
}

/* ── ABOUT ── */
.about {
  padding:140px 8%; background:var(--midnight-3);
  display:grid; grid-template-columns:1fr 1fr; gap:100px;
  align-items:center; max-width:1400px; margin:0 auto;
}
.about-stats {
  display:grid; grid-template-columns:1fr 1fr; gap:1px;
  border:1px solid var(--moon-line); margin-top:48px;
}
.stat-cell {
  padding:28px 28px;
  border-right:1px solid var(--moon-line);
  border-bottom:1px solid var(--moon-line);
  background:rgba(0,69,84,0.25);
}
.stat-cell:nth-child(2n) { border-right:none; }
.stat-cell:nth-child(3), .stat-cell:nth-child(4) { border-bottom:none; }
.stat-num {
  font-family:'Playfair Display', serif;
  font-size:42px; font-weight:300; color:var(--moonstone); line-height:1;
}
.stat-label { font-size:10px; letter-spacing:2px; color:var(--fog-low); text-transform:uppercase; margin-top:6px; }
.about-images-side { position:relative; height:600px; }
.about-img-main {
  position:absolute; top:0; right:0; width:80%; height:480px;
  object-fit:cover; display:block; border:1px solid var(--moon-line);
}
.about-img-accent {
  position:absolute; bottom:0; left:0; width:52%; height:300px;
  object-fit:cover; display:block;
  border:8px solid var(--midnight-3); outline:1px solid var(--moon-line);
  box-shadow:0 30px 70px rgba(0,0,0,.5);
}
.about-teal-bar {
  position:absolute; top:60px; left:-18px;
  width:3px; height:180px; background:var(--moonstone);
}

/* ── PARALLAX ── */
.parallax-banner {
  height:72vh; position:relative; overflow:hidden;
  display:flex; align-items:center; justify-content:center;
}
.parallax-bg {
  position:absolute; inset:-20%;
background-image: url('wave2.png');
background-size:cover; background-position:center;
}

.parallax-content { position:relative; z-index:2; text-align:center; padding:0 40px; }
.parallax-content .quote-mark {
  font-family:'Playfair Display', serif;
  font-size:120px; line-height:.6; color:var(--moonstone); opacity:.2;
  display:block; margin-bottom:20px;
}
.parallax-content blockquote {
  font-family:'Playfair Display', serif;
  font-size:clamp(24px, 4vw, 46px); font-weight:300; font-style:italic;
  color:var(--white); max-width:780px; line-height:1.4; margin-bottom:28px;
}
.parallax-content cite {
  font-size:10px; letter-spacing:3px; text-transform:uppercase; color:var(--moonstone-2); font-style:normal;
}

/* ── ROOMS ── */
.rooms-section { padding:120px 5%; background:var(--midnight-2); }
.rooms-header {
  display:grid; grid-template-columns:1fr 1fr; gap:40px;
  align-items:end; max-width:1300px; margin:0 auto 72px;
}
.rooms-header-action { text-align:right; }
.rooms-header-action .body-text { text-align:right; margin-bottom:24px; }
.rooms-grid {
  max-width:1300px; margin:0 auto;
  display:grid; grid-template-columns:1.35fr 1fr 1fr;
  gap:2px;
}
.room-card { position:relative; overflow:hidden; cursor:pointer; }
.room-card.large { grid-row:1/3; }
.room-card img {
  width:100%; display:block; object-fit:cover;
  transition:transform .8s cubic-bezier(.25,.46,.45,.94);
  
}
.room-card.large img { height:700px; }
.room-card:not(.large) img { height:700px; }
.room-card:hover img { transform:scale(1.08); filter:brightness(.45) saturate(1); }
.room-overlay {
  position:absolute; inset:0;
  background:linear-gradient(to top, rgba(0,37,53,.97) 0%, transparent 55%);
}
.room-badge {
  position:absolute; top:24px; left:24px;
  padding:6px 14px; border:1px solid var(--moon-line);
  background:rgba(0,37,53,.5); backdrop-filter:blur(10px);
  font-size:9px; letter-spacing:2px; text-transform:uppercase; color:var(--moonstone-2);
}
.room-info { position:absolute; bottom:28px; left:28px; right:28px; }
.room-info h3 {
  font-family:'Playfair Display', serif;
  font-size:28px; font-weight:300; color:var(--white);
  margin-bottom:8px; transition:color .3s;
}
.room-card:hover .room-info h3 { color:var(--lightblue); }
.room-info .price { font-size:13px; color:var(--moonstone-2); letter-spacing:1px; margin-bottom:14px; }
.room-info .price span { font-size:10px; color:var(--fog-low); }
.room-amenities {
  display:flex; flex-wrap:wrap; gap:8px; opacity:0;
  transform:translateY(10px); transition:opacity .4s, transform .4s;
}
.room-card:hover .room-amenities { opacity:1; transform:translateY(0); }
.amenity-tag {
  padding:5px 12px; border:1px solid var(--moon-line);
  font-size:10px; color:var(--fog-low); border-radius:20px;
  background:rgba(68,166,181,0.07);
}
.room-arrow {
  position:absolute; top:24px; right:24px;
  width:40px; height:40px; border-radius:50%;
  background:var(--moonstone); color:var(--midnight-3);
  display:flex; align-items:center; justify-content:center; font-size:14px;
  transform:scale(0); transition:transform .3s cubic-bezier(.34,1.56,.64,1);
}
.room-card:hover .room-arrow { transform:scale(1); }

/* ── SERVICES ── */
.services-section { padding:120px 5%; background:var(--midnight-3); }
.services-inner { max-width:1300px; margin:0 auto; }
.services-top {
  display:flex; justify-content:space-between; align-items:flex-end; margin-bottom:72px;
}
.services-grid { display:grid; grid-template-columns:repeat(3, 1fr); gap:2px; }
.svc-card { position:relative; height:480px; overflow:hidden; cursor:pointer; }
.svc-card img {
  width:100%; height:100%; object-fit:cover; display:block;
  transition:transform .7s cubic-bezier(.25,.46,.45,.94);
}
.svc-card:hover img { transform:scale(1.07); filter:brightness(.3) saturate(1); }
.svc-overlay {
  position:absolute; inset:0;
  background:linear-gradient(to top, rgba(0,37,53,.95) 0%, rgba(0,69,84,.1) 60%);
}
.svc-inner-border {
  position:absolute; inset:16px;
  border:1px solid rgba(68,166,181,.15); pointer-events:none; transition:border-color .4s;
}
.svc-card:hover .svc-inner-border { border-color:rgba(68,166,181,.45); }
.svc-num {
  position:absolute; top:32px; left:32px;
  font-family:'Playfair Display', serif; font-size:72px; font-weight:300; line-height:1;
  color:rgba(68,166,181,.1); transition:color .4s;
}
.svc-card:hover .svc-num { color:rgba(68,166,181,.22); }
.svc-content { position:absolute; bottom:36px; left:32px; right:32px; }
.svc-icon {
  width:42px; height:42px; border:1px solid var(--moon-line);
  display:flex; align-items:center; justify-content:center;
  color:var(--moonstone); font-size:16px; margin-bottom:20px; transition:background .3s;
}
.svc-card:hover .svc-icon { background:var(--moonstone); color:var(--midnight-3); }
.svc-content h3 {
  font-family:'Playfair Display', serif;
  font-size:30px; font-weight:300; color:var(--white); margin-bottom:8px;
}
.svc-content p { font-size:11px; letter-spacing:2px; text-transform:uppercase; color:var(--moonstone-2); }

/* ── GALLERY ── */
.gallery-section { padding:120px 5%; background:var(--midnight-2); }
.gallery-inner { max-width:1300px; margin:0 auto; }
.gallery-header { text-align:center; margin-bottom:64px; }
.gallery-header .section-eyebrow { justify-content:center; }
.gallery-grid {
  display:grid; grid-template-columns:repeat(12, 1fr);
  grid-template-rows:260px 260px; gap:3px;
}
.g-item { overflow:hidden; position:relative; }
.g-item img {
  width:100%; height:100%; object-fit:cover; display:block;
  transition:transform .6s cubic-bezier(.25,.46,.45,.94), filter .6s;
  filter:brightness(.7) saturate(.85);
}
.g-item:hover img { transform:scale(1.07); filter:brightness(.9) saturate(1.15); }
.g-1 { grid-column:1/5; grid-row:1/3; }
.g-2 { grid-column:5/8; grid-row:1/2; }
.g-3 { grid-column:8/13; grid-row:1/2; }
.g-4 { grid-column:5/9; grid-row:2/3; }
.g-5 { grid-column:9/13; grid-row:2/3; }


/* ======================= */
/* CONTACT MAP */
/* ======================= */

.contact-map-section{
    width:92%;
    height:520px;

    margin:120px auto;

    position:relative;

    border-radius:24px;
    overflow:hidden;

    border:1px solid var(--moon-line);

    background:var(--midnight-2);
}

/* MAP */

.map-side{
    width:100%;
    height:100%;
}

.map-side iframe{
    width:100%;
    height:100%;
    border:none;

}

/* CONTACT CARD */

.contact-card{
    position:absolute;

    top:50%;
    left:70px;

    transform:translateY(-50%);

    width:390px;

    padding:42px;

    background:rgba(0,37,53,.95);

    border:1px solid rgba(255,255,255,.06);

    box-shadow:0 20px 50px rgba(0,0,0,.35);

    z-index:5;
}

/* MINI */

.mini-title{
    color:var(--moonstone);
    font-size:11px;
    letter-spacing:3px;
    text-transform:uppercase;

    display:block;
    margin-bottom:18px;
}

/* TITLE */

.contact-card h2{
    font-size:42px;
    line-height:1.1;

    color:var(--white);

    font-family:'Playfair Display',serif;
    font-weight:400;

    margin-bottom:18px;
}

/* DESC */

.desc{
    color:var(--fog);
    line-height:1.8;
    margin-bottom:34px;
}

/* GRID */

.contact-grid{
    display:grid;
    grid-template-columns:1fr 1fr;
    gap:24px;
}

/* ITEM */

.item span{
    display:block;

    color:var(--lightblue);

    font-size:11px;
    letter-spacing:2px;
    text-transform:uppercase;

    margin-bottom:8px;
}

.item p{
    color:var(--white);
    line-height:1.7;
    font-size:14px;
}

/* BUTTON */

.direction-btn{
    margin-top:34px;

    display:inline-flex;
    align-items:center;
    justify-content:center;

    height:48px;
    padding:0 24px;

    background:transparent;

    border:1px solid var(--moonstone);

    color:var(--white);

    text-decoration:none;

    font-size:11px;
    letter-spacing:2px;
    text-transform:uppercase;

    transition:.4s;
}

.direction-btn:hover{
    background:var(--moonstone);
    color:white;
}

/* RESPONSIVE */

@media(max-width:900px){

.contact-map-section{
    height:auto;
}

.contact-card{
    position:relative;

    top:auto;
    left:auto;

    transform:none;

    width:100%;
}

.map-side{
    height:400px;
}

}

@media(max-width:600px){

.contact-card{
    padding:30px;
}

.contact-card h2{
    font-size:32px;
}

.contact-grid{
    grid-template-columns:1fr;
}

}





/* ── TESTIMONIAL ── */
.testimonial-section { padding:120px 5%; background:var(--midnight-3); }
.testimonial-inner { max-width:900px; margin:0 auto; text-align:center; }
.stars { color:var(--moonstone); font-size:14px; letter-spacing:6px; margin-bottom:36px; display:block; }
.testimonial-text {
  font-family:'Playfair Display', serif;
  font-size:clamp(22px, 3.5vw, 36px); font-weight:300; font-style:italic;
  color:var(--white); line-height:1.6; margin-bottom:40px;
}
.testimonial-author { display:flex; align-items:center; gap:20px; justify-content:center; }
.author-avatar { width:52px; height:52px; border-radius:50%; object-fit:cover; border:2px solid var(--moon-line); }
.author-info .name { font-size:13px; font-weight:500; color:var(--white); letter-spacing:1px; }
.author-info .origin { font-size:10px; letter-spacing:2px; text-transform:uppercase; color:var(--moonstone); margin-top:3px; }

/* ── FOOTER ── */
footer {
  background:var(--midnight);
  border-top:1px solid var(--moon-line);
  padding:96px 8% 36px;
}
.footer-top {
  display:grid; grid-template-columns:1.8fr 1fr 1fr 1fr;
  gap:64px; margin-bottom:72px;
}
.footer-brand .logo-main { font-size:28px; display:block; margin-bottom:10px; }
.footer-brand .logo-sub { text-align:left; font-size:12px; display:block; margin-bottom:24px; }
.footer-brand p { font-size:14px; line-height:1.85; color:var(--fog-low); max-width:280px; font-weight:300; }
.footer-socials { display:flex; gap:12px; margin-top:28px; }
.social-btn {
  width:38px; height:38px; border:1px solid var(--moon-line);
  display:flex; align-items:center; justify-content:center;
  color:var(--fog-low); font-size:14px; text-decoration:none;
  transition:border-color .3s, color .3s, background .3s;
}
.social-btn:hover { border-color:var(--moonstone); color:var(--moonstone); background:var(--moon-dim); }
.footer-col h4 {
  font-size:9px; letter-spacing:3px; text-transform:uppercase;
  color:var(--moonstone); font-weight:500; margin-bottom:24px;
  padding-bottom:12px; border-bottom:1px solid var(--moon-line);
}
.footer-col ul { list-style:none; display:flex; flex-direction:column; gap:12px; }
.footer-col ul li a {
  color:var(--fog-low); text-decoration:none; font-size:14px;
  font-weight:300; transition:color .3s, padding-left .3s; display:block;
}
.footer-col ul li a:hover { color:var(--moonstone-2); padding-left:6px; }
.footer-bottom {
  border-top:1px solid var(--fog-ghost); padding-top:24px;
  display:flex; justify-content:space-between; align-items:center;
  font-size:11px; color:rgba(178,213,226,.2); letter-spacing:.5px;
}

/* ── RESPONSIVE ── */
@media (max-width:1100px) {
  .about { grid-template-columns:1fr; gap:60px; }
  .about-images-side { height:400px; }
  .rooms-grid { grid-template-columns:1fr 1fr; }
  .room-card.large { grid-row:auto; }
  .room-card.large img, .room-card:not(.large) img { height:380px; }
  .rooms-header { grid-template-columns:1fr; }
  .rooms-header-action { text-align:left; }
  .footer-top { grid-template-columns:1fr 1fr; }
  .services-grid { grid-template-columns:1fr; }
}
@media (max-width:768px) {
  header { padding:0 24px; }
  nav { display:none; }
  .hero h1 { font-size:46px; }
  .booking-form { flex-direction:column; }
  .form-field { border-right:none; border-bottom:1px solid var(--moon-line); }
  .book-submit { padding:20px; }
  .rooms-grid { grid-template-columns:1fr; }
  .gallery-grid { grid-template-columns:1fr 1fr; grid-template-rows:auto; }
  .g-1,.g-2,.g-3,.g-4,.g-5 { grid-column:auto; grid-row:auto; height:220px; }
  .footer-top { grid-template-columns:1fr; gap:36px; }
  .footer-bottom { flex-direction:column; gap:8px; text-align:center; }
  .cursor-dot, .cursor-ring { display:none; }
  body { cursor:auto; }
  .hero-side-lines { margin:0 20px; }
}
</style>
</head>
<body>

<div class="cursor-dot" id="cursorDot"></div>
<div class="cursor-ring" id="cursorRing"></div>

<!-- ── HEADER ── -->
<header id="mainHeader">
  <div class="logo">
    <span class="logo-main">Blue Wave</span>
    <span class="logo-sub">Hôtel &amp; Spa</span>
  </div>
  <nav>
    <ul>
      <li><a href="index.jsp" class="active">Accueil</a></li>
      <li><a href="#about">À Propos</a></li>
      <li><a href="rooms">Chambres</a></li>
      <li><a href="#services">Services</a></li>
      <li><a href="#gallery">Galerie</a></li>
      <li><a href="#contact">Contact</a></li>
      <%@ page import="model.User" %>
      <% User _u = (User) session.getAttribute("loggedUser"); %>
      <% if (_u != null && "CLIENT".equals(_u.getRole())) { %>
        <li><a href="client/dashboard" class="nav-cta">Mon Espace</a></li>
        <li><a href="logout">Déconnexion</a></li>
      <% } else if (_u != null && "ADMIN".equals(_u.getRole())) { %>
        <li><a href="admin/reservations" class="nav-cta">Admin</a></li>
        <li><a href="logout">Déconnexion</a></li>
      <% } else { %>
        <li><a href="login" class="nav-cta">Connexion</a></li>
        <li><a href="register" style="color:var(--moonstone);font-size:10px;letter-spacing:2px;">Inscription</a></li>
      <% } %>
    </ul>
  </nav>
</header>

<!-- ── HERO ── -->
<section class="hero" id="hero">
  <div class="hero-bg"></div>
  <div class="hero-vignette"></div>
  <div class="hero-side-lines"></div>
  <div class="hero-content">
    <div class="hero-eyebrow">
      <div class="rule"></div>
      <span>Welcome to Blue Wave</span>
      <div class="rule"></div>
    </div>
    <h1>Luxe &amp; <em>Sérénité</em><br>Au bord de l'Océan</h1>
    <p class="hero-tagline">5 étoiles · Rabat, Maroc · Vue sur l'Atlantique</p>
    <div class="hero-ctas">
      <a href="#booking" class="btn-primary">
        <i class="fa-regular fa-calendar-check"></i>
        Réserver Maintenant
      </a>
      <a href="#about" class="btn-ghost">
        <i class="fa-regular fa-compass"></i>
        Découvrir
      </a>
    </div>
  </div>
  <div class="hero-scroll">
    <span>Défiler</span>
    <div class="scroll-line"></div>
  </div>
  <!-- Wave SVG transition -->
  <div class="hero-wave-overlay">
    <svg viewBox="0 0 1440 120" preserveAspectRatio="none" xmlns="http://www.w3.org/2000/svg">
      <path d="M0,60 C240,110 480,10 720,60 C960,110 1200,10 1440,60 L1440,120 L0,120 Z" fill="#002535"/>
    </svg>
  </div>
</section>

<!-- ── BOOKING ── -->
<section class="booking-section" id="booking">
  <div class="booking-wrap">
    <p class="booking-label">◈ &nbsp;Vérifier les disponibilités</p>
    <form action="rooms" method="get">
      <div class="booking-form">
        <div class="form-field">
          <label><i class="fa-regular fa-calendar-check"></i>Check-in</label>
          <input type="date" name="checkin" id="dateArrivee" required>
        </div>
        <div class="form-field">
          <label><i class="fa-regular fa-calendar-xmark"></i>Check-out</label>
          <input type="date" name="checkout" id="dateDepart" required>
        </div>
        <div class="form-field">
          <label><i class="fa-regular fa-user"></i>Voyageurs</label>
          <input type="number" name="guests" id="nbPersonnes" value="2" min="1" max="10" placeholder="2">
        </div>
        <div class="form-field" style="flex:0.6;">
          <label><i class="fa-solid fa-bed"></i>Type</label>
          <select>
            <option value="">Toutes</option>
            <option value="standard">Standard</option>
            <option value="deluxe">Deluxe</option>
            <option value="suite">Suite</option>
          </select>
        </div>
        <button type="submit" class="book-submit">Rechercher</button>
      </div>
    </form>
  </div>
</section>

<!-- ── ABOUT ── -->
<section class="about" id="about">
  <div class="about-text-side">
    <div class="section-eyebrow">
      <div class="dot"></div>
      <span>Notre Histoire</span>
      <div class="rule"></div>
    </div>
    <h2 class="display">Un refuge<br><em>d'exception</em><br>face à l'Atlantique</h2>
    <p class="body-text">
      Niché sur les rives dorées de Rabat, Blue Wave incarne l'art de vivre marocain
      sublimé par une architecture contemporaine. Chaque détail, chaque matière, chaque lumière
      a été pensé pour vous offrir une expérience sensorielle unique.
    </p>
    <p class="body-text">
      De nos suites avec vue panoramique à notre spa primé, du restaurant gastronomique
      à la piscine à débordement, tout conspire à votre bonheur absolu.
    </p>
    <div class="gold-divider">
      <div class="line"></div>
      <div class="diamond"></div>
      <div class="line"></div>
    </div>
    <div class="about-stats">
      <div class="stat-cell"><div class="stat-num">47</div><div class="stat-label">Suites &amp; Chambres</div></div>
      <div class="stat-cell"><div class="stat-num">12</div><div class="stat-label">Années d'excellence</div></div>
      <div class="stat-cell"><div class="stat-num">98%</div><div class="stat-label">Satisfaction client</div></div>
      <div class="stat-cell"><div class="stat-num">5★</div><div class="stat-label">Classement officiel</div></div>
    </div>
  </div>
  <div class="about-images-side">
    <div class="about-teal-bar"></div>
    <img class="about-img-main"
      src="https://i.pinimg.com/736x/a6/21/b3/a621b3d1aad500c13e859dcfd9941bff.jpg"
      alt="Blue Wave Hotel">
    <img class="about-img-accent"
      src="https://i.pinimg.com/1200x/db/45/3e/db453e8ddb497dc419881223dc3db36b.jpg"
      alt="Suite Blue Wave">
  </div>
</section>

<!-- ── PARALLAX QUOTE ── -->
<section class="parallax-banner">
  <div class="parallax-bg"></div>
  <div class="parallax-tint"></div>
  <div class="parallax-content">
    <span class="quote-mark">"</span>
    <blockquote>Le luxe véritable ne crie pas.<br>Il chuchote.</blockquote>
    <cite>Blue Wave · Philosophie Hôtelière</cite>
  </div>
</section>

<!-- ── ROOMS ── -->
<section class="rooms-section" id="rooms">
  <div class="rooms-header">
    <div class="rooms-header-text">
      <div class="section-eyebrow">
        <div class="dot"></div>
        <span>Sélection Exclusive</span>
        <div class="rule"></div>
      </div>
      <h2 class="display">Chambres<br>&amp; <em>Suites</em></h2>
    </div>
    <div class="rooms-header-action">
      <p class="body-text">Chaque espace a été conçu comme un sanctuaire personnel, alliant confort absolu et esthétique raffinée.</p>
      <a href="rooms" class="btn-ghost">
        Voir toutes les chambres &nbsp;<i class="fa-solid fa-arrow-right"></i>
      </a>
    </div>
  </div>
  <div class="rooms-grid">
    <div class="room-card large">
      <img src="https://i.pinimg.com/1200x/b0/50/4d/b0504deaf6760a45ac00b075424d229c.jpg" alt="Suite Panorama">
      <div class="room-overlay"></div>
      <div class="room-badge">Suite Signature</div>
      <div class="room-arrow"><i class="fa-solid fa-arrow-right"></i></div>
      <div class="room-info">
        <h3>Superior Panorama Suite</h3>
        <div class="price">À partir de 3 200 MAD <span>/ nuit</span></div>
        <div class="room-amenities">
          <span class="amenity-tag">Vue Océan</span>
          <span class="amenity-tag">Terrasse Privée</span>
          <span class="amenity-tag">80 m²</span>
          <span class="amenity-tag">Jacuzzi</span>
        </div>
      </div>
    </div>
    <div class="room-card">
      <img src="https://i.pinimg.com/1200x/44/39/af/4439af08dded186847e2788f6443afa3.jpg" alt="Garden Suite">
      <div class="room-overlay"></div>
      <div class="room-badge">Familiale</div>
      <div class="room-arrow"><i class="fa-solid fa-arrow-right"></i></div>
      <div class="room-info">
        <h3>Garden Family Room</h3>
        <div class="price">À partir de 1 800 MAD <span>/ nuit</span></div>
        <div class="room-amenities">
          <span class="amenity-tag">Vue Jardin</span>
          <span class="amenity-tag">Accès Piscine</span>
          <span class="amenity-tag">55 m²</span>
        </div>
      </div>
    </div>
    <div class="room-card">
      <img src="https://i.pinimg.com/1200x/13/4c/7e/134c7eb754a958ff08df6e1b540cf699.jpg" alt="Deluxe Room">
      <div class="room-overlay"></div>
      <div class="room-badge">Deluxe</div>
      <div class="room-arrow"><i class="fa-solid fa-arrow-right"></i></div>
      <div class="room-info">
        <h3>Deluxe Ocean View</h3>
        <div class="price">À partir de 2 400 MAD <span>/ nuit</span></div>
        <div class="room-amenities">
          <span class="amenity-tag">Balcon</span>
          <span class="amenity-tag">42 m²</span>
          <span class="amenity-tag">Bain Balnéo</span>
        </div>
      </div>
    </div>
  </div>
</section>

<!-- ── SERVICES ── -->
<section class="services-section" id="services">
  <div class="services-inner">
    <div class="services-top">
      <div>
        <div class="section-eyebrow">
          <div class="dot"></div>
          <span>Expériences Exclusives</span>
        </div>
        <h2 class="display">Services<br><em>Premium</em></h2>
      </div>
      <p class="body-text" style="max-width:360px; text-align:right;">
        Chaque prestation est pensée pour transcender vos attentes et graver ce séjour dans votre mémoire.
      </p>
    </div>
    <div class="services-grid">
      <div class="svc-card">
        <img src="https://i.pinimg.com/1200x/b6/f6/3b/b6f63bfc8b8bc72f2e4509091bdaec43.jpg" alt="Spa">
        <div class="svc-overlay"></div><div class="svc-inner-border"></div>
        <div class="svc-num">01</div>
        <div class="svc-content">
          <div class="svc-icon"><i class="fa-solid fa-spa"></i></div>
          <h3>Spa &amp; Wellness</h3>
          <p>Détente &amp; Sérénité</p>
        </div>
      </div>
      <div class="svc-card">
        <img src="https://i.pinimg.com/736x/b6/69/ec/b669eca9524f7bc97b19f50e2c9d0058.jpg" alt="Pool">
        <div class="svc-overlay"></div><div class="svc-inner-border"></div>
        <div class="svc-num">02</div>
        <div class="svc-content">
          <div class="svc-icon"><i class="fa-solid fa-water"></i></div>
          <h3>Piscine Infinity</h3>
          <p>Plaisir &amp; Fraîcheur</p>
        </div>
      </div>
      <div class="svc-card">
        <img src="https://i.pinimg.com/736x/e6/b3/86/e6b38639a058073f3609984c99faeefb.jpg" alt="Restaurant">
        <div class="svc-overlay"></div><div class="svc-inner-border"></div>
        <div class="svc-num">03</div>
        <div class="svc-content">
          <div class="svc-icon"><i class="fa-solid fa-utensils"></i></div>
          <h3>Restaurant Gastronomique</h3>
          <p>Saveurs &amp; Excellence</p>
        </div>
      </div>
    </div>
  </div>
</section>


<section class="contact-map-section">

    <!-- MAP -->

    <div class="map-side">

        <iframe
        src="https://www.google.com/maps?q=Newcastle+upon+Tyne&output=embed"
        loading="lazy">
        </iframe>

    </div>

    <!-- CONTACT CARD -->

    <div class="contact-card">

        <span class="mini-title">
            WHERE TO FIND US
        </span>

        <h2>
            Blue Wave Hôtel
        </h2>

        <p class="desc">
            Découvrez notre hôtel de luxe situé au cœur
            d’un environnement raffiné et exclusif.
        </p>

        <div class="contact-grid">

            <div class="item">
                <span>Adresse</span>
                <p>
                    Avenue Mohammed VI<br>
                    Marrakech 40000
                </p>
            </div>

            <div class="item">
                <span>Téléphone</span>
                <p>
                    +212 6 12 34 56 78
                </p>
            </div>

            <div class="item">
                <span>Email</span>
                <p>
                    contact@bluewave.ma
                </p>
            </div>

            <div class="item">
                <span>Réception</span>
                <p>
                    Ouvert 24h / 24
                </p>
            </div>

        </div>

        <a href="#" class="direction-btn">
            Voir l'adresse
        </a>

    </div>

</section>


<!-- ── TESTIMONIAL ── -->
<section class="testimonial-section">
  <div class="testimonial-inner">
    <div class="section-eyebrow" style="justify-content:center; margin-bottom:12px;">
      <div class="dot"></div>
      <span>Témoignages</span>
    </div>
    <span class="stars">★ ★ ★ ★ ★</span>
    <blockquote class="testimonial-text">
      "Un séjour absolument inoubliable. L'attention portée aux détails,
      la vue sur l'océan, le service d'une discrétion parfaite —
      Blue Wave redéfinit l'excellence hôtelière au Maroc."
    </blockquote>
    <div class="testimonial-author">
      <img class="author-avatar"
        src="https://images.unsplash.com/photo-1580489944761-15a19d654956?q=80&w=200&auto=format&fit=crop"
        alt="Sophie Laurent">
      <div class="author-info">
        <div class="name">Sophie Laurent</div>
        <div class="origin">Paris, France</div>
      </div>
    </div>
  </div>
</section>

<!-- ── FOOTER ── -->
<footer id="contact">
  <div class="footer-top">
    <div class="footer-brand">
      <span class="logo-main">Blue Wave</span>
      <span class="logo-sub">Hôtel &amp; Spa · Rabat</span>
      <p>Un hôtel 5 étoiles d'exception sur les rives de l'Atlantique, pour des séjours inoubliables en famille, en couple ou en affaires.</p>
      <div class="footer-socials">
        <a href="#" class="social-btn"><i class="fab fa-instagram"></i></a>
        <a href="#" class="social-btn"><i class="fab fa-facebook-f"></i></a>
        <a href="#" class="social-btn"><i class="fab fa-tripadvisor"></i></a>
        <a href="#" class="social-btn"><i class="fab fa-whatsapp"></i></a>
      </div>
    </div>
    <div class="footer-col">
      <h4>Navigation</h4>
      <ul>
        <li><a href="index.jsp">Accueil</a></li>
        <li><a href="rooms">Chambres &amp; Suites</a></li>
        <li><a href="#services">Restaurant</a></li>
        <li><a href="#services">Spa</a></li>
        <li><a href="#gallery">Galerie</a></li>
      </ul>
    </div>
    <div class="footer-col">
      <h4>Services</h4>
      <ul>
        <li><a href="#">Transfert aéroport</a></li>
        <li><a href="#">Location de voiture</a></li>
        <li><a href="#">Excursions privées</a></li>
        <li><a href="#">Événements &amp; Mariages</a></li>
        <li><a href="#">Séminaires</a></li>
      </ul>
    </div>
    <div class="footer-col">
      <h4>Contact</h4>
      <ul>
        <li><a href="#">📍 Rabat, Maroc</a></li>
        <li><a href="#">📞 +212 537 XX XX XX</a></li>
        <li><a href="#">✉️ contact@bluewave.ma</a></li>
        <li><a href="my-reservations">Mes réservations</a></li>
        <li><a href="#">Aide &amp; FAQ</a></li>
      </ul>
    </div>
  </div>
  <div class="footer-bottom">
    <p>© 2026 Blue Wave Hôtel. Tous droits réservés.</p>
    <p>Politique de confidentialité · Conditions générales</p>
  </div>
</footer>

<script>
/* ── DATES ── */
const today = new Date().toISOString().split('T')[0];
const arrInput = document.getElementById('dateArrivee');
const depInput = document.getElementById('dateDepart');
arrInput.min = today; depInput.min = today;
arrInput.addEventListener('change', function() {
  depInput.min = this.value;
  if (depInput.value && depInput.value <= this.value) {
    const next = new Date(this.value);
    next.setDate(next.getDate() + 1);
    depInput.value = next.toISOString().split('T')[0];
  }
});

/* ── HEADER SCROLL ── */
const header = document.getElementById('mainHeader');
window.addEventListener('scroll', () => {
  header.classList.toggle('scrolled', window.scrollY > 80);
}, { passive:true });

/* ── CURSOR ── */
const dot = document.getElementById('cursorDot');
const ring = document.getElementById('cursorRing');
let mx=0, my=0, rx=0, ry=0;
document.addEventListener('mousemove', e => { mx=e.clientX; my=e.clientY; });
(function animateCursor() {
  dot.style.left = mx+'px'; dot.style.top = my+'px';
  rx += (mx-rx)*.14; ry += (my-ry)*.14;
  ring.style.left = rx+'px'; ring.style.top = ry+'px';
  requestAnimationFrame(animateCursor);
})();
document.querySelectorAll('a, button').forEach(el => {
  el.addEventListener('mouseenter', () => {
    ring.style.width='54px'; ring.style.height='54px';
    ring.style.borderColor='var(--moonstone)';
  });
  el.addEventListener('mouseleave', () => {
    ring.style.width='36px'; ring.style.height='36px';
    ring.style.borderColor='var(--moon-line)';
  });
});

/* ── SCROLL REVEAL ── */
const observer = new IntersectionObserver(entries => {
  entries.forEach(e => {
    if (e.isIntersecting) {
      e.target.style.opacity = '1';
      e.target.style.transform = 'translateY(0)';
    }
  });
}, { threshold:.12 });
document.querySelectorAll('.stat-cell, .room-card, .svc-card, .g-item, h2.display, .section-eyebrow').forEach(el => {
  el.style.opacity = '0';
  el.style.transform = 'translateY(32px)';
  el.style.transition = 'opacity .7s cubic-bezier(.25,.46,.45,.94), transform .7s cubic-bezier(.25,.46,.45,.94)';
  observer.observe(el);
});
</script>
</body>
</html>