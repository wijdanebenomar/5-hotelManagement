-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : sam. 30 mai 2026 à 19:28
-- Version du serveur : 10.4.32-MariaDB
-- Version de PHP : 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `hotel`
--

-- --------------------------------------------------------

--
-- Structure de la table `reservations`
--

CREATE TABLE `reservations` (
  `id` int(11) NOT NULL,
  `client_name` varchar(100) DEFAULT NULL,
  `client_email` varchar(100) DEFAULT NULL,
  `client_phone` varchar(20) DEFAULT NULL,
  `room_type_id` int(11) NOT NULL,
  `room_id` int(11) DEFAULT NULL,
  `checkin` date NOT NULL,
  `checkout` date NOT NULL,
  `status` varchar(20) DEFAULT 'PENDING',
  `total_price` double DEFAULT 0,
  `card_last4` varchar(4) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `reservations`
--

INSERT INTO `reservations` (`id`, `client_name`, `client_email`, `client_phone`, `room_type_id`, `room_id`, `checkin`, `checkout`, `status`, `total_price`, `card_last4`, `created_at`) VALUES
(1, 'wijdane army', 'wijdanebenomar17@gmail.com', '0665828726', 1, 1, '2026-05-24', '2026-05-31', 'CANCELLED', 2680, '8888', '2026-05-23 16:35:40'),
(2, 'wijdane army', 'wijdanebenomar17@gmail.com', '0665828726', 1, 1, '2026-05-24', '2026-05-31', 'PENDING', 2800, '1111', '2026-05-23 17:22:34'),
(3, 'wijdane army', 'wijdanebenomar17@gmail.com', '0665828726', 1, 1, '2026-05-24', '2026-05-26', 'CANCELLED', 1200, '5555', '2026-05-23 17:51:23'),
(4, 'wijdane army', 'wijdanebenomar17@gmail.com', '5655', 1, 1, '2026-05-24', '2026-05-26', 'CONFIRMED', 900, '2222', '2026-05-23 17:56:03'),
(5, 'wijdane benomar', 'wijdanebenomar17@gmail.com', '888888888888', 1, 1, '2026-05-24', '2026-05-26', 'PENDING', 980, '7777', '2026-05-23 17:58:10'),
(6, 'israa', 'israabenomar17@gmail.com', '0665828726', 2, 4, '2026-05-25', '2026-05-29', 'CONFIRMED', 2430, '8888', '2026-05-24 22:43:56'),
(7, 'roumaisaer', 'roumbenomar17@gmail.com', '8888888888', 2, 4, '2026-05-25', '2026-05-29', 'CONFIRMED', 2310, '9999', '2026-05-24 22:45:16'),
(8, 'jalila', 'jalala@gmail.com', '066582878', 2, 5, '2026-05-25', '2026-05-29', 'CONFIRMED', 2430, '6666', '2026-05-24 22:49:07'),
(9, 'mustapha', 'sszeez@gmail.com', '0665828726', 2, 6, '2026-05-25', '2026-05-29', 'CANCELLED', 2430, '8888', '2026-05-24 22:51:02'),
(10, 'wijdane army', 'wijdanebenomar17@gmail.com', '88888', 3, 7, '2026-05-26', '2026-05-28', 'CONFIRMED', 2480, '4555', '2026-05-25 21:42:58'),
(11, 'hiba', 'hiba@gmail.com', '069874512', 3, 7, '2026-05-26', '2026-05-28', 'CONFIRMED', 2480, '8888', '2026-05-25 21:44:37'),
(12, 'wijdane army', 'wijdanebenomar17@gmail.com', '0665828726', 1, 1, '2026-06-01', '2026-06-04', 'CONFIRMED', 1130, '2222', '2026-05-25 22:36:08'),
(13, 'khaoula', 'khaoula@gmail.com', '0689541245', 1, 2, '2026-06-01', '2026-06-04', 'CONFIRMED', 1480, '9999', '2026-05-25 22:40:49'),
(14, 'mehdi', 'mehdi@gmail.com', '0689451278', 1, 3, '2026-06-01', '2026-06-04', 'CONFIRMED', 1430, '4623', '2026-05-25 22:41:39'),
(15, 'maroine', 'maroine@gmail.com', '0665828726', 1, 1, '2026-05-30', '2026-05-31', 'CONFIRMED', 630, '8888', '2026-05-28 15:03:49'),
(16, 'Administrateur', 'admin@bluewave.ma', '+212 537 00 00 00', 3, 7, '2026-06-27', '2026-06-30', 'CONFIRMED', 4100, '5555', '2026-05-30 15:10:08');

-- --------------------------------------------------------

--
-- Structure de la table `reservation_services`
--

CREATE TABLE `reservation_services` (
  `reservation_id` int(11) NOT NULL,
  `service_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `reservation_services`
--

INSERT INTO `reservation_services` (`reservation_id`, `service_id`) VALUES
(1, 1),
(1, 2),
(2, 3),
(2, 4),
(3, 2),
(3, 3),
(3, 4),
(4, 3),
(5, 1),
(5, 3),
(6, 1),
(6, 2),
(7, 5),
(7, 6),
(8, 1),
(8, 2),
(9, 1),
(9, 2),
(10, 1),
(11, 1),
(12, 1),
(13, 1),
(13, 3),
(13, 4),
(14, 1),
(14, 2),
(14, 4),
(15, 1),
(15, 3),
(16, 3),
(16, 5),
(16, 7);

-- --------------------------------------------------------

--
-- Structure de la table `rooms`
--

CREATE TABLE `rooms` (
  `id` int(11) NOT NULL,
  `room_number` varchar(20) NOT NULL,
  `type_id` int(11) NOT NULL,
  `status` varchar(20) DEFAULT 'LIBRE'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `rooms`
--

INSERT INTO `rooms` (`id`, `room_number`, `type_id`, `status`) VALUES
(1, '101', 1, 'LIBRE'),
(2, '102', 1, 'LIBRE'),
(3, '103', 1, 'LIBRE'),
(4, '201', 2, 'OCCUPEE'),
(5, '202', 2, 'LIBRE'),
(6, '203', 2, 'LIBRE'),
(7, '301', 3, 'OCCUPEE'),
(8, '302', 3, 'LIBRE');

-- --------------------------------------------------------

--
-- Structure de la table `room_types`
--

CREATE TABLE `room_types` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `price` double NOT NULL,
  `image` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `room_types`
--

INSERT INTO `room_types` (`id`, `name`, `description`, `price`, `image`) VALUES
(1, 'Chambre Simple', 'Chambre confortable pour 1 personne, lit simple, salle de bain privÃ©e', 350, 'simple.jpg'),
(2, 'Chambre Double', 'Chambre spacieuse pour 2 personnes, grand lit, vue jardin', 550, 'double.jpg'),
(3, 'Suite Luxe', 'Suite avec salon séparé, jacuzzi et vue panoramique sur la ville', 1200, 'suite.jpg'),
(4, 'wijdane army', 'fenaa b7ali', 2900, 'https://i.pinimg.com/1200x/73/58/f8/7358f8d34f37dd9b352ef291be7cc963.jpg'),
(5, 'wijdane army', 'fenaa b7ali', 2900, 'https://i.pinimg.com/1200x/73/58/f8/7358f8d34f37dd9b352ef291be7cc963.jpg');

-- --------------------------------------------------------

--
-- Structure de la table `services`
--

CREATE TABLE `services` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `price` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `services`
--

INSERT INTO `services` (`id`, `name`, `price`) VALUES
(1, 'Petit-dÃ©jeuner', 100),
(2, 'Dîner gastronomique', 150),
(3, 'Spa & Bien-être', 200),
(4, 'Navette Aéroport', 150),
(5, 'Room Service', 50),
(6, 'Parking', 60),
(7, 'wijdane', 250);

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL,
  `email` varchar(191) NOT NULL,
  `phone` varchar(30) DEFAULT NULL,
  `password` varchar(64) NOT NULL,
  `role` enum('ADMIN','CLIENT') NOT NULL DEFAULT 'CLIENT',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `phone`, `password`, `role`, `created_at`) VALUES
(2, 'Administrateur', 'admin@bluewave.ma', '+212 537 00 00 00', 'admin123', 'ADMIN', '2026-05-29 21:28:17'),
(3, 'Client Test', 'client@test.ma', '+212 6 12 34 56 78', 'client123', 'CLIENT', '2026-05-29 21:28:17');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `reservations`
--
ALTER TABLE `reservations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `room_type_id` (`room_type_id`),
  ADD KEY `room_id` (`room_id`);

--
-- Index pour la table `reservation_services`
--
ALTER TABLE `reservation_services`
  ADD PRIMARY KEY (`reservation_id`,`service_id`),
  ADD KEY `service_id` (`service_id`);

--
-- Index pour la table `rooms`
--
ALTER TABLE `rooms`
  ADD PRIMARY KEY (`id`),
  ADD KEY `type_id` (`type_id`);

--
-- Index pour la table `room_types`
--
ALTER TABLE `room_types`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `services`
--
ALTER TABLE `services`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `reservations`
--
ALTER TABLE `reservations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT pour la table `rooms`
--
ALTER TABLE `rooms`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT pour la table `room_types`
--
ALTER TABLE `room_types`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `services`
--
ALTER TABLE `services`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT pour la table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `reservations`
--
ALTER TABLE `reservations`
  ADD CONSTRAINT `reservations_ibfk_1` FOREIGN KEY (`room_type_id`) REFERENCES `room_types` (`id`),
  ADD CONSTRAINT `reservations_ibfk_2` FOREIGN KEY (`room_id`) REFERENCES `rooms` (`id`);

--
-- Contraintes pour la table `reservation_services`
--
ALTER TABLE `reservation_services`
  ADD CONSTRAINT `reservation_services_ibfk_1` FOREIGN KEY (`reservation_id`) REFERENCES `reservations` (`id`),
  ADD CONSTRAINT `reservation_services_ibfk_2` FOREIGN KEY (`service_id`) REFERENCES `services` (`id`);

--
-- Contraintes pour la table `rooms`
--
ALTER TABLE `rooms`
  ADD CONSTRAINT `rooms_ibfk_1` FOREIGN KEY (`type_id`) REFERENCES `room_types` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
