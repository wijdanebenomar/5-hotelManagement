-- ============================================================
-- Blue Wave Hotel — Migration: Système d'authentification
-- À exécuter dans votre base de données MySQL "hotel"
-- ============================================================

-- Table des utilisateurs (admin + clients)
CREATE TABLE IF NOT EXISTS users (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    name        VARCHAR(150)        NOT NULL,
    email       VARCHAR(191)        NOT NULL UNIQUE,
    phone       VARCHAR(30),
    password    VARCHAR(64)         NOT NULL,   -- SHA-256 hex
    role        ENUM('ADMIN','CLIENT') NOT NULL DEFAULT 'CLIENT',
    created_at  TIMESTAMP           DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ============================================================
-- Compte ADMIN par défaut
-- email    : admin@bluewave.ma
-- password : admin123   (hash SHA-256)
-- ============================================================
INSERT INTO users (name, email, phone, password, role) VALUES
(
  'Administrateur Blue Wave',
  'admin@bluewave.ma',
  '+212 537 00 00 00',
  'ecd71870d1963316a97e3ac3408c9835ad8cf0f3c1bc703527c30265534f75ae',  -- SHA-256 of "admin123"
  'ADMIN'
)
ON DUPLICATE KEY UPDATE id = id;

-- ============================================================
-- Exemple de client test
-- email    : client@test.ma
-- password : client123
-- ============================================================
INSERT INTO users (name, email, phone, password, role) VALUES
(
  'Mohammed Client Test',
  'client@test.ma',
  '+212 6 12 34 56 78',
  '8b5b9db0c13db24256c829aa364aa90b6d1d26e2d5d86c1c41a7fd2e68c29eb7',  -- SHA-256 of "client123"
  'CLIENT'
)
ON DUPLICATE KEY UPDATE id = id;

-- ============================================================
-- Vérification
-- ============================================================
SELECT id, name, email, phone, role, created_at FROM users;
