-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: db
-- Generation Time: Mar 17, 2026 at 10:38 AM
-- Server version: 9.6.0
-- PHP Version: 8.3.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `project_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `category_id` int NOT NULL,
  `category_name` varchar(255) NOT NULL,
  `description` text,
  `icon` varchar(255) DEFAULT NULL,
  `listing_count` int DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`category_id`, `category_name`, `description`, `icon`, `listing_count`) VALUES
(1, 'Weapons', 'Swords, spears, axes and combat tools', 'icon-weapons.png', 0),
(2, 'Armor', 'Protective gear used in battle', 'icon-armor.png', 0),
(3, 'Transport', 'Horses, chariots and movement equipment', 'icon-transport.png', 0),
(4, 'Artifacts', 'Historical or rare collectible items', 'icon-artifacts.png', 0),
(5, 'Accessories', 'Extra equipment and utility items', 'icon-accessories.png', 0);

-- --------------------------------------------------------

--
-- Table structure for table `listings`
--

CREATE TABLE `listings` (
  `listing_id` int NOT NULL,
  `user_id` int NOT NULL,
  `category_id` int NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `exchange_type` enum('lending','swap','giveaway') NOT NULL,
  `condition_status` enum('like_new','good','fair','well_used') NOT NULL,
  `condition_notes` text,
  `photo_url_1` varchar(255) DEFAULT NULL,
  `photo_url_2` varchar(255) DEFAULT NULL,
  `photo_url_3` varchar(255) DEFAULT NULL,
  `swap_preferences` text,
  `is_available` tinyint(1) DEFAULT '1',
  `view_count` int DEFAULT '0',
  `request_count` int DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `listings`
--

INSERT INTO `listings` (`listing_id`, `user_id`, `category_id`, `title`, `description`, `exchange_type`, `condition_status`, `condition_notes`, `photo_url_1`, `photo_url_2`, `photo_url_3`, `swap_preferences`, `is_available`, `view_count`, `request_count`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 'Sword of Kufa', 'Historical styled sword', 'swap', 'good', 'Minor scratches', NULL, NULL, NULL, 'Looking for shield', 1, 10, 0, '2026-03-17 10:28:30', '2026-03-17 10:28:30'),
(2, 2, 2, 'Battle Armor', 'Used in many battles', 'lending', 'fair', 'Heavy wear', NULL, NULL, NULL, NULL, 1, 25, 0, '2026-03-17 10:28:30', '2026-03-17 10:28:30'),
(3, 3, 1, 'Crusader Shield', 'Strong defensive shield', 'swap', 'like_new', NULL, NULL, NULL, NULL, 'Sword preferred', 1, 15, 0, '2026-03-17 10:28:30', '2026-03-17 10:28:30'),
(4, 4, 3, 'Horse Saddle', 'Comfortable saddle', 'giveaway', 'good', NULL, NULL, NULL, NULL, NULL, 1, 5, 0, '2026-03-17 10:28:30', '2026-03-17 10:28:30'),
(5, 5, 2, 'Ottoman Helmet', 'Steel helmet', 'swap', 'fair', 'Rust spots', NULL, NULL, NULL, NULL, 1, 8, 0, '2026-03-17 10:28:30', '2026-03-17 10:28:30'),
(6, 6, 1, 'Roman Gladius', 'Short sword', 'lending', 'good', NULL, NULL, NULL, NULL, NULL, 1, 30, 0, '2026-03-17 10:28:30', '2026-03-17 10:28:30'),
(7, 7, 2, 'Legion Armor', 'Roman armor', 'swap', 'fair', 'Used condition', NULL, NULL, NULL, 'Better armor', 1, 12, 0, '2026-03-17 10:28:30', '2026-03-17 10:28:30'),
(8, 8, 3, 'War Chariot', 'Two horse chariot', 'swap', 'well_used', 'Old but functional', NULL, NULL, NULL, NULL, 1, 20, 0, '2026-03-17 10:28:30', '2026-03-17 10:28:30'),
(9, 9, 1, 'Imperial Dagger', 'Decorative dagger', 'giveaway', 'like_new', NULL, NULL, NULL, NULL, NULL, 1, 7, 0, '2026-03-17 10:28:30', '2026-03-17 10:28:30'),
(10, 10, 2, 'Shield of Rome', 'Heavy shield', 'lending', 'good', NULL, NULL, NULL, NULL, NULL, 1, 18, 0, '2026-03-17 10:28:30', '2026-03-17 10:28:30'),
(11, 11, 1, 'Persian Spear', 'Long spear', 'swap', 'good', NULL, NULL, NULL, NULL, NULL, 1, 14, 0, '2026-03-17 10:28:30', '2026-03-17 10:28:30'),
(12, 12, 2, 'Royal Armor', 'Elite armor', 'lending', 'like_new', NULL, NULL, NULL, NULL, NULL, 1, 22, 0, '2026-03-17 10:28:30', '2026-03-17 10:28:30'),
(13, 13, 3, 'War Elephant Gear', 'Used in battles', 'swap', 'fair', 'Damaged parts', NULL, NULL, NULL, NULL, 1, 9, 0, '2026-03-17 10:28:30', '2026-03-17 10:28:30'),
(14, 14, 1, 'Legendary Sword', 'Mythical blade', 'giveaway', 'well_used', 'Ancient relic', NULL, NULL, NULL, NULL, 1, 11, 0, '2026-03-17 10:28:30', '2026-03-17 10:28:30'),
(15, 15, 2, 'Battle Axe', 'Heavy axe', 'swap', 'good', NULL, NULL, NULL, NULL, NULL, 1, 16, 0, '2026-03-17 10:28:30', '2026-03-17 10:28:30');

-- --------------------------------------------------------

--
-- Table structure for table `listing_tags`
--

CREATE TABLE `listing_tags` (
  `listing_id` int NOT NULL,
  `tag_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `listing_tags`
--

INSERT INTO `listing_tags` (`listing_id`, `tag_id`) VALUES
(1, 1),
(6, 1),
(1, 2),
(3, 2),
(10, 2),
(2, 3),
(5, 3),
(8, 3),
(3, 4),
(11, 4),
(14, 4),
(2, 5),
(7, 5),
(15, 5),
(4, 6),
(9, 7),
(14, 7),
(5, 8),
(13, 8),
(6, 9),
(10, 9),
(12, 9),
(8, 10);

-- --------------------------------------------------------

--
-- Table structure for table `messages`
--

CREATE TABLE `messages` (
  `message_id` int NOT NULL,
  `sender_id` int NOT NULL,
  `receiver_id` int NOT NULL,
  `request_id` int DEFAULT NULL,
  `listing_id` int DEFAULT NULL,
  `content` text NOT NULL,
  `is_read` tinyint(1) DEFAULT '0',
  `sent_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `messages`
--

INSERT INTO `messages` (`message_id`, `sender_id`, `receiver_id`, `request_id`, `listing_id`, `content`, `is_read`, `sent_at`) VALUES
(1, 1, 2, 1, NULL, 'Hey, I sent you a request', 0, '2026-03-17 10:34:05'),
(2, 2, 1, 1, NULL, 'Got it, will check', 1, '2026-03-17 10:34:05'),
(3, 3, 4, 2, NULL, 'Is the armor still available?', 0, '2026-03-17 10:34:05'),
(4, 4, 3, 2, NULL, 'Yes, it is', 1, '2026-03-17 10:34:05'),
(5, 5, 6, NULL, 3, 'Interested in your listing', 0, '2026-03-17 10:34:05'),
(6, 6, 5, NULL, 3, 'Sure, let’s discuss', 1, '2026-03-17 10:34:05'),
(7, 7, 8, NULL, 6, 'Can you lower the price?', 0, '2026-03-17 10:34:05'),
(8, 8, 7, NULL, 6, 'Maybe slightly', 1, '2026-03-17 10:34:05'),
(9, 9, 10, 5, NULL, 'Request cancelled?', 0, '2026-03-17 10:34:05'),
(10, 10, 9, 5, NULL, 'Yes, sorry', 1, '2026-03-17 10:34:05'),
(11, 11, 12, NULL, NULL, 'Hello there!', 0, '2026-03-17 10:34:05'),
(12, 12, 11, NULL, NULL, 'Hi!', 1, '2026-03-17 10:34:05'),
(13, 13, 14, 10, NULL, 'I completed the trade', 1, '2026-03-17 10:34:05'),
(14, 14, 13, 10, NULL, 'Great, thanks', 1, '2026-03-17 10:34:05'),
(15, 15, 1, NULL, 15, 'Still available?', 0, '2026-03-17 10:34:05');

-- --------------------------------------------------------

--
-- Table structure for table `ratings`
--

CREATE TABLE `ratings` (
  `rating_id` int NOT NULL,
  `request_id` int NOT NULL,
  `rater_id` int NOT NULL,
  `rated_id` int NOT NULL,
  `score` int NOT NULL,
  `comment` text,
  `rating_type` enum('as_lender','as_borrower','as_swapper','as_giver','as_receiver') NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ;

--
-- Dumping data for table `ratings`
--

INSERT INTO `ratings` (`rating_id`, `request_id`, `rater_id`, `rated_id`, `score`, `comment`, `rating_type`, `created_at`) VALUES
(1, 1, 2, 1, 5, 'Great experience', 'as_borrower', '2026-03-17 10:32:44'),
(2, 2, 3, 2, 4, 'Good but late return', 'as_lender', '2026-03-17 10:32:44'),
(3, 3, 4, 3, 3, 'Fair trade', 'as_swapper', '2026-03-17 10:32:44'),
(4, 4, 5, 4, 5, 'Excellent condition', 'as_receiver', '2026-03-17 10:32:44'),
(5, 5, 6, 5, 2, 'Not as described', 'as_borrower', '2026-03-17 10:32:44'),
(6, 6, 7, 6, 5, 'Perfect transaction', 'as_lender', '2026-03-17 10:32:44'),
(7, 7, 8, 7, 4, 'Smooth swap', 'as_swapper', '2026-03-17 10:32:44'),
(8, 8, 9, 8, 3, 'Average experience', 'as_receiver', '2026-03-17 10:32:44'),
(9, 9, 10, 9, 5, 'Highly recommended', 'as_giver', '2026-03-17 10:32:44'),
(10, 10, 11, 10, 4, 'Good quality item', 'as_borrower', '2026-03-17 10:32:44'),
(11, 11, 12, 11, 5, 'Very reliable', 'as_lender', '2026-03-17 10:32:44'),
(12, 12, 13, 12, 3, 'Okay experience', 'as_receiver', '2026-03-17 10:32:44'),
(13, 13, 14, 13, 4, 'Good communication', 'as_swapper', '2026-03-17 10:32:44'),
(14, 14, 15, 14, 2, 'Item worn out', 'as_borrower', '2026-03-17 10:32:44'),
(15, 15, 1, 15, 5, 'Excellent trade', 'as_giver', '2026-03-17 10:32:44');

-- --------------------------------------------------------

--
-- Table structure for table `requests`
--

CREATE TABLE `requests` (
  `request_id` int NOT NULL,
  `requester_id` int NOT NULL,
  `listing_id` int NOT NULL,
  `status` enum('pending','accepted','declined','completed','cancelled') DEFAULT 'pending',
  `message` text NOT NULL,
  `requested_duration` varchar(255) DEFAULT NULL,
  `swap_offer_description` text,
  `requested_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `responded_date` timestamp NULL DEFAULT NULL,
  `completed_date` timestamp NULL DEFAULT NULL,
  `owner_notes` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `requests`
--

INSERT INTO `requests` (`request_id`, `requester_id`, `listing_id`, `status`, `message`, `requested_duration`, `swap_offer_description`, `requested_date`, `responded_date`, `completed_date`, `owner_notes`) VALUES
(1, 2, 1, 'pending', 'Interested in your sword', '3 days', NULL, '2026-03-17 10:30:58', NULL, NULL, NULL),
(2, 3, 2, 'accepted', 'Can I borrow this armor?', '1 week', NULL, '2026-03-17 10:30:58', '2026-03-17 10:30:58', NULL, 'Handle with care'),
(3, 4, 3, 'declined', 'Swap for my shield?', NULL, 'Offering shield', '2026-03-17 10:30:58', '2026-03-17 10:30:58', NULL, 'Not interested'),
(4, 5, 4, 'completed', 'Need this saddle', '2 days', NULL, '2026-03-17 10:30:58', '2026-03-17 10:30:58', '2026-03-17 10:30:58', 'Returned in good condition'),
(5, 6, 5, 'cancelled', 'Helmet request', NULL, NULL, '2026-03-17 10:30:58', '2026-03-17 10:30:58', NULL, NULL),
(6, 7, 6, 'pending', 'Interested in gladius', '5 days', NULL, '2026-03-17 10:30:58', NULL, NULL, NULL),
(7, 8, 7, 'accepted', 'Swap armor?', NULL, 'Offering upgraded armor', '2026-03-17 10:30:58', '2026-03-17 10:30:58', NULL, NULL),
(8, 9, 8, 'declined', 'Chariot request', NULL, NULL, '2026-03-17 10:30:58', '2026-03-17 10:30:58', NULL, 'Too risky'),
(9, 10, 9, 'completed', 'Dagger looks great', NULL, NULL, '2026-03-17 10:30:58', '2026-03-17 10:30:58', '2026-03-17 10:30:58', NULL),
(10, 11, 10, 'pending', 'Shield request', '2 days', NULL, '2026-03-17 10:30:58', NULL, NULL, NULL),
(11, 12, 11, 'accepted', 'Interested in spear', NULL, NULL, '2026-03-17 10:30:58', '2026-03-17 10:30:58', NULL, NULL),
(12, 13, 12, 'completed', 'Armor needed urgently', '4 days', NULL, '2026-03-17 10:30:58', '2026-03-17 10:30:58', '2026-03-17 10:30:58', 'Good borrower'),
(13, 14, 13, 'pending', 'Elephant gear request', NULL, NULL, '2026-03-17 10:30:58', NULL, NULL, NULL),
(14, 15, 14, 'declined', 'Sword swap offer', NULL, 'Offering axe', '2026-03-17 10:30:58', '2026-03-17 10:30:58', NULL, 'Not equal value'),
(15, 1, 15, 'pending', 'Battle axe request', '1 day', NULL, '2026-03-17 10:30:58', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `tags`
--

CREATE TABLE `tags` (
  `tag_id` int NOT NULL,
  `tag_name` varchar(255) NOT NULL,
  `usage_count` int DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `tags`
--

INSERT INTO `tags` (`tag_id`, `tag_name`, `usage_count`) VALUES
(1, 'rare', 0),
(2, 'antique', 0),
(3, 'battle_used', 0),
(4, 'legendary', 0),
(5, 'heavy', 0),
(6, 'lightweight', 0),
(7, 'collectible', 0),
(8, 'damaged', 0),
(9, 'premium', 0),
(10, 'vintage', 0);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int NOT NULL,
  `email` varchar(255) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `bio` text,
  `location` varchar(255) NOT NULL,
  `latitude` decimal(10,7) DEFAULT NULL,
  `longitude` decimal(10,7) DEFAULT NULL,
  `profile_pic` varchar(255) DEFAULT 'default-avatar.png',
  `points` int DEFAULT '50',
  `average_rating` decimal(3,2) DEFAULT '0.00',
  `total_ratings` int DEFAULT '0',
  `items_lent` int DEFAULT '0',
  `items_borrowed` int DEFAULT '0',
  `items_given` int DEFAULT '0',
  `is_active` tinyint(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `email`, `password_hash`, `first_name`, `last_name`, `bio`, `location`, `latitude`, `longitude`, `profile_pic`, `points`, `average_rating`, `total_ratings`, `items_lent`, `items_borrowed`, `items_given`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'ali@history.com', 'hashed_pw', 'Ali', 'Ibn Abi Talib', 'Fourth caliph and warrior', 'Kufa', 32.0303000, 44.4009000, 'default-avatar.png', 120, 0.00, 0, 0, 0, 0, 1, '2026-03-17 10:11:45', '2026-03-17 10:11:45'),
(2, 'khalid@history.com', 'hashed_pw', 'Khalid', 'Ibn Al-Walid', 'Sword of Allah', 'Mecca', 21.3891000, 39.8579000, 'default-avatar.png', 150, 0.00, 0, 0, 0, 0, 1, '2026-03-17 10:11:45', '2026-03-17 10:11:45'),
(3, 'salahuddin@history.com', 'hashed_pw', 'Salahuddin', 'Ayyubi', 'Leader of the Muslim forces in Crusades', 'Jerusalem', 31.7683000, 35.2137000, 'default-avatar.png', 200, 0.00, 0, 0, 0, 0, 1, '2026-03-17 10:11:45', '2026-03-17 10:11:45'),
(4, 'tariq@history.com', 'hashed_pw', 'Tariq', 'Ibn Ziyad', 'Conqueror of Al-Andalus', 'Tangier', 35.7595000, -5.8340000, 'default-avatar.png', 130, 0.00, 0, 0, 0, 0, 1, '2026-03-17 10:11:45', '2026-03-17 10:11:45'),
(5, 'mehmed@history.com', 'hashed_pw', 'Mehmed', 'II', 'Ottoman conqueror of Constantinople', 'Istanbul', 41.0082000, 28.9784000, 'default-avatar.png', 180, 0.00, 0, 0, 0, 0, 1, '2026-03-17 10:11:45', '2026-03-17 10:11:45'),
(6, 'caesar@rome.com', 'hashed_pw', 'Julius', 'Caesar', 'Roman general and dictator', 'Rome', 41.9028000, 12.4964000, 'default-avatar.png', 170, 0.00, 0, 0, 0, 0, 1, '2026-03-17 10:11:45', '2026-03-17 10:11:45'),
(7, 'scipio@rome.com', 'hashed_pw', 'Scipio', 'Africanus', 'Defeated Hannibal', 'Rome', 41.9028000, 12.4964000, 'default-avatar.png', 140, 0.00, 0, 0, 0, 0, 1, '2026-03-17 10:11:45', '2026-03-17 10:11:45'),
(8, 'maximus@rome.com', 'hashed_pw', 'Maximus', 'Decimus', 'Fictional Roman general', 'Rome', 41.9028000, 12.4964000, 'default-avatar.png', 110, 0.00, 0, 0, 0, 0, 1, '2026-03-17 10:11:45', '2026-03-17 10:11:45'),
(9, 'augustus@rome.com', 'hashed_pw', 'Augustus', 'Octavian', 'First Roman emperor', 'Rome', 41.9028000, 12.4964000, 'default-avatar.png', 160, 0.00, 0, 0, 0, 0, 1, '2026-03-17 10:11:45', '2026-03-17 10:11:45'),
(10, 'aurelian@rome.com', 'hashed_pw', 'Aurelian', 'Emperor', 'Restored Roman Empire', 'Rome', 41.9028000, 12.4964000, 'default-avatar.png', 145, 0.00, 0, 0, 0, 0, 1, '2026-03-17 10:11:45', '2026-03-17 10:11:45'),
(11, 'cyrus@persia.com', 'hashed_pw', 'Cyrus', 'The Great', 'Founder of Achaemenid Empire', 'Persia', 29.9350000, 52.8916000, 'default-avatar.png', 200, 0.00, 0, 0, 0, 0, 1, '2026-03-17 10:11:45', '2026-03-17 10:11:45'),
(12, 'darius@persia.com', 'hashed_pw', 'Darius', 'The Great', 'Persian king', 'Persepolis', 29.9350000, 52.8916000, 'default-avatar.png', 175, 0.00, 0, 0, 0, 0, 1, '2026-03-17 10:11:45', '2026-03-17 10:11:45'),
(13, 'xerxes@persia.com', 'hashed_pw', 'Xerxes', 'I', 'Persian king in Greco-Persian wars', 'Persia', 29.9350000, 52.8916000, 'default-avatar.png', 160, 0.00, 0, 0, 0, 0, 1, '2026-03-17 10:11:45', '2026-03-17 10:11:45'),
(14, 'rostam@persia.com', 'hashed_pw', 'Rostam', 'Zal', 'Legendary Persian hero', 'Zabulistan', 31.0000000, 61.0000000, 'default-avatar.png', 155, 0.00, 0, 0, 0, 0, 1, '2026-03-17 10:11:45', '2026-03-17 10:11:45'),
(15, 'nadir@persia.com', 'hashed_pw', 'Nadir', 'Shah', 'Persian ruler and conqueror', 'Mashhad', 36.2605000, 59.6168000, 'default-avatar.png', 185, 0.00, 0, 0, 0, 0, 1, '2026-03-17 10:11:45', '2026-03-17 10:11:45');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`category_id`),
  ADD UNIQUE KEY `category_name` (`category_name`);

--
-- Indexes for table `listings`
--
ALTER TABLE `listings`
  ADD PRIMARY KEY (`listing_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `category_id` (`category_id`);

--
-- Indexes for table `listing_tags`
--
ALTER TABLE `listing_tags`
  ADD PRIMARY KEY (`listing_id`,`tag_id`),
  ADD KEY `tag_id` (`tag_id`);

--
-- Indexes for table `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`message_id`),
  ADD KEY `sender_id` (`sender_id`),
  ADD KEY `receiver_id` (`receiver_id`),
  ADD KEY `request_id` (`request_id`),
  ADD KEY `listing_id` (`listing_id`);

--
-- Indexes for table `ratings`
--
ALTER TABLE `ratings`
  ADD PRIMARY KEY (`rating_id`),
  ADD KEY `request_id` (`request_id`),
  ADD KEY `rater_id` (`rater_id`),
  ADD KEY `rated_id` (`rated_id`);

--
-- Indexes for table `requests`
--
ALTER TABLE `requests`
  ADD PRIMARY KEY (`request_id`),
  ADD KEY `requester_id` (`requester_id`),
  ADD KEY `listing_id` (`listing_id`);

--
-- Indexes for table `tags`
--
ALTER TABLE `tags`
  ADD PRIMARY KEY (`tag_id`),
  ADD UNIQUE KEY `tag_name` (`tag_name`);

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
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `category_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `listings`
--
ALTER TABLE `listings`
  MODIFY `listing_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `messages`
--
ALTER TABLE `messages`
  MODIFY `message_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `ratings`
--
ALTER TABLE `ratings`
  MODIFY `rating_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `requests`
--
ALTER TABLE `requests`
  MODIFY `request_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `tags`
--
ALTER TABLE `tags`
  MODIFY `tag_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `listings`
--
ALTER TABLE `listings`
  ADD CONSTRAINT `listings_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `listings_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`);

--
-- Constraints for table `listing_tags`
--
ALTER TABLE `listing_tags`
  ADD CONSTRAINT `listing_tags_ibfk_1` FOREIGN KEY (`listing_id`) REFERENCES `listings` (`listing_id`),
  ADD CONSTRAINT `listing_tags_ibfk_2` FOREIGN KEY (`tag_id`) REFERENCES `tags` (`tag_id`);

--
-- Constraints for table `messages`
--
ALTER TABLE `messages`
  ADD CONSTRAINT `messages_ibfk_1` FOREIGN KEY (`sender_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `messages_ibfk_2` FOREIGN KEY (`receiver_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `messages_ibfk_3` FOREIGN KEY (`request_id`) REFERENCES `requests` (`request_id`),
  ADD CONSTRAINT `messages_ibfk_4` FOREIGN KEY (`listing_id`) REFERENCES `listings` (`listing_id`);

--
-- Constraints for table `ratings`
--
ALTER TABLE `ratings`
  ADD CONSTRAINT `ratings_ibfk_1` FOREIGN KEY (`request_id`) REFERENCES `requests` (`request_id`),
  ADD CONSTRAINT `ratings_ibfk_2` FOREIGN KEY (`rater_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `ratings_ibfk_3` FOREIGN KEY (`rated_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `requests`
--
ALTER TABLE `requests`
  ADD CONSTRAINT `requests_ibfk_1` FOREIGN KEY (`requester_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `requests_ibfk_2` FOREIGN KEY (`listing_id`) REFERENCES `listings` (`listing_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
