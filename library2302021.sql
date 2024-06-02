-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Oct 02, 2023 at 02:24 PM
-- Server version: 5.7.31
-- PHP Version: 7.3.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `library2302021`
--

-- --------------------------------------------------------

--
-- Table structure for table `books`
--

DROP TABLE IF EXISTS `books`;
CREATE TABLE IF NOT EXISTS `books` (
  `book_id` int(11) NOT NULL AUTO_INCREMENT,
  `book_title` varchar(255) NOT NULL,
  `author` varchar(255) NOT NULL,
  `publication_year` varchar(255) DEFAULT NULL,
  `total_book` int(11) DEFAULT NULL,
  `ISBN` varchar(20) NOT NULL,
  PRIMARY KEY (`book_id`),
  UNIQUE KEY `ISBN` (`ISBN`)
) ENGINE=MyISAM AUTO_INCREMENT=33 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `books`
--

INSERT INTO `books` (`book_id`, `book_title`, `author`, `publication_year`, `total_book`, `ISBN`) VALUES
(1, 'Introduction to Electrical Engineering', 'John Smith', '2005', 20, '978-1234567891'),
(2, 'Mechanical Engineering Principles', 'Alice Johnson', '2010', 10, '978-1234567892'),
(3, 'Computer Science Essentials', 'David Johnson', '2018', 30, '978-1234567893'),
(4, 'Civil Engineering Fundamentals', 'Sarah Lee', '2015', 20, '978-1234567894'),
(5, 'Chemical Engineering Basics', 'Michael Brown', '2012', 15, '978-1234567895'),
(6, 'Data Structures and Algorithms', 'Emily Davis', '2019', 16, '978-1234567896'),
(7, 'Introduction to Robotics', 'William Smith', '2008', 17, '978-1234567897'),
(8, 'Software Development Principles', 'Olivia Johnson', '2020', 18, '978-1234567898'),
(9, 'Aeronautical Engineering Fundamentals', 'Daniel Wilson', '2003', 5, '978-1234567899'),
(10, 'Network Security', 'Sophia Martinez', '2017', 4, '978-1234567800'),
(11, 'Environmental Engineering', 'Ella Garcia', '2007', 3, '978-1234567801'),
(12, 'Biotechnology Advances', 'Liam Jackson', '2014', 50, '978-1234567802'),
(13, 'Artificial Intelligence in Healthcare', 'Mia Lopez', '2021', 40, '978-1234567803'),
(14, 'Renewable Energy Technologies', 'James Clark', '2016', 30, '978-1234567804'),
(15, 'Computer Networking', 'Emma Lewis', '2009', 20, '978-1234567805'),
(16, 'Materials Science and Engineering', 'Noah King', '2013', 20, '978-1234567806'),
(17, 'Electronics and Circuit Design', 'Ava Scott', '2006', 20, '978-1234567807'),
(18, 'Industrial Automation', 'Isabella Adams', '2010', 20, '978-1234567808'),
(19, 'Telecommunications Engineering', 'Liam Anderson', '2018', 20, '978-1234567809'),
(20, 'Introduction to Nanotechnology', 'Olivia Hall', '2004', 20, '978-1234567810'),
(21, 'Digital Signal Processing', 'Sophia Wright', '2011', 20, '978-1234567811'),
(22, 'Computer Graphics and Animation', 'William Walker', '2015', 20, '978-1234567812'),
(23, 'Green Building Design', 'Evelyn Green', '2017', 20, '978-1234567813'),
(24, 'Renewable Energy Systems', 'Daniel Taylor', '2019', 20, '978-1234567814'),
(25, 'Human-Computer Interaction', 'Liam Anderson', '2020', 20, '978-1234567815'),
(26, 'Electrical Power Systems', 'David Johnson', '2014', 20, '978-1234567816'),
(27, 'Machine Learning Algorithms', 'Sophia Martinez', '2016', 20, '978-1234567817'),
(28, 'Introduction to Quantum Computing', 'John Smith', '2022', 20, '978-1234567818'),
(29, 'Nanomaterials and Nanotechnology', 'Alice Johnson', '2013', 20, '978-1234567819'),
(30, 'Mathematics For Machience Learning', 'Satayndra Narayan Sarmah', '1995', 20, 'INBN1203485'),
(31, 'AI IN Time dialect', 'Xenque Hen', '2021', 2, 'ISBN123456'),
(32, 'Pythagorous Theoream', 'Rana Sheb Bnarji', '1985', 20, 'INS23485');

-- --------------------------------------------------------

--
-- Table structure for table `borrower`
--

DROP TABLE IF EXISTS `borrower`;
CREATE TABLE IF NOT EXISTS `borrower` (
  `userName` varchar(255) NOT NULL,
  `Email_id` varchar(255) DEFAULT NULL,
  `Phone_number` varchar(255) DEFAULT NULL,
  `book_id` varchar(255) NOT NULL,
  `issue_date` datetime DEFAULT NULL,
  `return_date` datetime DEFAULT NULL,
  PRIMARY KEY (`book_id`,`userName`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `borrower`
--

INSERT INTO `borrower` (`userName`, `Email_id`, `Phone_number`, `book_id`, `issue_date`, `return_date`) VALUES
('Hillol', 'rana@gmail.com', '22556255222', '1', '2023-10-02 10:44:36', '2023-10-02 10:58:33'),
('Hillol', 'rana@gmail.com', '22556255222', '2', '2023-10-02 10:47:32', '2023-10-02 10:52:45'),
('Hillol', 'rana@gmail.com', '22556255222', '3', '2023-10-02 10:54:26', '2023-10-02 10:54:29'),
('Hillol', 'rana@gmail.com', '22556255222', '4', '2023-10-02 11:03:03', '2023-10-02 11:03:15'),
('Hillol', 'rana@gmail.com', '22556255222', '5', '2023-10-02 11:03:55', '2023-10-02 11:04:09'),
('Hillol', 'rana@gmail.com', '22556255222', '6', '2023-10-02 11:54:16', NULL),
('Simanta Das', 'Email@gmail.com', '78952222222', '1', '2023-10-02 14:17:04', '2023-10-02 14:20:33'),
('Simanta Das', 'Email@gmail.com', '78952222222', '2', '2023-10-02 14:19:18', NULL),
('Udit Nath', 'udit@gmail.com', '1234567890', '1', '2023-10-02 19:36:49', '2023-10-02 19:36:58'),
('Udit Nath', 'udit@gmail.com', '1234567890', '2', '2023-10-02 19:37:08', NULL),
('Udit Nath', 'udit@gmail.com', '1234567890', '3', '2023-10-02 19:37:09', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `register`
--

DROP TABLE IF EXISTS `register`;
CREATE TABLE IF NOT EXISTS `register` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) DEFAULT NULL,
  `Password` varchar(255) DEFAULT NULL,
  `Email_id` varchar(255) DEFAULT NULL,
  `Phone_number` varchar(200) DEFAULT NULL,
  `Category` varchar(255) DEFAULT NULL,
  `Level` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `register`
--

INSERT INTO `register` (`id`, `username`, `Password`, `Email_id`, `Phone_number`, `Category`, `Level`) VALUES
(1, 'Partha Pratim Sarmah', '$2b$12$5WQjyKiCE8oKdYjHlRB2kuXHjrcwDK9fve9zJz48SaX1Mn/UbjSMG', 'sarmahpranab90@gmail.com', '8638312465', 'Admin', 'prof'),
(2, 'Simanta Das', '$2b$12$e0oJOhScoeHFk6EBaamaiOtiXsfkhhC1GrdSoBbIpqLRJ1SUES8Gi', 'Email@gmail.com', '78952222222', 'Student', 'phd'),
(3, 'Pranab Sarmah', '$2b$12$TKXgjfR2mSCDXwlW6NAAier6CGNv.Sv5cz/oCQhSvFbKFZR4sDnby', 'partha.pratim.srmah@gmail.com', '747474747474', 'Student', 'M.Tech CSE(3rd Sem)'),
(4, 'Hillol', '$2b$12$mRJdm1WoeF4AzEWeFd4E2OsSs.iK9cx.AxT7dE9huYLbAjdGAjgg.', 'rana@gmail.com', '22556255222', 'Student', 'M.Tech CSE(1st Sem)'),
(5, 'Udit Nath', '$2b$12$VQ2k6xvu7kZg6IQJ7fl2tOgDCQJ0et1NFnHsADV6Bi7HLctlKflQq', 'udit@gmail.com', '1234567890', 'Student', 'M.Tech CSE(1st Sem)');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
