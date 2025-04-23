-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th1 13, 2025 lúc 03:16 PM
-- Phiên bản máy phục vụ: 10.4.28-MariaDB
-- Phiên bản PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `thietbididong`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `addresses`
--

CREATE TABLE `addresses` (
  `id` int(11) NOT NULL,
  `userID` int(11) NOT NULL,
  `receiver` varchar(256) DEFAULT NULL,
  `phone` varchar(256) DEFAULT NULL,
  `street` varchar(256) NOT NULL,
  `village` varchar(256) NOT NULL,
  `district` varchar(256) NOT NULL,
  `province` varchar(256) NOT NULL,
  `updateTime` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `addresses`
--

INSERT INTO `addresses` (`id`, `userID`, `receiver`, `phone`, `street`, `village`, `district`, `province`, `updateTime`) VALUES
(5, 1, 'Hung Dong Nguyen', '113', '510 quốc lộ 13', 'Hiệp Bình Chánh', 'Thủ Đức', 'Hồ Chí Minh', '2025-01-09 05:19:26'),
(21, 5, 'Nhatg drth', '23842167412', 'fq34tgq3t', 'Bình Trưng Tây', 'Thủ Đức', 'Hồ Chí Minh', '2024-12-20 09:20:46'),
(22, 1, 'Nhi', '412353245', '14 đường số 2', 'Bình Trưng Tây', 'Thủ Đức', 'Hồ Chí Minh', '2025-01-09 05:04:50');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `branches`
--

CREATE TABLE `branches` (
  `id` int(11) NOT NULL,
  `name` varchar(256) NOT NULL,
  `addressID` int(11) NOT NULL,
  `avai` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `brands`
--

CREATE TABLE `brands` (
  `id` int(11) NOT NULL,
  `name` varchar(256) NOT NULL,
  `country` varchar(256) NOT NULL,
  `cateIDs` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`cateIDs`)),
  `avai` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `brands`
--

INSERT INTO `brands` (`id`, `name`, `country`, `cateIDs`, `avai`) VALUES
(1, 'Samsung', 'Hàn Quốc', '[1,2]', 1),
(2, 'Apple', 'Mỹ', '[1,2,3]', 1),
(3, 'Oppo', 'Trung Quốc', '[1,2]', 1),
(4, 'Xiaomi', 'Trung Quốc', '[1,2]', 1),
(5, 'Realme', 'Trung Quốc', '[1,2]', 1);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `carts`
--

CREATE TABLE `carts` (
  `id` int(11) NOT NULL,
  `userID` int(11) NOT NULL,
  `productDetailID` int(11) NOT NULL,
  `qty` int(11) NOT NULL,
  `updateTime` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `name` varchar(256) NOT NULL,
  `avai` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `categories`
--

INSERT INTO `categories` (`id`, `name`, `avai`) VALUES
(1, 'smartphone', 1),
(2, 'tablet', 2),
(3, 'laptop', 3);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `comments`
--

CREATE TABLE `comments` (
  `id` int(11) NOT NULL,
  `objectID` int(11) NOT NULL,
  `content` text NOT NULL,
  `star` int(11) NOT NULL,
  `userID` int(11) NOT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `avai` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `comments`
--

INSERT INTO `comments` (`id`, `objectID`, `content`, `star`, `userID`, `time`, `avai`) VALUES
(9, 52, 'Thiết kế tuyệt vời, sài bền', 5, 1, '2024-10-24 07:04:19', 1),
(10, 52, 'Giá hợp lý', 4, 2, '2024-10-24 07:04:39', 1);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `crosssells`
--

CREATE TABLE `crosssells` (
  `id` int(11) NOT NULL,
  `productID` int(11) NOT NULL,
  `otherID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `crosssells`
--

INSERT INTO `crosssells` (`id`, `productID`, `otherID`) VALUES
(2, 53, 54),
(3, 53, 56),
(4, 53, 57),
(5, 53, 59),
(6, 53, 60),
(7, 54, 53),
(8, 54, 56),
(9, 54, 57),
(10, 54, 59),
(11, 54, 60);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `images`
--

CREATE TABLE `images` (
  `id` int(11) NOT NULL,
  `title` varchar(256) DEFAULT NULL,
  `url` varchar(256) DEFAULT NULL,
  `parentID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `images`
--

INSERT INTO `images` (`id`, `title`, `url`, `parentID`) VALUES
(14, 'iphone11 black', 'iphone-11-den-5-1-750x500.jpg', 52),
(15, 'iphone11', 'iphone-11-up-4-new-1933x982.jpg', 52),
(16, 'iphone11', 'vi-vn-iphone-11-up-11.jpeg', 52),
(17, 'iphone11', 'vi-vn-iphone-11-up-3.jpeg', 52),
(18, 'iphone12 xanh lá', 'iphone-12-xanh-la-12-750x500.jpg', 53),
(19, 'iphone12', 'iphone-12-up-3-new-1933x982.jpg', 53),
(20, 'iphone12 xanh lá', 'iphone-12-xanh-la-4-750x500.jpg', 53),
(21, 'iphone12', 'vi-vn-iphone-12-up-2.jpeg', 53),
(22, 'title', 'iphone-13-xanh-glr-4-750x500.jpg', 55),
(23, 'title', 'iphone-13-xanh-glr-5-750x500.jpg', 55),
(24, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-2.jpeg', 55),
(25, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-4.jpeg', 55),
(26, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-5.jpeg', 55),
(27, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-6.jpeg', 55),
(28, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-8.jpeg', 55),
(29, 'title', 'iphone-13-xanh-glr-4-750x500.jpg', 56),
(30, 'title', 'iphone-13-xanh-glr-5-750x500.jpg', 56),
(31, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-2.jpeg', 56),
(32, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-4.jpeg', 56),
(33, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-5.jpeg', 56),
(34, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-6.jpeg', 56),
(35, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-8.jpeg', 56),
(36, 'title', 'iphone-13-xanh-glr-4-750x500.jpg', 57),
(37, 'title', 'iphone-13-xanh-glr-5-750x500.jpg', 57),
(38, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-2.jpeg', 57),
(39, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-4.jpeg', 57),
(40, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-5.jpeg', 57),
(41, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-6.jpeg', 57),
(42, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-8.jpeg', 57),
(43, 'title', 'iphone-13-xanh-glr-4-750x500.jpg', 58),
(44, 'title', 'iphone-13-xanh-glr-5-750x500.jpg', 58),
(45, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-2.jpeg', 58),
(46, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-4.jpeg', 58),
(47, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-5.jpeg', 58),
(48, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-6.jpeg', 58),
(49, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-8.jpeg', 58),
(50, 'title', 'iphone-13-xanh-glr-4-750x500.jpg', 59),
(51, 'title', 'iphone-13-xanh-glr-5-750x500.jpg', 59),
(52, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-2.jpeg', 59),
(53, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-4.jpeg', 59),
(54, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-5.jpeg', 59),
(55, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-6.jpeg', 59),
(56, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-8.jpeg', 59),
(57, 'title', 'iphone-13-xanh-glr-4-750x500.jpg', 60),
(58, 'title', 'iphone-13-xanh-glr-5-750x500.jpg', 60),
(59, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-2.jpeg', 60),
(60, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-4.jpeg', 60),
(61, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-5.jpeg', 60),
(62, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-6.jpeg', 60),
(63, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-8.jpeg', 60),
(64, 'title', 'iphone-13-xanh-glr-4-750x500.jpg', 61),
(65, 'title', 'iphone-13-xanh-glr-5-750x500.jpg', 61),
(66, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-2.jpeg', 61),
(67, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-4.jpeg', 61),
(68, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-5.jpeg', 61),
(69, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-6.jpeg', 61),
(70, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-8.jpeg', 61),
(71, 'title', 'iphone-13-xanh-glr-4-750x500.jpg', 62),
(72, 'title', 'iphone-13-xanh-glr-5-750x500.jpg', 62),
(73, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-2.jpeg', 62),
(74, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-4.jpeg', 62),
(75, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-5.jpeg', 62),
(76, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-6.jpeg', 62),
(77, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-8.jpeg', 62),
(78, 'title', 'iphone-13-xanh-glr-4-750x500.jpg', 63),
(79, 'title', 'iphone-13-xanh-glr-5-750x500.jpg', 63),
(80, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-2.jpeg', 63),
(81, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-4.jpeg', 63),
(82, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-5.jpeg', 63),
(83, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-6.jpeg', 63),
(84, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-8.jpeg', 63),
(85, 'title', 'iphone-13-xanh-glr-4-750x500.jpg', 64),
(86, 'title', 'iphone-13-xanh-glr-5-750x500.jpg', 64),
(87, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-2.jpeg', 64),
(88, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-4.jpeg', 64),
(89, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-5.jpeg', 64),
(90, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-6.jpeg', 64),
(91, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-8.jpeg', 64),
(92, 'title', 'iphone-13-xanh-glr-4-750x500.jpg', 65),
(93, 'title', 'iphone-13-xanh-glr-5-750x500.jpg', 65),
(94, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-2.jpeg', 65),
(95, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-4.jpeg', 65),
(96, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-5.jpeg', 65),
(97, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-6.jpeg', 65),
(98, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-8.jpeg', 65),
(99, 'title', 'iphone-13-xanh-glr-4-750x500.jpg', 66),
(100, 'title', 'iphone-13-xanh-glr-5-750x500.jpg', 66),
(101, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-2.jpeg', 66),
(102, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-4.jpeg', 66),
(103, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-5.jpeg', 66),
(104, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-6.jpeg', 66),
(105, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-8.jpeg', 66),
(106, 'title', 'iphone-13-xanh-glr-4-750x500.jpg', 67),
(107, 'title', 'iphone-13-xanh-glr-5-750x500.jpg', 67),
(108, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-2.jpeg', 67),
(109, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-4.jpeg', 67),
(110, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-5.jpeg', 67),
(111, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-6.jpeg', 67),
(112, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-8.jpeg', 67),
(113, 'title', 'iphone-13-xanh-glr-4-750x500.jpg', 68),
(114, 'title', 'iphone-13-xanh-glr-5-750x500.jpg', 68),
(115, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-2.jpeg', 68),
(116, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-4.jpeg', 68),
(117, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-5.jpeg', 68),
(118, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-6.jpeg', 68),
(119, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-8.jpeg', 68),
(127, 'title', 'iphone-13-xanh-glr-4-750x500.jpg', 70),
(128, 'title', 'iphone-13-xanh-glr-5-750x500.jpg', 70),
(129, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-2.jpeg', 70),
(130, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-4.jpeg', 70),
(131, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-5.jpeg', 70),
(132, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-6.jpeg', 70),
(133, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-8.jpeg', 70),
(134, 'title', 'iphone-13-xanh-glr-4-750x500.jpg', 71),
(135, 'title', 'iphone-13-xanh-glr-5-750x500.jpg', 71),
(136, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-2.jpeg', 71),
(137, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-4.jpeg', 71),
(138, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-5.jpeg', 71),
(139, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-6.jpeg', 71),
(140, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-8.jpeg', 71),
(141, 'title', 'iphone-13-xanh-glr-4-750x500.jpg', 72),
(142, 'title', 'iphone-13-xanh-glr-5-750x500.jpg', 72),
(143, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-2.jpeg', 72),
(144, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-4.jpeg', 72),
(145, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-5.jpeg', 72),
(146, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-6.jpeg', 72),
(147, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-8.jpeg', 72),
(148, 'title', 'iphone-13-xanh-glr-4-750x500.jpg', 73),
(149, 'title', 'iphone-13-xanh-glr-5-750x500.jpg', 73),
(150, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-2.jpeg', 73),
(151, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-4.jpeg', 73),
(152, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-5.jpeg', 73),
(153, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-6.jpeg', 73),
(154, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-8.jpeg', 73),
(155, 'title', 'iphone-13-xanh-glr-4-750x500.jpg', 74),
(156, 'title', 'iphone-13-xanh-glr-5-750x500.jpg', 74),
(157, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-2.jpeg', 74),
(158, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-4.jpeg', 74),
(159, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-5.jpeg', 74),
(160, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-6.jpeg', 74),
(161, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-8.jpeg', 74),
(162, 'title', 'iphone-13-xanh-glr-4-750x500.jpg', 75),
(163, 'title', 'iphone-13-xanh-glr-5-750x500.jpg', 75),
(164, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-2.jpeg', 75),
(165, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-4.jpeg', 75),
(166, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-5.jpeg', 75),
(167, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-6.jpeg', 75),
(168, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-8.jpeg', 75),
(169, 'title', 'iphone-13-xanh-glr-4-750x500.jpg', 76),
(170, 'title', 'iphone-13-xanh-glr-5-750x500.jpg', 76),
(171, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-2.jpeg', 76),
(172, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-4.jpeg', 76),
(173, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-5.jpeg', 76),
(174, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-6.jpeg', 76),
(175, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-8.jpeg', 76),
(176, 'title', 'iphone-13-xanh-glr-4-750x500.jpg', 77),
(177, 'title', 'iphone-13-xanh-glr-5-750x500.jpg', 77),
(178, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-2.jpeg', 77),
(179, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-4.jpeg', 77),
(180, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-5.jpeg', 77),
(181, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-6.jpeg', 77),
(182, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-8.jpeg', 77),
(183, 'title', 'iphone-13-xanh-glr-4-750x500.jpg', 78),
(184, 'title', 'iphone-13-xanh-glr-5-750x500.jpg', 78),
(185, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-2.jpeg', 78),
(186, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-4.jpeg', 78),
(187, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-5.jpeg', 78),
(188, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-6.jpeg', 78),
(189, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-8.jpeg', 78),
(197, 'title', 'iphone-13-xanh-glr-4-750x500.jpg', 80),
(198, 'title', 'iphone-13-xanh-glr-5-750x500.jpg', 80),
(199, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-2.jpeg', 80),
(200, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-4.jpeg', 80),
(201, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-5.jpeg', 80),
(202, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-6.jpeg', 80),
(203, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-8.jpeg', 80),
(204, 'title', 'iphone-13-xanh-glr-4-750x500.jpg', 81),
(205, 'title', 'iphone-13-xanh-glr-5-750x500.jpg', 81),
(206, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-2.jpeg', 81),
(207, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-4.jpeg', 81),
(208, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-5.jpeg', 81),
(209, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-6.jpeg', 81),
(210, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-8.jpeg', 81),
(211, 'title', 'iphone-13-xanh-glr-4-750x500.jpg', 82),
(212, 'title', 'iphone-13-xanh-glr-5-750x500.jpg', 82),
(213, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-2.jpeg', 82),
(214, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-4.jpeg', 82),
(215, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-5.jpeg', 82),
(216, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-6.jpeg', 82),
(217, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-8.jpeg', 82),
(218, 'title', 'iphone-13-xanh-glr-4-750x500.jpg', 83),
(219, 'title', 'iphone-13-xanh-glr-5-750x500.jpg', 83),
(220, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-2.jpeg', 83),
(221, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-4.jpeg', 83),
(222, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-5.jpeg', 83),
(223, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-6.jpeg', 83),
(224, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-8.jpeg', 83),
(225, 'title', 'iphone-13-xanh-glr-4-750x500.jpg', 84),
(226, 'title', 'iphone-13-xanh-glr-5-750x500.jpg', 84),
(227, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-2.jpeg', 84),
(228, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-4.jpeg', 84),
(229, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-5.jpeg', 84),
(230, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-6.jpeg', 84),
(231, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-8.jpeg', 84),
(232, 'title', 'iphone-13-xanh-glr-4-750x500.jpg', 85),
(233, 'title', 'iphone-13-xanh-glr-5-750x500.jpg', 85),
(234, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-2.jpeg', 85),
(235, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-4.jpeg', 85),
(236, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-5.jpeg', 85),
(237, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-6.jpeg', 85),
(238, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-8.jpeg', 85),
(239, 'title', 'iphone-13-xanh-glr-4-750x500.jpg', 86),
(240, 'title', 'iphone-13-xanh-glr-5-750x500.jpg', 86),
(241, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-2.jpeg', 86),
(242, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-4.jpeg', 86),
(243, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-5.jpeg', 86),
(244, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-6.jpeg', 86),
(245, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-8.jpeg', 86),
(246, 'title', 'iphone-13-xanh-glr-4-750x500.jpg', 87),
(247, 'title', 'iphone-13-xanh-glr-5-750x500.jpg', 87),
(248, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-2.jpeg', 87),
(249, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-4.jpeg', 87),
(250, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-5.jpeg', 87),
(251, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-6.jpeg', 87),
(252, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-8.jpeg', 87),
(253, 'title', 'iphone-13-xanh-glr-4-750x500.jpg', 88),
(254, 'title', 'iphone-13-xanh-glr-5-750x500.jpg', 88),
(255, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-2.jpeg', 88),
(256, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-4.jpeg', 88),
(257, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-5.jpeg', 88),
(258, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-6.jpeg', 88),
(259, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-8.jpeg', 88),
(260, 'title', 'iphone-13-xanh-glr-4-750x500.jpg', 89),
(261, 'title', 'iphone-13-xanh-glr-5-750x500.jpg', 89),
(262, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-2.jpeg', 89),
(263, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-4.jpeg', 89),
(264, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-5.jpeg', 89),
(265, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-6.jpeg', 89),
(266, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-8.jpeg', 89),
(267, 'title', 'iphone-13-xanh-glr-4-750x500.jpg', 90),
(268, 'title', 'iphone-13-xanh-glr-5-750x500.jpg', 90),
(269, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-2.jpeg', 90),
(270, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-4.jpeg', 90),
(271, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-5.jpeg', 90),
(272, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-6.jpeg', 90),
(273, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-8.jpeg', 90),
(274, 'title', 'iphone-13-xanh-glr-4-750x500.jpg', 91),
(275, 'title', 'iphone-13-xanh-glr-5-750x500.jpg', 91),
(276, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-2.jpeg', 91),
(277, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-4.jpeg', 91),
(278, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-5.jpeg', 91),
(279, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-6.jpeg', 91),
(280, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-8.jpeg', 91),
(281, 'title', 'iphone-13-xanh-glr-4-750x500.jpg', 92),
(282, 'title', 'iphone-13-xanh-glr-5-750x500.jpg', 92),
(283, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-2.jpeg', 92),
(284, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-4.jpeg', 92),
(285, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-5.jpeg', 92),
(286, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-6.jpeg', 92),
(287, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-8.jpeg', 92),
(288, 'title', 'iphone-13-xanh-glr-4-750x500.jpg', 93),
(289, 'title', 'iphone-13-xanh-glr-5-750x500.jpg', 93),
(290, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-2.jpeg', 93),
(291, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-4.jpeg', 93),
(292, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-5.jpeg', 93),
(293, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-6.jpeg', 93),
(294, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-8.jpeg', 93),
(295, 'title', 'iphone-13-xanh-glr-4-750x500.jpg', 94),
(296, 'title', 'iphone-13-xanh-glr-5-750x500.jpg', 94),
(297, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-2.jpeg', 94),
(298, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-4.jpeg', 94),
(299, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-5.jpeg', 94),
(300, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-6.jpeg', 94),
(301, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-8.jpeg', 94),
(302, 'title', 'iphone-13-xanh-glr-4-750x500.jpg', 95),
(303, 'title', 'iphone-13-xanh-glr-5-750x500.jpg', 95),
(304, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-2.jpeg', 95),
(305, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-4.jpeg', 95),
(306, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-5.jpeg', 95),
(307, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-6.jpeg', 95),
(308, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-8.jpeg', 95),
(309, 'title', 'iphone-13-xanh-glr-4-750x500.jpg', 96),
(310, 'title', 'iphone-13-xanh-glr-5-750x500.jpg', 96),
(311, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-2.jpeg', 96),
(312, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-4.jpeg', 96),
(313, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-5.jpeg', 96),
(314, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-6.jpeg', 96),
(315, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-8.jpeg', 96),
(316, 'title', 'iphone-13-xanh-glr-4-750x500.jpg', 97),
(317, 'title', 'iphone-13-xanh-glr-5-750x500.jpg', 97),
(318, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-2.jpeg', 97),
(319, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-4.jpeg', 97),
(320, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-5.jpeg', 97),
(321, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-6.jpeg', 97),
(322, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-8.jpeg', 97),
(323, 'title', 'iphone-13-xanh-glr-4-750x500.jpg', 98),
(324, 'title', 'iphone-13-xanh-glr-5-750x500.jpg', 98),
(325, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-2.jpeg', 98),
(326, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-4.jpeg', 98),
(327, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-5.jpeg', 98),
(328, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-6.jpeg', 98),
(329, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-8.jpeg', 98),
(330, 'title', 'iphone-13-xanh-glr-4-750x500.jpg', 99),
(331, 'title', 'iphone-13-xanh-glr-5-750x500.jpg', 99),
(332, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-2.jpeg', 99),
(333, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-4.jpeg', 99),
(334, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-5.jpeg', 99),
(335, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-6.jpeg', 99),
(336, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-8.jpeg', 99),
(337, 'title', 'iphone-13-xanh-glr-4-750x500.jpg', 100),
(338, 'title', 'iphone-13-xanh-glr-5-750x500.jpg', 100),
(339, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-2.jpeg', 100),
(340, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-4.jpeg', 100),
(341, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-5.jpeg', 100),
(342, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-6.jpeg', 100),
(343, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-8.jpeg', 100),
(344, 'title', 'iphone-13-xanh-glr-4-750x500.jpg', 101),
(345, 'title', 'iphone-13-xanh-glr-5-750x500.jpg', 101),
(346, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-2.jpeg', 101),
(347, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-4.jpeg', 101),
(348, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-5.jpeg', 101),
(349, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-6.jpeg', 101),
(350, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-8.jpeg', 101),
(351, 'title', 'iphone-13-xanh-glr-4-750x500.jpg', 102),
(352, 'title', 'iphone-13-xanh-glr-5-750x500.jpg', 102),
(353, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-2.jpeg', 102),
(354, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-4.jpeg', 102),
(355, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-5.jpeg', 102),
(356, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-6.jpeg', 102),
(357, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-8.jpeg', 102),
(358, 'title', 'iphone-13-xanh-glr-4-750x500.jpg', 103),
(359, 'title', 'iphone-13-xanh-glr-5-750x500.jpg', 103),
(360, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-2.jpeg', 103),
(361, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-4.jpeg', 103),
(362, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-5.jpeg', 103),
(363, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-6.jpeg', 103),
(364, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-8.jpeg', 103),
(365, 'title', 'iphone-13-xanh-glr-4-750x500.jpg', 104),
(366, 'title', 'iphone-13-xanh-glr-5-750x500.jpg', 104),
(367, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-2.jpeg', 104),
(368, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-4.jpeg', 104),
(369, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-5.jpeg', 104),
(370, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-6.jpeg', 104),
(371, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-8.jpeg', 104),
(372, 'title', 'iphone-13-xanh-glr-4-750x500.jpg', 105),
(373, 'title', 'iphone-13-xanh-glr-5-750x500.jpg', 105),
(374, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-2.jpeg', 105),
(375, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-4.jpeg', 105),
(376, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-5.jpeg', 105),
(377, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-6.jpeg', 105),
(378, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-8.jpeg', 105),
(379, 'title', 'iphone-13-xanh-glr-4-750x500.jpg', 106),
(380, 'title', 'iphone-13-xanh-glr-5-750x500.jpg', 106),
(381, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-2.jpeg', 106),
(382, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-4.jpeg', 106),
(383, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-5.jpeg', 106),
(384, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-6.jpeg', 106),
(385, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-8.jpeg', 106),
(386, 'title', 'iphone-13-xanh-glr-4-750x500.jpg', 107),
(387, 'title', 'iphone-13-xanh-glr-5-750x500.jpg', 107),
(388, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-2.jpeg', 107),
(389, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-4.jpeg', 107),
(390, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-5.jpeg', 107),
(391, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-6.jpeg', 107),
(392, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-8.jpeg', 107),
(393, 'title', 'iphone-13-xanh-glr-4-750x500.jpg', 108),
(394, 'title', 'iphone-13-xanh-glr-5-750x500.jpg', 108),
(395, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-2.jpeg', 108),
(396, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-4.jpeg', 108),
(397, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-5.jpeg', 108),
(398, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-6.jpeg', 108),
(399, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-8.jpeg', 108),
(400, 'title', 'iphone-13-xanh-glr-4-750x500.jpg', 109),
(401, 'title', 'iphone-13-xanh-glr-5-750x500.jpg', 109),
(402, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-2.jpeg', 109),
(403, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-4.jpeg', 109),
(404, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-5.jpeg', 109),
(405, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-6.jpeg', 109),
(406, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-8.jpeg', 109),
(407, 'title', 'iphone-13-xanh-glr-4-750x500.jpg', 110),
(408, 'title', 'iphone-13-xanh-glr-5-750x500.jpg', 110),
(409, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-2.jpeg', 110),
(410, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-4.jpeg', 110),
(411, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-5.jpeg', 110),
(412, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-6.jpeg', 110),
(413, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-8.jpeg', 110),
(414, 'title', 'iphone-13-xanh-glr-4-750x500.jpg', 111),
(415, 'title', 'iphone-13-xanh-glr-5-750x500.jpg', 111),
(416, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-2.jpeg', 111),
(417, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-4.jpeg', 111),
(418, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-5.jpeg', 111),
(419, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-6.jpeg', 111),
(420, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-8.jpeg', 111),
(421, 'title', 'iphone-13-xanh-glr-4-750x500.jpg', 112),
(422, 'title', 'iphone-13-xanh-glr-5-750x500.jpg', 112),
(423, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-2.jpeg', 112),
(424, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-4.jpeg', 112),
(425, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-5.jpeg', 112),
(426, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-6.jpeg', 112),
(427, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-8.jpeg', 112),
(428, 'title', 'iphone-13-xanh-glr-4-750x500.jpg', 113),
(429, 'title', 'iphone-13-xanh-glr-5-750x500.jpg', 113),
(430, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-2.jpeg', 113),
(431, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-4.jpeg', 113),
(432, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-5.jpeg', 113),
(433, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-6.jpeg', 113),
(434, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-8.jpeg', 113),
(435, 'title', 'iphone-13-xanh-glr-4-750x500.jpg', 114),
(436, 'title', 'iphone-13-xanh-glr-5-750x500.jpg', 114),
(437, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-2.jpeg', 114),
(438, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-4.jpeg', 114),
(439, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-5.jpeg', 114),
(440, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-6.jpeg', 114),
(441, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-8.jpeg', 114),
(442, 'title', 'iphone-13-xanh-glr-4-750x500.jpg', 115),
(443, 'title', 'iphone-13-xanh-glr-5-750x500.jpg', 115),
(444, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-2.jpeg', 115),
(445, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-4.jpeg', 115),
(446, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-5.jpeg', 115),
(447, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-6.jpeg', 115),
(448, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-8.jpeg', 115),
(449, 'title', 'iphone-13-xanh-glr-4-750x500.jpg', 116),
(450, 'title', 'iphone-13-xanh-glr-5-750x500.jpg', 116),
(451, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-2.jpeg', 116),
(452, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-4.jpeg', 116),
(453, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-5.jpeg', 116),
(454, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-6.jpeg', 116),
(455, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-8.jpeg', 116),
(456, 'title', 'iphone-13-xanh-glr-4-750x500.jpg', 117),
(457, 'title', 'iphone-13-xanh-glr-5-750x500.jpg', 117),
(458, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-2.jpeg', 117),
(459, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-4.jpeg', 117),
(460, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-5.jpeg', 117),
(461, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-6.jpeg', 117),
(462, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-8.jpeg', 117),
(463, 'title', 'iphone-13-xanh-glr-4-750x500.jpg', 118),
(464, 'title', 'iphone-13-xanh-glr-5-750x500.jpg', 118),
(465, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-2.jpeg', 118),
(466, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-4.jpeg', 118),
(467, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-5.jpeg', 118),
(468, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-6.jpeg', 118),
(469, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-8.jpeg', 118),
(470, 'title', 'iphone-13-xanh-glr-4-750x500.jpg', 119),
(471, 'title', 'iphone-13-xanh-glr-5-750x500.jpg', 119),
(472, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-2.jpeg', 119),
(473, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-4.jpeg', 119),
(474, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-5.jpeg', 119),
(475, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-6.jpeg', 119),
(476, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-8.jpeg', 119),
(477, 'title', 'iphone-13-xanh-glr-4-750x500.jpg', 120),
(478, 'title', 'iphone-13-xanh-glr-5-750x500.jpg', 120),
(479, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-2.jpeg', 120),
(480, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-4.jpeg', 120),
(481, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-5.jpeg', 120),
(482, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-6.jpeg', 120),
(483, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-8.jpeg', 120),
(484, 'title', 'iphone-13-xanh-glr-4-750x500.jpg', 121),
(485, 'title', 'iphone-13-xanh-glr-5-750x500.jpg', 121),
(486, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-2.jpeg', 121),
(487, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-4.jpeg', 121),
(488, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-5.jpeg', 121),
(489, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-6.jpeg', 121),
(490, 'title', 'vi-vn-samsung-galaxy-s23-fe-5g-8.jpeg', 121),
(501, NULL, 'itels.png', 79),
(502, NULL, 'iphone-13-xanh-glr-4-750x500.jpg', 69),
(503, NULL, 'iphone-13-xanh-glr-5-750x500.jpg', 69),
(504, NULL, 'vi-vn-samsung-galaxy-s23-fe-5g-2.jpeg', 69),
(505, NULL, 'vi-vn-samsung-galaxy-s23-fe-5g-4.jpeg', 69),
(506, NULL, 'vi-vn-samsung-galaxy-s23-fe-5g-5.jpeg', 69),
(507, NULL, 'vi-vn-samsung-galaxy-s23-fe-5g-6.jpeg', 69),
(508, NULL, 'vi-vn-samsung-galaxy-s23-fe-5g-8.jpeg', 69),
(509, NULL, 'download-25.png', 122),
(510, NULL, 'Temu｜1pc Blanco Gótico Alfabeto Número Carta Bordado Parches Hierro En Letras Parche A-Z Parche Bordado Parche Coser Parches Para Ropa Nombre Diy.jpg', 122),
(511, 'title', 'vi-vn-iphone-12-up-2.jpeg', 123),
(512, 'title', 'iphone-13-xanh-glr-4-750x500.jpg', 123),
(513, 'title', ' vi-vn-iphone-12-up-2.jpeg', 124),
(514, 'title', 'iphone-13-xanh-glr-4-750x500.jpg', 124),
(515, 'title', 'vi-vn-iphone-12-up-2.jpeg', 125),
(516, 'title', 'iphone-13-xanh-glr-4-750x500.jpg', 125),
(517, 'title', 'vi-vn-iphone-12-up-2.jpeg', 126),
(518, 'title', 'iphone-13-xanh-glr-4-750x500.jpg', 126),
(519, 'title', 'vi-vn-iphone-12-up-2.jpeg', 127),
(520, 'title', 'iphone-13-xanh-glr-4-750x500.jpg', 127),
(521, 'title', 'vi-vn-iphone-12-up-2.jpeg', 128),
(522, 'title', 'iphone-13-xanh-glr-4-750x500.jpg', 128),
(523, 'title', 'vi-vn-iphone-12-up-2.jpeg', 129),
(524, 'title', 'iphone-13-xanh-glr-4-750x500.jpg', 129),
(525, 'title', 'vi-vn-iphone-12-up-2.jpeg', 130),
(526, 'title', 'iphone-13-xanh-glr-4-750x500.jpg', 130),
(529, 'title', 'vi-vn-iphone-12-up-2.jpeg', 132),
(530, 'title', 'iphone-13-xanh-glr-4-750x500.jpg', 132),
(531, 'title', 'vi-vn-iphone-12-up-2.jpeg', 133),
(532, 'title', 'iphone-13-xanh-glr-4-750x500.jpg', 133),
(533, 'title', 'vi-vn-iphone-12-up-2.jpeg', 134),
(534, 'title', 'iphone-13-xanh-glr-4-750x500.jpg', 134),
(535, 'title', 'vi-vn-iphone-12-up-2.jpeg', 135),
(536, 'title', 'iphone-13-xanh-glr-4-750x500.jpg', 135),
(537, 'title', 'vi-vn-iphone-12-up-2.jpeg', 136),
(538, 'title', 'iphone-13-xanh-glr-4-750x500.jpg', 136),
(539, 'title', 'vi-vn-iphone-12-up-2.jpeg', 137),
(540, 'title', 'iphone-13-xanh-glr-4-750x500.jpg', 137),
(541, 'title', 'vi-vn-iphone-12-up-2.jpeg', 138),
(542, 'title', 'iphone-13-xanh-glr-4-750x500.jpg', 138),
(543, 'title', 'vi-vn-iphone-12-up-2.jpeg', 139),
(544, 'title', 'iphone-13-xanh-glr-4-750x500.jpg', 139),
(545, 'title', 'vi-vn-iphone-12-up-2.jpeg', 140),
(546, 'title', 'iphone-13-xanh-glr-4-750x500.jpg', 140),
(547, 'title', 'vi-vn-iphone-12-up-2.jpeg', 141),
(548, 'title', 'iphone-13-xanh-glr-4-750x500.jpg', 141),
(549, 'title', 'vi-vn-iphone-12-up-2.jpeg', 142),
(550, 'title', 'iphone-13-xanh-glr-4-750x500.jpg', 142),
(551, 'title', 'vi-vn-iphone-12-up-2.jpeg', 143),
(552, 'title', 'iphone-13-xanh-glr-4-750x500.jpg', 143),
(553, 'title', 'vi-vn-iphone-12-up-2.jpeg', 144),
(554, 'title', 'iphone-13-xanh-glr-4-750x500.jpg', 144),
(555, 'title', 'vi-vn-iphone-12-up-2.jpeg', 145),
(556, 'title', 'iphone-13-xanh-glr-4-750x500.jpg', 145),
(560, NULL, 'iphone-13-xanh-glr-4-750x500.jpg', 131),
(561, NULL, 'apple-macbook-air-m2-2022-16gb-256gb-10gpu-xam-thumb-600x600.jpg', 131);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `orderdetails`
--

CREATE TABLE `orderdetails` (
  `id` int(11) NOT NULL,
  `orderID` int(11) NOT NULL,
  `productDetailID` int(11) NOT NULL,
  `currentPrice` double NOT NULL,
  `qty` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `orderdetails`
--

INSERT INTO `orderdetails` (`id`, `orderID`, `productDetailID`, `currentPrice`, `qty`) VALUES
(41, 33, 145, 4090000, 4),
(42, 33, 92, 5490001, 1),
(43, 34, 195, 2490000, 1),
(44, 34, 92, 5490000, 1),
(45, 34, 116, 12990000, 1),
(46, 35, 116, 12990000, 1),
(47, 36, 124, 8990000, 1),
(48, 37, 92, 5490000, 1),
(49, 38, 116, 12990000, 1),
(50, 39, 92, 5490000, 1),
(51, 40, 161, 4690000, 1),
(52, 41, 92, 5490000, 1),
(53, 42, 116, 12990000, 2),
(54, 43, 92, 5490000, 1),
(55, 43, 116, 12990000, 1),
(56, 44, 145, 4090000, 1),
(57, 45, 164, 7990000, 1),
(58, 46, 92, 5490000, 1),
(59, 46, 116, 12990000, 1),
(60, 47, 116, 12990000, 1),
(61, 48, 116, 12990000, 1),
(62, 49, 145, 4090000, 1),
(63, 50, 116, 12990000, 1),
(64, 51, 116, 12990000, 1),
(65, 52, 116, 12990000, 1),
(66, 53, 182, 21490000, 1),
(67, 53, 114, 8490000, 4),
(68, 54, 92, 5490000, 1),
(69, 54, 182, 21490000, 1),
(70, 55, 219, 23000000, 1),
(71, 56, 120, 9990000, 2),
(72, 57, 214, 23000000, 1);

--
-- Bẫy `orderdetails`
--
DELIMITER $$
CREATE TRIGGER `track_orderdetails_changes` AFTER UPDATE ON `orderdetails` FOR EACH ROW BEGIN
    -- Kiểm tra nếu giá sản phẩm thay đổi
    IF OLD.currentPrice != NEW.currentPrice THEN
        INSERT INTO order_history(orderID, columnName, oldValue, newValue, modifiedBy)
        VALUES (NEW.orderID, 'currentPrice', OLD.currentPrice, NEW.currentPrice, CURRENT_USER());
    END IF;
    
    -- Kiểm tra nếu số lượng thay đổi
    IF OLD.qty != NEW.qty THEN
        INSERT INTO order_history(orderID, columnName, oldValue, newValue, modifiedBy)
        VALUES (NEW.orderID, 'qty', OLD.qty, NEW.qty, CURRENT_USER());
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `money` double NOT NULL,
  `userID` int(11) NOT NULL,
  `address` varchar(256) NOT NULL,
  `dateSet` datetime NOT NULL DEFAULT current_timestamp(),
  `updateTime` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `status` int(11) NOT NULL DEFAULT 0,
  `signature` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `orders`
--

INSERT INTO `orders` (`id`, `money`, `userID`, `address`, `dateSet`, `updateTime`, `status`, `signature`) VALUES
(33, 9580000, 1, 'Hung Dong Nguyen (092413211)   |510 quốc lộ 13, Hiệp Bình Chánh, Thủ Đức, Hồ Chí Minh', '2024-12-13 13:58:09', '2024-12-24 07:53:27', 12, 'awe'),
(34, 20970000, 1, 'Hung Dong Nguyen (092413211)   |510 quốc lộ 13, Hiệp Bình Chánh, Thủ Đức, Hồ Chí Minh', '2024-12-13 20:32:29', '2024-12-24 00:17:19', 1, 'aw'),
(35, 12990000, 1, 'Hung Dong Nguyen (092413211)   |510 quốc lộ 13, Hiệp Bình Chánh, Thủ Đức, Hồ Chí Minh', '2024-12-13 20:34:58', '2024-12-24 00:17:20', 10, 'resign'),
(36, 8990000, 1, 'Hung Dong Nguyen (092413211)   |510 quốc lộ 13, Hiệp Bình Chánh, Thủ Đức, Hồ Chí Minh', '2024-12-13 20:36:41', '2024-12-24 00:17:22', 10, 'resign'),
(37, 5490000, 1, 'Hung Dong Nguyen (092413211)   |510 quốc lộ 13, Hiệp Bình Chánh, Thủ Đức, Hồ Chí Minh', '2024-12-13 20:41:35', '2024-12-24 00:17:21', 10, 'resign'),
(38, 12990000, 1, 'Hung Dong Nguyen (092413211)   |510 quốc lộ 13, Hiệp Bình Chánh, Thủ Đức, Hồ Chí Minh', '2024-12-13 20:43:56', '2024-12-24 00:17:24', 10, 'resign'),
(39, 5490000, 1, 'Hung Dong Nguyen (092413211)   |510 quốc lộ 13, Hiệp Bình Chánh, Thủ Đức, Hồ Chí Minh', '2024-12-13 20:47:52', '2024-12-24 00:17:25', 10, 'resign'),
(40, 4690000, 1, 'Hung Dong Nguyen (092413211)   |510 quốc lộ 13, Hiệp Bình Chánh, Thủ Đức, Hồ Chí Minh', '2024-12-13 20:55:03', '2024-12-24 00:17:27', 1, 'awfe'),
(41, 5490000, 1, 'Hung Dong Nguyen (092413211)   |510 quốc lộ 13, Hiệp Bình Chánh, Thủ Đức, Hồ Chí Minh', '2024-12-13 22:15:19', '2024-12-24 00:17:28', 1, 'awf'),
(42, 25980000, 1, 'Hung Dong Nguyen (092413211)   |510 quốc lộ 13, Hiệp Bình Chánh, Thủ Đức, Hồ Chí Minh', '2024-12-20 10:10:49', '2024-12-24 00:17:30', 10, 'resign'),
(43, 18480000, 1, 'Hung Dong Nguyen (092413211)   |510 quốc lộ 13, Hiệp Bình Chánh, Thủ Đức, Hồ Chí Minh', '2024-12-20 15:41:27', '2024-12-24 00:17:31', 1, 'wfa3'),
(44, 4090000, 1, 'Hung Dong Nguyen (092413211)   |510 quốc lộ 13, Hiệp Bình Chánh, Thủ Đức, Hồ Chí Minh', '2024-12-20 16:09:14', '2024-12-24 00:17:33', 10, 'resign'),
(45, 7990000, 1, 'Hung Dong Nguyen (092413211)   |510 quốc lộ 13, Hiệp Bình Chánh, Thủ Đức, Hồ Chí Minh', '2024-12-20 16:11:18', '2024-12-24 00:17:35', 1, 'awfa'),
(46, 18480000, 5, 'Nhatg drth (23842167412)   |fq34tgq3t, Bình Trưng Tây, Thủ Đức, Hồ Chí Minh', '2024-12-20 16:21:00', '2024-12-24 00:16:44', 1, 'jYrBb5ZLiNqsRGWvF4F59z2bBB0R2WI0WIzTjYcWla3D9bZTvzeUSaj1n28e8OvgU2ghNZWhEfs6i7tWei3ZjvntMrOFaewWXy1Qz/Fu6YUJSYmUMEJCU43JGbxFo9j+xVIyipfEzOUGWsp/0aknRTOQXSFKIbA1gG+yc1EBGzqHJ80FbUSFiM6AB6tL3frOBY4Jmc+SrdWB2lEwwivN0i8+vu4kIS6F7LC66qf5HNG2K+E79cS6RJ7f8WoqtJX9HRojmYYA2eA96hkX11bKV91CTMXLm6QgX43E68xpxpL/wMZtn4+Ovco/bfc7ztREJOdsJsIjWrUU0FnTQWM+6g=='),
(47, 12990000, 1, 'Hung Dong Nguyen (092413211)   |510 quốc lộ 13, Hiệp Bình Chánh, Thủ Đức, Hồ Chí Minh', '2024-12-20 16:31:39', '2024-12-24 00:17:36', 1, 'awf'),
(48, 12990000, 1, 'Hung Dong Nguyen (092413211)   |510 quốc lộ 13, Hiệp Bình Chánh, Thủ Đức, Hồ Chí Minh', '2024-12-23 19:04:28', '2024-12-24 08:19:16', 10, 'awf'),
(49, 4090000, 1, 'Hung Dong Nguyen (092413211)   |510 quốc lộ 13, Hiệp Bình Chánh, Thủ Đức, Hồ Chí Minh', '2024-12-23 19:24:25', '2024-12-24 00:17:37', 1, 'awf'),
(50, 12990000, 1, 'Hung Dong Nguyen (092413211)   |510 quốc lộ 13, Hiệp Bình Chánh, Thủ Đức, Hồ Chí Minh', '2024-12-23 23:09:10', '2024-12-24 00:17:38', 1, 'awf'),
(51, 12990000, 1, 'Hung Dong Nguyen (092413211)   |510 quốc lộ 13, Hiệp Bình Chánh, Thủ Đức, Hồ Chí Minh', '2024-12-23 23:18:04', '2024-12-24 00:17:39', 1, 'awf'),
(52, 12990000, 1, 'Hung Dong Nguyen (092413211)   |510 quốc lộ 13, Hiệp Bình Chánh, Thủ Đức, Hồ Chí Minh', '2024-12-24 00:29:59', '2024-12-24 00:30:34', 0, 'jJm4VuQd+XHtlN/nE82BOwHlg4jtdEAv/89P9OfIcK/YT+rXVrReSsiuHxwpkvUHGqhTC8QCLk0vgQekqjO545nvuO4oqVZwluWE0/Y5YZE7CU9CvdC+OgNJZp88ZoCheWC8VD88BZG5aEuxY5MGKf2ejhhxhXhXTN3i651aXerBxbHgQ28LO7m3wnj7kTDCflXoWbbAoqbz5xcXxT43rVFgcORCzQYvkBSkIdJc8cRf4j4TzrzAND3rCRPstz1UxmisaIOY6TfPubmHHv+gFZS34R5LOQJKmGl0Bjg2EYbTcyqA6eTH/ouh1eHxX6VY+3TobBYl4Dvv6bzdg9Gs1Q=='),
(53, 55450000, 1, 'Hung Dong Nguyen (092413211)   |510 quốc lộ 13, Hiệp Bình Chánh, Thủ Đức, Hồ Chí Minh', '2024-12-24 07:42:42', '2024-12-24 08:18:42', 1, 'I0YHTLX9Z82qUIUwbWIxQ//G4Tg10JO2tXwj+ne6vEundbabHPaIJRYnmI7EI+qQ2kSVF2Bwzp6iYY+QO9cjgo9sbsUe3hLJKGobeiNHnsBH6cI1BLYItXkFp5yQmUbowWPUBHfR+lRf+MFIvSTD97kXa5QBCz8qn/EnxwqzNURePmOwCvrhXB5MswvdJaVTeYD14PRIZmvFeUqIcElPxqduGJKgpR2keMVfo6IvJj+nqPI2dtEBMKvBf7rL8QCNzXiRZTOhi3qD20BzAvsFoViDAalimJFPBmXOs5rNctwrmdmB6iwVmp31w03yb8m1ohEQxje9V1j0sRCR8Z5wSg=='),
(54, 26980000, 1, 'Hung Dong Nguyen (092413211)   |510 quốc lộ 13, Hiệp Bình Chánh, Thủ Đức, Hồ Chí Minh', '2024-12-24 08:27:17', '2024-12-24 08:31:40', 1, 'resign'),
(55, 23000000, 1, 'Hung Dong Nguyen (113)   |510 quốc lộ 13, Hiệp Bình Chánh, Thủ Đức, Hồ Chí Minh', '2025-01-13 18:59:51', '2025-01-13 18:59:51', 0, NULL),
(56, 19980000, 1, 'Nhi (412353245)   |14 đường số 2, Bình Trưng Tây, Thủ Đức, Hồ Chí Minh', '2025-01-13 19:01:02', '2025-01-13 19:01:02', 0, NULL),
(57, 23000000, 1, 'Hung Dong Nguyen (113)   |510 quốc lộ 13, Hiệp Bình Chánh, Thủ Đức, Hồ Chí Minh', '2025-01-13 19:02:35', '2025-01-13 19:02:35', 0, NULL);

--
-- Bẫy `orders`
--
DELIMITER $$
CREATE TRIGGER `track_signature_changes` AFTER UPDATE ON `orders` FOR EACH ROW BEGIN
    -- Nếu chữ ký bị thay đổi
    IF OLD.signature != NEW.signature THEN
        INSERT INTO order_history(orderID, columnName, oldValue, newValue, modifiedBy)
        VALUES (NEW.id, 'signature', OLD.signature, NEW.signature, CURRENT_USER());
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `order_history`
--

CREATE TABLE `order_history` (
  `id` int(11) NOT NULL,
  `orderID` int(11) DEFAULT NULL,
  `columnName` varchar(255) DEFAULT NULL,
  `oldValue` text DEFAULT NULL,
  `newValue` text DEFAULT NULL,
  `modifiedAt` datetime DEFAULT current_timestamp(),
  `modifiedBy` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `order_history`
--

INSERT INTO `order_history` (`id`, `orderID`, `columnName`, `oldValue`, `newValue`, `modifiedAt`, `modifiedBy`) VALUES
(1, 33, 'qty', '2', '4', '2024-12-24 07:57:19', '@'),
(2, 33, 'currentPrice', '5490000', '5490001', '2024-12-24 07:57:24', '@'),
(3, 54, 'qty', '1', '2', '2024-12-24 08:29:15', '@'),
(4, 54, 'qty', '2', '1', '2024-12-24 08:29:45', '@'),
(5, 54, 'signature', 'kMfiSHFfbYHsJ+94OuEgwHPnn3X1COLmWcuTPQOAeGAoNiDLmcckn25HksSCuzhD5SIuVS7wYQOPMuTAmfHYRthH3fdcX0zSowD9OcvtWIZzapbRq2Ys8AakoaOGkp3EGau/VEJdWGULScUG8FdCoe0F9x5UE7dob8oqCjByCdOOP74YDieMXjHn+h1Dg0DqLM7qOfqbPWkHt15eJDqW2QyElFFYoKjES9bY1OvbTpU3Ut4eA2PQfE5rAbk6t+JNl/Z510ZKbKfUECGfZhzA5OZabdhmGmuXuyV9Ra9d9iywZ+RiyRh8PWvWgxXBurFZRjoRw2TB2hAWqFMvgpRk6w==', 'resign', '2024-12-24 08:31:40', '@');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `productdetails`
--

CREATE TABLE `productdetails` (
  `id` int(11) NOT NULL,
  `productID` int(11) NOT NULL,
  `color` varchar(256) NOT NULL,
  `ram` int(11) NOT NULL,
  `rom` int(11) NOT NULL,
  `price` double NOT NULL,
  `qty` int(11) NOT NULL,
  `avai` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `productdetails`
--

INSERT INTO `productdetails` (`id`, `productID`, `color`, `ram`, `rom`, `price`, `qty`, `avai`) VALUES
(11, 52, 'trắng', 4, 64, 8990000, -1, 1),
(12, 52, 'đen', 4, 64, 8990000, 9, 1),
(13, 52, 'trắng', 4, 128, 9990000, 10, 1),
(14, 52, 'đen', 4, 128, 9990000, 10, 1),
(15, 53, 'xanh lá', 4, 64, 10990000, 8, 1),
(16, 53, 'trắng', 4, 64, 10990000, 10, 1),
(17, 53, 'đen', 4, 64, 10990000, 10, 1),
(18, 53, 'xanh lá', 4, 128, 11990000, 10, 1),
(19, 53, 'trắng', 4, 128, 11990000, 10, 1),
(20, 53, 'đen', 4, 128, 11990000, 10, 1),
(21, 54, 'hồng', 6, 128, 13890000, 10, 1),
(22, 54, 'trắng', 6, 128, 13890000, 10, 1),
(23, 54, 'đen', 6, 128, 13890000, 10, 1),
(24, 54, 'hồng', 6, 256, 14890000, 10, 1),
(25, 54, 'trắng', 6, 256, 14890000, 10, 1),
(26, 54, 'đen', 6, 256, 14890000, 10, 1),
(27, 56, 'tím nhạt', 6, 128, 17390000, 10, 1),
(28, 56, 'trắng', 6, 128, 17390000, 10, 1),
(29, 56, 'đen', 6, 128, 17390000, 10, 1),
(30, 56, 'tím nhạt', 6, 256, 18390000, 10, 1),
(31, 56, 'trắng', 6, 256, 18390000, 10, 1),
(32, 56, 'đen', 6, 256, 18390000, 10, 1),
(33, 55, 'xanh dương', 6, 128, 19990000, 10, 1),
(34, 55, 'vàng', 6, 128, 19990000, 10, 1),
(35, 55, 'tím nhạt', 6, 128, 19990000, 10, 1),
(36, 55, 'xanh dương', 6, 256, 20990000, 10, 1),
(37, 55, 'vàng', 6, 256, 20990000, 10, 1),
(38, 55, 'tím nhạt', 6, 256, 20990000, 10, 1),
(39, 57, 'hồng nhạt', 8, 128, 19790000, 10, 1),
(40, 57, 'xanh dương nhạt', 8, 128, 19790000, 10, 1),
(41, 57, 'hồng nhạt', 8, 256, 20790000, 10, 1),
(42, 57, 'xanh dương nhạt', 8, 256, 20790000, 10, 1),
(43, 58, 'vàng nhạt', 8, 128, 22790000, 10, 1),
(44, 58, 'đen', 8, 128, 22790000, 10, 1),
(45, 58, 'vàng nhạt', 8, 256, 23790000, 10, 1),
(46, 58, 'đen', 8, 256, 23790000, 10, 1),
(47, 59, 'titan đen', 8, 256, 28390000, 10, 1),
(48, 59, 'titan tự nhiên', 8, 256, 28390000, 10, 1),
(49, 59, 'titan đen', 8, 256, 28390000, 10, 1),
(50, 59, 'titan tự nhiên', 8, 256, 28390000, 10, 1),
(51, 59, 'titan đen', 8, 512, 29390000, 10, 1),
(52, 59, 'titan tự nhiên', 8, 512, 29390000, 10, 1),
(53, 59, 'titan đen', 8, 1000, 30390000, 10, 1),
(54, 59, 'titan tự nhiên', 8, 1000, 30390000, 10, 1),
(55, 61, 'xanh lưu ly', 8, 128, 22590000, 10, 1),
(56, 61, 'trắng', 8, 128, 22590000, 10, 1),
(57, 61, 'đen', 8, 128, 22590000, 10, 1),
(58, 61, 'xanh lưu ly', 8, 256, 23590000, 10, 1),
(59, 61, 'trắng', 8, 256, 23590000, 10, 1),
(60, 61, 'đen', 8, 256, 23590000, 10, 1),
(61, 61, 'xanh lưu ly', 8, 512, 24590000, 10, 1),
(62, 61, 'trắng', 8, 512, 24590000, 10, 1),
(63, 61, 'đen', 8, 512, 24590000, 10, 1),
(64, 62, 'xanh lưu ly', 8, 256, 25990000, 10, 1),
(65, 62, 'trắng', 8, 256, 25990000, 10, 1),
(66, 62, 'đen', 8, 256, 25990000, 10, 1),
(67, 62, 'xanh lưu ly', 8, 512, 26990000, 10, 1),
(68, 62, 'trắng', 8, 512, 26990000, 10, 1),
(69, 62, 'đen', 8, 512, 26990000, 10, 1),
(70, 64, 'titan tự nhiên', 8, 512, 28990000, 10, 1),
(71, 64, 'titan đen', 8, 512, 28990000, 10, 1),
(72, 64, 'titan tự nhiên', 8, 1000, 29990000, 10, 1),
(73, 64, 'titan đen', 8, 1000, 29990000, 10, 1),
(74, 63, 'titan tự nhiên', 8, 512, 34990000, 10, 1),
(75, 63, 'titan đen', 8, 512, 34990000, 10, 1),
(76, 63, 'titan tự nhiên', 8, 1000, 35990000, 10, 1),
(77, 63, 'titan đen', 8, 1000, 35990000, 10, 1),
(78, 65, 'xanh dương', 4, 64, 3290000, 10, 1),
(79, 65, 'xanh dương', 4, 128, 4290000, 10, 1),
(80, 66, 'tím', 6, 128, 4990000, 10, 1),
(81, 66, 'đen', 6, 128, 4990000, 10, 1),
(82, 66, 'tím', 8, 256, 6990000, 10, 1),
(83, 66, 'đen', 8, 256, 6990000, 10, 1),
(84, 67, 'đen', 4, 128, 4390000, 10, 1),
(85, 67, 'vàng đồng', 4, 128, 4390000, 10, 1),
(86, 67, 'đen', 6, 128, 5390000, 10, 1),
(87, 67, 'vàng đồng', 6, 128, 5390000, 10, 1),
(88, 68, 'đỏ', 4, 64, 3490000, 10, 1),
(89, 68, 'xanh dương', 4, 64, 3490000, 10, 1),
(90, 68, 'đỏ', 4, 128, 4490000, 10, 1),
(91, 68, 'xanh dương', 4, 128, 4490000, 10, 1),
(92, 69, 'xanh ngọc xanh', 6, 128, 5490000, 1, -99),
(93, 69, 'đen', 6, 128, 5490000, 10, 1),
(94, 69, 'xanh ngọc', 8, 128, 6490000, 10, 1),
(95, 69, 'đen', 8, 128, 6490000, 10, 1),
(96, 70, 'xanh dương nhat', 8, 128, 5490000, 10, 1),
(97, 70, 'đen tím', 8, 128, 5490000, 10, 1),
(98, 70, 'xanh dương nhat', 8, 256, 6490000, 10, 1),
(99, 70, 'đen tím', 8, 256, 6490000, 10, 1),
(100, 71, 'xanh lá', 8, 256, 5490000, 10, 1),
(101, 71, 'đen', 8, 256, 5490000, 10, 1),
(102, 72, 'xanh lá', 8, 256, 7490000, 10, 1),
(103, 72, 'đen', 8, 256, 7490000, 10, 1),
(104, 73, 'hồng', 12, 512, 22990000, 10, 1),
(105, 73, 'vàng đồng', 12, 512, 22990000, 10, 1),
(106, 74, 'hồng', 12, 512, 41990000, 10, 1),
(107, 74, 'vàng đồng', 12, 512, 41990000, 10, 1),
(108, 76, 'trắng', 8, 256, 7990000, 10, 1),
(109, 76, 'xám', 8, 256, 7990000, 10, 1),
(110, 75, 'trắng', 12, 512, 12990000, 10, 1),
(111, 75, 'xám', 12, 512, 12990000, 10, 1),
(112, 77, 'tím', 12, 256, 14490000, 10, 1),
(113, 77, 'xám', 12, 256, 14490000, 10, 1),
(114, 78, 'hồng', 8, 256, 8490000, 6, 1),
(115, 78, 'xanh đen', 8, 256, 8490000, 10, 1),
(116, 79, 'bạc', 12, 256, 12990000, -9, 1),
(117, 79, 'nâu', 12, 256, 12990000, 10, 1),
(118, 79, 'bạc', 12, 512, 13990000, 10, 1),
(119, 79, 'nâu', 12, 512, 13990000, 9, 1),
(120, 82, 'cam', 8, 256, 9990000, 7, 1),
(121, 82, 'xanh lá', 8, 256, 9990000, 10, 1),
(122, 82, 'cam', 12, 256, 10990000, 10, 1),
(123, 82, 'xanh lá', 12, 256, 10990000, 10, 1),
(124, 81, 'cam', 8, 256, 8990000, 10, 1),
(125, 81, 'xanh lá', 8, 256, 8990000, 10, 1),
(126, 81, 'cam', 12, 256, 9990000, 10, 1),
(127, 81, 'xanh lá', 12, 256, 9990000, 10, 1),
(128, 83, 'xám', 12, 512, 18990000, 10, 1),
(129, 83, 'nâu', 12, 512, 18990000, 10, 1),
(130, 84, 'xanh da trời', 8, 512, 8990000, 10, 1),
(131, 84, 'xanh ngọc', 6, 256, 4490000, 10, 1),
(132, 84, 'đen', 6, 256, 4490000, 10, 1),
(133, 85, 'xanh ngọc', 6, 256, 4090000, 10, 1),
(134, 85, 'đen', 6, 256, 4090000, 10, 1),
(135, 86, 'vàng', 6, 256, 2790000, 10, 1),
(136, 87, 'đen', 6, 256, 4790000, 10, 1),
(137, 88, 'tím', 8, 512, 4790000, 10, 1),
(138, 88, 'xanh da trời', 8, 512, 4790000, 10, 1),
(139, 89, 'xanh ngọc', 8, 256, 4290000, 10, 1),
(140, 89, 'đen', 8, 256, 4290000, 10, 1),
(141, 90, 'đen', 8, 256, 2490000, 10, 1),
(142, 91, 'xanh dương', 6, 128, 3990000, 10, 1),
(143, 91, 'vàng nhạt', 6, 128, 3990000, 10, 1),
(144, 91, 'vàng', 8, 256, 5990000, 10, 1),
(145, 92, 'bạc', 4, 128, 4090000, 6, 1),
(146, 92, 'đen', 4, 128, 4090000, 10, 1),
(147, 92, 'bạc', 6, 128, 5090000, 10, 1),
(148, 92, 'đen', 6, 128, 5090000, 10, 1),
(149, 93, 'xanh dương', 4, 64, 3190000, 10, 1),
(150, 93, 'xanh dương', 6, 128, 5190000, 10, 1),
(151, 94, 'xanh dương', 6, 128, 4990000, 9, 1),
(152, 95, 'xanh lá', 6, 128, 6990000, 10, 1),
(153, 96, 'xanh lá', 6, 128, 7490000, 10, 1),
(154, 97, 'vàng nhạt', 6, 128, 6490000, 10, 1),
(155, 97, 'đen', 6, 128, 6490000, 10, 1),
(156, 97, 'vàng nhạt', 8, 128, 7490000, 10, 1),
(157, 97, 'đen', 8, 128, 7490000, 10, 1),
(158, 98, 'xanh dương', 4, 64, 8790000, 10, 1),
(159, 98, 'xanh dương', 6, 128, 10790000, 10, 1),
(160, 99, 'đen', 6, 128, 11490000, 10, 1),
(161, 100, 'xanh dương', 6, 128, 4690000, 9, 1),
(162, 100, 'đen', 6, 128, 4690000, 10, 1),
(163, 101, 'hồng nhạt', 6, 128, 8790000, 10, 1),
(164, 102, 'tím nhạt', 6, 128, 7990000, 9, 1),
(165, 102, 'đen', 6, 128, 7990000, 10, 1),
(166, 104, 'xanh mint', 8, 128, 10990000, 10, 1),
(167, 104, 'hồng nhạt', 8, 128, 10990000, 10, 1),
(168, 105, 'đen', 12, 512, 23990000, 10, 1),
(169, 106, 'tím nhạt', 8, 128, 15990000, 10, 1),
(170, 106, 'đen', 8, 128, 15990000, 10, 1),
(171, 106, 'tím nhạt', 8, 256, 16990000, 10, 1),
(172, 106, 'đen', 8, 256, 16990000, 10, 1),
(173, 107, 'vàng gold', 8, 128, 23990000, 10, 1),
(174, 107, 'đen', 8, 128, 23990000, 10, 1),
(175, 107, 'vàng gold', 8, 256, 24990000, 10, 1),
(176, 107, 'đen', 8, 256, 24990000, 10, 1),
(177, 108, 'đen', 12, 512, 29990000, 10, 1),
(178, 108, 'trắng', 12, 512, 29990000, 10, 1),
(179, 109, 'đen', 8, 256, 17990000, 10, 1),
(180, 109, 'đen', 8, 512, 18990000, 10, 1),
(181, 110, 'xám', 8, 256, 39490000, 10, 1),
(182, 111, 'trắng ', 6, 128, 21490000, 4, 1),
(183, 111, 'đen', 6, 128, 21490000, 10, 1),
(184, 111, 'trắng ', 8, 128, 22490000, 10, 1),
(185, 111, 'đen', 8, 128, 22490000, 10, 1),
(186, 112, 'vàng gold', 12, 512, 29990000, 10, 1),
(187, 113, 'trắng', 8, 256, 12990000, 10, 1),
(188, 113, 'đen', 12, 512, 12990000, 10, 1),
(189, 113, 'trắng', 12, 512, 12990000, 10, 1),
(190, 116, 'vàng', 6, 128, 3690000, 10, 1),
(191, 116, 'đen', 6, 128, 3690000, 10, 1),
(192, 116, 'vàng', 8, 128, 4690000, 10, 1),
(193, 116, 'đen', 8, 128, 4690000, 10, 1),
(194, 117, 'hồng', 6, 128, 3290000, 10, 1),
(195, 118, 'xám', 4, 64, 2490000, 10, 1),
(196, 119, 'xanh da trời', 6, 128, 7290000, 10, 1),
(197, 119, 'đen', 6, 128, 7290000, 10, 1),
(198, 121, 'đen', 8, 256, 9490000, 10, 1),
(199, 121, 'vàng', 8, 256, 9490000, 10, 1),
(200, 122, 'xanh', 6, 128, 200, 4, 1),
(201, 122, 'hồng', 6, 256, 200, 4, 1),
(202, 123, 'đen', 8, 128, 23000000, 10, 1),
(203, 123, 'trắng', 12, 128, 30000000, 10, 1),
(204, 124, 'đen', 8, 64, 13000000, 10, 1),
(205, 124, 'trắng', 12, 128, 14000000, 10, 1),
(206, 125, 'đen', 8, 256, 34000000, 10, 1),
(207, 125, 'trắng', 12, 512, 23000000, 10, 1),
(208, 126, 'đen', 8, 128, 43000000, 10, 1),
(209, 126, 'trắng', 12, 128, 35000000, 10, 1),
(210, 127, 'đen', 8, 64, 23000000, 10, 1),
(211, 127, 'trắng', 12, 128, 34000000, 10, 1),
(212, 128, 'đen', 6, 256, 20000000, 10, 1),
(213, 128, 'trắng', 8, 512, 23000000, 10, 1),
(214, 129, 'đen', 12, 128, 23000000, 9, 1),
(215, 129, 'trắng', 6, 128, 42000000, 10, 1),
(216, 130, 'đen', 8, 64, 23000000, 10, 1),
(217, 130, 'trắng', 12, 128, 22000000, 10, 1),
(218, 131, 'đen', 6, 256, 26000000, 10, 1),
(219, 131, 'trắng', 8, 512, 23000000, 9, 1),
(220, 132, 'đen', 12, 128, 32000000, 10, 1),
(221, 132, 'trắng', 6, 128, 30000000, 10, 1),
(222, 133, 'đen', 8, 64, 16000000, 10, 1),
(223, 133, 'trắng', 12, 128, 20000000, 10, 1),
(224, 134, 'đen', 6, 256, 29000000, 10, 1),
(225, 134, 'trắng', 8, 512, 25000000, 10, 1),
(226, 135, 'đen', 12, 128, 26000000, 10, 1),
(227, 135, 'trắng', 6, 128, 24000000, 10, 1),
(228, 136, 'đen', 8, 64, 24000000, 10, 1),
(229, 136, 'trắng', 12, 128, 26000000, 10, 1),
(230, 137, 'đen', 6, 256, 26000000, 10, 1),
(231, 137, 'trắng', 8, 512, 24000000, 10, 1),
(232, 138, 'đen', 12, 512, 27000000, 10, 1),
(233, 138, 'trắng', 6, 1024, 28000000, 10, 1),
(234, 139, 'đen', 8, 128, 23000000, 10, 1),
(235, 139, 'trắng', 12, 128, 30000000, 10, 1),
(236, 140, 'đen', 8, 64, 13000000, 10, 1),
(237, 140, 'trắng', 12, 128, 14000000, 10, 1),
(238, 141, 'đen', 8, 256, 34000000, 10, 1),
(239, 141, 'trắng', 12, 512, 23000000, 10, 1),
(240, 142, 'đen', 8, 128, 43000000, 10, 1),
(241, 142, 'trắng', 12, 128, 35000000, 10, 1),
(242, 143, 'đen', 8, 64, 23000000, 10, 1),
(243, 143, 'trắng', 12, 128, 34000000, 10, 1),
(244, 144, 'đen', 6, 256, 20000000, 10, 1),
(245, 144, 'trắng', 8, 512, 23000000, 10, 1),
(246, 145, 'đen', 12, 128, 23000000, 10, 1),
(247, 145, 'trắng', 6, 128, 42000000, 10, 1);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `name` varchar(256) NOT NULL,
  `version` varchar(256) NOT NULL,
  `brandID` int(11) NOT NULL,
  `cateID` int(11) NOT NULL,
  `config` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `thumbnail` varchar(256) NOT NULL,
  `firstsale` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `des` longtext DEFAULT NULL,
  `prominence` int(11) NOT NULL DEFAULT 1,
  `avai` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `products`
--

INSERT INTO `products` (`id`, `name`, `version`, `brandID`, `cateID`, `config`, `thumbnail`, `firstsale`, `des`, `prominence`, `avai`) VALUES
(52, 'iPhone 11', 'thường', 2, 1, '{\"screen\":\"oled\", \"display\":\"6.1 inch\", \"front-camera\":\"12mpx\", \"main-camera\":\"200mpx\",\"os\": \"IOS 14\", \"chip\": \"A16\",\"battery\":\"3000mah\", \"charge\":\"20w\", \"features\": [\"oled\",\"200mpx\"]}', 'iphone-11-trang-600x600.jpg', '{\"date\":\"2024-10-10\",\"initial-price\":19000000}', 'Thế hệ mới của nhà Táo ra mắt với nhiều màu sắc trẻ trung và cá tính, cho phép người dùng tự do lựa chọn theo sở thích riêng. Nút nguồn tích hợp Touch ID nằm ở cạnh trên máy giúp mở khóa và truy cập thiết bị nhanh chóng, đồng thời bảo vệ sự riêng tư một cách tốt hơn.', 103, 1),
(53, 'iPhone 12', 'thường', 2, 1, '{\"screen\":\"oled\", \"display\":\"6.1 inch\", \"front-camera\":\"12mpx\", \"main-camera\":\"200mpx\",\"os\": \"IOS 14\", \"chip\": \"A16\",\"battery\":\"3000mah\", \"charge\":\"20w\", \"features\": [\"oled\",\"200mpx\"]}', 'iphone-12-xanh-la-new-2-600x600.jpg', '{\"date\":\"2024-10-10\",\"initial-price\":19000000}', 'Thế hệ mới của nhà Táo ra mắt với nhiều màu sắc trẻ trung và cá tính, cho phép người dùng tự do lựa chọn theo sở thích riêng. Nút nguồn tích hợp Touch ID nằm ở cạnh trên máy giúp mở khóa và truy cập thiết bị nhanh chóng, đồng thời bảo vệ sự riêng tư một cách tốt hơn.', 180, 1),
(54, 'iPhone 13', 'thường', 2, 1, '{\"screen\":\"oled\", \"display\":\"6.1 inch\", \"front-camera\":\"12mpx\", \"main-camera\":\"200mpx\",\"os\": \"IOS 14\", \"chip\": \"A16\",\"battery\":\"3000mah\", \"charge\":\"20w\", \"features\": [\"oled\",\"200mpx\"]}', 'iphone-13-xanh-la-thumb-new-600x600.jpg', '{\"date\":\"2024-10-10\",\"initial-price\":19000000}', 'Thế hệ mới của nhà Táo ra mắt với nhiều màu sắc trẻ trung và cá tính, cho phép người dùng tự do lựa chọn theo sở thích riêng. Nút nguồn tích hợp Touch ID nằm ở cạnh trên máy giúp mở khóa và truy cập thiết bị nhanh chóng, đồng thời bảo vệ sự riêng tư một cách tốt hơn.', 42, 1),
(55, 'iPhone 14', 'Plus', 2, 1, '{\"screen\":\"oled\", \"display\":\"6.1 inch\", \"front-camera\":\"12mpx\", \"main-camera\":\"200mpx\",\"os\": \"IOS 14\", \"chip\": \"A16\",\"battery\":\"3000mah\", \"charge\":\"20w\", \"features\": [\"oled\",\"200mpx\"]}', 'iPhone-14-plus-thumb-xanh-1-600x600.jpg', '{\"date\":\"2024-10-10\",\"initial-price\":19000000}', 'Thế hệ mới của nhà Táo ra mắt với nhiều màu sắc trẻ trung và cá tính, cho phép người dùng tự do lựa chọn theo sở thích riêng. Nút nguồn tích hợp Touch ID nằm ở cạnh trên máy giúp mở khóa và truy cập thiết bị nhanh chóng, đồng thời bảo vệ sự riêng tư một cách tốt hơn.', 131, 1),
(56, 'iPhone 14', 'thường', 2, 1, '{\"screen\":\"oled\", \"display\":\"6.1 inch\", \"front-camera\":\"12mpx\", \"main-camera\":\"200mpx\",\"os\": \"IOS 14\", \"chip\": \"A16\",\"battery\":\"3000mah\", \"charge\":\"20w\", \"features\": [\"oled\",\"200mpx\"]}', 'iPhone-14-thumb-tim-1-600x600.jpg', '{\"date\":\"2024-10-10\",\"initial-price\":19000000}', 'Thế hệ mới của nhà Táo ra mắt với nhiều màu sắc trẻ trung và cá tính, cho phép người dùng tự do lựa chọn theo sở thích riêng. Nút nguồn tích hợp Touch ID nằm ở cạnh trên máy giúp mở khóa và truy cập thiết bị nhanh chóng, đồng thời bảo vệ sự riêng tư một cách tốt hơn.', 168, 1),
(57, 'iPhone 15', 'thường', 2, 1, '{\"screen\":\"oled\", \"display\":\"6.1 inch\", \"front-camera\":\"12mpx\", \"main-camera\":\"200mpx\",\"os\": \"IOS 14\", \"chip\": \"A16\",\"battery\":\"3000mah\", \"charge\":\"20w\", \"features\": [\"oled\",\"200mpx\"]}', 'iphone-15-hong-thumb-1-600x600.jpg', '{\"date\":\"2024-10-10\",\"initial-price\":19000000}', 'Thế hệ mới của nhà Táo ra mắt với nhiều màu sắc trẻ trung và cá tính, cho phép người dùng tự do lựa chọn theo sở thích riêng. Nút nguồn tích hợp Touch ID nằm ở cạnh trên máy giúp mở khóa và truy cập thiết bị nhanh chóng, đồng thời bảo vệ sự riêng tư một cách tốt hơn.', 21, 1),
(58, 'iPhone 15', 'Plus', 2, 1, '{\"screen\":\"oled\", \"display\":\"6.1 inch\", \"front-camera\":\"12mpx\", \"main-camera\":\"200mpx\",\"os\": \"IOS 14\", \"chip\": \"A16\",\"battery\":\"3000mah\", \"charge\":\"20w\", \"features\": [\"oled\",\"200mpx\"]}', 'iphone-15-plus-xanh-la-128gb-thumb-600x600.jpg', '{\"date\":\"2024-10-10\",\"initial-price\":19000000}', 'Thế hệ mới của nhà Táo ra mắt với nhiều màu sắc trẻ trung và cá tính, cho phép người dùng tự do lựa chọn theo sở thích riêng. Nút nguồn tích hợp Touch ID nằm ở cạnh trên máy giúp mở khóa và truy cập thiết bị nhanh chóng, đồng thời bảo vệ sự riêng tư một cách tốt hơn.', 46, 1),
(59, 'iPhone 15', 'Pro', 2, 1, '{\"screen\":\"oled\", \"display\":\"6.1 inch\", \"front-camera\":\"12mpx\", \"main-camera\":\"200mpx\",\"os\": \"IOS 14\", \"chip\": \"A16\",\"battery\":\"3000mah\", \"charge\":\"20w\", \"features\": [\"oled\",\"200mpx\"]}', 'iphone-15-pro-black-thumbnew-600x600.jpg', '{\"date\":\"2024-10-10\",\"initial-price\":19000000}', 'Thế hệ mới của nhà Táo ra mắt với nhiều màu sắc trẻ trung và cá tính, cho phép người dùng tự do lựa chọn theo sở thích riêng. Nút nguồn tích hợp Touch ID nằm ở cạnh trên máy giúp mở khóa và truy cập thiết bị nhanh chóng, đồng thời bảo vệ sự riêng tư một cách tốt hơn.', 32, 1),
(60, 'iPhone 15', 'Pro Max', 2, 1, '{\"screen\":\"oled\", \"display\":\"6.1 inch\", \"front-camera\":\"12mpx\", \"main-camera\":\"200mpx\",\"os\": \"IOS 14\", \"chip\": \"A16\",\"battery\":\"3000mah\", \"charge\":\"20w\", \"features\": [\"oled\",\"200mpx\"]}', 'iphone-15-pro-max-gold-thumbnew-600x600.jpg', '{\"date\":\"2024-10-10\",\"initial-price\":19000000}', 'Thế hệ mới của nhà Táo ra mắt với nhiều màu sắc trẻ trung và cá tính, cho phép người dùng tự do lựa chọn theo sở thích riêng. Nút nguồn tích hợp Touch ID nằm ở cạnh trên máy giúp mở khóa và truy cập thiết bị nhanh chóng, đồng thời bảo vệ sự riêng tư một cách tốt hơn.', 137, 1),
(61, 'iPhone 16', 'thường', 2, 1, '{\"screen\":\"oled\", \"display\":\"6.1 inch\", \"front-camera\":\"12mpx\", \"main-camera\":\"200mpx\",\"os\": \"IOS 14\", \"chip\": \"A16\",\"battery\":\"3000mah\", \"charge\":\"20w\", \"features\": [\"oled\",\"200mpx\"]}', 'iphone-16-blue-600x600.png', '{\"date\":\"2024-10-10\",\"initial-price\":19000000}', 'Thế hệ mới của nhà Táo ra mắt với nhiều màu sắc trẻ trung và cá tính, cho phép người dùng tự do lựa chọn theo sở thích riêng. Nút nguồn tích hợp Touch ID nằm ở cạnh trên máy giúp mở khóa và truy cập thiết bị nhanh chóng, đồng thời bảo vệ sự riêng tư một cách tốt hơn.', 116, 1),
(62, 'iPhone 16', 'Plus', 2, 1, '{\"screen\":\"oled\", \"display\":\"6.1 inch\", \"front-camera\":\"12mpx\", \"main-camera\":\"200mpx\",\"os\": \"IOS 14\", \"chip\": \"A16\",\"battery\":\"3000mah\", \"charge\":\"20w\", \"features\": [\"oled\",\"200mpx\"]}', 'iphone-16-plus-xanh-thumb-600x600.jpg', '{\"date\":\"2024-10-10\",\"initial-price\":19000000}', 'Thế hệ mới của nhà Táo ra mắt với nhiều màu sắc trẻ trung và cá tính, cho phép người dùng tự do lựa chọn theo sở thích riêng. Nút nguồn tích hợp Touch ID nằm ở cạnh trên máy giúp mở khóa và truy cập thiết bị nhanh chóng, đồng thời bảo vệ sự riêng tư một cách tốt hơn.', 11, 1),
(63, 'iPhone 16', 'Pro Max', 2, 1, '{\"screen\":\"oled\", \"display\":\"6.1 inch\", \"front-camera\":\"12mpx\", \"main-camera\":\"200mpx\",\"os\": \"IOS 14\", \"chip\": \"A16\",\"battery\":\"3000mah\", \"charge\":\"20w\", \"features\": [\"oled\",\"200mpx\"]}', 'iphone-16-pro-max-sa-mac-thumb-600x600.jpg', '{\"date\":\"2024-10-10\",\"initial-price\":19000000}', 'Thế hệ mới của nhà Táo ra mắt với nhiều màu sắc trẻ trung và cá tính, cho phép người dùng tự do lựa chọn theo sở thích riêng. Nút nguồn tích hợp Touch ID nằm ở cạnh trên máy giúp mở khóa và truy cập thiết bị nhanh chóng, đồng thời bảo vệ sự riêng tư một cách tốt hơn.', 146, 1),
(64, 'iPhone 16', 'Pro', 2, 1, '{\"screen\":\"oled\", \"display\":\"6.1 inch\", \"front-camera\":\"12mpx\", \"main-camera\":\"200mpx\",\"os\": \"IOS 14\", \"chip\": \"A16\",\"battery\":\"3000mah\", \"charge\":\"20w\", \"features\": [\"oled\",\"200mpx\"]}', 'iphone-16-pro-titan-tu-nhien.png', '{\"date\":\"2024-10-10\",\"initial-price\":19000000}', 'Thế hệ mới của nhà Táo ra mắt với nhiều màu sắc trẻ trung và cá tính, cho phép người dùng tự do lựa chọn theo sở thích riêng. Nút nguồn tích hợp Touch ID nằm ở cạnh trên máy giúp mở khóa và truy cập thiết bị nhanh chóng, đồng thời bảo vệ sự riêng tư một cách tốt hơn.', 114, 1),
(65, 'Oppo A18', 'thường', 3, 1, '{\"screen\":\"oled\", \"display\":\"6.1 inch\", \"front-camera\":\"12mpx\", \"main-camera\":\"200mpx\",\"os\": \"IOS 14\", \"chip\": \"A16\",\"battery\":\"3000mah\", \"charge\":\"20w\", \"features\": [\"oled\",\"200mpx\"]}', 'oppo-a18-xanh-thumb-1-2-3-600x600.jpg', '{\"date\":\"2024-10-10\",\"initial-price\":19000000}', 'Thế hệ mới của nhà Táo ra mắt với nhiều màu sắc trẻ trung và cá tính, cho phép người dùng tự do lựa chọn theo sở thích riêng. Nút nguồn tích hợp Touch ID nằm ở cạnh trên máy giúp mở khóa và truy cập thiết bị nhanh chóng, đồng thời bảo vệ sự riêng tư một cách tốt hơn.', 9, 1),
(66, 'Oppo A3', 'thường', 3, 1, '{\"screen\":\"oled\", \"display\":\"6.1 inch\", \"front-camera\":\"12mpx\", \"main-camera\":\"200mpx\",\"os\": \"IOS 14\", \"chip\": \"A16\",\"battery\":\"3000mah\", \"charge\":\"20w\", \"features\": [\"oled\",\"200mpx\"]}', 'oppo-a3-purple-thumb-1-600x600.jpg', '{\"date\":\"2024-10-10\",\"initial-price\":19000000}', 'Thế hệ mới của nhà Táo ra mắt với nhiều màu sắc trẻ trung và cá tính, cho phép người dùng tự do lựa chọn theo sở thích riêng. Nút nguồn tích hợp Touch ID nằm ở cạnh trên máy giúp mở khóa và truy cập thiết bị nhanh chóng, đồng thời bảo vệ sự riêng tư một cách tốt hơn.', 13, 1),
(67, 'Oppo A38', 'thường', 3, 1, '{\"screen\":\"oled\", \"display\":\"6.1 inch\", \"front-camera\":\"12mpx\", \"main-camera\":\"200mpx\",\"os\": \"IOS 14\", \"chip\": \"A16\",\"battery\":\"3000mah\", \"charge\":\"20w\", \"features\": [\"oled\",\"200mpx\"]}', 'oppo-a38-black-thumb-600x600.jpg', '{\"date\":\"2024-10-10\",\"initial-price\":19000000}', 'Thế hệ mới của nhà Táo ra mắt với nhiều màu sắc trẻ trung và cá tính, cho phép người dùng tự do lựa chọn theo sở thích riêng. Nút nguồn tích hợp Touch ID nằm ở cạnh trên máy giúp mở khóa và truy cập thiết bị nhanh chóng, đồng thời bảo vệ sự riêng tư một cách tốt hơn.', 23, 1),
(68, 'Oppo A3X', 'thường', 3, 1, '{\"screen\":\"oled\", \"display\":\"6.1 inch\", \"front-camera\":\"12mpx\", \"main-camera\":\"200mpx\",\"os\": \"IOS 14\", \"chip\": \"A16\",\"battery\":\"3000mah\", \"charge\":\"20w\", \"features\": [\"oled\",\"200mpx\"]}', 'oppo-a3x-red-thumb-600x600.jpg', '{\"date\":\"2024-10-10\",\"initial-price\":19000000}', 'Thế hệ mới của nhà Táo ra mắt với nhiều màu sắc trẻ trung và cá tính, cho phép người dùng tự do lựa chọn theo sở thích riêng. Nút nguồn tích hợp Touch ID nằm ở cạnh trên máy giúp mở khóa và truy cập thiết bị nhanh chóng, đồng thời bảo vệ sự riêng tư một cách tốt hơn.', 172, 1),
(69, 'Oppo A58', '5G', 3, 1, '{\"screen\":\"oled\", \"display\":\"6.1 inch\", \"front-camera\":\"12mpx\", \"main-camera\":\"200mpx\",\"os\": \"IOS 14\", \"chip\": \"A16\",\"battery\":\"3000mah\", \"charge\":\"20w\", \"features\": [\"oled\",\"200mpx\"]}', 'oppo-a58-4g-green-thumb-600x600.jpg', '{\"date\":\"2024-10-10\",\"initial-price\":19000000}', 'Thế hệ mới của nhà Táo ra mắt với nhiều màu sắc trẻ trung và cá tính, cho phép người dùng tự do lựa chọn theo sở thích riêng. Nút nguồn tích hợp Touch ID nằm ở cạnh trên máy giúp mở khóa và truy cập thiết bị nhanh chóng, đồng thời bảo vệ sự riêng tư một cách tốt hơn.', 191, 1),
(70, 'Oppo A60', 'thường', 3, 1, '{\"screen\":\"oled\", \"display\":\"6.1 inch\", \"front-camera\":\"12mpx\", \"main-camera\":\"200mpx\",\"os\": \"IOS 14\", \"chip\": \"A16\",\"battery\":\"3000mah\", \"charge\":\"20w\", \"features\": [\"oled\",\"200mpx\"]}', 'oppo-a60-blue-thumb-600x600.jpg', '{\"date\":\"2024-10-10\",\"initial-price\":19000000}', 'Thế hệ mới của nhà Táo ra mắt với nhiều màu sắc trẻ trung và cá tính, cho phép người dùng tự do lựa chọn theo sở thích riêng. Nút nguồn tích hợp Touch ID nằm ở cạnh trên máy giúp mở khóa và truy cập thiết bị nhanh chóng, đồng thời bảo vệ sự riêng tư một cách tốt hơn.', 124, 1),
(71, 'Oppo A78', 'thường', 3, 1, '{\"screen\":\"oled\", \"display\":\"6.1 inch\", \"front-camera\":\"12mpx\", \"main-camera\":\"200mpx\",\"os\": \"IOS 14\", \"chip\": \"A16\",\"battery\":\"3000mah\", \"charge\":\"20w\", \"features\": [\"oled\",\"200mpx\"]}', 'oppo-a78-xanh-thumb-1-600x600.jpg', '{\"date\":\"2024-10-10\",\"initial-price\":19000000}', 'Thế hệ mới của nhà Táo ra mắt với nhiều màu sắc trẻ trung và cá tính, cho phép người dùng tự do lựa chọn theo sở thích riêng. Nút nguồn tích hợp Touch ID nằm ở cạnh trên máy giúp mở khóa và truy cập thiết bị nhanh chóng, đồng thời bảo vệ sự riêng tư một cách tốt hơn.', 50, 1),
(72, 'Oppo A79', '5G', 3, 1, '{\"screen\":\"oled\", \"display\":\"6.1 inch\", \"front-camera\":\"12mpx\", \"main-camera\":\"200mpx\",\"os\": \"IOS 14\", \"chip\": \"A16\",\"battery\":\"3000mah\", \"charge\":\"20w\", \"features\": [\"oled\",\"200mpx\"]}', 'oppo-a79-5g-tim-thumb-1-2-600x600.jpg', '{\"date\":\"2024-10-10\",\"initial-price\":19000000}', 'Thế hệ mới của nhà Táo ra mắt với nhiều màu sắc trẻ trung và cá tính, cho phép người dùng tự do lựa chọn theo sở thích riêng. Nút nguồn tích hợp Touch ID nằm ở cạnh trên máy giúp mở khóa và truy cập thiết bị nhanh chóng, đồng thời bảo vệ sự riêng tư một cách tốt hơn.', 79, 1),
(73, 'Oppo Find N3 Flip', '5G', 3, 1, '{\"screen\":\"oled\", \"display\":\"6.1 inch\", \"front-camera\":\"12mpx\", \"main-camera\":\"200mpx\",\"os\": \"IOS 14\", \"chip\": \"A16\",\"battery\":\"3000mah\", \"charge\":\"20w\", \"features\": [\"oled\",\"200mpx\"]}', 'oppo-find-n3-flip-pink-thumb-600x600.jpeg', '{\"date\":\"2024-10-10\",\"initial-price\":19000000}', 'Thế hệ mới của nhà Táo ra mắt với nhiều màu sắc trẻ trung và cá tính, cho phép người dùng tự do lựa chọn theo sở thích riêng. Nút nguồn tích hợp Touch ID nằm ở cạnh trên máy giúp mở khóa và truy cập thiết bị nhanh chóng, đồng thời bảo vệ sự riêng tư một cách tốt hơn.', 169, 1),
(74, 'Oppo Find N3', '5G', 3, 1, '{\"screen\":\"oled\", \"display\":\"6.1 inch\", \"front-camera\":\"12mpx\", \"main-camera\":\"200mpx\",\"os\": \"IOS 14\", \"chip\": \"A16\",\"battery\":\"3000mah\", \"charge\":\"20w\", \"features\": [\"oled\",\"200mpx\"]}', 'oppo-find-n3-vang-dong-thumb-600x600.jpg', '{\"date\":\"2024-10-10\",\"initial-price\":19000000}', 'Thế hệ mới của nhà Táo ra mắt với nhiều màu sắc trẻ trung và cá tính, cho phép người dùng tự do lựa chọn theo sở thích riêng. Nút nguồn tích hợp Touch ID nằm ở cạnh trên máy giúp mở khóa và truy cập thiết bị nhanh chóng, đồng thời bảo vệ sự riêng tư một cách tốt hơn.', 133, 1),
(75, 'Oppo Reno 11', 'Pro', 3, 1, '{\"screen\":\"oled\", \"display\":\"6.1 inch\", \"front-camera\":\"12mpx\", \"main-camera\":\"200mpx\",\"os\": \"IOS 14\", \"chip\": \"A16\",\"battery\":\"3000mah\", \"charge\":\"20w\", \"features\": [\"oled\",\"200mpx\"]}', 'oppo-reno-11-pro-trang-thumb-600x600.jpg', '{\"date\":\"2024-10-10\",\"initial-price\":19000000}', 'Thế hệ mới của nhà Táo ra mắt với nhiều màu sắc trẻ trung và cá tính, cho phép người dùng tự do lựa chọn theo sở thích riêng. Nút nguồn tích hợp Touch ID nằm ở cạnh trên máy giúp mở khóa và truy cập thiết bị nhanh chóng, đồng thời bảo vệ sự riêng tư một cách tốt hơn.', 76, 1),
(76, 'Oppo Reno 11', 'thường', 3, 1, '{\"screen\":\"oled\", \"display\":\"6.1 inch\", \"front-camera\":\"12mpx\", \"main-camera\":\"200mpx\",\"os\": \"IOS 14\", \"chip\": \"A16\",\"battery\":\"3000mah\", \"charge\":\"20w\", \"features\": [\"oled\",\"200mpx\"]}', 'oppo-reno-11-xam-thumb-600x600.jpg', '{\"date\":\"2024-10-10\",\"initial-price\":19000000}', 'Thế hệ mới của nhà Táo ra mắt với nhiều màu sắc trẻ trung và cá tính, cho phép người dùng tự do lựa chọn theo sở thích riêng. Nút nguồn tích hợp Touch ID nằm ở cạnh trên máy giúp mở khóa và truy cập thiết bị nhanh chóng, đồng thời bảo vệ sự riêng tư một cách tốt hơn.', 117, 1),
(77, 'Oppo Reno10', 'Pro Plus', 3, 1, '{\"screen\":\"oled\", \"display\":\"6.1 inch\", \"front-camera\":\"12mpx\", \"main-camera\":\"200mpx\",\"os\": \"IOS 14\", \"chip\": \"A16\",\"battery\":\"3000mah\", \"charge\":\"20w\", \"features\": [\"oled\",\"200mpx\"]}', 'oppo-reno10-pro-plus-thumbnew-600x600.jpg', '{\"date\":\"2024-10-10\",\"initial-price\":19000000}', 'Thế hệ mới của nhà Táo ra mắt với nhiều màu sắc trẻ trung và cá tính, cho phép người dùng tự do lựa chọn theo sở thích riêng. Nút nguồn tích hợp Touch ID nằm ở cạnh trên máy giúp mở khóa và truy cập thiết bị nhanh chóng, đồng thời bảo vệ sự riêng tư một cách tốt hơn.', 156, 1),
(78, 'Oppo Reno11', 'F', 3, 1, '{\"screen\":\"oled\", \"display\":\"6.1 inch\", \"front-camera\":\"12mpx\", \"main-camera\":\"200mpx\",\"os\": \"IOS 14\", \"chip\": \"A16\",\"battery\":\"3000mah\", \"charge\":\"20w\", \"features\": [\"oled\",\"200mpx\"]}', 'banner.jpg', '{\"date\":\"2024-10-10\",\"initial-price\":19000000}', 'Thế hệ mới của nhà Táo ra mắt với nhiều màu sắc trẻ trung và cá tính, cho phép người dùng tự do lựa chọn theo sở thích riêng. Nút nguồn tích hợp Touch ID nằm ở cạnh trên máy giúp mở khóa và truy cập thiết bị nhanh chóng, đồng thời bảo vệ sự riêng tư một cách tốt hơn.', 196, 1),
(79, 'Oppo Reno12', '10G', 3, 1, '{\"screen\":\"oled\", \"display\":\"6.1 inch\", \"front-camera\":\"12mpx\", \"main-camera\":\"200mpx\",\"os\": \"IOS 14\", \"chip\": \"A16\",\"battery\":\"3000mah\", \"charge\":\"20w\", \"features\": [\"oled\",\"200mpx\"]}', 'banner.jpg', '{\"date\":\"2024-10-10\",\"initial-price\":19000000}', 'Thế hệ mới của nhà Táo ra mắt với nhiều màu sắc trẻ trung và cá tính, cho phép người dùng tự do lựa chọn theo sở thích riêng. Nút nguồn tích hợp Touch ID nằm ở cạnh trên máy giúp mở khóa và truy cập thiết bị nhanh chóng, đồng thời bảo vệ sự riêng tư một cách tốt hơn.', 202, 1),
(80, 'Oppo Reno12', '5G', 3, 1, '{\"screen\":\"oled\", \"display\":\"6.1 inch\", \"front-camera\":\"12mpx\", \"main-camera\":\"200mpx\",\"os\": \"IOS 14\", \"chip\": \"A16\",\"battery\":\"3000mah\", \"charge\":\"20w\", \"features\": [\"oled\",\"200mpx\"]}', 'oppo-reno12-5g-sliver-thumb-1-600x600.jpg', '{\"date\":\"2024-10-10\",\"initial-price\":19000000}', 'Thế hệ mới của nhà Táo ra mắt với nhiều màu sắc trẻ trung và cá tính, cho phép người dùng tự do lựa chọn theo sở thích riêng. Nút nguồn tích hợp Touch ID nằm ở cạnh trên máy giúp mở khóa và truy cập thiết bị nhanh chóng, đồng thời bảo vệ sự riêng tư một cách tốt hơn.', 147, 1),
(81, 'Oppo Reno12', 'F 4G', 3, 1, '{\"screen\":\"oled\", \"display\":\"6.1 inch\", \"front-camera\":\"12mpx\", \"main-camera\":\"200mpx\",\"os\": \"IOS 14\", \"chip\": \"A16\",\"battery\":\"3000mah\", \"charge\":\"20w\", \"features\": [\"oled\",\"200mpx\"]}', 'oppo-reno12-f-4g-green-thumb-600x600.jpg', '{\"date\":\"2024-10-10\",\"initial-price\":19000000}', 'Thế hệ mới của nhà Táo ra mắt với nhiều màu sắc trẻ trung và cá tính, cho phép người dùng tự do lựa chọn theo sở thích riêng. Nút nguồn tích hợp Touch ID nằm ở cạnh trên máy giúp mở khóa và truy cập thiết bị nhanh chóng, đồng thời bảo vệ sự riêng tư một cách tốt hơn.', 181, 1),
(82, 'Oppo Reno12', 'F 5G', 3, 1, '{\"screen\":\"oled\", \"display\":\"6.1 inch\", \"front-camera\":\"12mpx\", \"main-camera\":\"200mpx\",\"os\": \"IOS 14\", \"chip\": \"A16\",\"battery\":\"3000mah\", \"charge\":\"20w\", \"features\": [\"oled\",\"200mpx\"]}', 'iphone-15-pro-max-gold-thumbnew-600x600.jpg', '{\"date\":\"2024-10-10\",\"initial-price\":19000000}', 'Thế hệ mới của nhà Táo ra mắt với nhiều màu sắc trẻ trung và cá tính, cho phép người dùng tự do lựa chọn theo sở thích riêng. Nút nguồn tích hợp Touch ID nằm ở cạnh trên máy giúp mở khóa và truy cập thiết bị nhanh chóng, đồng thời bảo vệ sự riêng tư một cách tốt hơn.', 197, 1),
(83, 'Oppo Reno12', 'Pro 5G', 3, 1, '{\"screen\":\"oled\", \"display\":\"6.1 inch\", \"front-camera\":\"12mpx\", \"main-camera\":\"200mpx\",\"os\": \"IOS 14\", \"chip\": \"A16\",\"battery\":\"3000mah\", \"charge\":\"20w\", \"features\": [\"oled\",\"200mpx\"]}', 'oppo-reno12-pro-5g-sliver-thumb-600x600.jpg', '{\"date\":\"2024-10-10\",\"initial-price\":19000000}', 'Thế hệ mới của nhà Táo ra mắt với nhiều màu sắc trẻ trung và cá tính, cho phép người dùng tự do lựa chọn theo sở thích riêng. Nút nguồn tích hợp Touch ID nằm ở cạnh trên máy giúp mở khóa và truy cập thiết bị nhanh chóng, đồng thời bảo vệ sự riêng tư một cách tốt hơn.', 104, 1),
(84, 'Realme C51', 'thường', 5, 1, '{\"screen\":\"oled\", \"display\":\"6.1 inch\", \"front-camera\":\"12mpx\", \"main-camera\":\"200mpx\",\"os\": \"IOS 14\", \"chip\": \"A16\",\"battery\":\"3000mah\", \"charge\":\"20w\", \"features\": [\"oled\",\"200mpx\"]}', 'realme-c51-xanh-thumb-600x600.jpg', '{\"date\":\"2024-10-10\",\"initial-price\":19000000}', 'Thế hệ mới của nhà Táo ra mắt với nhiều màu sắc trẻ trung và cá tính, cho phép người dùng tự do lựa chọn theo sở thích riêng. Nút nguồn tích hợp Touch ID nằm ở cạnh trên máy giúp mở khóa và truy cập thiết bị nhanh chóng, đồng thời bảo vệ sự riêng tư một cách tốt hơn.', 176, 1),
(85, 'Realme C53', 'thường', 5, 1, '{\"screen\":\"oled\", \"display\":\"6.1 inch\", \"front-camera\":\"12mpx\", \"main-camera\":\"200mpx\",\"os\": \"IOS 14\", \"chip\": \"A16\",\"battery\":\"3000mah\", \"charge\":\"20w\", \"features\": [\"oled\",\"200mpx\"]}', 'realme-c53-gold-thumb-1-600x600.jpg', '{\"date\":\"2024-10-10\",\"initial-price\":19000000}', 'Thế hệ mới của nhà Táo ra mắt với nhiều màu sắc trẻ trung và cá tính, cho phép người dùng tự do lựa chọn theo sở thích riêng. Nút nguồn tích hợp Touch ID nằm ở cạnh trên máy giúp mở khóa và truy cập thiết bị nhanh chóng, đồng thời bảo vệ sự riêng tư một cách tốt hơn.', 39, 1),
(86, 'Realme C60', 'thường', 5, 1, '{\"screen\":\"oled\", \"display\":\"6.1 inch\", \"front-camera\":\"12mpx\", \"main-camera\":\"200mpx\",\"os\": \"IOS 14\", \"chip\": \"A16\",\"battery\":\"3000mah\", \"charge\":\"20w\", \"features\": [\"oled\",\"200mpx\"]}', 'realme-c60-blue-thumb-600x600.jpg', '{\"date\":\"2024-10-10\",\"initial-price\":19000000}', 'Thế hệ mới của nhà Táo ra mắt với nhiều màu sắc trẻ trung và cá tính, cho phép người dùng tự do lựa chọn theo sở thích riêng. Nút nguồn tích hợp Touch ID nằm ở cạnh trên máy giúp mở khóa và truy cập thiết bị nhanh chóng, đồng thời bảo vệ sự riêng tư một cách tốt hơn.', 105, 1),
(87, 'Realme C65', 'thường', 5, 1, '{\"screen\":\"oled\", \"display\":\"6.1 inch\", \"front-camera\":\"12mpx\", \"main-camera\":\"200mpx\",\"os\": \"IOS 14\", \"chip\": \"A16\",\"battery\":\"3000mah\", \"charge\":\"20w\", \"features\": [\"oled\",\"200mpx\"]}', 'realme-c65-purple-thumb-600x600.jpg', '{\"date\":\"2024-10-10\",\"initial-price\":19000000}', 'Thế hệ mới của nhà Táo ra mắt với nhiều màu sắc trẻ trung và cá tính, cho phép người dùng tự do lựa chọn theo sở thích riêng. Nút nguồn tích hợp Touch ID nằm ở cạnh trên máy giúp mở khóa và truy cập thiết bị nhanh chóng, đồng thời bảo vệ sự riêng tư một cách tốt hơn.', 73, 1),
(88, 'Realme C65', 'S', 5, 1, '{\"screen\":\"oled\", \"display\":\"6.1 inch\", \"front-camera\":\"12mpx\", \"main-camera\":\"200mpx\",\"os\": \"IOS 14\", \"chip\": \"A16\",\"battery\":\"3000mah\", \"charge\":\"20w\", \"features\": [\"oled\",\"200mpx\"]}', 'realme-c65s-blue-thumb-1-600x600.jpg', '{\"date\":\"2024-10-10\",\"initial-price\":19000000}', 'Thế hệ mới của nhà Táo ra mắt với nhiều màu sắc trẻ trung và cá tính, cho phép người dùng tự do lựa chọn theo sở thích riêng. Nút nguồn tích hợp Touch ID nằm ở cạnh trên máy giúp mở khóa và truy cập thiết bị nhanh chóng, đồng thời bảo vệ sự riêng tư một cách tốt hơn.', 150, 1),
(89, 'Realme C67', 'thường', 5, 1, '{\"screen\":\"oled\", \"display\":\"6.1 inch\", \"front-camera\":\"12mpx\", \"main-camera\":\"200mpx\",\"os\": \"IOS 14\", \"chip\": \"A16\",\"battery\":\"3000mah\", \"charge\":\"20w\", \"features\": [\"oled\",\"200mpx\"]}', 'realme-c67-xanh-thumb-600x600.jpg', '{\"date\":\"2024-10-10\",\"initial-price\":19000000}', 'Thế hệ mới của nhà Táo ra mắt với nhiều màu sắc trẻ trung và cá tính, cho phép người dùng tự do lựa chọn theo sở thích riêng. Nút nguồn tích hợp Touch ID nằm ở cạnh trên máy giúp mở khóa và truy cập thiết bị nhanh chóng, đồng thời bảo vệ sự riêng tư một cách tốt hơn.', 32, 1),
(90, 'Realme Note 50', 'thường', 5, 1, '{\"screen\":\"oled\", \"display\":\"6.1 inch\", \"front-camera\":\"12mpx\", \"main-camera\":\"200mpx\",\"os\": \"IOS 14\", \"chip\": \"A16\",\"battery\":\"3000mah\", \"charge\":\"20w\", \"features\": [\"oled\",\"200mpx\"]}', 'realme-note-50-blue-thumb-600x600.jpg', '{\"date\":\"2024-10-10\",\"initial-price\":19000000}', 'Thế hệ mới của nhà Táo ra mắt với nhiều màu sắc trẻ trung và cá tính, cho phép người dùng tự do lựa chọn theo sở thích riêng. Nút nguồn tích hợp Touch ID nằm ở cạnh trên máy giúp mở khóa và truy cập thiết bị nhanh chóng, đồng thời bảo vệ sự riêng tư một cách tốt hơn.', 172, 1),
(91, 'Redmi 13', 'thường', 4, 1, '{\"screen\":\"oled\", \"display\":\"6.1 inch\", \"front-camera\":\"12mpx\", \"main-camera\":\"200mpx\",\"os\": \"IOS 14\", \"chip\": \"A16\",\"battery\":\"3000mah\", \"charge\":\"20w\", \"features\": [\"oled\",\"200mpx\"]}', 'redmi-13-blue-thumb-600x600.jpg', '{\"date\":\"2024-10-10\",\"initial-price\":19000000}', 'Thế hệ mới của nhà Táo ra mắt với nhiều màu sắc trẻ trung và cá tính, cho phép người dùng tự do lựa chọn theo sở thích riêng. Nút nguồn tích hợp Touch ID nằm ở cạnh trên máy giúp mở khóa và truy cập thiết bị nhanh chóng, đồng thời bảo vệ sự riêng tư một cách tốt hơn.', 64, 1),
(92, 'Samsung Galaxy A05', 'S', 1, 1, '{\"screen\":\"oled\", \"display\":\"6.1 inch\", \"front-camera\":\"12mpx\", \"main-camera\":\"200mpx\",\"os\": \"IOS 14\", \"chip\": \"A16\",\"battery\":\"3000mah\", \"charge\":\"20w\", \"features\": [\"oled\",\"200mpx\"]}', 'samsung-galaxy-a05s-sliver-thumbnew-600x600.jpg', '{\"date\":\"2024-10-10\",\"initial-price\":19000000}', 'Thế hệ mới của nhà Táo ra mắt với nhiều màu sắc trẻ trung và cá tính, cho phép người dùng tự do lựa chọn theo sở thích riêng. Nút nguồn tích hợp Touch ID nằm ở cạnh trên máy giúp mở khóa và truy cập thiết bị nhanh chóng, đồng thời bảo vệ sự riêng tư một cách tốt hơn.', 190, 1),
(93, 'Samsung Galaxy A06', 'thường', 1, 1, '{\"screen\":\"oled\", \"display\":\"6.1 inch\", \"front-camera\":\"12mpx\", \"main-camera\":\"200mpx\",\"os\": \"IOS 14\", \"chip\": \"A16\",\"battery\":\"3000mah\", \"charge\":\"20w\", \"features\": [\"oled\",\"200mpx\"]}', 'samsung-galaxy-a06-green-thumb-600x600.jpg', '{\"date\":\"2024-10-10\",\"initial-price\":19000000}', 'Thế hệ mới của nhà Táo ra mắt với nhiều màu sắc trẻ trung và cá tính, cho phép người dùng tự do lựa chọn theo sở thích riêng. Nút nguồn tích hợp Touch ID nằm ở cạnh trên máy giúp mở khóa và truy cập thiết bị nhanh chóng, đồng thời bảo vệ sự riêng tư một cách tốt hơn.', 130, 1),
(94, 'Samsung Galaxy A15', '4G', 1, 1, '{\"screen\":\"oled\", \"display\":\"6.1 inch\", \"front-camera\":\"12mpx\", \"main-camera\":\"200mpx\",\"os\": \"IOS 14\", \"chip\": \"A16\",\"battery\":\"3000mah\", \"charge\":\"20w\", \"features\": [\"oled\",\"200mpx\"]}', 'samsung-galaxy-a15-4g-xanh-thumb.jpg', '{\"date\":\"2024-10-10\",\"initial-price\":19000000}', 'Thế hệ mới của nhà Táo ra mắt với nhiều màu sắc trẻ trung và cá tính, cho phép người dùng tự do lựa chọn theo sở thích riêng. Nút nguồn tích hợp Touch ID nằm ở cạnh trên máy giúp mở khóa và truy cập thiết bị nhanh chóng, đồng thời bảo vệ sự riêng tư một cách tốt hơn.', 182, 1),
(95, 'Samsung Galaxy A16', '5G', 1, 1, '{\"screen\":\"oled\", \"display\":\"6.1 inch\", \"front-camera\":\"12mpx\", \"main-camera\":\"200mpx\",\"os\": \"IOS 14\", \"chip\": \"A16\",\"battery\":\"3000mah\", \"charge\":\"20w\", \"features\": [\"oled\",\"200mpx\"]}', 'samsung-galaxy-a16-5g-gold-thumbnew-600x600.jpg', '{\"date\":\"2024-10-10\",\"initial-price\":19000000}', 'Thế hệ mới của nhà Táo ra mắt với nhiều màu sắc trẻ trung và cá tính, cho phép người dùng tự do lựa chọn theo sở thích riêng. Nút nguồn tích hợp Touch ID nằm ở cạnh trên máy giúp mở khóa và truy cập thiết bị nhanh chóng, đồng thời bảo vệ sự riêng tư một cách tốt hơn.', 167, 1),
(96, 'Samsung Galaxy A16', 'thường', 1, 1, '{\"screen\":\"oled\", \"display\":\"6.1 inch\", \"front-camera\":\"12mpx\", \"main-camera\":\"200mpx\",\"os\": \"IOS 14\", \"chip\": \"A16\",\"battery\":\"3000mah\", \"charge\":\"20w\", \"features\": [\"oled\",\"200mpx\"]}', 'samsung-galaxy-a16-green-thumbnew-600x600.jpg', '{\"date\":\"2024-10-10\",\"initial-price\":19000000}', 'Thế hệ mới của nhà Táo ra mắt với nhiều màu sắc trẻ trung và cá tính, cho phép người dùng tự do lựa chọn theo sở thích riêng. Nút nguồn tích hợp Touch ID nằm ở cạnh trên máy giúp mở khóa và truy cập thiết bị nhanh chóng, đồng thời bảo vệ sự riêng tư một cách tốt hơn.', 32, 1),
(97, 'Samsung Galaxy A25', '5G', 1, 1, '{\"screen\":\"oled\", \"display\":\"6.1 inch\", \"front-camera\":\"12mpx\", \"main-camera\":\"200mpx\",\"os\": \"IOS 14\", \"chip\": \"A16\",\"battery\":\"3000mah\", \"charge\":\"20w\", \"features\": [\"oled\",\"200mpx\"]}', 'samsung-galaxy-a25-5g-xanh-duong-thumb-600x600.jpg', '{\"date\":\"2024-10-10\",\"initial-price\":19000000}', 'Thế hệ mới của nhà Táo ra mắt với nhiều màu sắc trẻ trung và cá tính, cho phép người dùng tự do lựa chọn theo sở thích riêng. Nút nguồn tích hợp Touch ID nằm ở cạnh trên máy giúp mở khóa và truy cập thiết bị nhanh chóng, đồng thời bảo vệ sự riêng tư một cách tốt hơn.', 49, 1),
(98, 'Samsung Galaxy A35', '5G', 1, 1, '{\"screen\":\"oled\", \"display\":\"6.1 inch\", \"front-camera\":\"12mpx\", \"main-camera\":\"200mpx\",\"os\": \"IOS 14\", \"chip\": \"A16\",\"battery\":\"3000mah\", \"charge\":\"20w\", \"features\": [\"oled\",\"200mpx\"]}', 'samsung-galaxy-a35-5g-xanh-thumb-1-600x600.jpg', '{\"date\":\"2024-10-10\",\"initial-price\":19000000}', 'Thế hệ mới của nhà Táo ra mắt với nhiều màu sắc trẻ trung và cá tính, cho phép người dùng tự do lựa chọn theo sở thích riêng. Nút nguồn tích hợp Touch ID nằm ở cạnh trên máy giúp mở khóa và truy cập thiết bị nhanh chóng, đồng thời bảo vệ sự riêng tư một cách tốt hơn.', 136, 1),
(99, 'Samsung Galaxy A55', '5G', 1, 1, '{\"screen\":\"oled\", \"display\":\"6.1 inch\", \"front-camera\":\"12mpx\", \"main-camera\":\"200mpx\",\"os\": \"IOS 14\", \"chip\": \"A16\",\"battery\":\"3000mah\", \"charge\":\"20w\", \"features\": [\"oled\",\"200mpx\"]}', 'samsung-galaxy-a55-5g-xanh-thumb-1-600x600.jpg', '{\"date\":\"2024-10-10\",\"initial-price\":19000000}', 'Thế hệ mới của nhà Táo ra mắt với nhiều màu sắc trẻ trung và cá tính, cho phép người dùng tự do lựa chọn theo sở thích riêng. Nút nguồn tích hợp Touch ID nằm ở cạnh trên máy giúp mở khóa và truy cập thiết bị nhanh chóng, đồng thời bảo vệ sự riêng tư một cách tốt hơn.', 33, 1),
(100, 'Samsung Galaxy M15', '5G', 1, 1, '{\"screen\":\"oled\", \"display\":\"6.1 inch\", \"front-camera\":\"12mpx\", \"main-camera\":\"200mpx\",\"os\": \"IOS 14\", \"chip\": \"A16\",\"battery\":\"3000mah\", \"charge\":\"20w\", \"features\": [\"oled\",\"200mpx\"]}', 'samsung-galaxy-m15-5g-blue-thumb-1-600x600.jpg', '{\"date\":\"2024-10-10\",\"initial-price\":19000000}', 'Thế hệ mới của nhà Táo ra mắt với nhiều màu sắc trẻ trung và cá tính, cho phép người dùng tự do lựa chọn theo sở thích riêng. Nút nguồn tích hợp Touch ID nằm ở cạnh trên máy giúp mở khóa và truy cập thiết bị nhanh chóng, đồng thời bảo vệ sự riêng tư một cách tốt hơn.', 175, 1),
(101, 'Samsung Galaxy M35', '5G', 1, 1, '{\"screen\":\"oled\", \"display\":\"6.1 inch\", \"front-camera\":\"12mpx\", \"main-camera\":\"200mpx\",\"os\": \"IOS 14\", \"chip\": \"A16\",\"battery\":\"3000mah\", \"charge\":\"20w\", \"features\": [\"oled\",\"200mpx\"]}', 'samsung-galaxy-m35-5g-xanhdam-thumb-600x600.jpg', '{\"date\":\"2024-10-10\",\"initial-price\":19000000}', 'Thế hệ mới của nhà Táo ra mắt với nhiều màu sắc trẻ trung và cá tính, cho phép người dùng tự do lựa chọn theo sở thích riêng. Nút nguồn tích hợp Touch ID nằm ở cạnh trên máy giúp mở khóa và truy cập thiết bị nhanh chóng, đồng thời bảo vệ sự riêng tư một cách tốt hơn.', 54, 1),
(102, 'Samsung Galaxy M54', 'thường', 1, 1, '{\"screen\":\"oled\", \"display\":\"6.1 inch\", \"front-camera\":\"12mpx\", \"main-camera\":\"200mpx\",\"os\": \"IOS 14\", \"chip\": \"A16\",\"battery\":\"3000mah\", \"charge\":\"20w\", \"features\": [\"oled\",\"200mpx\"]}', 'samsung-galaxy-m54-xanh-thumb-600x600.jpg', '{\"date\":\"2024-10-10\",\"initial-price\":19000000}', 'Thế hệ mới của nhà Táo ra mắt với nhiều màu sắc trẻ trung và cá tính, cho phép người dùng tự do lựa chọn theo sở thích riêng. Nút nguồn tích hợp Touch ID nằm ở cạnh trên máy giúp mở khóa và truy cập thiết bị nhanh chóng, đồng thời bảo vệ sự riêng tư một cách tốt hơn.', 175, 1),
(103, 'Samsung Galaxy M55', '5G', 1, 1, '{\"screen\":\"oled\", \"display\":\"6.1 inch\", \"front-camera\":\"12mpx\", \"main-camera\":\"200mpx\",\"os\": \"IOS 14\", \"chip\": \"A16\",\"battery\":\"3000mah\", \"charge\":\"20w\", \"features\": [\"oled\",\"200mpx\"]}', 'samsung-galaxy-m55-5g-black-thumb-600x600.jpg', '{\"date\":\"2024-10-10\",\"initial-price\":19000000}', 'Thế hệ mới của nhà Táo ra mắt với nhiều màu sắc trẻ trung và cá tính, cho phép người dùng tự do lựa chọn theo sở thích riêng. Nút nguồn tích hợp Touch ID nằm ở cạnh trên máy giúp mở khóa và truy cập thiết bị nhanh chóng, đồng thời bảo vệ sự riêng tư một cách tốt hơn.', 29, 1),
(104, 'Samsung Galaxy S23', 'Fe', 1, 1, '{\"screen\":\"oled\", \"display\":\"6.1 inch\", \"front-camera\":\"12mpx\", \"main-camera\":\"200mpx\",\"os\": \"IOS 14\", \"chip\": \"A16\",\"battery\":\"3000mah\", \"charge\":\"20w\", \"features\": [\"oled\",\"200mpx\"]}', 'samsung-galaxy-s23-fe-mint-thumbnew-600x600.jpg', '{\"date\":\"2024-10-10\",\"initial-price\":19000000}', 'Thế hệ mới của nhà Táo ra mắt với nhiều màu sắc trẻ trung và cá tính, cho phép người dùng tự do lựa chọn theo sở thích riêng. Nút nguồn tích hợp Touch ID nằm ở cạnh trên máy giúp mở khóa và truy cập thiết bị nhanh chóng, đồng thời bảo vệ sự riêng tư một cách tốt hơn.', 147, 1),
(105, 'Samsung Galaxy S23', 'Ultra', 1, 1, '{\"screen\":\"oled\", \"display\":\"6.1 inch\", \"front-camera\":\"12mpx\", \"main-camera\":\"200mpx\",\"os\": \"IOS 14\", \"chip\": \"A16\",\"battery\":\"3000mah\", \"charge\":\"20w\", \"features\": [\"oled\",\"200mpx\"]}', 'samsung-galaxy-s23-ultra-green-thumbnew-600x600.jpg', '{\"date\":\"2024-10-10\",\"initial-price\":19000000}', 'Thế hệ mới của nhà Táo ra mắt với nhiều màu sắc trẻ trung và cá tính, cho phép người dùng tự do lựa chọn theo sở thích riêng. Nút nguồn tích hợp Touch ID nằm ở cạnh trên máy giúp mở khóa và truy cập thiết bị nhanh chóng, đồng thời bảo vệ sự riêng tư một cách tốt hơn.', 135, 1),
(106, 'Samsung Galaxy S24', 'Fe', 1, 1, '{\"screen\":\"oled\", \"display\":\"6.1 inch\", \"front-camera\":\"12mpx\", \"main-camera\":\"200mpx\",\"os\": \"IOS 14\", \"chip\": \"A16\",\"battery\":\"3000mah\", \"charge\":\"20w\", \"features\": [\"oled\",\"200mpx\"]}', 'samsung-galaxy-s24-fe-mint-thumb-1-600x600.jpg', '{\"date\":\"2024-10-10\",\"initial-price\":19000000}', 'Thế hệ mới của nhà Táo ra mắt với nhiều màu sắc trẻ trung và cá tính, cho phép người dùng tự do lựa chọn theo sở thích riêng. Nút nguồn tích hợp Touch ID nằm ở cạnh trên máy giúp mở khóa và truy cập thiết bị nhanh chóng, đồng thời bảo vệ sự riêng tư một cách tốt hơn.', 5, 1),
(107, 'Samsung Galaxy S24', 'Plus', 1, 1, '{\"screen\":\"oled\", \"display\":\"6.1 inch\", \"front-camera\":\"12mpx\", \"main-camera\":\"200mpx\",\"os\": \"IOS 14\", \"chip\": \"A16\",\"battery\":\"3000mah\", \"charge\":\"20w\", \"features\": [\"oled\",\"200mpx\"]}', 'samsung-galaxy-s24-plus-violet-thumbnew-600x600.jpg', '{\"date\":\"2024-10-10\",\"initial-price\":19000000}', 'Thế hệ mới của nhà Táo ra mắt với nhiều màu sắc trẻ trung và cá tính, cho phép người dùng tự do lựa chọn theo sở thích riêng. Nút nguồn tích hợp Touch ID nằm ở cạnh trên máy giúp mở khóa và truy cập thiết bị nhanh chóng, đồng thời bảo vệ sự riêng tư một cách tốt hơn.', 138, 1),
(108, 'Samsung Galaxy S24', 'Ultra', 1, 1, '{\"screen\":\"oled\", \"display\":\"6.1 inch\", \"front-camera\":\"12mpx\", \"main-camera\":\"200mpx\",\"os\": \"IOS 14\", \"chip\": \"A16\",\"battery\":\"3000mah\", \"charge\":\"20w\", \"features\": [\"oled\",\"200mpx\"]}', 'samsung-galaxy-s24-ultra-grey-thumbnew-600x600.jpg', '{\"date\":\"2024-10-10\",\"initial-price\":19000000}', 'Thế hệ mới của nhà Táo ra mắt với nhiều màu sắc trẻ trung và cá tính, cho phép người dùng tự do lựa chọn theo sở thích riêng. Nút nguồn tích hợp Touch ID nằm ở cạnh trên máy giúp mở khóa và truy cập thiết bị nhanh chóng, đồng thời bảo vệ sự riêng tư một cách tốt hơn.', 32, 1),
(109, 'Samsung Galaxy S24', 'thường', 1, 1, '{\"screen\":\"oled\", \"display\":\"6.1 inch\", \"front-camera\":\"12mpx\", \"main-camera\":\"200mpx\",\"os\": \"IOS 14\", \"chip\": \"A16\",\"battery\":\"3000mah\", \"charge\":\"20w\", \"features\": [\"oled\",\"200mpx\"]}', 'samsung-galaxy-s24-yellow-thumbnew-600x600.jpg', '{\"date\":\"2024-10-10\",\"initial-price\":19000000}', 'Thế hệ mới của nhà Táo ra mắt với nhiều màu sắc trẻ trung và cá tính, cho phép người dùng tự do lựa chọn theo sở thích riêng. Nút nguồn tích hợp Touch ID nằm ở cạnh trên máy giúp mở khóa và truy cập thiết bị nhanh chóng, đồng thời bảo vệ sự riêng tư một cách tốt hơn.', 24, 1),
(110, 'Samsung Galaxy Z Fold6', '5G', 1, 1, '{\"screen\":\"oled\", \"display\":\"6.1 inch\", \"front-camera\":\"12mpx\", \"main-camera\":\"200mpx\",\"os\": \"IOS 14\", \"chip\": \"A16\",\"battery\":\"3000mah\", \"charge\":\"20w\", \"features\": [\"oled\",\"200mpx\"]}', 'samsung-galaxy-z-fold6-xam-thumbn-600x600.jpg', '{\"date\":\"2024-10-10\",\"initial-price\":19000000}', 'Thế hệ mới của nhà Táo ra mắt với nhiều màu sắc trẻ trung và cá tính, cho phép người dùng tự do lựa chọn theo sở thích riêng. Nút nguồn tích hợp Touch ID nằm ở cạnh trên máy giúp mở khóa và truy cập thiết bị nhanh chóng, đồng thời bảo vệ sự riêng tư một cách tốt hơn.', 122, 1),
(111, 'Xiaomi 14', 'thường', 4, 1, '{\"screen\":\"oled\", \"display\":\"6.1 inch\", \"front-camera\":\"12mpx\", \"main-camera\":\"200mpx\",\"os\": \"IOS 14\", \"chip\": \"A16\",\"battery\":\"3000mah\", \"charge\":\"20w\", \"features\": [\"oled\",\"200mpx\"]}', 'iphone-15-pro-max-gold-thumbnew-600x600.jpg', '{\"date\":\"2024-10-10\",\"initial-price\":19000000}', 'Thế hệ mới của nhà Táo ra mắt với nhiều màu sắc trẻ trung và cá tính, cho phép người dùng tự do lựa chọn theo sở thích riêng. Nút nguồn tích hợp Touch ID nằm ở cạnh trên máy giúp mở khóa và truy cập thiết bị nhanh chóng, đồng thời bảo vệ sự riêng tư một cách tốt hơn.', 193, 1),
(112, 'Xiaomi 14', 'Ultra', 4, 1, '{\"screen\":\"oled\", \"display\":\"6.1 inch\", \"front-camera\":\"12mpx\", \"main-camera\":\"200mpx\",\"os\": \"IOS 14\", \"chip\": \"A16\",\"battery\":\"3000mah\", \"charge\":\"20w\", \"features\": [\"oled\",\"200mpx\"]}', 'xiaomi-14-ultra-black-thumbnew-600x600.jpg', '{\"date\":\"2024-10-10\",\"initial-price\":19000000}', 'Thế hệ mới của nhà Táo ra mắt với nhiều màu sắc trẻ trung và cá tính, cho phép người dùng tự do lựa chọn theo sở thích riêng. Nút nguồn tích hợp Touch ID nằm ở cạnh trên máy giúp mở khóa và truy cập thiết bị nhanh chóng, đồng thời bảo vệ sự riêng tư một cách tốt hơn.', 132, 1),
(113, 'Xiaomi 14', 'T', 4, 1, '{\"screen\":\"oled\", \"display\":\"6.1 inch\", \"front-camera\":\"12mpx\", \"main-camera\":\"200mpx\",\"os\": \"IOS 14\", \"chip\": \"A16\",\"battery\":\"3000mah\", \"charge\":\"20w\", \"features\": [\"oled\",\"200mpx\"]}', 'xiaomi-14t-blue-thumb-600x600.jpg', '{\"date\":\"2024-10-10\",\"initial-price\":19000000}', 'Thế hệ mới của nhà Táo ra mắt với nhiều màu sắc trẻ trung và cá tính, cho phép người dùng tự do lựa chọn theo sở thích riêng. Nút nguồn tích hợp Touch ID nằm ở cạnh trên máy giúp mở khóa và truy cập thiết bị nhanh chóng, đồng thời bảo vệ sự riêng tư một cách tốt hơn.', 98, 1),
(114, 'Xiaomi 14', 'T', 4, 1, '{\"screen\":\"oled\", \"display\":\"6.1 inch\", \"front-camera\":\"12mpx\", \"main-camera\":\"200mpx\",\"os\": \"IOS 14\", \"chip\": \"A16\",\"battery\":\"3000mah\", \"charge\":\"20w\", \"features\": [\"oled\",\"200mpx\"]}', 'xiaomi-14t-grey-thumb-600x600.jpg', '{\"date\":\"2024-10-10\",\"initial-price\":19000000}', 'Thế hệ mới của nhà Táo ra mắt với nhiều màu sắc trẻ trung và cá tính, cho phép người dùng tự do lựa chọn theo sở thích riêng. Nút nguồn tích hợp Touch ID nằm ở cạnh trên máy giúp mở khóa và truy cập thiết bị nhanh chóng, đồng thời bảo vệ sự riêng tư một cách tốt hơn.', 154, 1),
(115, 'Xiaomi 14', 'T Pro', 4, 1, '{\"screen\":\"oled\", \"display\":\"6.1 inch\", \"front-camera\":\"12mpx\", \"main-camera\":\"200mpx\",\"os\": \"IOS 14\", \"chip\": \"A16\",\"battery\":\"3000mah\", \"charge\":\"20w\", \"features\": [\"oled\",\"200mpx\"]}', 'xiaomi-14t-pro-blue-thumb-600x600.jpg', '{\"date\":\"2024-10-10\",\"initial-price\":19000000}', 'Thế hệ mới của nhà Táo ra mắt với nhiều màu sắc trẻ trung và cá tính, cho phép người dùng tự do lựa chọn theo sở thích riêng. Nút nguồn tích hợp Touch ID nằm ở cạnh trên máy giúp mở khóa và truy cập thiết bị nhanh chóng, đồng thời bảo vệ sự riêng tư một cách tốt hơn.', 166, 1),
(116, 'Xiaomi Poco M6', 'thường', 4, 1, '{\"screen\":\"oled\", \"display\":\"6.1 inch\", \"front-camera\":\"12mpx\", \"main-camera\":\"200mpx\",\"os\": \"IOS 14\", \"chip\": \"A16\",\"battery\":\"3000mah\", \"charge\":\"20w\", \"features\": [\"oled\",\"200mpx\"]}', 'xiaomi-poco-m6-black-thumb-600x600.jpg', '{\"date\":\"2024-10-10\",\"initial-price\":19000000}', 'Thế hệ mới của nhà Táo ra mắt với nhiều màu sắc trẻ trung và cá tính, cho phép người dùng tự do lựa chọn theo sở thích riêng. Nút nguồn tích hợp Touch ID nằm ở cạnh trên máy giúp mở khóa và truy cập thiết bị nhanh chóng, đồng thời bảo vệ sự riêng tư một cách tốt hơn.', 126, 1),
(117, 'Xiaomi Redmi 14C', 'thường', 4, 1, '{\"screen\":\"oled\", \"display\":\"6.1 inch\", \"front-camera\":\"12mpx\", \"main-camera\":\"200mpx\",\"os\": \"IOS 14\", \"chip\": \"A16\",\"battery\":\"3000mah\", \"charge\":\"20w\", \"features\": [\"oled\",\"200mpx\"]}', 'xiaomi-redmi-14c-blue-1-600x600.jpg', '{\"date\":\"2024-10-10\",\"initial-price\":19000000}', 'Thế hệ mới của nhà Táo ra mắt với nhiều màu sắc trẻ trung và cá tính, cho phép người dùng tự do lựa chọn theo sở thích riêng. Nút nguồn tích hợp Touch ID nằm ở cạnh trên máy giúp mở khóa và truy cập thiết bị nhanh chóng, đồng thời bảo vệ sự riêng tư một cách tốt hơn.', 30, 1),
(118, 'Xiaomi Redmi A3', 'thường', 4, 1, '{\"screen\":\"oled\", \"display\":\"6.1 inch\", \"front-camera\":\"12mpx\", \"main-camera\":\"200mpx\",\"os\": \"IOS 14\", \"chip\": \"A16\",\"battery\":\"3000mah\", \"charge\":\"20w\", \"features\": [\"oled\",\"200mpx\"]}', 'xiaomi-redmi-a3-xanh-lá-thumb-600x600.jpg', '{\"date\":\"2024-10-10\",\"initial-price\":19000000}', 'Thế hệ mới của nhà Táo ra mắt với nhiều màu sắc trẻ trung và cá tính, cho phép người dùng tự do lựa chọn theo sở thích riêng. Nút nguồn tích hợp Touch ID nằm ở cạnh trên máy giúp mở khóa và truy cập thiết bị nhanh chóng, đồng thời bảo vệ sự riêng tư một cách tốt hơn.', 184, 1),
(119, 'Xiaomi Redmi Note 13', 'thường', 4, 1, '{\"screen\":\"oled\", \"display\":\"6.1 inch\", \"front-camera\":\"12mpx\", \"main-camera\":\"200mpx\",\"os\": \"IOS 14\", \"chip\": \"A16\",\"battery\":\"3000mah\", \"charge\":\"20w\", \"features\": [\"oled\",\"200mpx\"]}', 'xiaomi-redmi-note-13-gold-thumb-600x600.jpg', '{\"date\":\"2024-10-10\",\"initial-price\":19000000}', 'Thế hệ mới của nhà Táo ra mắt với nhiều màu sắc trẻ trung và cá tính, cho phép người dùng tự do lựa chọn theo sở thích riêng. Nút nguồn tích hợp Touch ID nằm ở cạnh trên máy giúp mở khóa và truy cập thiết bị nhanh chóng, đồng thời bảo vệ sự riêng tư một cách tốt hơn.', 126, 1),
(120, 'Xiaomi Redmi Note 13', 'thường', 4, 1, '{\"screen\":\"oled\", \"display\":\"6.1 inch\", \"front-camera\":\"12mpx\", \"main-camera\":\"200mpx\",\"os\": \"IOS 14\", \"chip\": \"A16\",\"battery\":\"3000mah\", \"charge\":\"20w\", \"features\": [\"oled\",\"200mpx\"]}', 'xiaomi-redmi-note-13-green-thumb-600x600.jpg', '{\"date\":\"2024-10-10\",\"initial-price\":19000000}', 'Thế hệ mới của nhà Táo ra mắt với nhiều màu sắc trẻ trung và cá tính, cho phép người dùng tự do lựa chọn theo sở thích riêng. Nút nguồn tích hợp Touch ID nằm ở cạnh trên máy giúp mở khóa và truy cập thiết bị nhanh chóng, đồng thời bảo vệ sự riêng tư một cách tốt hơn.', 106, 1),
(121, 'Xiaomi Redmi Note 13', 'Pro', 4, 1, '{\"screen\":\"oled\", \"display\":\"6.1 inch\", \"front-camera\":\"12mpx\", \"main-camera\":\"200mpx\",\"os\": \"IOS 14\", \"chip\": \"A16\",\"battery\":\"3000mah\", \"charge\":\"20w\", \"features\": [\"oled\",\"200mpx\"]}', 'xiaomi-redmi-note-13-pro-5g-xanhla-thumb-600x600.jpg', '{\"date\":\"2024-10-10\",\"initial-price\":19000000}', 'Thế hệ mới của nhà Táo ra mắt với nhiều màu sắc trẻ trung và cá tính, cho phép người dùng tự do lựa chọn theo sở thích riêng. Nút nguồn tích hợp Touch ID nằm ở cạnh trên máy giúp mở khóa và truy cập thiết bị nhanh chóng, đồng thời bảo vệ sự riêng tư một cách tốt hơn.', 151, 1),
(122, 'iphone 19', 'thường', 2, 1, '{\"screen\":\"oled\", \"display\":\"6.1 inch\", \"front-camera\":\"12mpx\", \"main-camera\":\"200mpx\",\"os\": \"IOS 14\", \"chip\": \"A16\",\"battery\":\"3000mah\", \"charge\":\"20w\", \"features\": [\"oled\",\"200mpx\"]}', '461164173_1254207616030553_55356019258858284_n.jpg', '{\"date\":\"2024-10-10\",\"initial-price\":19000000}', 'Thế hệ mới của nhà Táo ra mắt với nhiều màu sắc trẻ trung và cá tính, cho phép người dùng tự do lựa chọn theo sở thích riêng. Nút nguồn tích hợp Touch ID nằm ở cạnh trên máy giúp mở khóa và truy cập thiết bị nhanh chóng, đồng thời bảo vệ sự riêng tư một cách tốt hơn.', 1, 1),
(123, 'Samsung Galaxy Tab S10', ' Ultra 5G', 1, 2, '{\"screen\":\"oled\", \"display\":\"6.1 inch\", \"front-camera\":\"12mpx\", \"main-camera\":\"200mpx\",\"os\": \"IOS 14\", \"chip\": \"A16\",\"battery\":\"3000mah\", \"charge\":\"20w\", \"features\": [\"oled\",\"200mpx\"]}', 'samsung-galaxy-tab-s10-ultra-sliver-thumb-600x600.jpg', '{\"date\":\"2024-10-10\",\"initial-price\":19000000}', 'Thế hệ mới của nhà Táo ra mắt với nhiều màu sắc trẻ trung và cá tính, cho phép người dùng tự do lựa chọn theo sở thích riêng. Nút nguồn tích hợp Touch ID nằm ở cạnh trên máy giúp mở khóa và truy cập thiết bị nhanh chóng, đồng thời bảo vệ sự riêng tư một cách tốt hơn.', 100, 1),
(124, 'Samsung Galaxy Tab S10', 'Plus', 1, 2, '{\"screen\":\"oled\", \"display\":\"6.1 inch\", \"front-camera\":\"12mpx\", \"main-camera\":\"200mpx\",\"os\": \"IOS 14\", \"chip\": \"A16\",\"battery\":\"3000mah\", \"charge\":\"20w\", \"features\": [\"oled\",\"200mpx\"]}', 'samsung-galaxy-tab-s10-plus-gray-thumb-600x600.jpg', '{\"date\":\"2024-10-10\",\"initial-price\":19000000}', 'Thế hệ mới của nhà Táo ra mắt với nhiều màu sắc trẻ trung và cá tính, cho phép người dùng tự do lựa chọn theo sở thích riêng. Nút nguồn tích hợp Touch ID nằm ở cạnh trên máy giúp mở khóa và truy cập thiết bị nhanh chóng, đồng thời bảo vệ sự riêng tư một cách tốt hơn.', 123, 1),
(125, 'Samsung Galaxy Tab A9', 'Plus', 1, 2, '{\"screen\":\"oled\", \"display\":\"6.1 inch\", \"front-camera\":\"12mpx\", \"main-camera\":\"200mpx\",\"os\": \"IOS 14\", \"chip\": \"A16\",\"battery\":\"3000mah\", \"charge\":\"20w\", \"features\": [\"oled\",\"200mpx\"]}', 'samsung-galaxy-a9-plus-den-thumb-600x600.jpg', '{\"date\":\"2024-10-10\",\"initial-price\":19000000}', 'Thế hệ mới của nhà Táo ra mắt với nhiều màu sắc trẻ trung và cá tính, cho phép người dùng tự do lựa chọn theo sở thích riêng. Nút nguồn tích hợp Touch ID nằm ở cạnh trên máy giúp mở khóa và truy cập thiết bị nhanh chóng, đồng thời bảo vệ sự riêng tư một cách tốt hơn.', 124, 1),
(126, 'Samsung Galaxy Tab A9', 'thường', 1, 2, '{\"screen\":\"oled\", \"display\":\"6.1 inch\", \"front-camera\":\"12mpx\", \"main-camera\":\"200mpx\",\"os\": \"IOS 14\", \"chip\": \"A16\",\"battery\":\"3000mah\", \"charge\":\"20w\", \"features\": [\"oled\",\"200mpx\"]}', 'samsung-galaxy-a9-plus-den-thumb-600x600.jpg', '{\"date\":\"2024-10-10\",\"initial-price\":19000000}', 'Thế hệ mới của nhà Táo ra mắt với nhiều màu sắc trẻ trung và cá tính, cho phép người dùng tự do lựa chọn theo sở thích riêng. Nút nguồn tích hợp Touch ID nằm ở cạnh trên máy giúp mở khóa và truy cập thiết bị nhanh chóng, đồng thời bảo vệ sự riêng tư một cách tốt hơn.', 3526, 1),
(127, 'Samsung Galaxy Tab S9', ' FE', 1, 2, '{\"screen\":\"oled\", \"display\":\"6.1 inch\", \"front-camera\":\"12mpx\", \"main-camera\":\"200mpx\",\"os\": \"IOS 14\", \"chip\": \"A16\",\"battery\":\"3000mah\", \"charge\":\"20w\", \"features\": [\"oled\",\"200mpx\"]}', 'galaxy-tab-s9-fe-xanh-mint-thumb-600x600.jpg', '{\"date\":\"2024-10-10\",\"initial-price\":19000000}', 'Thế hệ mới của nhà Táo ra mắt với nhiều màu sắc trẻ trung và cá tính, cho phép người dùng tự do lựa chọn theo sở thích riêng. Nút nguồn tích hợp Touch ID nằm ở cạnh trên máy giúp mở khóa và truy cập thiết bị nhanh chóng, đồng thời bảo vệ sự riêng tư một cách tốt hơn.', 262, 1),
(128, 'Samsung Galaxy Tab S9', 'thường', 1, 2, '{\"screen\":\"oled\", \"display\":\"6.1 inch\", \"front-camera\":\"12mpx\", \"main-camera\":\"200mpx\",\"os\": \"IOS 14\", \"chip\": \"A16\",\"battery\":\"3000mah\", \"charge\":\"20w\", \"features\": [\"oled\",\"200mpx\"]}', 'samsung-galaxy-tab-s9-grey-thumbnew-600x600.jpg', '{\"date\":\"2024-10-10\",\"initial-price\":19000000}', 'Thế hệ mới của nhà Táo ra mắt với nhiều màu sắc trẻ trung và cá tính, cho phép người dùng tự do lựa chọn theo sở thích riêng. Nút nguồn tích hợp Touch ID nằm ở cạnh trên máy giúp mở khóa và truy cập thiết bị nhanh chóng, đồng thời bảo vệ sự riêng tư một cách tốt hơn.', 214, 1);
INSERT INTO `products` (`id`, `name`, `version`, `brandID`, `cateID`, `config`, `thumbnail`, `firstsale`, `des`, `prominence`, `avai`) VALUES
(129, 'iPad 10', 'WiFi', 2, 2, '{\"screen\":\"oled\", \"display\":\"6.1 inch\", \"front-camera\":\"12mpx\", \"main-camera\":\"200mpx\",\"os\": \"IOS 14\", \"chip\": \"A16\",\"battery\":\"3000mah\", \"charge\":\"20w\", \"features\": [\"oled\",\"200mpx\"]}', 'iPad-Gen-10-sliver-thumb-600x600.jpg', '{\"date\":\"2024-10-10\",\"initial-price\":19000000}', 'Thế hệ mới của nhà Táo ra mắt với nhiều màu sắc trẻ trung và cá tính, cho phép người dùng tự do lựa chọn theo sở thích riêng. Nút nguồn tích hợp Touch ID nằm ở cạnh trên máy giúp mở khóa và truy cập thiết bị nhanh chóng, đồng thời bảo vệ sự riêng tư một cách tốt hơn.', 5136, 1),
(130, 'iPad 9', 'WiFi', 2, 2, '{\"screen\":\"oled\", \"display\":\"6.1 inch\", \"front-camera\":\"12mpx\", \"main-camera\":\"200mpx\",\"os\": \"IOS 14\", \"chip\": \"A16\",\"battery\":\"3000mah\", \"charge\":\"20w\", \"features\": [\"oled\",\"200mpx\"]}', 'iPad-9-wifi-den-600x600.jpg', '{\"date\":\"2024-10-10\",\"initial-price\":19000000}', 'Thế hệ mới của nhà Táo ra mắt với nhiều màu sắc trẻ trung và cá tính, cho phép người dùng tự do lựa chọn theo sở thích riêng. Nút nguồn tích hợp Touch ID nằm ở cạnh trên máy giúp mở khóa và truy cập thiết bị nhanh chóng, đồng thời bảo vệ sự riêng tư một cách tốt hơn.', 13513, 1),
(131, 'iPad Air 6 M2 11 inch', 'WiFi', 2, 2, '{  \"screen\": \"oled\",  \"display\": \"6.1 inch\",  \"front-camera\": \"12mpx\",  \"main-camera\": \"200mpx\",  \"os\": \"IOS 14\",  \"chip\": \"A16\",  \"battery\": \"3000mah\",  \"charge\": \"20w\",  \"features\": [    \"oled\",    \"200mpx\"  ]}', 'ipad-air-11-inch-m2-wifi-purple-thumb-600x600.jpg', '{  \"date\": \"2024-10-10\",  \"initial-price\": \"19000000\"}', NULL, 25458, 1),
(132, 'iPad Pro M4 11 inch', 'WiFi', 2, 2, '{\"screen\":\"oled\", \"display\":\"6.1 inch\", \"front-camera\":\"12mpx\", \"main-camera\":\"200mpx\",\"os\": \"IOS 14\", \"chip\": \"A16\",\"battery\":\"3000mah\", \"charge\":\"20w\", \"features\": [\"oled\",\"200mpx\"]}', 'ipad-pro-11-inch-m4-wifi-black-thumb-600x600.jpg', '{\"date\":\"2024-10-10\",\"initial-price\":19000000}', 'Thế hệ mới của nhà Táo ra mắt với nhiều màu sắc trẻ trung và cá tính, cho phép người dùng tự do lựa chọn theo sở thích riêng. Nút nguồn tích hợp Touch ID nằm ở cạnh trên máy giúp mở khóa và truy cập thiết bị nhanh chóng, đồng thời bảo vệ sự riêng tư một cách tốt hơn.', 143, 1),
(133, 'iPad mini 7', '5G', 2, 2, '{\"screen\":\"oled\", \"display\":\"6.1 inch\", \"front-camera\":\"12mpx\", \"main-camera\":\"200mpx\",\"os\": \"IOS 14\", \"chip\": \"A16\",\"battery\":\"3000mah\", \"charge\":\"20w\", \"features\": [\"oled\",\"200mpx\"]}', 'ipad-mini-7-5g-grey-thumb-600x600.jpg', '{\"date\":\"2024-10-10\",\"initial-price\":19000000}', 'Thế hệ mới của nhà Táo ra mắt với nhiều màu sắc trẻ trung và cá tính, cho phép người dùng tự do lựa chọn theo sở thích riêng. Nút nguồn tích hợp Touch ID nằm ở cạnh trên máy giúp mở khóa và truy cập thiết bị nhanh chóng, đồng thời bảo vệ sự riêng tư một cách tốt hơn.', 123, 1),
(134, 'iPad Air 6 M2 13 inch', '5G', 2, 2, '{\"screen\":\"oled\", \"display\":\"6.1 inch\", \"front-camera\":\"12mpx\", \"main-camera\":\"200mpx\",\"os\": \"IOS 14\", \"chip\": \"A16\",\"battery\":\"3000mah\", \"charge\":\"20w\", \"features\": [\"oled\",\"200mpx\"]}', 'ipad-air-13-inch-m2-lte-blue-thumb-600x600.jpg', '{\"date\":\"2024-10-10\",\"initial-price\":19000000}', 'Thế hệ mới của nhà Táo ra mắt với nhiều màu sắc trẻ trung và cá tính, cho phép người dùng tự do lựa chọn theo sở thích riêng. Nút nguồn tích hợp Touch ID nằm ở cạnh trên máy giúp mở khóa và truy cập thiết bị nhanh chóng, đồng thời bảo vệ sự riêng tư một cách tốt hơn.', 543, 1),
(135, 'Xiaomi Pad 6', 'WiFi', 4, 2, '{\"screen\":\"oled\", \"display\":\"6.1 inch\", \"front-camera\":\"12mpx\", \"main-camera\":\"200mpx\",\"os\": \"IOS 14\", \"chip\": \"A16\",\"battery\":\"3000mah\", \"charge\":\"20w\", \"features\": [\"oled\",\"200mpx\"]}', 'xiaomi-pad-6-grey-thumb-600x600.jpg', '{\"date\":\"2024-10-10\",\"initial-price\":19000000}', 'Thế hệ mới của nhà Táo ra mắt với nhiều màu sắc trẻ trung và cá tính, cho phép người dùng tự do lựa chọn theo sở thích riêng. Nút nguồn tích hợp Touch ID nằm ở cạnh trên máy giúp mở khóa và truy cập thiết bị nhanh chóng, đồng thời bảo vệ sự riêng tư một cách tốt hơn.', 757, 1),
(136, 'Xiaomi Redmi Pad', 'SE', 4, 2, '{\"screen\":\"oled\", \"display\":\"6.1 inch\", \"front-camera\":\"12mpx\", \"main-camera\":\"200mpx\",\"os\": \"IOS 14\", \"chip\": \"A16\",\"battery\":\"3000mah\", \"charge\":\"20w\", \"features\": [\"oled\",\"200mpx\"]}', 'xiaomi-pad-se-xanh-thumb-600x600.jpg', '{\"date\":\"2024-10-10\",\"initial-price\":19000000}', 'Thế hệ mới của nhà Táo ra mắt với nhiều màu sắc trẻ trung và cá tính, cho phép người dùng tự do lựa chọn theo sở thích riêng. Nút nguồn tích hợp Touch ID nằm ở cạnh trên máy giúp mở khóa và truy cập thiết bị nhanh chóng, đồng thời bảo vệ sự riêng tư một cách tốt hơn.', 324, 1),
(137, 'Xiaomi Redmi Pad SE 8.7', ' WiFi', 4, 2, '{\"screen\":\"oled\", \"display\":\"6.1 inch\", \"front-camera\":\"12mpx\", \"main-camera\":\"200mpx\",\"os\": \"IOS 14\", \"chip\": \"A16\",\"battery\":\"3000mah\", \"charge\":\"20w\", \"features\": [\"oled\",\"200mpx\"]}', 'redmi-pad-se-8-7-wifi-grey-thumb-600x600.jpg', '{\"date\":\"2024-10-10\",\"initial-price\":19000000}', 'Thế hệ mới của nhà Táo ra mắt với nhiều màu sắc trẻ trung và cá tính, cho phép người dùng tự do lựa chọn theo sở thích riêng. Nút nguồn tích hợp Touch ID nằm ở cạnh trên máy giúp mở khóa và truy cập thiết bị nhanh chóng, đồng thời bảo vệ sự riêng tư một cách tốt hơn.', 523, 1),
(138, 'Xiaomi Pad 6S', 'Pro', 4, 2, '{\"screen\":\"oled\", \"display\":\"6.1 inch\", \"front-camera\":\"12mpx\", \"main-camera\":\"200mpx\",\"os\": \"IOS 14\", \"chip\": \"A16\",\"battery\":\"3000mah\", \"charge\":\"20w\", \"features\": [\"oled\",\"200mpx\"]}', 'xiaomi-mi-pad-6s-pro-grey-thumb-600x600.jpg', '{\"date\":\"2024-10-10\",\"initial-price\":19000000}', 'Thế hệ mới của nhà Táo ra mắt với nhiều màu sắc trẻ trung và cá tính, cho phép người dùng tự do lựa chọn theo sở thích riêng. Nút nguồn tích hợp Touch ID nằm ở cạnh trên máy giúp mở khóa và truy cập thiết bị nhanh chóng, đồng thời bảo vệ sự riêng tư một cách tốt hơn.', 4132, 1),
(139, 'Samsung Galaxy Chromebook Go XE340XDA N4500', 'thường', 1, 3, '{\"screen\":\"oled\", \"display\":\"6.1 inch\", \"front-camera\":\"12mpx\", \"main-camera\":\"200mpx\",\"os\": \"IOS 14\", \"chip\": \"A16\",\"battery\":\"3000mah\", \"charge\":\"20w\", \"features\": [\"oled\",\"200mpx\"]}', 'samsung-galaxy-chromebook-go-xe340xda-n4500-thumb-600x600.jpg', '{\"date\":\"2024-10-10\",\"initial-price\":19000000}', NULL, 100, 1),
(140, 'MacBook Air 13 inch', 'M1', 2, 3, '{\"screen\":\"oled\", \"display\":\"6.1 inch\", \"front-camera\":\"12mpx\", \"main-camera\":\"200mpx\",\"os\": \"IOS 14\", \"chip\": \"A16\",\"battery\":\"3000mah\", \"charge\":\"20w\", \"features\": [\"oled\",\"200mpx\"]}', 'macbook-air-m1-2020-gray-600x600.jpg', '{\"date\":\"2024-10-10\",\"initial-price\":19000000}', NULL, 123, 1),
(141, 'MacBook Air 13 inch', 'M2', 2, 3, '{\"screen\":\"oled\", \"display\":\"6.1 inch\", \"front-camera\":\"12mpx\", \"main-camera\":\"200mpx\",\"os\": \"IOS 14\", \"chip\": \"A16\",\"battery\":\"3000mah\", \"charge\":\"20w\", \"features\": [\"oled\",\"200mpx\"]}', 'apple-macbook-air-m2-2022-16gb-256gb-thumb-600x600.jpg', '{\"date\":\"2024-10-10\",\"initial-price\":19000000}', NULL, 124, 1),
(142, 'MacBook Air 13 inch', 'M2 10GPU', 2, 3, '{\"screen\":\"oled\", \"display\":\"6.1 inch\", \"front-camera\":\"12mpx\", \"main-camera\":\"200mpx\",\"os\": \"IOS 14\", \"chip\": \"A16\",\"battery\":\"3000mah\", \"charge\":\"20w\", \"features\": [\"oled\",\"200mpx\"]}', 'apple-macbook-air-m2-2022-16gb-256gb-10gpu-xam-thumb-600x600.jpg', '{\"date\":\"2024-10-10\",\"initial-price\":19000000}', NULL, 3526, 1),
(143, 'MacBook Air 13 inch', 'M3 8GPU', 2, 3, '{\"screen\":\"oled\", \"display\":\"6.1 inch\", \"front-camera\":\"12mpx\", \"main-camera\":\"200mpx\",\"os\": \"IOS 14\", \"chip\": \"A16\",\"battery\":\"3000mah\", \"charge\":\"20w\", \"features\": [\"oled\",\"200mpx\"]}', 'macbook-air-13-inch-m3-16gb-256gb-8gpu-011124-123817-671-600x600.jpg', '{\"date\":\"2024-10-10\",\"initial-price\":19000000}', NULL, 262, 1),
(144, 'MacBook Pro 14 inch', 'M4 pro', 2, 3, '{\"screen\":\"oled\", \"display\":\"6.1 inch\", \"front-camera\":\"12mpx\", \"main-camera\":\"200mpx\",\"os\": \"IOS 14\", \"chip\": \"A16\",\"battery\":\"3000mah\", \"charge\":\"20w\", \"features\": [\"oled\",\"200mpx\"]}', 'macbook-pro-14-inch-m4-pro-24gb-512gb-011124-120607-479-600x600.jpg', '{\"date\":\"2024-10-10\",\"initial-price\":19000000}', NULL, 214, 1),
(145, 'MacBook Pro 14 inch', 'M4 Nano pro', 2, 3, '{\"screen\":\"oled\", \"display\":\"6.1 inch\", \"front-camera\":\"12mpx\", \"main-camera\":\"200mpx\",\"os\": \"IOS 14\", \"chip\": \"A16\",\"battery\":\"3000mah\", \"charge\":\"20w\", \"features\": [\"oled\",\"200mpx\"]}', 'macbook-pro-14-nano-m4-16-512-tgdd-den-thumb-638682286113899532-600x600.jpg', '{\"date\":\"2024-10-10\",\"initial-price\":19000000}', NULL, 5135, 1);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `promotions`
--

CREATE TABLE `promotions` (
  `id` int(11) NOT NULL,
  `saleprogramID` int(11) NOT NULL,
  `content` varchar(256) NOT NULL,
  `discount` double NOT NULL,
  `time` datetime NOT NULL,
  `endTime` datetime NOT NULL,
  `avai` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `publickeys`
--

CREATE TABLE `publickeys` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `content` text NOT NULL,
  `createAt` datetime NOT NULL DEFAULT current_timestamp(),
  `endAt` datetime DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `publickeys`
--

INSERT INTO `publickeys` (`id`, `user_id`, `content`, `createAt`, `endAt`) VALUES
(1, 1, 'daegaewrga', '2024-12-23 13:49:46', '2024-12-23 19:51:18'),
(2, 1, '# Để sử dụng tài khoản tonhat211\r\ngit remote set-url origin git@tonhat211:tonhat211/ThietBiDiDong.git  \r\n\r\nSu dung ssh key tonhat211\r\neval \"$(ssh-agent -s)\"\r\nssh-add ~/.ssh/id_nhat\r\n\r\n\r\n# Để sử dụng tài khoản Lipspr345\r\ngit remote set-url origin git@Litspr345:tonhat211/ThietBiDiDong.git  \r\n\r\nSu dung ssh key Lipspr345\r\neval \"$(ssh-agent -s)\"\r\nssh-add ~/.ssh/id_nhi\r\n\r\n\r\ngit remote set-url origin git@github.com:tonhat211/AnToanBaoMat.git\r\n\r\n\r\nssh-keygen -t rsa -b 4096 -C \"21130463@st.hcmuaf.edu.vn\"\r\nssh-add ~/.ssh/tonhat211\r\n\r\n# Di chuyển đến thư mục repository của bạn\r\ncd C:\\Users\\TO NHAT\\IdeaProjects\\ThietBiDiDong\r\n\r\n# Thiết lập tên và email cho tài khoản \"nhat\" : vo trong thu muc cua project\r\ngit config user.name \"Tên tài khoản nhat\"\r\ngit config user.email \"email_taikhoan_nhat@example.com\"\r\n\r\n################ trước khi push code,\r\ngit remote set-url...\r\nkiểm tra lại config user', '2024-12-23 22:32:57', '2024-12-02 22:58:00'),
(3, 1, '# Để sử dụng tài khoản tonhat211\r\ngit remote set-url origin git@tonhat211:tonhat211/ThietBiDiDong.git  \r\n\r\nSu dung ssh key tonhat211\r\neval \"$(ssh-agent -s)\"\r\nssh-add ~/.ssh/id_nhat\r\n\r\n\r\n# Để sử dụng tài khoản Lipspr345\r\ngit remote set-url origin git@Litspr345:tonhat211/ThietBiDiDong.git  \r\n\r\nSu dung ssh key Lipspr345\r\neval \"$(ssh-agent -s)\"\r\nssh-add ~/.ssh/id_nhi\r\n\r\n\r\ngit remote set-url origin git@github.com:tonhat211/AnToanBaoMat.git\r\n\r\n\r\nssh-keygen -t rsa -b 4096 -C \"21130463@st.hcmuaf.edu.vn\"\r\nssh-add ~/.ssh/tonhat211\r\n\r\n# Di chuyển đến thư mục repository của bạn\r\ncd C:\\Users\\TO NHAT\\IdeaProjects\\ThietBiDiDong\r\n\r\n# Thiết lập tên và email cho tài khoản \"nhat\" : vo trong thu muc cua project\r\ngit config user.name \"Tên tài khoản nhat\"\r\ngit config user.email \"email_taikhoan_nhat@example.com\"\r\n\r\n################ trước khi push code,\r\ngit remote set-url...\r\nkiểm tra lại config user', '2024-12-23 22:33:03', '2024-12-02 22:58:00'),
(4, 1, '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\r\nssh-keygen -t rsa -C \"21130125@st.hcmuaf.edu.vn\"\r\nssh-keygen -t rsa -C \"21130463@st.hcmuaf.edu.vn\"\r\nssh-keygen -t rsa -b 4096 -C \"21130125@st.hcmuaf.edu.vn\"', '2024-12-23 22:47:51', '2024-12-02 22:58:00'),
(5, 1, 'tonhat211\r\n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', '2024-12-23 22:58:40', '2024-12-02 23:07:00'),
(6, 1, 'MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAmysQpMnQ+9tYFnKPBaGMFOoRxFJU5UrPmY/6mukmoGmWg44n5Uqa7FBUAdN10A6hvrUFjIpLqyGJftIQqiH0EAizWKNNrdTkb389ZvIECxHlRg7cqNRUa+d1R5I2TtvImRwdfZM3k8wBV/Ah11px1MM/AgwwdxR5MVXZMqPjfoQ37L+b9HBL0xl0L7+zSp35BaRKCGawKGMZb2qwFe0BfqrWdeIto/9Ao5dRw9tBuul0Cmq3ybfS+3M5FjiL43jQuHd0bHQcm6uqLNdxuMuiuMGDG7yxwdXjBGnwtDi+O6eOeJpCch8qqsvRs0+YkyRRDXffMCYL0KqRM0ldtwAb6QIDAQAB', '2024-12-23 23:07:14', '2024-12-23 23:07:14'),
(7, 1, '', '2024-12-23 23:15:55', '2024-12-23 23:15:55'),
(8, 1, 'MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAmysQpMnQ+9tYFnKPBaGMFOoRxFJU5UrPmY/6mukmoGmWg44n5Uqa7FBUAdN10A6hvrUFjIpLqyGJftIQqiH0EAizWKNNrdTkb389ZvIECxHlRg7cqNRUa+d1R5I2TtvImRwdfZM3k8wBV/Ah11px1MM/AgwwdxR5MVXZMqPjfoQ37L+b9HBL0xl0L7+zSp35BaRKCGawKGMZb2qwFe0BfqrWdeIto/9Ao5dRw9tBuul0Cmq3ybfS+3M5FjiL43jQuHd0bHQcm6uqLNdxuMuiuMGDG7yxwdXjBGnwtDi+O6eOeJpCch8qqsvRs0+YkyRRDXffMCYL0KqRM0ldtwAb6QIDAQAB', '2024-12-23 23:17:49', '2024-12-22 23:19:00'),
(9, 1, 'MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAmysQpMnQ+9tYFnKPBaGMFOoRxFJU5UrPmY/6mukmoGmWg44n5Uqa7FBUAdN10A6hvrUFjIpLqyGJftIQqiH0EAizWKNNrdTkb389ZvIECxHlRg7cqNRUa+d1R5I2TtvImRwdfZM3k8wBV/Ah11px1MM/AgwwdxR5MVXZMqPjfoQ37L+b9HBL0xl0L7+zSp35BaRKCGawKGMZb2qwFe0BfqrWdeIto/9Ao5dRw9tBuul0Cmq3ybfS+3M5FjiL43jQuHd0bHQcm6uqLNdxuMuiuMGDG7yxwdXjBGnwtDi+O6eOeJpCch8qqsvRs0+YkyRRDXffMCYL0KqRM0ldtwAb6QIDAQAB', '2024-12-23 23:20:04', '2024-12-10 23:22:00'),
(10, 1, '', '2024-12-23 23:22:16', '2024-12-23 23:22:16'),
(11, 1, 'MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAmysQpMnQ+9tYFnKPBaGMFOoRxFJU5UrPmY/6mukmoGmWg44n5Uqa7FBUAdN10A6hvrUFjIpLqyGJftIQqiH0EAizWKNNrdTkb389ZvIECxHlRg7cqNRUa+d1R5I2TtvImRwdfZM3k8wBV/Ah11px1MM/AgwwdxR5MVXZMqPjfoQ37L+b9HBL0xl0L7+zSp35BaRKCGawKGMZb2qwFe0BfqrWdeIto/9Ao5dRw9tBuul0Cmq3ybfS+3M5FjiL43jQuHd0bHQcm6uqLNdxuMuiuMGDG7yxwdXjBGnwtDi+O6eOeJpCch8qqsvRs0+YkyRRDXffMCYL0KqRM0ldtwAb6QIDAQAB', '2024-12-23 23:46:07', '2024-12-02 23:46:00'),
(12, 1, 'MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAmysQpMnQ+9tYFnKPBaGMFOoRxFJU5UrPmY/6mukmoGmWg44n5Uqa7FBUAdN10A6hvrUFjIpLqyGJftIQqiH0EAizWKNNrdTkb389ZvIECxHlRg7cqNRUa+d1R5I2TtvImRwdfZM3k8wBV/Ah11px1MM/AgwwdxR5MVXZMqPjfoQ37L+b9HBL0xl0L7+zSp35BaRKCGawKGMZb2qwFe0BfqrWdeIto/9Ao5dRw9tBuul0Cmq3ybfS+3M5FjiL43jQuHd0bHQcm6uqLNdxuMuiuMGDG7yxwdXjBGnwtDi+O6eOeJpCch8qqsvRs0+YkyRRDXffMCYL0KqRM0ldtwAb6QIDAQAB', '2024-12-23 23:46:40', '2024-12-02 23:50:00'),
(13, 1, 'MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAmysQpMnQ+9tYFnKPBaGMFOoRxFJU5UrPmY/6mukmoGmWg44n5Uqa7FBUAdN10A6hvrUFjIpLqyGJftIQqiH0EAizWKNNrdTkb389ZvIECxHlRg7cqNRUa+d1R5I2TtvImRwdfZM3k8wBV/Ah11px1MM/AgwwdxR5MVXZMqPjfoQ37L+b9HBL0xl0L7+zSp35BaRKCGawKGMZb2qwFe0BfqrWdeIto/9Ao5dRw9tBuul0Cmq3ybfS+3M5FjiL43jQuHd0bHQcm6uqLNdxuMuiuMGDG7yxwdXjBGnwtDi+O6eOeJpCch8qqsvRs0+YkyRRDXffMCYL0KqRM0ldtwAb6QIDAQAB', '2024-12-23 23:50:20', '2024-12-01 23:50:00'),
(14, 1, 'MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAmysQpMnQ+9tYFnKPBaGMFOoRxFJU5UrPmY/6mukmoGmWg44n5Uqa7FBUAdN10A6hvrUFjIpLqyGJftIQqiH0EAizWKNNrdTkb389ZvIECxHlRg7cqNRUa+d1R5I2TtvImRwdfZM3k8wBV/Ah11px1MM/AgwwdxR5MVXZMqPjfoQ37L+b9HBL0xl0L7+zSp35BaRKCGawKGMZb2qwFe0BfqrWdeIto/9Ao5dRw9tBuul0Cmq3ybfS+3M5FjiL43jQuHd0bHQcm6uqLNdxuMuiuMGDG7yxwdXjBGnwtDi+O6eOeJpCch8qqsvRs0+YkyRRDXffMCYL0KqRM0ldtwAb6QIDAQAB', '2024-12-23 23:51:06', '2024-12-02 23:59:00'),
(15, 1, 'MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAmysQpMnQ+9tYFnKPBaGMFOoRxFJU5UrPmY/6mukmoGmWg44n5Uqa7FBUAdN10A6hvrUFjIpLqyGJftIQqiH0EAizWKNNrdTkb389ZvIECxHlRg7cqNRUa+d1R5I2TtvImRwdfZM3k8wBV/Ah11px1MM/AgwwdxR5MVXZMqPjfoQ37L+b9HBL0xl0L7+zSp35BaRKCGawKGMZb2qwFe0BfqrWdeIto/9Ao5dRw9tBuul0Cmq3ybfS+3M5FjiL43jQuHd0bHQcm6uqLNdxuMuiuMGDG7yxwdXjBGnwtDi+O6eOeJpCch8qqsvRs0+YkyRRDXffMCYL0KqRM0ldtwAb6QIDAQAB', '2024-12-23 23:59:24', '2024-12-22 00:13:00'),
(16, 1, 'MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAmysQpMnQ+9tYFnKPBaGMFOoRxFJU5UrPmY/6mukmoGmWg44n5Uqa7FBUAdN10A6hvrUFjIpLqyGJftIQqiH0EAizWKNNrdTkb389ZvIECxHlRg7cqNRUa+d1R5I2TtvImRwdfZM3k8wBV/Ah11px1MM/AgwwdxR5MVXZMqPjfoQ37L+b9HBL0xl0L7+zSp35BaRKCGawKGMZb2qwFe0BfqrWdeIto/9Ao5dRw9tBuul0Cmq3ybfS+3M5FjiL43jQuHd0bHQcm6uqLNdxuMuiuMGDG7yxwdXjBGnwtDi+O6eOeJpCch8qqsvRs0+YkyRRDXffMCYL0KqRM0ldtwAb6QIDAQAB', '2024-12-24 00:13:27', '2024-12-01 00:17:00'),
(17, 1, 'MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAmysQpMnQ+9tYFnKPBaGMFOoRxFJU5UrPmY/6mukmoGmWg44n5Uqa7FBUAdN10A6hvrUFjIpLqyGJftIQqiH0EAizWKNNrdTkb389ZvIECxHlRg7cqNRUa+d1R5I2TtvImRwdfZM3k8wBV/Ah11px1MM/AgwwdxR5MVXZMqPjfoQ37L+b9HBL0xl0L7+zSp35BaRKCGawKGMZb2qwFe0BfqrWdeIto/9Ao5dRw9tBuul0Cmq3ybfS+3M5FjiL43jQuHd0bHQcm6uqLNdxuMuiuMGDG7yxwdXjBGnwtDi+O6eOeJpCch8qqsvRs0+YkyRRDXffMCYL0KqRM0ldtwAb6QIDAQAB', '2024-12-24 00:17:16', '2024-12-24 08:25:00'),
(18, 1, 'ms7BLi0IQl6AGc5CZvjHAl8TA5gZw91AJyrezZAJeW496lkSk4Y2btPGyMm3Ku8ZC2yJchqqhndCwIDAQAB', '2024-12-24 08:31:40', '2025-01-06 13:50:00'),
(19, 1, 'xascdfv', '2025-01-07 13:50:13', NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `saleprograms`
--

CREATE TABLE `saleprograms` (
  `id` int(11) NOT NULL,
  `objectID` int(11) NOT NULL,
  `discount` double NOT NULL,
  `name` varchar(256) NOT NULL,
  `main` int(11) NOT NULL,
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`content`)),
  `startTime` datetime NOT NULL,
  `endTime` datetime NOT NULL,
  `avai` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `saleprograms`
--

INSERT INTO `saleprograms` (`id`, `objectID`, `discount`, `name`, `main`, `content`, `startTime`, `endTime`, `avai`) VALUES
(5, 53, 50, 'Back to School', 1, '[\"Giảm 30% cho học sinh sinh viên\",\"Tặng balo trị giá 500k\",\"Tặng thêm 1 năm bảo hành do ThietBiDiDong\"]', '2025-01-13 18:06:55', '2025-01-14 18:06:55', 1),
(6, 52, 50, 'flash', 2, '[\"Giảm 30% cho học sinh sinh viên\",\"Tặng balo trị giá 500k\",\"Tặng thêm 1 năm bảo hành do ThietBiDiDong\"]', '2025-01-13 12:55:41', '2025-01-14 18:06:55', 1),
(7, 53, 50, 'flash', 2, '[\"Giảm 30% cho học sinh sinh viên\",\"Tặng balo trị giá 500k\",\"Tặng thêm 1 năm bảo hành do ThietBiDiDong\"]', '2025-01-13 12:55:41', '2025-01-14 18:06:55', 1),
(8, 54, 50, 'flash', 2, '[\"Giảm 30% cho học sinh sinh viên\",\"Tặng balo trị giá 500k\",\"Tặng thêm 1 năm bảo hành do ThietBiDiDong\"]', '2025-01-13 12:56:58', '2025-01-14 18:06:55', 1),
(9, 55, 50, 'flash', 2, '[\"Giảm 30% cho học sinh sinh viên\",\"Tặng balo trị giá 500k\",\"Tặng thêm 1 năm bảo hành do ThietBiDiDong\"]', '2025-01-13 12:56:58', '2025-01-14 18:06:55', 1);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `series`
--

CREATE TABLE `series` (
  `id` int(11) NOT NULL,
  `name` varchar(256) NOT NULL,
  `avai` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `series`
--

INSERT INTO `series` (`id`, `name`, `avai`) VALUES
(1, 'S23', 1);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(256) NOT NULL,
  `email` varchar(256) NOT NULL,
  `password` varchar(256) NOT NULL,
  `roles` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`roles`)),
  `branchID` int(11) DEFAULT NULL,
  `info` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`info`)),
  `avai` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `roles`, `branchID`, `info`, `avai`) VALUES
(1, 'Nhật', '21130463@st.hcmuaf.edu.vn', '81dc9bdb52d04dc20036dbd8313ed055', '[\"customer\",\"employee\",\"product\",\"order\"]', NULL, '{\"dateIn\":\"2024-10-10\",\"phone\":\"723425134\",\"gender\":\"male\",\"birthday\":\"2003-10-04\",\"position\":\"it\",\"area\":\"ceo\"}', 1),
(2, 'Cristiano Ronaldo', 'ronaldo@gmail.com', '81dc9bdb52d04dc20036dbd8313ed055', NULL, NULL, '{\"dateIn\":\"2024-10-10\",\"phone\":\"1124\",\"gender\":\"male\",\"birthday\":\"2003-10-04\",\"position\":\"null\",\"area\":\"null\"}', 1),
(5, 'Tô Minh Nhật', 'pharmacity@gmail.com', '81dc9bdb52d04dc20036dbd8313ed055', NULL, NULL, '{\"dateIn\":\"2024-12-03\",\"phone\":\"null\",\"gender\":\"null\",\"birthday\":\"null\",\"position\":\"null\",\"area\":\"null\"}', 0),
(6, 'Tô Minh Nhật', 'no665ok@gmail.com', 'f21aa12185edfed910d8a4ebdbde00e2', NULL, NULL, '{\"dateIn\":\"2024-12-03\",\"phone\":\"null\",\"gender\":\"null\",\"birthday\":\"null\",\"position\":\"Intern\",\"area\":\"Thiết kế\"}', -99),
(7, 'To Minh Nhat', 'tominh@gmail.com', '7107ff771d4d48192bc85fa6c26bcdc8', NULL, NULL, '{\"dateIn\":\"2025-01-08\",\"phone\":\"null\",\"gender\":\"null\",\"birthday\":\"null\",\"position\":\"null\",\"area\":\"null\"}', 0),
(14, 'To Minh Nhat', 'tominh.nhat03@gmail.com', '7107ff771d4d48192bc85fa6c26bcdc8', NULL, NULL, '{\"dateIn\":\"2025-01-08\",\"phone\":\"null\",\"gender\":\"null\",\"birthday\":\"null\",\"position\":\"null\",\"area\":\"null\"}', -99),
(15, 'To Minh Nhat', 'tominh@gmail.xn--comeaf-5zb', '7107ff771d4d48192bc85fa6c26bcdc8', '[]', NULL, '{\"dateIn\":\"2025-01-08\",\"phone\":\"null\",\"gender\":\"null\",\"birthday\":\"null\",\"position\":\"null\",\"area\":\"null\"}', -99),
(16, 'Nhi', 'nhi@gmail.com', '6830148152b38e36e93170892ab20764', NULL, NULL, '{\"dateIn\":\"2025-01-09\",\"phone\":\"null\",\"gender\":\"null\",\"birthday\":\"null\",\"position\":\"null\",\"area\":\"null\"}', -99),
(17, 'To Minh Nhat', 'tominh@gmail.com', '5711dfab15a1c50c9d706e57ec6c751d', '[\"null\",\"null\",\"null\",\"null\"]', NULL, '{\"dateIn\":\"2025-01-09\",\"phone\":\"null\",\"gender\":\"null\",\"birthday\":\"null\",\"position\":\"ceo\",\"area\":\"serg\"}', -99),
(18, 'To Minh Nhat', 'tonhat@gmail.com', '5711dfab15a1c50c9d706e57ec6c751d', '[\"null\",\"null\",\"null\",\"null\"]', NULL, '{\"dateIn\":\"2025-01-09\",\"phone\":\"null\",\"gender\":\"null\",\"birthday\":\"null\",\"position\":\"wef\",\"area\":\"qfwe\"}', -99);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `verifycode`
--

CREATE TABLE `verifycode` (
  `id` int(11) NOT NULL,
  `code` varchar(256) NOT NULL,
  `email` varchar(256) NOT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `isVerify` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `verifycode`
--

INSERT INTO `verifycode` (`id`, `code`, `email`, `time`, `isVerify`) VALUES
(1, '11111', '2003tonhat@gmail.com', '2024-10-19 14:46:29', 1),
(2, '496438', '21130463@st.hcmuaf.edu.vn', '2024-12-13 15:16:28', 1),
(3, '843681', '21130463@st.hcmuaf.edu.vn', '2024-12-13 15:19:13', 1),
(4, '611382', '21130463@st.hcmuaf.edu.vn', '2024-12-13 15:21:54', 1),
(5, '879112', '21130463@st.hcmuaf.edu.vn', '2024-12-13 15:23:44', 1),
(6, '586916', '21130463@st.hcmuaf.edu.vn', '2024-12-13 15:24:08', 1),
(7, '521353', '21130463@st.hcmuaf.edu.vn', '2024-12-13 15:25:21', 1),
(8, '656773', '21130463@st.hcmuaf.edu.vn', '2024-12-13 15:29:36', 1),
(9, '777878', '21130463@st.hcmuaf.edu.vn', '2024-12-13 15:31:55', 1),
(10, '247548', '21130463@st.hcmuaf.edu.vn', '2024-12-13 15:32:41', 1),
(11, '588641', '21130463@st.hcmuaf.edu.vn', '2024-12-13 15:34:25', 1),
(12, '346361', '21130463@st.hcmuaf.edu.vn', '2024-12-13 15:35:09', 1),
(13, '449615', '21130463@st.hcmuaf.edu.vn', '2024-12-13 15:38:48', 1),
(14, '369412', '21130463@st.hcmuaf.edu.vn', '2024-12-13 15:39:04', 1),
(15, '872726', '21130463@st.hcmuaf.edu.vn', '2024-12-13 15:43:24', 0),
(16, '63356', '21130463@st.hcmuaf.edu.vn', '2024-12-13 15:48:10', 0),
(17, '65989', '21130463@st.hcmuaf.edu.vn', '2024-12-13 16:16:14', 0),
(18, '71793', '21130463@st.hcmuaf.edu.vn', '2024-12-13 16:19:21', 0),
(19, '25724', '21130463@st.hcmuaf.edu.vn', '2024-12-13 16:22:20', 0),
(20, '58984', '21130463@st.hcmuaf.edu.vn', '2024-12-13 16:25:57', 0),
(21, '12345', '21130463@st.hcmuaf.edu.vn', '2024-12-13 16:26:46', 0),
(22, '12345', '21130463@st.hcmuaf.edu.vn', '2024-12-13 16:28:01', 0),
(23, '12345', '21130463@st.hcmuaf.edu.vn', '2024-12-13 16:30:02', 0),
(24, '12345', '21130463@st.hcmuaf.edu.vn', '2024-12-13 16:35:57', 0),
(25, '12345', '21130463@st.hcmuaf.edu.vn', '2024-12-13 16:36:42', 0),
(26, '12345', '21130463@st.hcmuaf.edu.vn', '2024-12-13 16:40:07', 0),
(27, '12345', '21130463@st.hcmuaf.edu.vn', '2024-12-13 16:41:38', 0),
(28, '12345', '21130463@st.hcmuaf.edu.vn', '2024-12-13 16:45:10', 0),
(29, '12345', '21130463@st.hcmuaf.edu.vn', '2024-12-13 16:46:52', 0),
(30, '12345', '21130463@st.hcmuaf.edu.vn', '2024-12-13 16:48:30', 0),
(31, '12345', '21130463@st.hcmuaf.edu.vn', '2024-12-13 16:50:40', 0),
(32, '12345', '21130463@st.hcmuaf.edu.vn', '2024-12-13 16:54:24', 0),
(33, '12345', '21130463@st.hcmuaf.edu.vn', '2024-12-13 16:57:58', 0),
(34, '12345', '21130463@st.hcmuaf.edu.vn', '2024-12-13 17:18:37', 0),
(35, '12345', '21130463@st.hcmuaf.edu.vn', '2024-12-13 17:28:18', 0),
(36, '12345', '21130463@st.hcmuaf.edu.vn', '2024-12-13 17:29:15', 0),
(37, '12345', '21130463@st.hcmuaf.edu.vn', '2024-12-13 17:30:26', 0),
(38, '12345', '21130463@st.hcmuaf.edu.vn', '2024-12-13 17:32:44', 0),
(39, '12345', '21130463@st.hcmuaf.edu.vn', '2024-12-13 17:42:37', 0),
(40, '77865', '21130463@st.hcmuaf.edu.vn', '2024-12-20 03:12:12', 0),
(41, '522784', 'tominh@gmail.com', '2025-01-08 05:08:22', 1),
(42, '822389', 'tominh.nhat03@gmail.com', '2025-01-08 05:35:14', 1),
(43, '451562', 'tominh.nhat03@gmail.com', '2025-01-08 05:39:16', 1),
(44, '984686', 'tominh.nhat03@gmail.com', '2025-01-08 05:40:29', 1),
(45, '14369', 'tominh.nhat03@gmail.com', '2025-01-08 05:41:29', 1),
(46, '93286', 'tominh.nhat03@gmail.com', '2025-01-08 05:45:34', 1),
(47, '43438', 'tominh.nhat03@gmail.com', '2025-01-08 05:50:25', 0),
(48, '94614', 'tominh.nhat03@gmail.com', '2025-01-08 05:54:01', 0),
(49, '51735', 'tominh@gmail.xn--comeaf-5zb', '2025-01-08 08:21:29', 1);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `verifycodes`
--

CREATE TABLE `verifycodes` (
  `id` int(11) NOT NULL,
  `code` varchar(20) NOT NULL,
  `email` varchar(250) NOT NULL,
  `time` datetime NOT NULL DEFAULT current_timestamp(),
  `isVerify` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `verifycodes`
--

INSERT INTO `verifycodes` (`id`, `code`, `email`, `time`, `isVerify`) VALUES
(2, '351743', '21130463@st.hcmuaf.edu.vn', '2024-12-18 22:50:53', 1),
(3, '454444', '21130463@st.hcmuaf.edu.vn', '2024-12-18 23:03:02', 1),
(4, '717211', '21130463@st.hcmuaf.edu.vn', '2024-12-18 23:10:52', 1),
(5, '822862', '21130463@st.hcmuaf.edu.vn', '2024-12-18 23:12:10', 1),
(6, '75613', '21130463@st.hcmuaf.edu.vn', '2024-12-18 23:15:14', 1),
(7, '79484', '21130463@st.hcmuaf.edu.vn', '2024-12-18 23:18:26', 1),
(8, '55425', '21130463@st.hcmuaf.edu.vn', '2024-12-18 23:19:44', 0),
(9, '36211', '21130463@st.hcmuaf.edu.vn', '2024-12-18 23:24:28', 1),
(10, '71313', '21130463@st.hcmuaf.edu.vn', '2024-12-18 23:31:34', 0),
(11, '92876', '21130463@st.hcmuaf.edu.vn', '2024-12-18 23:39:21', 0),
(12, '88385', '21130463@st.hcmuaf.edu.vn', '2024-12-18 23:40:20', 1),
(13, '31445', '21130463@st.hcmuaf.edu.vn', '2024-12-18 23:41:51', 0),
(14, '13823', '21130463@st.hcmuaf.edu.vn', '2024-12-18 23:42:47', 1),
(15, '86375', '21130463@st.hcmuaf.edu.vn', '2024-12-18 23:42:50', 1),
(16, '12337', '21130463@st.hcmuaf.edu.vn', '2024-12-18 23:43:05', 1),
(17, '83144', '21130463@st.hcmuaf.edu.vn', '2024-12-18 23:44:05', 1),
(18, '41473', '21130463@st.hcmuaf.edu.vn', '2024-12-18 23:44:49', 1),
(19, '33979', '21130463@st.hcmuaf.edu.vn', '2024-12-18 23:46:40', 1),
(20, '95186', '21130463@st.hcmuaf.edu.vn', '2024-12-18 23:48:18', 1),
(21, '54378', '21130463@st.hcmuaf.edu.vn', '2024-12-18 23:48:35', 1),
(22, '79692', '21130463@st.hcmuaf.edu.vn', '2024-12-18 23:49:29', 1),
(23, '32391', '21130463@st.hcmuaf.edu.vn', '2024-12-18 23:50:09', 1),
(24, '13512', '21130463@st.hcmuaf.edu.vn', '2024-12-18 23:50:24', 1),
(25, '15652', '21130463@st.hcmuaf.edu.vn', '2024-12-18 23:50:37', 1),
(26, '11926', '21130463@st.hcmuaf.edu.vn', '2024-12-18 23:50:54', 1),
(27, '95659', '21130463@st.hcmuaf.edu.vn', '2024-12-18 23:51:49', 1),
(28, '34434', '21130463@st.hcmuaf.edu.vn', '2024-12-18 23:52:39', 0),
(29, '36989', '21130463@st.hcmuaf.edu.vn', '2024-12-18 23:55:18', 0),
(30, '55982', '21130463@st.hcmuaf.edu.vn', '2024-12-20 12:25:40', 1),
(31, '49338', '21130463@st.hcmuaf.edu.vn', '2024-12-20 12:26:54', 1),
(32, '74789', '21130463@st.hcmuaf.edu.vn', '2024-12-20 12:31:54', 1),
(33, '22336', '21130463@st.hcmuaf.edu.vn', '2024-12-20 12:32:12', 1),
(34, '25735', '21130463@st.hcmuaf.edu.vn', '2024-12-20 13:41:41', 1),
(35, '26273', '21130463@st.hcmuaf.edu.vn', '2024-12-20 13:42:09', 0),
(36, '13393', '21130463@st.hcmuaf.edu.vn', '2024-12-20 13:44:57', 0),
(37, '87611', '21130463@st.hcmuaf.edu.vn', '2024-12-20 13:50:21', 0),
(38, '74987', '21130463@st.hcmuaf.edu.vn', '2024-12-20 14:40:26', 0),
(39, '18548', '21130463@st.hcmuaf.edu.vn', '2024-12-20 14:42:07', 0),
(40, '71864', '21130463@st.hcmuaf.edu.vn', '2024-12-20 16:02:12', 0),
(41, '37338', '21130463@st.hcmuaf.edu.vn', '2024-12-23 21:59:12', 1),
(42, '28382', '21130463@st.hcmuaf.edu.vn', '2024-12-23 22:00:01', 1),
(43, '93994', '21130463@st.hcmuaf.edu.vn', '2024-12-23 22:06:05', 1),
(44, '92772', '21130463@st.hcmuaf.edu.vn', '2024-12-23 22:11:18', 1),
(45, '54134', '21130463@st.hcmuaf.edu.vn', '2024-12-23 22:16:44', 0),
(46, '11955', '21130463@st.hcmuaf.edu.vn', '2024-12-23 22:20:05', 0),
(47, '74472', '21130463@st.hcmuaf.edu.vn', '2024-12-23 22:25:37', 0),
(48, '79573', '21130463@st.hcmuaf.edu.vn', '2024-12-23 22:27:24', 0),
(49, '14858', '21130463@st.hcmuaf.edu.vn', '2024-12-23 22:29:31', 0),
(50, '33557', '21130463@st.hcmuaf.edu.vn', '2024-12-23 22:31:08', 0),
(51, '35391', '21130463@st.hcmuaf.edu.vn', '2024-12-23 22:32:35', 0),
(52, '11177', '21130463@st.hcmuaf.edu.vn', '2024-12-23 22:36:32', 1),
(53, '69121', '21130463@st.hcmuaf.edu.vn', '2024-12-23 22:36:49', 0),
(54, '93467', '21130463@st.hcmuaf.edu.vn', '2024-12-23 22:45:10', 0),
(55, '35826', '21130463@st.hcmuaf.edu.vn', '2024-12-23 22:46:09', 0),
(56, '72958', '21130463@st.hcmuaf.edu.vn', '2024-12-23 22:47:30', 0),
(57, '12282', '21130463@st.hcmuaf.edu.vn', '2024-12-23 22:55:59', 0),
(58, '43823', '21130463@st.hcmuaf.edu.vn', '2024-12-23 23:06:48', 0),
(59, '56225', '21130463@st.hcmuaf.edu.vn', '2024-12-23 23:14:11', 0),
(60, '35245', '21130463@st.hcmuaf.edu.vn', '2024-12-23 23:15:09', 0),
(61, '82191', '21130463@st.hcmuaf.edu.vn', '2024-12-23 23:17:23', 0),
(62, '26332', '21130463@st.hcmuaf.edu.vn', '2024-12-23 23:19:12', 0),
(63, '64132', '21130463@st.hcmuaf.edu.vn', '2024-12-23 23:20:54', 0),
(64, '41464', '21130463@st.hcmuaf.edu.vn', '2024-12-23 23:45:16', 0),
(65, '38759', '21130463@st.hcmuaf.edu.vn', '2024-12-23 23:46:13', 0),
(66, '33316', '21130463@st.hcmuaf.edu.vn', '2024-12-23 23:50:00', 0),
(67, '94191', '21130463@st.hcmuaf.edu.vn', '2024-12-23 23:50:38', 0),
(68, '86823', '21130463@st.hcmuaf.edu.vn', '2024-12-23 23:59:02', 0),
(69, '16261', '21130463@st.hcmuaf.edu.vn', '2024-12-24 00:04:59', 1),
(70, '49462', '21130463@st.hcmuaf.edu.vn', '2024-12-24 00:13:05', 0),
(71, '51754', '21130463@st.hcmuaf.edu.vn', '2024-12-24 00:16:48', 0),
(72, '76285', 'pharmacity@gmail.com', '2024-12-24 07:44:20', 1),
(73, '15347', '21130463@st.hcmuaf.edu.vn', '2024-12-24 08:30:09', 0),
(74, '16355', '21130463@st.hcmuaf.edu.vn', '2025-01-07 13:36:52', 1),
(75, '82432', '21130463@st.hcmuaf.edu.vn', '2025-01-07 13:44:21', 1),
(76, '54768', '21130463@st.hcmuaf.edu.vn', '2025-01-07 13:48:57', 0);

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `addresses`
--
ALTER TABLE `addresses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `userID` (`userID`);

--
-- Chỉ mục cho bảng `branches`
--
ALTER TABLE `branches`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `brands`
--
ALTER TABLE `brands`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `carts`
--
ALTER TABLE `carts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `userID` (`userID`),
  ADD KEY `productDetailID` (`productDetailID`);

--
-- Chỉ mục cho bảng `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `frk_userID` (`userID`),
  ADD KEY `objectID` (`objectID`);

--
-- Chỉ mục cho bảng `crosssells`
--
ALTER TABLE `crosssells`
  ADD PRIMARY KEY (`id`),
  ADD KEY `productID` (`productID`);

--
-- Chỉ mục cho bảng `images`
--
ALTER TABLE `images`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `orderdetails`
--
ALTER TABLE `orderdetails`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `userID` (`userID`);

--
-- Chỉ mục cho bảng `order_history`
--
ALTER TABLE `order_history`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `productdetails`
--
ALTER TABLE `productdetails`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pId_keY` (`productID`);

--
-- Chỉ mục cho bảng `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `brId_keY` (`brandID`),
  ADD KEY `cateId_keY` (`cateID`);

--
-- Chỉ mục cho bảng `promotions`
--
ALTER TABLE `promotions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `frk_saleProgramID` (`saleprogramID`);

--
-- Chỉ mục cho bảng `publickeys`
--
ALTER TABLE `publickeys`
  ADD PRIMARY KEY (`id`),
  ADD KEY `frk_publickey_user` (`user_id`);

--
-- Chỉ mục cho bảng `saleprograms`
--
ALTER TABLE `saleprograms`
  ADD PRIMARY KEY (`id`),
  ADD KEY `objectID` (`objectID`);

--
-- Chỉ mục cho bảng `series`
--
ALTER TABLE `series`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `verifycode`
--
ALTER TABLE `verifycode`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `verifycodes`
--
ALTER TABLE `verifycodes`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `addresses`
--
ALTER TABLE `addresses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT cho bảng `branches`
--
ALTER TABLE `branches`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `brands`
--
ALTER TABLE `brands`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT cho bảng `carts`
--
ALTER TABLE `carts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=73;

--
-- AUTO_INCREMENT cho bảng `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT cho bảng `comments`
--
ALTER TABLE `comments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT cho bảng `crosssells`
--
ALTER TABLE `crosssells`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT cho bảng `images`
--
ALTER TABLE `images`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=562;

--
-- AUTO_INCREMENT cho bảng `orderdetails`
--
ALTER TABLE `orderdetails`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=73;

--
-- AUTO_INCREMENT cho bảng `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=58;

--
-- AUTO_INCREMENT cho bảng `order_history`
--
ALTER TABLE `order_history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT cho bảng `productdetails`
--
ALTER TABLE `productdetails`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=248;

--
-- AUTO_INCREMENT cho bảng `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=146;

--
-- AUTO_INCREMENT cho bảng `promotions`
--
ALTER TABLE `promotions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT cho bảng `publickeys`
--
ALTER TABLE `publickeys`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT cho bảng `saleprograms`
--
ALTER TABLE `saleprograms`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT cho bảng `series`
--
ALTER TABLE `series`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT cho bảng `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT cho bảng `verifycode`
--
ALTER TABLE `verifycode`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50;

--
-- AUTO_INCREMENT cho bảng `verifycodes`
--
ALTER TABLE `verifycodes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=77;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `addresses`
--
ALTER TABLE `addresses`
  ADD CONSTRAINT `addresses_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `users` (`id`);

--
-- Các ràng buộc cho bảng `carts`
--
ALTER TABLE `carts`
  ADD CONSTRAINT `carts_ibfk_1` FOREIGN KEY (`productDetailID`) REFERENCES `productdetails` (`id`),
  ADD CONSTRAINT `carts_ibfk_2` FOREIGN KEY (`userID`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `carts_ibfk_3` FOREIGN KEY (`productDetailID`) REFERENCES `productdetails` (`id`);

--
-- Các ràng buộc cho bảng `comments`
--
ALTER TABLE `comments`
  ADD CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`objectID`) REFERENCES `products` (`id`),
  ADD CONSTRAINT `frk_objectID` FOREIGN KEY (`objectID`) REFERENCES `productdetails` (`id`),
  ADD CONSTRAINT `frk_userID` FOREIGN KEY (`userID`) REFERENCES `users` (`id`);

--
-- Các ràng buộc cho bảng `crosssells`
--
ALTER TABLE `crosssells`
  ADD CONSTRAINT `crosssells_ibfk_1` FOREIGN KEY (`productID`) REFERENCES `productdetails` (`productID`);

--
-- Các ràng buộc cho bảng `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `users` (`id`);

--
-- Các ràng buộc cho bảng `productdetails`
--
ALTER TABLE `productdetails`
  ADD CONSTRAINT `pId_keY` FOREIGN KEY (`productID`) REFERENCES `products` (`id`);

--
-- Các ràng buộc cho bảng `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `brId_keY` FOREIGN KEY (`brandID`) REFERENCES `brands` (`id`),
  ADD CONSTRAINT `cateId_keY` FOREIGN KEY (`cateID`) REFERENCES `categories` (`id`);

--
-- Các ràng buộc cho bảng `promotions`
--
ALTER TABLE `promotions`
  ADD CONSTRAINT `frk_saleProgramID` FOREIGN KEY (`saleprogramID`) REFERENCES `saleprograms` (`id`);

--
-- Các ràng buộc cho bảng `publickeys`
--
ALTER TABLE `publickeys`
  ADD CONSTRAINT `frk_publickey_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Các ràng buộc cho bảng `saleprograms`
--
ALTER TABLE `saleprograms`
  ADD CONSTRAINT `frk_objectIDPromotion` FOREIGN KEY (`objectID`) REFERENCES `productdetails` (`id`),
  ADD CONSTRAINT `saleprograms_ibfk_1` FOREIGN KEY (`objectID`) REFERENCES `products` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
