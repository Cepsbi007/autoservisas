-- phpMyAdmin SQL Dump
-- version 5.2.1deb3
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Nov 06, 2025 at 02:13 PM
-- Server version: 8.0.41-0ubuntu0.24.04.1
-- PHP Version: 8.3.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `autoservisas`
--

-- --------------------------------------------------------

--
-- Table structure for table `duk`
--

CREATE TABLE `duk` (
  `id` int NOT NULL,
  `klausimas` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `atsakymas` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `rodyti` tinyint(1) DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `duk`
--

INSERT INTO `duk` (`id`, `klausimas`, `atsakymas`, `rodyti`) VALUES
(1, 'Kiek laiko trunka alyvos keitimas?', 'Paprastai 30–45 minutes.', 1),
(2, 'Ar galima atsiskaityti kortele?', 'Taip, priimame visas korteles.', 1),
(3, 'Ar dirbate savaitgaliais?', 'Taip, šeštadieniais 9:00–14:00.', 1),
(4, 'Koks tavo vardas', 'Auksinis kardas', 1);

-- --------------------------------------------------------

--
-- Table structure for table `meistrai_paslaugos`
--

CREATE TABLE `meistrai_paslaugos` (
  `meistras_id` int NOT NULL,
  `paslauga_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `meistrai_paslaugos`
--

INSERT INTO `meistrai_paslaugos` (`meistras_id`, `paslauga_id`) VALUES
(2, 1),
(3, 1),
(2, 2),
(5, 2),
(3, 3);

-- --------------------------------------------------------

--
-- Table structure for table `paslaugos`
--

CREATE TABLE `paslaugos` (
  `id` int NOT NULL,
  `pavadinimas` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `trukme_min` int NOT NULL DEFAULT '60',
  `kaina` decimal(6,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `paslaugos`
--

INSERT INTO `paslaugos` (`id`, `pavadinimas`, `trukme_min`, `kaina`) VALUES
(1, 'Alyvos keitimas', 45, 35.00),
(2, 'Stabdžių tikrinimas', 60, 50.00),
(3, 'Padangų montavimas', 90, 80.00);

-- --------------------------------------------------------

--
-- Table structure for table `reitingai`
--

CREATE TABLE `reitingai` (
  `id` int NOT NULL,
  `uzsakymas_id` int DEFAULT NULL,
  `ivertinimas` tinyint DEFAULT NULL,
  `komentaras` text COLLATE utf8mb4_unicode_ci,
  `sukurta` datetime DEFAULT CURRENT_TIMESTAMP
) ;

--
-- Dumping data for table `reitingai`
--

INSERT INTO `reitingai` (`id`, `uzsakymas_id`, `ivertinimas`, `komentaras`, `sukurta`) VALUES
(1, 1, 4, 'neblogai', '2025-11-05 19:08:51');

-- --------------------------------------------------------

--
-- Table structure for table `uzdarytos_valandos`
--

CREATE TABLE `uzdarytos_valandos` (
  `id` int NOT NULL,
  `meistras_id` int DEFAULT NULL,
  `data` date NOT NULL,
  `pradzios_laikas` time NOT NULL,
  `pabaigos_laikas` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `uzdarytos_valandos`
--

INSERT INTO `uzdarytos_valandos` (`id`, `meistras_id`, `data`, `pradzios_laikas`, `pabaigos_laikas`) VALUES
(2, 3, '2025-11-05', '22:30:00', '17:00:00'),
(3, 2, '2025-11-05', '10:00:00', '17:00:00'),
(4, 3, '2025-11-05', '00:00:00', '17:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `uzsakymai`
--

CREATE TABLE `uzsakymai` (
  `id` int NOT NULL,
  `klientas_id` int DEFAULT NULL,
  `meistras_id` int DEFAULT NULL,
  `paslauga_id` int DEFAULT NULL,
  `data` date NOT NULL,
  `pradzios_laikas` time NOT NULL,
  `busena` enum('patvirtintas','įvykdytas') COLLATE utf8mb4_unicode_ci DEFAULT 'patvirtintas',
  `sukurta` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `uzsakymai`
--

INSERT INTO `uzsakymai` (`id`, `klientas_id`, `meistras_id`, `paslauga_id`, `data`, `pradzios_laikas`, `busena`, `sukurta`) VALUES
(1, 1, 2, 3, '2025-11-05', '08:00:00', 'įvykdytas', '2025-11-05 17:45:12'),
(2, 1, 3, 3, '2025-11-05', '08:00:00', 'patvirtintas', '2025-11-05 17:50:03'),
(3, 1, 2, 1, '2025-11-05', '09:30:00', 'patvirtintas', '2025-11-05 18:49:36'),
(4, 1, 3, 1, '2025-11-05', '09:30:00', 'patvirtintas', '2025-11-05 18:51:04'),
(5, 5, 2, 1, '2025-11-06', '08:00:00', 'patvirtintas', '2025-11-05 19:50:50');

-- --------------------------------------------------------

--
-- Table structure for table `vartotojai`
--

CREATE TABLE `vartotojai` (
  `id` int NOT NULL,
  `vardas` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `pavarde` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `el_pastas` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slaptazodis` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tipas` enum('klientas','meistras','administratorius') COLLATE utf8mb4_unicode_ci DEFAULT 'klientas',
  `sukurta` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `vartotojai`
--

INSERT INTO `vartotojai` (`id`, `vardas`, `pavarde`, `el_pastas`, `slaptazodis`, `tipas`, `sukurta`) VALUES
(1, 'Ana', 'Anaitienė', 'ana@klientas.lt', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'klientas', '2025-11-05 16:59:14'),
(2, 'Jonas', 'Jonaitis', 'jonas@servisas.lt', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'meistras', '2025-11-05 16:59:14'),
(3, 'Petras', 'Petraitis', 'petras@servisas.lt', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'meistras', '2025-11-05 16:59:14'),
(4, 'Adminas', 'Adminaitis', 'admin@servisas.lt', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'administratorius', '2025-11-05 16:59:14'),
(5, 'Arminas', 'Arlauskas', 'arminas@klientas.lt', '$2y$10$iZRxw.FsIR..m4CykhSMTuv2.6.XwXzTF9FZSLquNGpLD/A8o5uYC', 'meistras', '2025-11-05 19:49:52');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `duk`
--
ALTER TABLE `duk`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `meistrai_paslaugos`
--
ALTER TABLE `meistrai_paslaugos`
  ADD PRIMARY KEY (`meistras_id`,`paslauga_id`),
  ADD KEY `paslauga_id` (`paslauga_id`);

--
-- Indexes for table `paslaugos`
--
ALTER TABLE `paslaugos`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `reitingai`
--
ALTER TABLE `reitingai`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uzsakymas_id` (`uzsakymas_id`);

--
-- Indexes for table `uzdarytos_valandos`
--
ALTER TABLE `uzdarytos_valandos`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `meistras_id` (`meistras_id`,`data`,`pradzios_laikas`);

--
-- Indexes for table `uzsakymai`
--
ALTER TABLE `uzsakymai`
  ADD PRIMARY KEY (`id`),
  ADD KEY `klientas_id` (`klientas_id`),
  ADD KEY `meistras_id` (`meistras_id`),
  ADD KEY `paslauga_id` (`paslauga_id`);

--
-- Indexes for table `vartotojai`
--
ALTER TABLE `vartotojai`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `el_pastas` (`el_pastas`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `duk`
--
ALTER TABLE `duk`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `paslaugos`
--
ALTER TABLE `paslaugos`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `reitingai`
--
ALTER TABLE `reitingai`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `uzdarytos_valandos`
--
ALTER TABLE `uzdarytos_valandos`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `uzsakymai`
--
ALTER TABLE `uzsakymai`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `vartotojai`
--
ALTER TABLE `vartotojai`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `meistrai_paslaugos`
--
ALTER TABLE `meistrai_paslaugos`
  ADD CONSTRAINT `meistrai_paslaugos_ibfk_1` FOREIGN KEY (`meistras_id`) REFERENCES `vartotojai` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `meistrai_paslaugos_ibfk_2` FOREIGN KEY (`paslauga_id`) REFERENCES `paslaugos` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `reitingai`
--
ALTER TABLE `reitingai`
  ADD CONSTRAINT `reitingai_ibfk_1` FOREIGN KEY (`uzsakymas_id`) REFERENCES `uzsakymai` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `uzdarytos_valandos`
--
ALTER TABLE `uzdarytos_valandos`
  ADD CONSTRAINT `uzdarytos_valandos_ibfk_1` FOREIGN KEY (`meistras_id`) REFERENCES `vartotojai` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `uzsakymai`
--
ALTER TABLE `uzsakymai`
  ADD CONSTRAINT `uzsakymai_ibfk_1` FOREIGN KEY (`klientas_id`) REFERENCES `vartotojai` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `uzsakymai_ibfk_2` FOREIGN KEY (`meistras_id`) REFERENCES `vartotojai` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `uzsakymai_ibfk_3` FOREIGN KEY (`paslauga_id`) REFERENCES `paslaugos` (`id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
