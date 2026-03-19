-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: db
-- Generation Time: Mar 19, 2026 at 12:29 AM
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
(1, 'Books', NULL, NULL, 0),
(2, 'Electronics', NULL, NULL, 0),
(3, 'Kitchen', NULL, NULL, 0),
(4, 'Sports', NULL, NULL, 0),
(5, 'Furniture', NULL, NULL, 0);

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
(1, 1, 1, 'Python Programming Book', 'Good for beginners', 'lending', 'good', NULL, NULL, NULL, NULL, NULL, 1, 0, 0, '2026-03-19 00:26:42', '2026-03-19 00:26:42'),
(2, 2, 2, 'MacBook Charger', 'Works perfectly', 'giveaway', 'good', NULL, NULL, NULL, NULL, NULL, 1, 0, 0, '2026-03-19 00:26:42', '2026-03-19 00:26:42'),
(3, 3, 3, 'Rice Cooker', 'Small size', 'lending', 'fair', NULL, NULL, NULL, NULL, NULL, 1, 0, 0, '2026-03-19 00:26:42', '2026-03-19 00:26:42'),
(4, 4, 4, 'Yoga Mat', 'Barely used', 'swap', 'like_new', NULL, NULL, NULL, NULL, NULL, 1, 0, 0, '2026-03-19 00:26:42', '2026-03-19 00:26:42'),
(5, 5, 5, 'Desk Chair', 'Used but comfy', 'giveaway', 'well_used', NULL, NULL, NULL, NULL, NULL, 1, 0, 0, '2026-03-19 00:26:42', '2026-03-19 00:26:42'),
(6, 6, 1, 'Algorithms Book', 'Helpful for exams', 'lending', 'good', NULL, NULL, NULL, NULL, NULL, 1, 0, 0, '2026-03-19 00:26:42', '2026-03-19 00:26:42'),
(7, 7, 2, 'Bluetooth Speaker', 'Loud and clear', 'swap', 'good', NULL, NULL, NULL, NULL, NULL, 1, 0, 0, '2026-03-19 00:26:42', '2026-03-19 00:26:42'),
(8, 8, 3, 'Toaster', 'Works fine', 'giveaway', 'fair', NULL, NULL, NULL, NULL, NULL, 1, 0, 0, '2026-03-19 00:26:42', '2026-03-19 00:26:42'),
(9, 9, 4, 'Football', 'Almost new', 'lending', 'like_new', NULL, NULL, NULL, NULL, NULL, 1, 0, 0, '2026-03-19 00:26:42', '2026-03-19 00:26:42'),
(10, 10, 5, 'Study Desk', 'Moving out', 'giveaway', 'good', NULL, NULL, NULL, NULL, NULL, 1, 0, 0, '2026-03-19 00:26:42', '2026-03-19 00:26:42'),
(11, 11, 1, 'Database Systems Book', 'Second year module', 'lending', 'good', NULL, NULL, NULL, NULL, NULL, 1, 0, 0, '2026-03-19 00:26:42', '2026-03-19 00:26:42'),
(12, 12, 2, 'Wireless Mouse', 'Smooth and fast', 'giveaway', 'like_new', NULL, NULL, NULL, NULL, NULL, 1, 0, 0, '2026-03-19 00:26:42', '2026-03-19 00:26:42'),
(13, 13, 3, 'Air Fryer', 'Great condition', 'swap', 'good', NULL, NULL, NULL, NULL, NULL, 1, 0, 0, '2026-03-19 00:26:42', '2026-03-19 00:26:42'),
(14, 14, 4, 'Dumbbells Set', '5kg each', 'lending', 'good', NULL, NULL, NULL, NULL, NULL, 1, 0, 0, '2026-03-19 00:26:42', '2026-03-19 00:26:42'),
(15, 15, 5, 'Lamp', 'Desk lamp', 'giveaway', 'good', NULL, NULL, NULL, NULL, NULL, 1, 0, 0, '2026-03-19 00:26:42', '2026-03-19 00:26:42');

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
(3, 1),
(6, 1),
(11, 1),
(14, 1),
(2, 2),
(5, 2),
(8, 2),
(10, 2),
(15, 2),
(1, 3),
(9, 3),
(12, 3),
(4, 5),
(7, 5),
(13, 5);

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
(1, 2, 1, 1, NULL, 'Hi, is this available?', 0, '2026-03-19 00:27:17'),
(2, 1, 2, 1, NULL, 'Yes, it is', 0, '2026-03-19 00:27:17'),
(3, 3, 2, 2, NULL, 'Can I pick it up today?', 0, '2026-03-19 00:27:17'),
(4, 4, 3, 3, NULL, 'Thanks for the cooker', 0, '2026-03-19 00:27:17'),
(5, 5, 4, 4, NULL, 'Still interested?', 0, '2026-03-19 00:27:17'),
(6, 6, 5, 5, NULL, 'Can I collect tonight?', 0, '2026-03-19 00:27:17'),
(7, 7, 6, 6, NULL, 'Need it urgently', 0, '2026-03-19 00:27:17'),
(8, 8, 7, 7, NULL, 'Is it loud?', 0, '2026-03-19 00:27:17'),
(9, 9, 8, 8, NULL, 'I will come later', 0, '2026-03-19 00:27:17'),
(10, 10, 9, 9, NULL, 'Is it still available?', 0, '2026-03-19 00:27:17');

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `ratings`
--

INSERT INTO `ratings` (`rating_id`, `request_id`, `rater_id`, `rated_id`, `score`, `comment`, `rating_type`, `created_at`) VALUES
(1, 3, 4, 3, 5, NULL, 'as_borrower', '2026-03-19 00:27:24'),
(2, 5, 6, 5, 4, NULL, 'as_giver', '2026-03-19 00:27:24'),
(3, 8, 9, 8, 5, NULL, 'as_receiver', '2026-03-19 00:27:24'),
(4, 10, 11, 10, 4, NULL, 'as_giver', '2026-03-19 00:27:24');

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
(1, 2, 1, 'pending', 'Can I borrow this for revision?', NULL, NULL, '2026-03-19 00:27:05', NULL, NULL, NULL),
(2, 3, 2, 'accepted', 'Is charger still available?', NULL, NULL, '2026-03-19 00:27:05', NULL, NULL, NULL),
(3, 4, 3, 'completed', 'Need it for cooking', NULL, NULL, '2026-03-19 00:27:05', NULL, NULL, NULL),
(4, 5, 4, 'pending', 'Can swap with skipping rope', NULL, NULL, '2026-03-19 00:27:05', NULL, NULL, NULL),
(5, 6, 5, 'completed', 'Need chair urgently', NULL, NULL, '2026-03-19 00:27:05', NULL, NULL, NULL),
(6, 7, 6, 'pending', 'Can I take this for a week?', NULL, NULL, '2026-03-19 00:27:05', NULL, NULL, NULL),
(7, 8, 7, 'accepted', 'Interested in speaker', NULL, NULL, '2026-03-19 00:27:05', NULL, NULL, NULL),
(8, 9, 8, 'completed', 'Can collect today', NULL, NULL, '2026-03-19 00:27:05', NULL, NULL, NULL),
(9, 10, 9, 'pending', 'Need football for match', NULL, NULL, '2026-03-19 00:27:05', NULL, NULL, NULL),
(10, 11, 10, 'completed', 'Desk still available?', NULL, NULL, '2026-03-19 00:27:05', NULL, NULL, NULL);

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
(1, 'student', 0),
(2, 'cheap', 0),
(3, 'like-new', 0),
(4, 'urgent', 0),
(5, 'exchange', 0);

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
(1, 'alex.turner@roehampton.ac.uk', 'h1', 'Alex', 'Turner', NULL, 'Roehampton, London', NULL, NULL, 'default-avatar.png', 50, 0.00, 0, 0, 0, 0, 1, '2026-03-19 00:25:51', '2026-03-19 00:25:51'),
(2, 'sarah.khan@roehampton.ac.uk', 'h2', 'Sarah', 'Khan', NULL, 'Putney, London', NULL, NULL, 'default-avatar.png', 50, 0.00, 0, 0, 0, 0, 1, '2026-03-19 00:25:51', '2026-03-19 00:25:51'),
(3, 'james.wilson@roehampton.ac.uk', 'h3', 'James', 'Wilson', NULL, 'Wandsworth, London', NULL, NULL, 'default-avatar.png', 50, 0.00, 0, 0, 0, 0, 1, '2026-03-19 00:25:51', '2026-03-19 00:25:51'),
(4, 'emma.clarke@roehampton.ac.uk', 'h4', 'Emma', 'Clarke', NULL, 'Barnes, London', NULL, NULL, 'default-avatar.png', 50, 0.00, 0, 0, 0, 0, 1, '2026-03-19 00:25:51', '2026-03-19 00:25:51'),
(5, 'daniel.lee@roehampton.ac.uk', 'h5', 'Daniel', 'Lee', NULL, 'Fulham, London', NULL, NULL, 'default-avatar.png', 50, 0.00, 0, 0, 0, 0, 1, '2026-03-19 00:25:51', '2026-03-19 00:25:51'),
(6, 'olivia.brown@roehampton.ac.uk', 'h6', 'Olivia', 'Brown', NULL, 'Clapham, London', NULL, NULL, 'default-avatar.png', 50, 0.00, 0, 0, 0, 0, 1, '2026-03-19 00:25:51', '2026-03-19 00:25:51'),
(7, 'noah.davis@roehampton.ac.uk', 'h7', 'Noah', 'Davis', NULL, 'Tooting, London', NULL, NULL, 'default-avatar.png', 50, 0.00, 0, 0, 0, 0, 1, '2026-03-19 00:25:51', '2026-03-19 00:25:51'),
(8, 'mia.evans@roehampton.ac.uk', 'h8', 'Mia', 'Evans', NULL, 'Richmond, London', NULL, NULL, 'default-avatar.png', 50, 0.00, 0, 0, 0, 0, 1, '2026-03-19 00:25:51', '2026-03-19 00:25:51'),
(9, 'liam.taylor@roehampton.ac.uk', 'h9', 'Liam', 'Taylor', NULL, 'Kingston, London', NULL, NULL, 'default-avatar.png', 50, 0.00, 0, 0, 0, 0, 1, '2026-03-19 00:25:51', '2026-03-19 00:25:51'),
(10, 'ava.moore@roehampton.ac.uk', 'h10', 'Ava', 'Moore', NULL, 'Hammersmith, London', NULL, NULL, 'default-avatar.png', 50, 0.00, 0, 0, 0, 0, 1, '2026-03-19 00:25:51', '2026-03-19 00:25:51'),
(11, 'ethan.white@roehampton.ac.uk', 'h11', 'Ethan', 'White', NULL, 'Chelsea, London', NULL, NULL, 'default-avatar.png', 50, 0.00, 0, 0, 0, 0, 1, '2026-03-19 00:25:51', '2026-03-19 00:25:51'),
(12, 'sophia.martin@roehampton.ac.uk', 'h12', 'Sophia', 'Martin', NULL, 'Putney, London', NULL, NULL, 'default-avatar.png', 50, 0.00, 0, 0, 0, 0, 1, '2026-03-19 00:25:51', '2026-03-19 00:25:51'),
(13, 'lucas.hall@roehampton.ac.uk', 'h13', 'Lucas', 'Hall', NULL, 'Wimbledon, London', NULL, NULL, 'default-avatar.png', 50, 0.00, 0, 0, 0, 0, 1, '2026-03-19 00:25:51', '2026-03-19 00:25:51'),
(14, 'amelia.young@roehampton.ac.uk', 'h14', 'Amelia', 'Young', NULL, 'Battersea, London', NULL, NULL, 'default-avatar.png', 50, 0.00, 0, 0, 0, 0, 1, '2026-03-19 00:25:51', '2026-03-19 00:25:51'),
(15, 'harry.king@roehampton.ac.uk', 'h15', 'Harry', 'King', NULL, 'Southfields, London', NULL, NULL, 'default-avatar.png', 50, 0.00, 0, 0, 0, 0, 1, '2026-03-19 00:25:51', '2026-03-19 00:25:51');

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
  MODIFY `message_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `ratings`
--
ALTER TABLE `ratings`
  MODIFY `rating_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `requests`
--
ALTER TABLE `requests`
  MODIFY `request_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `tags`
--
ALTER TABLE `tags`
  MODIFY `tag_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

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
