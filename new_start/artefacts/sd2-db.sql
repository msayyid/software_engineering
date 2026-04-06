-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: db:3306
-- Generation Time: Apr 06, 2026 at 09:29 AM
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
-- Database: `sd2-db`
--

-- --------------------------------------------------------

--
-- Table structure for table `Modules`
--

CREATE TABLE `Modules` (
  `code` varchar(10) NOT NULL,
  `name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Modules`
--

INSERT INTO `Modules` (`code`, `name`) VALUES
('CMP020C101', 'Software Development 1'),
('CMP020C102', 'Computer Systems'),
('CMP020C103', 'Mathematics for Computer Science'),
('CMP020C104', 'Software Development 2'),
('CMP020C105', 'Computing and Society'),
('CMP020C106', 'Databases'),
('PHY020C101', 'Physics Skills and Techniques'),
('PHY020C102', 'Mathematics for Physics'),
('PHY020C103', 'Computation for Physics'),
('PHY020C106', 'Introduction to Astrophysics');

-- --------------------------------------------------------

--
-- Table structure for table `Programmes`
--

CREATE TABLE `Programmes` (
  `id` varchar(8) NOT NULL,
  `name` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Programmes`
--

INSERT INTO `Programmes` (`id`, `name`) VALUES
('09UU0001', 'BSc Computer Science'),
('09UU0002', 'BEng Software Engineering'),
('09UU0003', 'BSc Physics');

-- --------------------------------------------------------

--
-- Table structure for table `Programme_Modules`
--

CREATE TABLE `Programme_Modules` (
  `programme` varchar(8) NOT NULL,
  `module` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Programme_Modules`
--

INSERT INTO `Programme_Modules` (`programme`, `module`) VALUES
('09UU0001', 'CMP020C101'),
('09UU0001', 'CMP020C102'),
('09UU0001', 'CMP020C103'),
('09UU0001', 'CMP020C104'),
('09UU0001', 'CMP020C105'),
('09UU0001', 'CMP020C106'),
('09UU0002', 'CMP020C101'),
('09UU0002', 'CMP020C102'),
('09UU0002', 'CMP020C103'),
('09UU0002', 'CMP020C104'),
('09UU0002', 'CMP020C105'),
('09UU0002', 'CMP020C106'),
('09UU0003', 'PHY020C101'),
('09UU0003', 'PHY020C102'),
('09UU0003', 'PHY020C103'),
('09UU0003', 'PHY020C106');

-- --------------------------------------------------------

--
-- Table structure for table `Students`
--

CREATE TABLE `Students` (
  `id` int NOT NULL,
  `name` varchar(50) NOT NULL,
  `note` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Students`
--

INSERT INTO `Students` (`id`, `name`, `note`) VALUES
(1, 'Kevin Chalmers', '43987u5098234758902347hsdafgsdohgapoiuhsdfu'),
(2, 'Lisa Haskel', '43y5927843509127305982dsfhfogjadsoifjhsadoiufvhjasdoipujfhopqiaju'),
(3, 'Arturo Araujo', 'changing notes again '),
(4, 'Sobhan Tehrani', 'fasdasd456789062347589234uytfasdhdgfiuasdhf98034750982qhdfsaiujhfgauifsdhgiou'),
(100, 'Oge Okonor', NULL),
(200, 'Kimia Aksir', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `Student_Programme`
--

CREATE TABLE `Student_Programme` (
  `id` int DEFAULT NULL,
  `programme` varchar(8) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Student_Programme`
--

INSERT INTO `Student_Programme` (`id`, `programme`) VALUES
(3, '09UU0003'),
(1, '09UU0003'),
(2, '09UU0003'),
(4, '09UU0001');

-- --------------------------------------------------------

--
-- Table structure for table `Users`
--

CREATE TABLE `Users` (
  `id` int NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Users`
--

INSERT INTO `Users` (`id`, `email`, `password`) VALUES
(1, 'kevin@kevin.com', '$2b$10$Ycw00m1afn7cSuZwMZzRtepv4jOY2DpS/ZhM4wmLjmLLf1tuZFqsW'),
(2, 'lisa@lisa.com', '$2b$10$p3LFy.bk0pZB03FQ4tPzxOMEvANKj.Ns8mgBVHiFQxaFIBEgbl2rW'),
(3, 'arturo@arturo.com', ''),
(4, 'Sobham@sobhan.com', ''),
(5, 'example@exmaple.com', '$2b$10$7MZqXh3LYMbqWLIXjR20J.byuARudW3P3r3freYShmToIQkbGDBOG');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Modules`
--
ALTER TABLE `Modules`
  ADD PRIMARY KEY (`code`);

--
-- Indexes for table `Programmes`
--
ALTER TABLE `Programmes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `Programme_Modules`
--
ALTER TABLE `Programme_Modules`
  ADD KEY `programme` (`programme`),
  ADD KEY `module` (`module`);

--
-- Indexes for table `Students`
--
ALTER TABLE `Students`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `Student_Programme`
--
ALTER TABLE `Student_Programme`
  ADD KEY `id` (`id`),
  ADD KEY `programme` (`programme`);

--
-- Indexes for table `Users`
--
ALTER TABLE `Users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Users`
--
ALTER TABLE `Users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `Programme_Modules`
--
ALTER TABLE `Programme_Modules`
  ADD CONSTRAINT `programme_modules_ibfk_1` FOREIGN KEY (`programme`) REFERENCES `Programmes` (`id`),
  ADD CONSTRAINT `programme_modules_ibfk_2` FOREIGN KEY (`module`) REFERENCES `Modules` (`code`);

--
-- Constraints for table `Student_Programme`
--
ALTER TABLE `Student_Programme`
  ADD CONSTRAINT `student_programme_ibfk_1` FOREIGN KEY (`id`) REFERENCES `Students` (`id`),
  ADD CONSTRAINT `student_programme_ibfk_2` FOREIGN KEY (`programme`) REFERENCES `Programmes` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
