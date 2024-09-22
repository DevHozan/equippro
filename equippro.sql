-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 22, 2024 at 07:17 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `equippro`
--

-- --------------------------------------------------------

--
-- Table structure for table `assets`
--

CREATE TABLE `assets` (
  `asset_id` int(11) NOT NULL,
  `asset_name` varchar(100) NOT NULL,
  `asset_type` varchar(50) NOT NULL,
  `purchase_date` date NOT NULL,
  `purchase_price` decimal(10,2) NOT NULL,
  `current_value` decimal(10,2) DEFAULT NULL,
  `status` varchar(20) DEFAULT 'Activated',
  `location` varchar(100) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `depreciation_rate` decimal(5,2) DEFAULT NULL,
  `last_maintenance_date` date DEFAULT NULL,
  `last_replacement_date` date DEFAULT NULL,
  `owner_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `assets`
--

INSERT INTO `assets` (`asset_id`, `asset_name`, `asset_type`, `purchase_date`, `purchase_price`, `current_value`, `status`, `location`, `description`, `depreciation_rate`, `last_maintenance_date`, `last_replacement_date`, `owner_id`, `created_at`, `updated_at`) VALUES
(1, 'CNC', '3D Prrinter', '2024-09-11', 500.00, NULL, 'Sold', 'Musanze', 'It prints  3D shapes', 2.00, '2024-09-22', NULL, NULL, '2024-09-22 09:35:46', '2024-09-22 14:17:13'),
(2, 'CNC', '3D Prrinter', '2024-09-11', 500.00, NULL, 'active', 'Musanze', 'It prints  3D shapes', 2.00, '0000-00-00', '2024-09-22', NULL, '2024-09-22 09:35:49', '2024-09-22 13:48:55'),
(3, 'Arduino', 'CDT', '2024-09-24', 23.00, NULL, 'active', 'Musanze', '33', 3.00, '0000-00-00', NULL, NULL, '2024-09-22 09:49:00', '2024-09-22 11:55:24'),
(4, 'CNC', '3D Prrinter', '2024-09-13', 500.00, NULL, 'active', 'Musanze', 'uy', 2.00, NULL, NULL, NULL, '2024-09-22 14:16:15', '2024-09-22 14:16:15'),
(5, 'Arduino', 'CDT', '2024-09-11', 12000.00, NULL, 'active', 'Rulindo', 'DHT ', 2.00, '2024-09-22', NULL, NULL, '2024-09-22 16:31:03', '2024-09-22 16:32:00');

-- --------------------------------------------------------

--
-- Table structure for table `maintenance`
--

CREATE TABLE `maintenance` (
  `maintenance_id` int(11) NOT NULL,
  `asset_id` int(11) DEFAULT NULL,
  `maintenance_date` date NOT NULL,
  `details` text DEFAULT NULL,
  `cost` decimal(10,2) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `replacements`
--

CREATE TABLE `replacements` (
  `replacement_id` int(11) NOT NULL,
  `asset_id` int(11) DEFAULT NULL,
  `replacement_date` date NOT NULL,
  `details` text DEFAULT NULL,
  `cost` decimal(10,2) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `names` varchar(50) NOT NULL,
  `email` varchar(50) DEFAULT NULL,
  `tel` varchar(13) DEFAULT NULL,
  `level` varchar(20) DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  `password` varchar(20) NOT NULL,
  `date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `names`, `email`, `tel`, `level`, `status`, `password`, `date`) VALUES
(10, 'Hozana', 'hozana@gmail.com', '0791724884', 'admin', 'active', '123', '2024-09-22 16:20:24'),
(11, 'manager', 'manager@gmail.com', '0787565258', 'manager', 'active', '123', '2024-09-22 16:21:01'),
(12, 'manager', 'manager@gmail.com', '0787565258', 'manager', 'active', '123', '2024-09-22 16:51:33');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `assets`
--
ALTER TABLE `assets`
  ADD PRIMARY KEY (`asset_id`);

--
-- Indexes for table `maintenance`
--
ALTER TABLE `maintenance`
  ADD PRIMARY KEY (`maintenance_id`),
  ADD KEY `asset_id` (`asset_id`);

--
-- Indexes for table `replacements`
--
ALTER TABLE `replacements`
  ADD PRIMARY KEY (`replacement_id`),
  ADD KEY `asset_id` (`asset_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `assets`
--
ALTER TABLE `assets`
  MODIFY `asset_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `maintenance`
--
ALTER TABLE `maintenance`
  MODIFY `maintenance_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `replacements`
--
ALTER TABLE `replacements`
  MODIFY `replacement_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `maintenance`
--
ALTER TABLE `maintenance`
  ADD CONSTRAINT `maintenance_ibfk_1` FOREIGN KEY (`asset_id`) REFERENCES `assets` (`asset_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
