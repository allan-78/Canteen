-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 02, 2025 at 07:58 AM
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
-- Database: `canteen_database`
--

-- --------------------------------------------------------

--
-- Table structure for table `cart`
--

CREATE TABLE `cart` (
  `cart_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cart`
--

INSERT INTO `cart` (`cart_id`, `user_id`, `item_id`, `quantity`) VALUES
(23, 6, 2, 1);

-- --------------------------------------------------------

--
-- Table structure for table `inventory`
--

CREATE TABLE `inventory` (
  `inventory_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `quantity_in_stock` int(11) NOT NULL,
  `last_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `inventory`
--

INSERT INTO `inventory` (`inventory_id`, `item_id`, `quantity_in_stock`, `last_updated`) VALUES
(1, 1, 45, '2025-02-21 03:47:35'),
(2, 2, 89, '2025-02-28 04:01:46'),
(3, 3, 178, '2025-02-21 01:46:13'),
(4, 4, 29, '2025-02-20 13:10:40'),
(5, 5, 66, '2025-02-21 01:22:01');

-- --------------------------------------------------------

--
-- Table structure for table `menu_items`
--

CREATE TABLE `menu_items` (
  `item_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `category` enum('Snacks','Drinks','Meals') NOT NULL,
  `availability` tinyint(1) DEFAULT 1,
  `image_path` varchar(255) NOT NULL DEFAULT 'default.jpg',
  `stall_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `menu_items`
--

INSERT INTO `menu_items` (`item_id`, `name`, `price`, `category`, `availability`, `image_path`, `stall_id`) VALUES
(1, 'Cheeseburger', 5.99, 'Meals', 1, 'images/cheeseburger.jpg', 1),
(2, 'French Fries', 2.99, 'Snacks', 1, 'images/french_fries.jpg', 1),
(3, 'Coke', 1.50, 'Drinks', 1, 'images/coke.jpg', 2),
(4, 'Pizza Slice', 3.99, 'Meals', 1, 'images/pizza_slice.jpg', 1),
(5, 'Ice Cream', 2.49, 'Snacks', 1, 'images/ice_cream.jpg', 3);

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `order_id` varchar(50) NOT NULL,
  `user_id` int(11) NOT NULL,
  `total_price` decimal(10,2) NOT NULL,
  `order_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` enum('Pending','Completed','Canceled') DEFAULT 'Pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`order_id`, `user_id`, `total_price`, `order_date`, `status`) VALUES
('ORDER_67b729d0000a00.79837591', 1, 9.98, '2025-02-20 13:10:40', 'Pending'),
('ORDER_67b729da8ec268.39575638', 1, 4.50, '2025-02-20 13:10:50', 'Pending'),
('ORDER_67b732cdde3a30.48020126', 1, 1.50, '2025-02-20 13:49:01', 'Pending'),
('ORDER_67b7d49e4e5f71.05682525', 1, 7.49, '2025-02-21 01:19:26', 'Pending'),
('ORDER_67b7d5396f1d13.39117098', 1, 22.41, '2025-02-21 01:22:01', 'Pending'),
('ORDER_67b7d6337e1f40.69251557', 1, 29.93, '2025-02-21 01:26:11', 'Pending'),
('ORDER_67b7dae517d179.85585574', 2, 7.50, '2025-02-21 01:46:13', 'Pending'),
('ORDER_67b7ec30719de5.72521993', 2, 5.99, '2025-02-21 03:00:00', 'Pending'),
('ORDER_67b7f757b5d2b3.79201193', 5, 5.99, '2025-02-21 03:47:35', 'Pending'),
('ORDER_67c1352adf30c4.98216851', 6, 11.96, '2025-02-28 04:01:46', 'Pending');

-- --------------------------------------------------------

--
-- Table structure for table `order_details`
--

CREATE TABLE `order_details` (
  `order_detail_id` int(11) NOT NULL,
  `order_id` varchar(50) NOT NULL,
  `item_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `subtotal` decimal(10,2) NOT NULL,
  `price` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `payment_id` int(11) NOT NULL,
  `order_id` varchar(50) NOT NULL,
  `user_id` int(11) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `payment_method` enum('gcash','paymaya','bank_transfer','balance') NOT NULL,
  `status` enum('pending','completed','failed') DEFAULT 'pending',
  `payment_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`payment_id`, `order_id`, `user_id`, `amount`, `payment_method`, `status`, `payment_date`) VALUES
(6, 'ORDER_67b729d0000a00.79837591', 1, 9.98, 'balance', 'completed', '2025-02-20 13:10:40'),
(7, 'ORDER_67b729da8ec268.39575638', 1, 4.50, 'paymaya', 'completed', '2025-02-20 13:10:50'),
(8, 'ORDER_67b732cdde3a30.48020126', 1, 1.50, 'gcash', 'completed', '2025-02-20 13:49:01'),
(9, 'ORDER_67b7d49e4e5f71.05682525', 1, 7.49, 'balance', 'completed', '2025-02-21 01:19:26'),
(10, 'ORDER_67b7d5396f1d13.39117098', 1, 22.41, 'bank_transfer', 'completed', '2025-02-21 01:22:01'),
(11, 'ORDER_67b7d6337e1f40.69251557', 1, 29.93, 'balance', 'completed', '2025-02-21 01:26:11'),
(12, 'ORDER_67b7dae517d179.85585574', 2, 7.50, 'balance', 'completed', '2025-02-21 01:46:13'),
(13, 'ORDER_67b7ec30719de5.72521993', 2, 5.99, 'balance', 'completed', '2025-02-21 03:00:00'),
(14, 'ORDER_67b7f757b5d2b3.79201193', 5, 5.99, 'balance', 'completed', '2025-02-21 03:47:35'),
(15, 'ORDER_67c1352adf30c4.98216851', 6, 11.96, 'bank_transfer', 'completed', '2025-02-28 04:01:46');

-- --------------------------------------------------------

--
-- Table structure for table `stalls`
--

CREATE TABLE `stalls` (
  `stall_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `image_path` varchar(255) NOT NULL DEFAULT 'default_stall.jpg'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `stalls`
--

INSERT INTO `stalls` (`stall_id`, `name`, `description`, `image_path`) VALUES
(1, 'Store 1', 'Delicious Burgers and Fries', 'images/store1.jpg'),
(2, 'Store 2', 'Fresh Drinks and Juices', 'images/store2.jpg'),
(3, 'Store 3', 'Tasty Snacks and Desserts', 'images/store3.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('Student','Staff','Admin') NOT NULL,
  `balance` decimal(10,2) DEFAULT 0.00,
  `phone` varchar(15) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `image_path` varchar(255) DEFAULT 'images/default-profile.jpg'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `name`, `email`, `password`, `role`, `balance`, `phone`, `address`, `image_path`) VALUES
(1, 'Allan Monforte', 'allanmonforte@gmail.com', '$2y$10$j2Xm9vb2YSUD310EVE.ghuUyudfpgNF8E6QrNTamqhHvv/OBlVFdm', 'Student', 847.65, '09686827403', '285 PNR Site, Western Bicutan Taguig City, Western Bicutan', 'images/profiles/67b71f8628b2f_RobloxScreenShot20250219_220845337.png'),
(2, 'EGAY', 'ego123123@gmail.net', '$2y$10$jTeazZ6pzHdI2d5dSxkIdu65pLFLM7xpyR6mmExVIcrb1vSdoxgVq', 'Student', 99999999.99, '6969', 'gayland', 'images/default-profile.jpg'),
(3, 'Melvin', 'melvin1234@gmail.com', '$2y$10$3sdO.wGghgce/3n6jipIh.syBETL7VagujIPjIKXiUFh7inGO6DpK', 'Student', 0.00, NULL, NULL, 'images/default-profile.jpg'),
(4, 'zcdasad@gasfsas.coaj', '123123@gmail.com', '$2y$10$.7F2Ud.lXqib.uNErYlc1uVy162S.7KKxeB64PyORXj8sHhBx5aTq', 'Student', 0.00, NULL, NULL, 'images/default-profile.jpg'),
(5, 'allan monforte porto', 'allan123@gmail.com', '$2y$10$CUxcH8PsjnM8YZ.CL7.0E.r7MJQn7IdTM.H86G5/B./jGrv5X4/g.', 'Student', 999993.01, NULL, NULL, 'images/default-profile.jpg'),
(6, 'egoian', 'ego123@gmail.com', '$2y$10$v7CN02fZjTAVgoheVDzBWOiHtbnsTRbxZGJHyp/v7mf4seTHKKWSy', 'Student', 0.00, NULL, NULL, 'images/default-profile.jpg');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`cart_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `item_id` (`item_id`);

--
-- Indexes for table `inventory`
--
ALTER TABLE `inventory`
  ADD PRIMARY KEY (`inventory_id`),
  ADD KEY `item_id` (`item_id`);

--
-- Indexes for table `menu_items`
--
ALTER TABLE `menu_items`
  ADD PRIMARY KEY (`item_id`),
  ADD KEY `stall_id` (`stall_id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `order_details`
--
ALTER TABLE `order_details`
  ADD PRIMARY KEY (`order_detail_id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `item_id` (`item_id`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`payment_id`),
  ADD KEY `order_id` (`order_id`);

--
-- Indexes for table `stalls`
--
ALTER TABLE `stalls`
  ADD PRIMARY KEY (`stall_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cart`
--
ALTER TABLE `cart`
  MODIFY `cart_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `inventory`
--
ALTER TABLE `inventory`
  MODIFY `inventory_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `menu_items`
--
ALTER TABLE `menu_items`
  MODIFY `item_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `order_details`
--
ALTER TABLE `order_details`
  MODIFY `order_detail_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `payment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `stalls`
--
ALTER TABLE `stalls`
  MODIFY `stall_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `cart`
--
ALTER TABLE `cart`
  ADD CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `cart_ibfk_2` FOREIGN KEY (`item_id`) REFERENCES `menu_items` (`item_id`) ON DELETE CASCADE;

--
-- Constraints for table `inventory`
--
ALTER TABLE `inventory`
  ADD CONSTRAINT `inventory_ibfk_1` FOREIGN KEY (`item_id`) REFERENCES `menu_items` (`item_id`) ON DELETE CASCADE;

--
-- Constraints for table `menu_items`
--
ALTER TABLE `menu_items`
  ADD CONSTRAINT `fk_stall` FOREIGN KEY (`stall_id`) REFERENCES `stalls` (`stall_id`) ON DELETE CASCADE;

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `order_details`
--
ALTER TABLE `order_details`
  ADD CONSTRAINT `order_details_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `order_details_ibfk_2` FOREIGN KEY (`item_id`) REFERENCES `menu_items` (`item_id`) ON DELETE CASCADE;

--
-- Constraints for table `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
