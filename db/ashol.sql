-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Oct 22, 2022 at 07:10 PM
-- Server version: 10.4.25-MariaDB
-- PHP Version: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ashol`
--

-- --------------------------------------------------------

--
-- Table structure for table `area`
--

CREATE TABLE `area` (
  `area_name` varchar(100) NOT NULL,
  `region_name` varchar(100) DEFAULT NULL,
  `city_name` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `area`
--

INSERT INTO `area` (`area_name`, `region_name`, `city_name`) VALUES
('Azimpur', 'Dhaka', 'Dhaka-South'),
('Babupur', 'Noakhali', 'Senbag'),
('Badda', 'Dhaka', 'Dhaka-North'),
('Banashree', 'Dhaka', 'Dhaka-North'),
('Bashundhara', 'Dhaka', 'Dhaka-North'),
('Bozra', 'Noakhali', 'Hatia'),
('Chakbazar', 'Dhaka', 'Dhaka-South'),
('Chowmuhuni bazar', 'Noakhali', 'Chowmuhuni'),
('Dhanmondi', 'Dhaka', 'Dhaka-North'),
('Ekhlaspur', 'Noakhali', 'Maijdhee'),
('Farmgate', 'Dhaka', 'Dhaka-North'),
('Gazir Hat', 'Noakhali', 'Senbag'),
('Ghater Char', 'Noakhali', 'Hatia'),
('Gulshan', 'Dhaka', 'Dhaka-North'),
('Islampur', 'Dhaka', 'Dhaka-South'),
('Kabil Pur', 'Noakhali', 'Senbag'),
('Keraniganj', 'Dhaka', 'Dhaka-South'),
('Mirpur Darussalam', 'Dhaka', 'Dhaka-North'),
('Mirpur-2', 'Dhaka', 'Dhaka-North'),
('Panthapath', 'Dhaka', 'Dhaka-North'),
('Sadarghat', 'Dhaka', 'Dhaka-South'),
('Shamoli', 'Dhaka', 'Dhaka-North'),
('Tejgaon', 'Dhaka', 'Dhaka-North'),
('Uttara', 'Dhaka', 'Dhaka-North');

-- --------------------------------------------------------

--
-- Table structure for table `branch`
--

CREATE TABLE `branch` (
  `id` int(11) NOT NULL,
  `brand_id` int(11) NOT NULL,
  `location` varchar(255) NOT NULL,
  `area_name` varchar(100) NOT NULL,
  `region_name` varchar(100) NOT NULL,
  `city_name` varchar(100) NOT NULL,
  `phone` varchar(16) NOT NULL,
  `opening_hours` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `branch`
--

INSERT INTO `branch` (`id`, `brand_id`, `location`, `area_name`, `region_name`, `city_name`, `phone`, `opening_hours`) VALUES
(10101, 101, 'House 2, Gulshan Avenue ', 'Gulshan', 'Dhaka', 'Dhaka-South', '01812345678', '10 AM to 11 PM'),
(10102, 101, '97/1 , Nirala', 'Panthapath', 'Dhaka', 'Dhaka-North', '0154621347894', '10 AM to 8 PM'),
(10103, 101, 'Satmasjid Road', 'Dhanmondi', 'Dhaka', 'Dhaka-North', '01612345678', '10 AM to 10 PM'),
(10104, 101, 'Mirpur 11', 'Mirpur-2', 'Dhaka', 'Dhaka-North', '01546495465', '10 AM to 9 PM'),
(10105, 101, 'Dumuriya, 9/A', 'Gazir Hat', 'Noakhali', 'Senbag', '01892004917', '11 AM to 11 PM'),
(10201, 102, '12/A Jahanara Road', 'Mirpur-2', 'Dhaka', 'Dhaka-North', '0185467431', '9 AM to 11 PM'),
(10202, 102, 'Bangla College Road', 'Mirpur Darussalam', 'Dhaka', 'Dhaka-North', '0192453413', '9AM to 10PM'),
(10203, 102, 'Senbag Bazar', 'Babupur', 'Noakhali', 'Senbag', '01798211717', '10 AM to 10 PM'),
(10204, 102, 'Satmasjid Road', 'Dhanmondi', 'Dhaka', 'Dhaka-North', '01962075931', '10 AM to 11 PM'),
(10301, 103, '97/A, Nirala', 'Panthapath', 'Dhaka', 'Dhaka-North', '01745612398', '10 AM to 8 PM'),
(10302, 103, 'Azimpur Gorosthan', 'Azimpur', 'Dhaka', 'Dhaka-South', '01578945231', '10 AM to 10 PM'),
(10303, 103, 'Satmasjid Road', 'Dhanmondi', 'Dhaka', 'Dhaka-North', '01465236124', '10 AM to 10 PM'),
(10304, 103, 'Mirpur 11.5 ', 'Mirpur-2', 'Dhaka', 'Dhaka-North', '01432564789', '10 AM to 10 PM'),
(10401, 104, 'Mirpur 11/2', 'Mirpur-2', 'Dhaka', 'Dhaka-North', '01945678912', '10 AM to 10 PM'),
(10402, 104, 'Sangkar Road', 'Dhanmondi', 'Dhaka', 'Dhaka-North', '01548451265', '10 AM to 10 PM'),
(10403, 104, 'Nabisco', 'Tejgaon', 'Dhaka', 'Dhaka-North', '01892004917', '10 AM to 10 PM'),
(10404, 104, 'Gulshan Avenue ', 'Gulshan', 'Dhaka', 'Dhaka-South', '01564123548', '10 AM to 10 PM'),
(10501, 105, '74/6 Green Road', 'Panthapath', 'Dhaka', 'Dhaka-North', '01765596264', '8 AM to 10 PM'),
(10502, 105, 'Puran Dhaka', 'Azimpur', 'Dhaka', 'Dhaka-South', '01815461168', '8 AM TO 10 PM'),
(10503, 105, 'Nilkhet ', 'Azimpur', 'Dhaka', 'Dhaka-North', '01985485509', '10 AM to 9 PM'),
(10504, 105, 'Nil khet', 'Azimpur', 'Dhaka', 'Dhaka-South', '0198515148', '9 AM to 10 PM'),
(10601, 106, 'Infront of UCC', 'Farmgate', 'Dhaka', 'Dhaka-North', '01890224917', '10 AM to 10 PM'),
(10602, 106, 'Satmasjid Road', 'Dhanmondi', 'Dhaka', 'Dhaka-North', '01798211415', '10 AM to 10 PM'),
(10603, 106, 'Commerce College Road', 'Mirpur-2', 'Dhaka', 'Dhaka-North', '01465234789', '10 AM to 10 PM'),
(10604, 106, 'Nuruzzaman Sarak, 45/B', 'Azimpur', 'Dhaka', 'Dhaka-South', '01498524563', '10 AM to 10 PM'),
(10701, 107, 'Nizam Uddin Road 102/3', 'Azimpur', 'Dhaka', 'Dhaka-South', '01926616215', '9 AM to 10 PM'),
(10801, 108, 'Sankar Road', 'Dhanmondi', 'Dhaka', 'Dhaka-North', '01487562345', '10 AM to 10 PM'),
(10802, 108, 'Stadium Road, 45/A', 'Mirpur-2', 'Dhaka', 'Dhaka-North', '01745632185', '10 AM to 10 PM'),
(10804, 108, 'Abul Hasnat Road, 4/A', 'Azimpur', 'Dhaka', 'Dhaka-South', '01478965412', '10 AM to 10 PM'),
(10901, 109, 'Nazimuddin Road, 54/A', 'Azimpur', 'Dhaka', 'Dhaka-South', '04123654789', '10 AM to 10 PM'),
(10902, 109, 'Jigatola,98/G', 'Dhanmondi', 'Dhaka', 'Dhaka-North', '01478965412', '10 AM to 10 PM'),
(10903, 109, 'Samsuddin Road, Gulshan Avenue ', 'Gulshan', 'Dhaka', 'Dhaka-North', '01478965417', '10 AM to 10 PM'),
(10904, 109, 'S Ali tower, Sector 6/A.', 'Mirpur-2', 'Dhaka', 'Dhaka-North', '01745612387', '10 AM to 10 PM'),
(11001, 110, '78/ A  Haimchar Road', 'Azimpur', 'Dhaka', 'Dhaka-South', '01985485505', '10 AM to 10 PM');

-- --------------------------------------------------------

--
-- Table structure for table `brand`
--

CREATE TABLE `brand` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `logo` varchar(120) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `brand`
--

INSERT INTO `brand` (`id`, `name`, `logo`) VALUES
(101, 'KFC', 'kfc.jpeg'),
(102, 'Banoful & Co.', 'banoful.png'),
(103, 'BFC', 'bfc.png'),
(104, 'Bonolota', 'bonolota.png'),
(105, 'Well Food', 'wellfood.png'),
(106, 'Tasty Treat', 'tt.png'),
(107, 'Haji Biriyani', 'hajibiriyani.png'),
(108, 'Kacchi Vai', 'kv.png'),
(109, 'Sultans Dine', 'sd.png'),
(110, 'Nanna Biriyani', 'nb.png');

-- --------------------------------------------------------

--
-- Table structure for table `city`
--

CREATE TABLE `city` (
  `city_name` varchar(100) NOT NULL,
  `region_name` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `city`
--

INSERT INTO `city` (`city_name`, `region_name`) VALUES
('Dhaka-North', 'Dhaka'),
('Dhaka-South', 'Dhaka'),
('Chowmuhuni', 'Noakhali'),
('Hatia', 'Noakhali'),
('Maijdhee', 'Noakhali'),
('Senbag', 'Noakhali'),
('Subarna Char', 'Noakhali');

-- --------------------------------------------------------

--
-- Table structure for table `region`
--

CREATE TABLE `region` (
  `region_name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `region`
--

INSERT INTO `region` (`region_name`) VALUES
('Barishal'),
('Chattogram'),
('Dhaka'),
('Khulna'),
('Mymensingh'),
('Noakhali'),
('Rangpur'),
('Sylhet');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `area`
--
ALTER TABLE `area`
  ADD PRIMARY KEY (`area_name`),
  ADD KEY `region_name` (`region_name`),
  ADD KEY `city_name` (`city_name`);

--
-- Indexes for table `branch`
--
ALTER TABLE `branch`
  ADD PRIMARY KEY (`id`),
  ADD KEY `brand_id` (`brand_id`),
  ADD KEY `region_name` (`region_name`),
  ADD KEY `city_name` (`city_name`),
  ADD KEY `area_name` (`area_name`);

--
-- Indexes for table `brand`
--
ALTER TABLE `brand`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `city`
--
ALTER TABLE `city`
  ADD PRIMARY KEY (`city_name`),
  ADD KEY `region_name` (`region_name`);

--
-- Indexes for table `region`
--
ALTER TABLE `region`
  ADD PRIMARY KEY (`region_name`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `branch`
--
ALTER TABLE `branch`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11004;

--
-- AUTO_INCREMENT for table `brand`
--
ALTER TABLE `brand`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=111;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `area`
--
ALTER TABLE `area`
  ADD CONSTRAINT `area_ibfk_1` FOREIGN KEY (`region_name`) REFERENCES `region` (`region_name`),
  ADD CONSTRAINT `area_ibfk_2` FOREIGN KEY (`city_name`) REFERENCES `city` (`city_name`);

--
-- Constraints for table `branch`
--
ALTER TABLE `branch`
  ADD CONSTRAINT `branch_ibfk_1` FOREIGN KEY (`brand_id`) REFERENCES `brand` (`id`),
  ADD CONSTRAINT `branch_ibfk_2` FOREIGN KEY (`region_name`) REFERENCES `region` (`region_name`),
  ADD CONSTRAINT `branch_ibfk_3` FOREIGN KEY (`city_name`) REFERENCES `city` (`city_name`),
  ADD CONSTRAINT `branch_ibfk_4` FOREIGN KEY (`area_name`) REFERENCES `area` (`area_name`);

--
-- Constraints for table `city`
--
ALTER TABLE `city`
  ADD CONSTRAINT `city_ibfk_1` FOREIGN KEY (`region_name`) REFERENCES `region` (`region_name`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
