-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Počítač: 127.0.0.1
-- Vytvořeno: Čtv 03. čec 2025, 14:58
-- Verze serveru: 10.4.32-MariaDB
-- Verze PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Databáze: `price_tracker`
--

-- --------------------------------------------------------

--
-- Struktura tabulky `price_history`
--

CREATE TABLE `price_history` (
  `id` int(11) NOT NULL,
  `product_id` int(11) DEFAULT NULL,
  `price` decimal(10,0) DEFAULT NULL,
  `timestamp` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Vypisuji data pro tabulku `price_history`
--

INSERT INTO `price_history` (`id`, `product_id`, `price`, `timestamp`) VALUES
(119, 72, 21590, '2025-06-01 10:00:00'),
(120, 72, 21590, '2025-06-02 10:00:00'),
(121, 72, 21490, '2025-06-03 10:00:00'),
(122, 72, 21390, '2025-06-04 10:00:00'),
(123, 72, 21390, '2025-06-05 10:00:00'),
(124, 72, 21190, '2025-06-06 10:00:00'),
(125, 72, 21190, '2025-06-07 10:00:00'),
(126, 72, 21090, '2025-06-08 10:00:00'),
(127, 72, 21090, '2025-06-09 10:00:00'),
(128, 72, 21000, '2025-06-10 10:00:00'),
(129, 72, 20990, '2025-06-11 10:00:00'),
(130, 72, 20990, '2025-06-12 10:00:00'),
(131, 72, 20890, '2025-06-13 10:00:00'),
(132, 72, 20890, '2025-06-14 10:00:00'),
(133, 72, 20790, '2025-06-15 10:00:00'),
(134, 73, 33490, '2025-06-01 10:00:00'),
(135, 73, 33290, '2025-06-02 10:00:00'),
(136, 73, 33090, '2025-06-03 10:00:00'),
(137, 73, 32890, '2025-06-04 10:00:00'),
(138, 73, 32890, '2025-06-05 10:00:00'),
(139, 73, 32690, '2025-06-06 10:00:00'),
(140, 73, 32690, '2025-06-07 10:00:00'),
(141, 73, 32590, '2025-06-08 10:00:00'),
(142, 73, 32590, '2025-06-09 10:00:00'),
(143, 73, 32490, '2025-06-10 10:00:00'),
(144, 73, 32490, '2025-06-11 10:00:00'),
(145, 73, 32490, '2025-06-12 10:00:00'),
(146, 73, 32490, '2025-06-13 10:00:00'),
(147, 73, 32490, '2025-06-14 10:00:00'),
(148, 73, 32490, '2025-06-15 10:00:00'),
(164, 72, 20790, '2025-06-21 11:23:39'),
(189, 97, 4459, '2025-06-21 13:44:46'),
(190, 98, 2779, '2025-06-21 13:44:56'),
(191, 99, 56, '2025-06-21 13:45:19'),
(192, 100, 4599, '2025-06-21 13:50:52'),
(193, 101, 199, '2025-06-21 13:52:29'),
(194, 102, 17490, '2025-06-21 13:52:49'),
(196, 104, 7999, '2025-06-21 14:13:24'),
(200, 108, 6990, '2025-06-21 14:42:12'),
(201, 109, 17490, '2025-06-21 14:42:26'),
(202, 110, 1799, '2025-06-21 14:42:39'),
(203, 111, 4599, '2025-06-21 14:42:54'),
(204, 112, 3169, '2025-06-21 14:43:06'),
(238, 100, 4599, '2025-06-21 14:49:09'),
(239, 104, 11999, '2025-06-21 14:49:29'),
(242, 109, 18000, '2025-06-01 10:00:00'),
(243, 109, 17490, '2025-06-02 10:00:00'),
(244, 109, 17400, '2025-06-03 10:00:00'),
(245, 109, 17350, '2025-06-04 10:00:00'),
(246, 109, 17350, '2025-06-05 10:00:00'),
(247, 109, 17290, '2025-06-06 10:00:00'),
(248, 109, 17290, '2025-06-07 10:00:00'),
(249, 109, 17250, '2025-06-08 10:00:00'),
(250, 109, 17250, '2025-06-09 10:00:00'),
(251, 109, 17200, '2025-06-10 10:00:00'),
(252, 72, 20490, '2025-06-28 11:28:08'),
(253, 97, 4390, '2025-06-28 11:28:21'),
(254, 98, 2789, '2025-06-28 11:28:27'),
(255, 109, 18390, '2025-06-28 11:29:12');

-- --------------------------------------------------------

--
-- Struktura tabulky `uzivatele`
--

CREATE TABLE `uzivatele` (
  `id` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  `PASSWORD_hash` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Vypisuji data pro tabulku `uzivatele`
--

INSERT INTO `uzivatele` (`id`, `email`, `PASSWORD_hash`, `created_at`) VALUES
(1, 'david.tetur@seznam.cz', '$2b$12$QH.C0Yj1jdpyyyNtJFbXu.hRoTv1CQ0NJaiEFnIG/03iodWAZvVmC', '2025-06-20 12:04:07'),
(2, 'vlakvedouci03@seznam.cz', '$2b$12$uvF9CdYkibqvPvEAYg2qHORXwAKzOKxsO427FQaHpl8vXhSyBVoYK', '2025-06-20 21:03:47'),
(9, 'guest@seznam.cz', '$2b$12$51i71fjCELke3UGBY8LuL.3PT/SkJwKkUtJK2RCTFi2T5ZQsOmmv2', '2025-06-21 12:39:56');

-- --------------------------------------------------------

--
-- Struktura tabulky `wishlist`
--

CREATE TABLE `wishlist` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `link` varchar(255) DEFAULT NULL,
  `last_checked` datetime DEFAULT current_timestamp(),
  `original_price` decimal(10,2) DEFAULT NULL,
  `current_price` decimal(10,2) DEFAULT NULL,
  `image_url` text DEFAULT NULL,
  `description` text DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `email_sent` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Vypisuji data pro tabulku `wishlist`
--

INSERT INTO `wishlist` (`id`, `name`, `link`, `last_checked`, `original_price`, `current_price`, `image_url`, `description`, `user_id`, `email_sent`) VALUES
(72, 'iPhone 16 128GB černá - s výkupním bonusem 2 500 Kč', 'https://www.alza.cz/iphone-16-128gb-cerna-d12541617.htm', '2025-06-28 11:28:08', 21590.00, 20490.00, 'https://image.alza.cz/products/RI049b5/RI049b5.jpg?width=230&height=230', 'Mobilní telefon - 6,1\" Super Retina XDR OLED 2556 × 1179, operační paměť 8 GB, vnitřní paměť 128 GB, single SIM + eSIM, procesor Apple A18 Bionic, fotoaparát: 48Mpx (f/1,6) hlavní + 12Mpx širokoúhlý, GPS, NFC, LTE, 5G, USB-C, voděodolný dle IP68, rychlé nabíjení, bezdrátové nabíjení 15W, baterie 3561 mAh, model 2024, iOS', 1, 0),
(73, 'iPhone 16 Pro Max 256GB pouštní titan - s výkupním bonusem 2 500 Kč', 'https://www.alza.cz/iphone-16-pro-max-256gb-poustni-titan-d12541635.htm', '2025-06-20 18:21:43', 33490.00, 32490.00, 'https://image.alza.cz/products/RI052b4/RI052b4.jpg?width=230&height=230', 'Mobilní telefon - 6,9\" Super Retina XDR OLED 2868 × 1320 (120Hz), operační paměť 8 GB, vnitřní paměť 256 GB, single SIM + eSIM, procesor Apple A18 Pro, fotoaparát: 48Mpx (f/1,78) hlavní + 48Mpx širokoúhlý + 12Mpx teleobjektiv, přední kamera 12Mpx, GPS, NFC, LTE, 5G, USB-C, voděodolný dle IP68, rychlé nabíjení, bezdrátové nabíjení 25W, baterie 4685 mAh, model 2024, iOS', 1, 0),
(97, 'AMD Ryzen 5 7600', 'https://www.alza.cz/amd-ryzen-5-7600-d7612605.htm', '2025-06-28 11:28:21', 4459.00, 4390.00, 'https://image.alza.cz/products/BD750k5a/BD750k5a.jpg?width=230&height=230', 'Procesor 6 jádrový, 12 vláken, 3,8GHz (TDP 65W), Boost 5,1 GHz, 32MB L3 cache, AMD Radeon Graphics, socket AMD AM5, Raphael, box chladič, Wraith Stealth', 1, 0),
(98, 'Kingston FURY 32GB KIT DDR5 6000MT/s CL36 Beast White RGB EXPO', 'https://www.alza.cz/kingston-fury-32gb-kit-ddr5-6000mt-s-cl36-beast-white-rgb-expo-d12553667.htm?o=5', '2025-06-28 11:28:27', 2779.00, 2789.00, 'https://image.alza.cz/products/DEbw32b60er2/DEbw32b60er2.jpg?width=230&height=230', 'Operační paměť - 2x16GB, PC5-48000, CL36-44-44, napětí 1.35 V, AMD EXPO', 1, 0),
(99, 'Trixie Píšťalka kovová, vysokofrekvenční 8 cm', 'https://www.alza.cz/pet/trixie-pistalka-kovova-vysokofrekvencni-8-cm-d6435793.htm?o=1', '2025-06-21 13:45:19', 56.00, 56.00, 'https://image.alza.cz/products/CHPhr0207/CHPhr0207.jpg?width=230&height=230', 'Píšťalka na psy vhodná pro trénink, vysokofrekvenční, materiál: kov a plast, velikost: 8cm, černá barva', 1, 0),
(100, 'MSI MAG B650 TOMAHAWK WIFI', 'https://www.alza.cz/msi-mag-b650-tomahawk-wifi-d7505165.htm', '2025-06-21 14:49:09', 4599.00, 4599.00, 'https://image.alza.cz/products/AAb650mtw/AAb650mtw.jpg?width=230&height=230', 'Základní deska AMD B650, socket AMD AM5, PCI Express 4.0, 2× PCIe x16, 1× PCIe x1, 4× DDR5 6400MHz (OC), 6× SATA III, 3× M.2, USB 3.2 Gen 2, RJ-45 (LAN) 2,5Gbps, WiFi, 8ch zvuková karta, formát ATX', 1, 0),
(101, 'AlzaPower Core USB-A to USB-C 3.2 Gen 1 5Gbp 1m černý', 'https://www.alza.cz/alzapower-core-usb-c-3-1-gen1?dq=5472812', '2025-06-21 13:52:29', 199.00, 199.00, 'https://image.alza.cz/products/APWCB116b/APWCB116b.jpg?width=230&height=230', 'Datový kabel SuperSpeed USB 5Gb/s, Sync & Charge až 3A, pozlacené konektory, pro mobilní telefony, tablety a jiná zařízení s USB-C konektorem, VelcroStrap+', 1, 0),
(102, 'Mac mini M4 2024 - s výkupním bonusem 2 500 Kč', 'https://www.alza.cz/mac-mini-m4-2024?dq=12661695', '2025-06-21 13:52:49', 17490.00, 17490.00, 'https://image.alza.cz/products/TL024a1/TL024a1.jpg?width=230&height=230', 'Mini počítač Apple M4 (10jádrové), Apple Apple M4 10jádrová GPU, RAM 16GB, SSD 256 GB, Wi-Fi, HDMI, macOS', 1, 0),
(104, 'Anda Seat T-Pro 2 Premium Gaming Chair - XL Black', 'https://www.alza.cz/anda-seat-t-pro-2-xl-cerna-d7523288.htm', '2025-06-21 14:49:29', 7999.00, 11999.00, 'https://image.alza.cz/products/MENTL004/MENTL004.jpg?width=230&height=230', 'Herní židle – textil potažení, houpací mechanika s aretací, bederní a hlavová opěrka, výška, rotace vrchní části, posun dopředu / dozadu a posun doleva / doprava područky, sedák s balančními prvky, otočná a kovová konstrukce, výplň sedáku studená pěna (HR pěna), pogumovaná kolečka, černá barva, nosnost 200 kg', 2, 0),
(108, 'AMD Ryzen 7 7700', 'https://www.alza.cz/amd-ryzen-7-7700-d7612606.htm?o=1', '2025-06-21 14:42:12', 6990.00, 6990.00, 'https://image.alza.cz/products/BD750k6a/BD750k6a.jpg?width=230&height=230', 'Procesor 8 jádrový, 16 vláken, 3,8GHz (TDP 65W), Boost 5,3 GHz, 32MB L3 cache, AMD Radeon Graphics, socket AMD AM5, Raphael, box chladič, Wraith Prism', 9, 0),
(109, 'GIGABYTE Radeon RX 9070 GAMING OC 16G', 'https://www.alza.cz/gigabyte-radeon-rx-9070-gaming-oc-16g-d12828025.htm?o=1', '2025-06-28 11:29:12', 18000.00, 18390.00, 'https://image.alza.cz/products/EGr97g1/EGr97g1.jpg?width=230&height=230', 'Grafická karta - 16 GB GDDR6 (20000 MHz), AMD Radeon, RDNA 4.0 (Navi 48, 2400 MHz), PCI Express x16 5.0, 256Bit, HDMI 2.1b a DisplayPort 2.1a', 9, 0),
(110, 'WD_BLACK SN7100 1TB', 'https://www.alza.cz/wd_black-sn7100-1tb-d12827694.htm', '2025-06-21 14:42:39', 1799.00, 1799.00, 'https://image.alza.cz/products/FWsn7100a3/FWsn7100a3.jpg?width=230&height=230', 'SSD disk M.2 2280, M.2 (PCIe 4.0 4x NVMe), TLC (Triple-Level Cell), rychlost čtení 7250MB/s, rychlost zápisu 6900MB/s, životnost 600TBW', 9, 0),
(111, 'MSI MAG B650 TOMAHAWK WIFI', 'https://www.alza.cz/msi-mag-b650-tomahawk-wifi-d7505165.htm', '2025-06-21 14:42:54', 4599.00, 4599.00, 'https://image.alza.cz/products/AAb650mtw/AAb650mtw.jpg?width=230&height=230', 'Základní deska AMD B650, socket AMD AM5, PCI Express 4.0, 2× PCIe x16, 1× PCIe x1, 4× DDR5 6400MHz (OC), 6× SATA III, 3× M.2, USB 3.2 Gen 2, RJ-45 (LAN) 2,5Gbps, WiFi, 8ch zvuková karta, formát ATX', 9, 0),
(112, 'Kingston FURY 32GB KIT DDR4 3200MHz CL16 Beast Black 1Gx8', 'https://www.alza.cz/kingston-fury-32gb-kit-ddr4-3200mhz-cl16-beast-black-1gx8-d6622621.htm', '2025-06-21 14:43:06', 3169.00, 3169.00, 'https://image.alza.cz/products/DEb32b32bs2/DEb32b32bs2.jpg?width=230&height=230', 'Operační paměť - 2x16GB, PC4-25600, CL16-18-18, napětí 1.35 V, pasivní chladič, XMP 2.0 a Dual Rank', 9, 0);

--
-- Indexy pro exportované tabulky
--

--
-- Indexy pro tabulku `price_history`
--
ALTER TABLE `price_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexy pro tabulku `uzivatele`
--
ALTER TABLE `uzivatele`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexy pro tabulku `wishlist`
--
ALTER TABLE `wishlist`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_uzivatel` (`user_id`);

--
-- AUTO_INCREMENT pro tabulky
--

--
-- AUTO_INCREMENT pro tabulku `price_history`
--
ALTER TABLE `price_history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=256;

--
-- AUTO_INCREMENT pro tabulku `uzivatele`
--
ALTER TABLE `uzivatele`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT pro tabulku `wishlist`
--
ALTER TABLE `wishlist`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=116;

--
-- Omezení pro exportované tabulky
--

--
-- Omezení pro tabulku `price_history`
--
ALTER TABLE `price_history`
  ADD CONSTRAINT `price_history_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `wishlist` (`id`) ON DELETE CASCADE;

--
-- Omezení pro tabulku `wishlist`
--
ALTER TABLE `wishlist`
  ADD CONSTRAINT `fk_uzivatel` FOREIGN KEY (`user_id`) REFERENCES `uzivatele` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
