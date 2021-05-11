-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 09, 2020 at 02:32 PM
-- Server version: 10.1.38-MariaDB
-- PHP Version: 7.3.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `hotel`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_cuisine_types_by_restID` (IN `restID` INT(20))  SELECT restaurant_name,  cuisine_type
FROM t_restaurants
INNER JOIN t_restaurant_cuisine
ON t_restaurants.restaurant_id = t_restaurant_cuisine.restaurant_id
where t_restaurants.restaurant_id =restID$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_banquet_rates_by_bid` (IN `CID` INT(30), IN `BID` INT(30))  SELECT
    t_banquet_capacity_price.banquet_capacity_price
FROM
    t_banquet_booking
INNER JOIN t_banquet_capacity_price ON
t_banquet_booking.banquet_capacity_price_id = t_banquet_capacity_price.banquet_capacity_price_id

where t_banquet_booking.banquet_booking_id = BID
AND t_banquet_booking.booked_by = CID$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_check_abbr_by_id` (IN `rabbr` VARCHAR(30), IN `custID` INT(20))  NO SQL
(
    SELECT
        t_customer_login.cust_id,
        cust_fname,
        cust_lname,
        restaurant_name AS bookings,
        t_restaurant_booking.rest_booking_ID AS bookingID,
        restaurant_datetime AS checkin,
    	restaurant_datetime AS checkout,
        rest_abbr
    FROM
        t_customer_personal_data
    INNER JOIN t_customer_login ON t_customer_login.cust_id = t_customer_personal_data.cust_id
    INNER JOIN t_restaurant_booking ON t_restaurant_booking.customer_id = t_customer_login.cust_id
    INNER JOIN t_restaurants ON t_restaurants.restaurant_id = t_restaurant_booking.restaurant_id
    WHERE
        t_restaurant_booking.is_booked = 1 AND
    t_customer_personal_data.cust_id = custID AND t_restaurants.rest_abbr = rabbr
)
UNION
    (
    SELECT
        t_customer_login.cust_id,
        cust_fname,
        cust_lname,
        banquet_name,
        t_banquet_booking.banquet_booking_id AS bookingID,
        booking_date,
        booking_date,
        abbr
    FROM
        t_customer_personal_data
    INNER JOIN t_customer_login ON t_customer_login.cust_id = t_customer_personal_data.cust_id
    INNER JOIN t_banquet_booking ON t_banquet_booking.booked_by = t_customer_login.cust_id
    INNER JOIN t_banquets ON t_banquets.banquet_id = t_banquet_booking.banquet_id
    WHERE
        t_banquet_booking.is_booked = 1 AND
    t_customer_personal_data.cust_id = custID AND t_banquets.abbr = rabbr
)
UNION
    (
    SELECT
        t_customer_login.cust_id,
        cust_fname,
        cust_lname,
        room_type,
        t_room_booking.room_booking_id AS bookingID,
        check_in,
        check_out,
        abbr
    FROM
        t_customer_personal_data
    INNER JOIN t_customer_login ON t_customer_login.cust_id = t_customer_personal_data.cust_id
    INNER JOIN t_room_booking ON t_room_booking.booked_by = t_customer_login.cust_id
    INNER JOIN t_rooms ON t_rooms.room_id = t_room_booking.room_id
    INNER JOIN t_room_type ON t_room_type.room_type_id = t_rooms.room_type_id
    WHERE
        t_room_booking.is_booked = 1 AND
    t_customer_personal_data.cust_id = custID AND t_room_type.abbr = rabbr
)
UNION
    (
    SELECT
        t_customer_login.cust_id,
        cust_fname,
        cust_lname,
        spa_massage_type,
        t_spaa.spa_id AS bookingID,
        spa_datetime,
         spa_datetime,
        abbr
    FROM
        t_customer_personal_data
    INNER JOIN t_customer_login ON t_customer_login.cust_id = t_customer_personal_data.cust_id
    INNER JOIN t_spaa ON t_spaa.cust_id = t_customer_login.cust_id
    INNER JOIN t_spa_massage_type ON t_spa_massage_type.spa_massage_type_id = t_spaa.spa_massage_type_id
    WHERE
        t_spaa.is_booked = 1 AND
    t_customer_personal_data.cust_id = custID AND t_spa_massage_type.abbr = rabbr
)
UNION
    (
    SELECT
        t_customer_login.cust_id,
        cust_fname,
        cust_lname,
        t_conference_list.conf_type,
        t_conference.conference_id AS bookingID,
        t_conference.conference_date,
        t_conference.conference_date,
        t_conference_list.abbr
    FROM
        t_customer_personal_data
    INNER JOIN t_customer_login ON t_customer_login.cust_id = t_customer_personal_data.cust_id
    INNER JOIN t_conference ON t_conference.cust_id = t_customer_login.cust_id
    INNER JOIN t_conference_list ON t_conference_list.conf_type_id = t_conference.conf_type_id
    WHERE
        t_conference.is_booked = 1 AND t_customer_personal_data.cust_id = custID AND t_conference_list.abbr = rabbr
)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_conf_rates_by_bid` (IN `BID` INT(30), IN `CID` INT(30))  SELECT
    t_conference_list.conf_rent
FROM
    t_conference
INNER JOIN t_conference_list ON t_conference.conf_type_id = t_conference_list.conf_type_id
WHERE
    t_conference.conference_id = BID AND t_conference.cust_id = CID$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_get_all_bills_for_checkout` ()  (
    SELECT
        t_customer_login.cust_id,
        cust_fname,
        cust_lname,
        restaurant_name AS bookings,
        t_restaurant_booking.rest_booking_ID AS bookingID,
        restaurant_datetime AS checkin,
        restaurant_datetime AS checkout,
        rest_abbr
    FROM
        t_customer_personal_data
    INNER JOIN t_customer_login ON t_customer_login.cust_id = t_customer_personal_data.cust_id
    INNER JOIN t_restaurant_booking ON t_restaurant_booking.customer_id = t_customer_login.cust_id
    INNER JOIN t_restaurants ON t_restaurants.restaurant_id = t_restaurant_booking.restaurant_id
    WHERE
        t_restaurant_booking.is_booked = 1
)
UNION
    (
    SELECT
        t_customer_login.cust_id,
        cust_fname,
        cust_lname,
        banquet_name,
        t_banquet_booking.banquet_booking_id AS bookingID,
        booking_date,
        booking_date,
        abbr
    FROM
        t_customer_personal_data
    INNER JOIN t_customer_login ON t_customer_login.cust_id = t_customer_personal_data.cust_id
    INNER JOIN t_banquet_booking ON t_banquet_booking.booked_by = t_customer_login.cust_id
    INNER JOIN t_banquets ON t_banquets.banquet_id = t_banquet_booking.banquet_id
    WHERE
        t_banquet_booking.is_booked = 1
)
UNION
    (
    SELECT
        t_customer_login.cust_id,
        cust_fname,
        cust_lname,
        room_type,
        t_room_booking.room_booking_id AS bookingID,
        check_in,
        check_out,
        abbr
    FROM
        t_customer_personal_data
    INNER JOIN t_customer_login ON t_customer_login.cust_id = t_customer_personal_data.cust_id
    INNER JOIN t_room_booking ON t_room_booking.booked_by = t_customer_login.cust_id
    INNER JOIN t_rooms ON t_rooms.room_id = t_room_booking.room_id
    INNER JOIN t_room_type ON t_room_type.room_type_id = t_rooms.room_type_id
    WHERE
        t_room_booking.is_booked = 1
)
UNION
    (
    SELECT
        t_customer_login.cust_id,
        cust_fname,
        cust_lname,
        spa_massage_type,
        t_spaa.spa_id AS bookingID,
        spa_datetime,
        spa_datetime,
        abbr
    FROM
        t_customer_personal_data
    INNER JOIN t_customer_login ON t_customer_login.cust_id = t_customer_personal_data.cust_id
    INNER JOIN t_spaa ON t_spaa.cust_id = t_customer_login.cust_id
    INNER JOIN t_spa_massage_type ON t_spa_massage_type.spa_massage_type_id = t_spaa.spa_massage_type_id
    WHERE
        t_spaa.is_booked = 1
)
UNION
    (
    SELECT
        t_customer_login.cust_id,
        cust_fname,
        cust_lname,
        t_conference_list.conf_type,
        t_conference.conference_id AS bookingID,
        t_conference.conference_date,
        t_conference.conference_date,
        t_conference_list.abbr
    FROM
        t_customer_personal_data
    INNER JOIN t_customer_login ON t_customer_login.cust_id = t_customer_personal_data.cust_id
    INNER JOIN t_conference ON t_conference.cust_id = t_customer_login.cust_id
    INNER JOIN t_conference_list ON t_conference_list.conf_type_id = t_conference.conf_type_id
    WHERE
        t_conference.is_booked = 1
)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_get_booked_banquets` ()  BEGIN

SELECT * FROM v_get_booked_banquets_admin;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_get_booked_conference` ()  NO SQL
SELECT t_conference.conference_id,
t_customer_personal_data.cust_id, t_customer_personal_data.cust_fname, t_customer_personal_data.cust_lname, cl.conf_type, cg.conf_guest,
t_conference.conference_date, t_conference.conf_time, cl.conf_rent,
t_conference.created_on

FROM t_customer_personal_data

INNER JOIN t_customer_login 
ON t_customer_personal_data.cust_id = t_customer_login.cust_id


INNER JOIN t_conference
ON t_conference.cust_id = t_customer_login.cust_id 

INNER JOIN t_conference_list cl
ON t_conference.conf_type_id = cl.conf_type_id

INNER JOIN t_conf_guest cg
ON t_conference.conf_guest_id = cg.conf_guest_id

where t_conference.is_booked=1
group by `t_conference`.`created_on` order by `t_conference`.`created_on` desc$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_get_booked_restaurants` ()  NO SQL
SELECT * FROM v_get_booked_rest_admin$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_get_booked_rooms` ()  select * from v_get_booked_rooms_admin$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_get_booked_spa` ()  NO SQL
SELECT t_spaa.spa_id,
t_customer_personal_data.cust_id, t_customer_personal_data.cust_fname, t_customer_personal_data.cust_lname, smt.spa_massage_type, 
t_spaa.spa_datetime,
t_spaa.spa_time,
t_spaa.created_on

FROM t_customer_personal_data

INNER JOIN t_customer_login 
ON t_customer_personal_data.cust_id = t_customer_login.cust_id

INNER JOIN t_spaa 
ON t_spaa.cust_id = t_customer_login.cust_id 

INNER JOIN t_spa_massage_type smt 
ON t_spaa.spa_massage_type_id = smt.spa_massage_type_id

where t_spaa.is_booked=1
group by `t_spaa`.`created_on` order by `t_spaa`.`created_on` desc$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_get_checkoutbill_by_date` (IN `custID` INT(30), IN `datet` DATE)  (
    SELECT
        t_customer_login.cust_id,
        cust_fname,
        cust_lname,
        restaurant_name AS bookings,
        t_restaurant_booking.rest_booking_ID AS bookingID,
        restaurant_datetime AS checkout,
        rest_abbr
    FROM
        t_customer_personal_data
    INNER JOIN t_customer_login ON t_customer_login.cust_id = 	 t_customer_personal_data.cust_id
    INNER JOIN t_restaurant_booking ON t_restaurant_booking.customer_id = t_customer_login.cust_id
    INNER JOIN t_restaurants ON t_restaurants.restaurant_id = t_restaurant_booking.restaurant_id
    WHERE
        t_restaurant_booking.is_booked = 1 AND t_customer_login.cust_id = custID AND t_restaurant_booking.restaurant_datetime = datet
)
UNION
    (
    SELECT
        t_customer_login.cust_id,
        cust_fname,
        cust_lname,
        banquet_name,
        t_banquet_booking.banquet_booking_id AS bookingID,
        booking_date,
        abbr
    FROM
        t_customer_personal_data 
    INNER JOIN t_customer_login ON t_customer_login.cust_id = t_customer_personal_data.cust_id
    INNER JOIN t_banquet_booking ON t_banquet_booking.booked_by = t_customer_login.cust_id
    INNER JOIN t_banquets ON t_banquets.banquet_id = t_banquet_booking.banquet_id
    WHERE
        t_banquet_booking.is_booked = 1 AND t_customer_login.cust_id = custID  AND t_banquet_booking.booking_date = datet
)
UNION
    (
    SELECT
        t_customer_login.cust_id,
        cust_fname,
        cust_lname,
        room_type,
        t_room_booking.room_booking_id AS bookingID,
        check_out,
        abbr
    FROM
        t_customer_personal_data
    INNER JOIN t_customer_login ON t_customer_login.cust_id = t_customer_personal_data.cust_id
    INNER JOIN t_room_booking ON t_room_booking.booked_by = t_customer_login.cust_id
    INNER JOIN t_rooms ON t_rooms.room_id = t_room_booking.room_id
    INNER JOIN t_room_type ON t_room_type.room_type_id = t_rooms.room_type_id
    WHERE
        t_room_booking.is_booked = 1 AND t_customer_login.cust_id = custID  AND t_room_booking.check_out = datet 
)
UNION
    (
    SELECT
        t_customer_login.cust_id,
        cust_fname,
        cust_lname,
        spa_massage_type,
        t_spaa.spa_id AS bookingID,
        spa_datetime,
        abbr
    FROM
        t_customer_personal_data
    INNER JOIN t_customer_login ON t_customer_login.cust_id = t_customer_personal_data.cust_id
    INNER JOIN t_spaa ON t_spaa.cust_id = t_customer_login.cust_id
    INNER JOIN t_spa_massage_type ON t_spa_massage_type.spa_massage_type_id = t_spaa.spa_massage_type_id
    WHERE
        t_spaa.is_booked = 1 AND t_customer_login.cust_id = custID  AND t_spaa.spa_datetime = datet
)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_get_distinct_data_for_checkout` ()  NO SQL
(
    SELECT
        DISTINCT t_customer_login.cust_id,
        cust_fname,
        cust_lname,
        restaurant_name AS bookings,
        t_restaurant_booking.rest_booking_ID AS bookingID,
        restaurant_datetime AS checkin,
        restaurant_datetime AS checkout,
        rest_abbr
    FROM
        t_customer_personal_data
    INNER JOIN t_customer_login ON t_customer_login.cust_id = t_customer_personal_data.cust_id
    INNER JOIN t_restaurant_booking ON t_restaurant_booking.customer_id = t_customer_login.cust_id
    INNER JOIN t_restaurants ON t_restaurants.restaurant_id = t_restaurant_booking.restaurant_id
    WHERE
        t_restaurant_booking.is_booked = 1
)
UNION
    (
    SELECT
       DISTINCT t_customer_login.cust_id,
        cust_fname,
        cust_lname,
        banquet_name,
        t_banquet_booking.banquet_booking_id AS bookingID,
        booking_date,
        booking_date,
        abbr
    FROM
        t_customer_personal_data
    INNER JOIN t_customer_login ON t_customer_login.cust_id = t_customer_personal_data.cust_id
    INNER JOIN t_banquet_booking ON t_banquet_booking.booked_by = t_customer_login.cust_id
    INNER JOIN t_banquets ON t_banquets.banquet_id = t_banquet_booking.banquet_id
    WHERE
        t_banquet_booking.is_booked = 1
)
UNION
    (
    SELECT
        DISTINCT t_customer_login.cust_id,
        cust_fname,
        cust_lname,
        room_type,
        t_room_booking.room_booking_id AS bookingID,
        check_in,
        check_out,
        abbr
    FROM
        t_customer_personal_data
    INNER JOIN t_customer_login ON t_customer_login.cust_id = t_customer_personal_data.cust_id
    INNER JOIN t_room_booking ON t_room_booking.booked_by = t_customer_login.cust_id
    INNER JOIN t_rooms ON t_rooms.room_id = t_room_booking.room_id
    INNER JOIN t_room_type ON t_room_type.room_type_id = t_rooms.room_type_id
    WHERE
        t_room_booking.is_booked = 1
)
UNION
    (
    SELECT
       DISTINCT  t_customer_login.cust_id,
        cust_fname,
        cust_lname,
        spa_massage_type,
        t_spaa.spa_id AS bookingID,
        spa_datetime,
        spa_datetime,
        abbr
    FROM
        t_customer_personal_data
    INNER JOIN t_customer_login ON t_customer_login.cust_id = t_customer_personal_data.cust_id
    INNER JOIN t_spaa ON t_spaa.cust_id = t_customer_login.cust_id
    INNER JOIN t_spa_massage_type ON t_spa_massage_type.spa_massage_type_id = t_spaa.spa_massage_type_id
    WHERE
        t_spaa.is_booked = 1
)
UNION
    (
    SELECT
      DISTINCT  t_customer_login.cust_id,
        cust_fname,
        cust_lname,
        t_conference_list.conf_type,
        t_conference.conference_id AS bookingID,
        t_conference.conference_date,
        t_conference.conference_date,
        t_conference_list.abbr
    FROM
        t_customer_personal_data
    INNER JOIN t_customer_login ON t_customer_login.cust_id = t_customer_personal_data.cust_id
    INNER JOIN t_conference ON t_conference.cust_id = t_customer_login.cust_id
    INNER JOIN t_conference_list ON t_conference_list.conf_type_id = t_conference.conf_type_id
    WHERE
        t_conference.is_booked = 1
)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_get_only_amenities` (IN `custID` INT(30))  (
    SELECT
        t_customer_login.cust_id,
        cust_fname,
        cust_lname,
        restaurant_name AS bookings,
        t_restaurant_booking.rest_booking_ID AS bookingID,
        restaurant_datetime AS checkin,
    	restaurant_datetime AS checkout,
        rest_abbr
    FROM
        t_customer_personal_data
    INNER JOIN t_customer_login ON t_customer_login.cust_id = t_customer_personal_data.cust_id
    INNER JOIN t_restaurant_booking ON t_restaurant_booking.customer_id = t_customer_login.cust_id
    INNER JOIN t_restaurants ON t_restaurants.restaurant_id = t_restaurant_booking.restaurant_id
    WHERE
        t_restaurant_booking.is_booked = 1 AND
    t_customer_personal_data.cust_id = custID 
)
UNION
    (
    SELECT
        t_customer_login.cust_id,
        cust_fname,
        cust_lname,
        banquet_name,
        t_banquet_booking.banquet_booking_id AS bookingID,
        booking_date,
        booking_date,
        abbr
    FROM
        t_customer_personal_data
    INNER JOIN t_customer_login ON t_customer_login.cust_id = t_customer_personal_data.cust_id
    INNER JOIN t_banquet_booking ON t_banquet_booking.booked_by = t_customer_login.cust_id
    INNER JOIN t_banquets ON t_banquets.banquet_id = t_banquet_booking.banquet_id
    WHERE
        t_banquet_booking.is_booked = 1 AND
    t_customer_personal_data.cust_id = custID
)
UNION
    (
    SELECT
        t_customer_login.cust_id,
        cust_fname,
        cust_lname,
        spa_massage_type,
        t_spaa.spa_id AS bookingID,
        spa_datetime,
         spa_datetime,
        abbr
    FROM
        t_customer_personal_data
    INNER JOIN t_customer_login ON t_customer_login.cust_id = t_customer_personal_data.cust_id
    INNER JOIN t_spaa ON t_spaa.cust_id = t_customer_login.cust_id
    INNER JOIN t_spa_massage_type ON t_spa_massage_type.spa_massage_type_id = t_spaa.spa_massage_type_id
    WHERE
        t_spaa.is_booked = 1 AND
    t_customer_personal_data.cust_id = custID 
)
UNION
    (
    SELECT
        t_customer_login.cust_id,
        cust_fname,
        cust_lname,
        t_conference_list.conf_type,
        t_conference.conference_id AS bookingID,
        t_conference.conference_date,
        t_conference.conference_date,
        t_conference_list.abbr
    FROM
        t_customer_personal_data
    INNER JOIN t_customer_login ON t_customer_login.cust_id = t_customer_personal_data.cust_id
    INNER JOIN t_conference ON t_conference.cust_id = t_customer_login.cust_id
    INNER JOIN t_conference_list ON t_conference_list.conf_type_id = t_conference.conf_type_id
    WHERE
        t_conference.is_booked = 1 AND t_customer_personal_data.cust_id = custID 
)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_pay_amenities_by_RM` (IN `checkin` DATE, IN `checkout` DATE, IN `Cid` INT(30))  (
    SELECT
        t_customer_login.cust_id,
        cust_fname,
        cust_lname,
        restaurant_name AS bookings,
        t_restaurant_booking.rest_booking_ID AS bookingID,
        restaurant_datetime AS checkin,
    	restaurant_datetime AS checkout,
        rest_abbr
    FROM
        t_customer_personal_data
    INNER JOIN t_customer_login ON t_customer_login.cust_id = t_customer_personal_data.cust_id
    INNER JOIN t_restaurant_booking ON t_restaurant_booking.customer_id = t_customer_login.cust_id
    INNER JOIN t_restaurants ON t_restaurants.restaurant_id = t_restaurant_booking.restaurant_id
    WHERE
        t_restaurant_booking.is_booked = 1 AND 
    t_customer_personal_data.cust_id =Cid AND
    t_restaurant_booking.restaurant_datetime BETWEEN checkin AND checkout AND t_restaurant_booking.restaurant_datetime <= checkout
)
UNION
    (
    SELECT
        t_customer_login.cust_id,
        cust_fname,
        cust_lname,
        banquet_name,
        t_banquet_booking.banquet_booking_id AS bookingID,
        booking_date,
        booking_date,
        abbr
    FROM
        t_customer_personal_data
    INNER JOIN t_customer_login ON t_customer_login.cust_id = t_customer_personal_data.cust_id
    INNER JOIN t_banquet_booking ON t_banquet_booking.booked_by = t_customer_login.cust_id
    INNER JOIN t_banquets ON t_banquets.banquet_id = t_banquet_booking.banquet_id
    WHERE
        t_banquet_booking.is_booked = 1  and t_customer_personal_data.cust_id =Cid AND
    t_banquet_booking.booking_date BETWEEN checkin AND checkout
)

UNION
    (
    SELECT
        t_customer_login.cust_id,
        cust_fname,
        cust_lname,
        spa_massage_type,
        t_spaa.spa_id AS bookingID,
        spa_datetime,
         spa_datetime,
        abbr
    FROM
        t_customer_personal_data
    INNER JOIN t_customer_login ON t_customer_login.cust_id = t_customer_personal_data.cust_id
    INNER JOIN t_spaa ON t_spaa.cust_id = t_customer_login.cust_id
    INNER JOIN t_spa_massage_type ON t_spa_massage_type.spa_massage_type_id = t_spaa.spa_massage_type_id
    WHERE
        t_spaa.is_booked = 1 and  t_customer_personal_data.cust_id =Cid AND
    t_spaa.spa_datetime BETWEEN checkin AND checkout
)
UNION
    (
    SELECT
        t_customer_login.cust_id,
        cust_fname,
        cust_lname,
        t_conference_list.conf_type,
        t_conference.conference_id AS bookingID,
        t_conference.conference_date,
        t_conference.conference_date,
        t_conference_list.abbr
    FROM
        t_customer_personal_data
    INNER JOIN t_customer_login ON t_customer_login.cust_id = t_customer_personal_data.cust_id
    INNER JOIN t_conference ON t_conference.cust_id = t_customer_login.cust_id
    INNER JOIN t_conference_list ON t_conference_list.conf_type_id = t_conference.conf_type_id
    WHERE
        t_conference.is_booked = 1 and t_customer_personal_data.cust_id =Cid AND
    t_conference.conference_date BETWEEN checkin AND checkout
)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_pay_rooms_by_RM` (IN `checkin` DATE, IN `checkout` DATE, IN `Cid` INT(30))  SELECT
        t_customer_login.cust_id,
        cust_fname,
        cust_lname,
        room_type,
        t_room_booking.room_booking_id AS bookingID,
        check_in,
        check_out,
        abbr
    FROM
        t_customer_personal_data
    INNER JOIN t_customer_login ON t_customer_login.cust_id = t_customer_personal_data.cust_id
    INNER JOIN t_room_booking ON t_room_booking.booked_by = t_customer_login.cust_id
    INNER JOIN t_rooms ON t_rooms.room_id = t_room_booking.room_id
    INNER JOIN t_room_type ON t_room_type.room_type_id = t_rooms.room_type_id
    WHERE
        t_room_booking.is_booked = 1 AND
        t_customer_login.cust_id = Cid AND
       t_room_booking.check_in BETWEEN checkin AND checkout
       AND t_room_booking.check_out <= checkout$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_restaurant_rates_by_BID` (IN `BID` INT, IN `CID` INT)  SELECT
    t_restaurant_booking.restaurant_guests,
    t_restaurants.restaurant_rates
FROM
    t_restaurant_booking
INNER JOIN t_restaurants ON t_restaurants.restaurant_id = t_restaurant_booking.restaurant_id
WHERE t_restaurant_booking.rest_booking_ID = BID AND t_restaurant_booking.customer_id = CID$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_room_rate_by_bid` (IN `BID` INT(30), IN `CID` INT(30))  SELECT
    t_room_booking.total_rent
FROM
    t_room_booking

where t_room_booking.room_booking_id = BID
AND t_room_booking.booked_by = CID$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_spa_rates_by_bid` (IN `BID` INT(30), IN `CID` INT(30))  SELECT
    t_spa_massage_type.spa_rate
FROM
    t_spaa
INNER JOIN t_spa_massage_type ON t_spaa.spa_massage_type_id = t_spa_massage_type.spa_massage_type_id
WHERE
    t_spaa.spa_id = BID AND t_spaa.cust_id = CID$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_banquet_booking` (IN `fName` VARCHAR(20), IN `mName` VARCHAR(20), IN `lName` VARCHAR(30), IN `dob` DATE, IN `pNumber` VARCHAR(11), IN `street` VARCHAR(20), IN `city` VARCHAR(20), IN `state` VARCHAR(20), IN `country` VARCHAR(20), IN `passport` VARCHAR(20), IN `nationalId` VARCHAR(20), IN `cardDetails` VARCHAR(20), IN `banquetMenuTypeId` INT, IN `banquetId` INT, IN `banquetCapacityPriceId` INT, IN `isBooked` TINYINT(1), IN `bookingDate` DATE, IN `bookingTimeFrom` TIME, IN `bookingTimeTo` TIME, IN `username` VARCHAR(20), IN `password` VARCHAR(30), IN `loyalty` INT)  BEGIN

INSERT INTO 
t_customer_personal_data(cust_fname,
                         cust_mname,
                         cust_lname,
                         cust_dob,
                         cust_phone_number)
                  VALUES(fName,
                         mName,
                         lName,
                         dob,
                         pNumber);
SET @custId = LAST_INSERT_ID();

INSERT INTO 
t_customer_address(cust_id,
                   cust_street,
                   cust_city,
                   cust_state,
                   cust_country)
            VALUES(@custId,
                   street,
                   city,
                   state,
                   country);
                   
INSERT INTO 
t_customer_identity_data(cust_id,
                         cust_passport_number,
                         cust_national_id,
                         cust_card_details)
                  VALUES(@custId,
                         passport,
                         nationalId,
                         cardDetails);
                         
INSERT INTO 
t_banquet_booking(booked_by,
                  banquet_menu_type_id,
                  banquet_id,
                  banquet_capacity_price_id,
                  is_booked,
                  booking_date,
                  booking_time_from,
                  booking_time_to
                 )
           VALUES(@custId,
                  banquetMenuTypeId,
                  banquetId,
                  banquetCapacityPriceId,
                  isBooked,
                  bookingDate,
                  bookingTimeFrom,
                  bookingTimeTo);
                  
INSERT INTO 
t_customer_login(cust_id,
                   cust_username,
                   cust_password
                   )
                   
            VALUES(@custId,
                   username,
                   password
                   );

INSERT INTO 
t_customer_loyalty_points(cust_id,
                   cust_loyalty_points
                   )
                   
            VALUES(@custId,
                   loyalty
                   );
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_book_banquet_by_login` (IN `custId` INT, IN `banquetId` INT, IN `bookinDate` DATE, IN `bookingTimeFrom` TIME, IN `bookingTimeTo` TIME, IN `banquetMenuTypeId` INT, IN `banquetCapacityPriceId` INT, IN `isBooked` TINYINT(1), IN `loyalty` INT)  BEGIN

INSERT INTO 
t_banquet_booking(booked_by,
                  banquet_menu_type_id,
                  banquet_id,
                  banquet_capacity_price_id,
                  booking_date,
                  booking_time_from,
                  booking_time_to,
                  is_booked)
           VALUES(custId,
                  banquetMenuTypeId,
                  banquetId,
                  banquetCapacityPriceId,
                  bookinDate,
                  bookingTimeFrom,
                  bookingTimeTo,
                  isBooked);
                  
UPDATE t_customer_loyalty_points 
SET cust_loyalty_points = cust_loyalty_points+loyalty 
WHERE cust_id = custId;                 

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_check_room_availability_by_type_date` (IN `roomTypeId` INT, IN `checkIn` DATE)  SELECT COUNT(is_booked) 
FROM t_room_booking
inner join t_rooms
on t_room_booking.room_id = t_rooms.room_id

where t_rooms.room_type_id = roomTypeId
AND t_room_booking.check_in = checkIn
And t_room_booking.is_booked = 1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_delete_booked_rooms_by_booking_id` (IN `bookingId` INT, IN `custID` INT)  MODIFIES SQL DATA
BEGIN

DECLARE prevLoyalty INT;
DECLARE prevTotalLoyalty INT;

SELECT loyalty_points INTO @prevLoyalty
FROM t_room_booking
WHERE room_booking_id = bookingId;

SELECT cust_loyalty_points INTO @prevTotalLoyalty
FROM t_customer_loyalty_points
WHERE cust_id = custID;

SET @custLoyalty = @prevTotalLoyalty - @prevLoyalty;

UPDATE t_customer_loyalty_points
SET cust_loyalty_points = @custLoyalty
WHERE cust_id = custID;

UPDATE t_room_booking
SET is_active = 0,
	is_booked = 0
WHERE room_booking_id = bookingId;

SELECT 'Deleted succesfully' as message;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_adult_child_capacity_by_roomtype` (IN `roomType` INT(30))  select DISTINCT room_type_id, adult_capacity, children_capacity from
t_rooms
inner join t_room_adult_children_capacity_mapping
on t_rooms.adult_children_capacity_map_id = t_room_adult_children_capacity_mapping.adult_children_capacity_map_id
INNER join t_room_adult_capacity ON
t_room_adult_children_capacity_mapping.adult_capacity_id = t_room_adult_capacity.adult_capacity_id
INNER join t_room_children_capacity
on t_room_adult_children_capacity_mapping.children_capacity_id = t_room_children_capacity.children_capacity_id

where t_rooms.room_type_id = roomType$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_all_cuisines` ()  SELECT  `restaurant_id`, `cuisine_type` FROM `t_restaurant_cuisine`$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_all_deals` ()  select * from t_room_deals$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_all_restaurants` ()  SELECT `restaurant_id`,`restaurant_name`, `restaurant_detail`, `restaurant_mode`, `restaurant_rates`, `restaurant_max_loyalty_points`, `restaurant_open_time`, `restaurant_close_time` FROM `t_restaurants`$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_available_room_count` (IN `roomTypeId` INT, IN `checkIn` DATE, IN `checkOut` DATE)  BEGIN

SELECT rf.room_floor, rn.room_number, r.room_id, COUNT(r.room_id) as count
FROM t_room_floors rf

INNER JOIN t_room_number_floor_mapping rnfm
ON rf.room_floor_id = rnfm.room_floor_id

INNER JOIN t_room_number rn
ON rnfm.room_number_id = rn.room_number_id

INNER JOIN t_rooms r
ON r.room_num_floor_map_id = rnfm.room_num_floor_map_id


WHERE r.room_id 
not IN (SELECT rb.room_id FROM t_room_booking rb 
  WHERE(checkIn <= rb.check_in AND checkOut >= rb.check_in)
    OR (checkIn <= rb.check_out AND checkOut >= rb.check_out)
    OR (rb.check_in <= checkIn AND rb.check_out >= checkOut) )
        
       
AND r.room_type_id = roomTypeId;


END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_available_room_number_by_room_type_id` (IN `roomTypeId` INT, IN `checkIn` DATE, IN `checkOut` DATE)  BEGIN

SELECT rf.room_floor, rn.room_number, r.room_id
FROM t_room_floors rf

INNER JOIN t_room_number_floor_mapping rnfm
ON rf.room_floor_id = rnfm.room_floor_id

INNER JOIN t_room_number rn
ON rnfm.room_number_id = rn.room_number_id

INNER JOIN t_rooms r
ON r.room_num_floor_map_id = rnfm.room_num_floor_map_id


WHERE r.room_id 
not IN (SELECT rb.room_id FROM t_room_booking rb 
  WHERE(checkIn <= rb.check_in AND checkOut >= rb.check_in)
    OR (checkIn <= rb.check_out AND checkOut >= rb.check_out)
    OR (rb.check_in <= checkIn AND rb.check_out >= checkOut) )
        
       
AND r.room_type_id = roomTypeId;


END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_banquets_details` ()  SELECT banquet_id, banquet_name, banquet_description, banquet_rate, total_capacity, seating_capacity, opening_time, closing_time, banquet_loyalty_points  
FROM t_banquets
WHERE is_active = 1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_banquet_availability_by_id` (IN `banquetId` INT, IN `bookingDate` DATE, IN `bookingTimeFrom` TIME)  NO SQL
BEGIN

    SELECT 1
    FROM t_banquet_booking
    WHERE banquet_id = banquetId 
    AND booking_date = bookingDate
    AND booking_time_from = bookingTimeFrom
    AND is_booked = 1;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_banquet_capacity_price_by_id` (IN `b_c_price_id` INT)  SELECT banquet_capacity_price
FROM t_banquet_capacity_price
WHERE banquet_capacity_price_id = b_c_price_id
AND is_active = 1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_banquet_menu_type` ()  SELECT banquet_menu_type_id, banquet_menu_type, menu_type_price
FROM t_banquet_menu_type$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_booked_banquets_by_cust_id` (IN `custId` INT)  SELECT pd.cust_id AS cust_id,
bb.banquet_booking_id AS banquet_booking_id,
pd.cust_fname AS cust_fname,
pd.cust_lname AS cust_lname,
b.banquet_name AS banquet_name,
bcp.banquet_capacity AS banquet_capacity,
bcp.banquet_capacity_price AS banquet_capacity_price,
bb.booking_date AS booking_date,
bb.booking_time_from AS booking_time_from,
bb.booking_time_to AS booking_time_to 

FROM t_customer_personal_data pd 

INNER JOIN t_banquet_booking bb 
ON bb.booked_by = pd.cust_id 

INNER JOIN t_banquet_capacity_price bcp
ON bcp.banquet_capacity_price_id = bb.banquet_capacity_price_id

INNER JOIN t_banquets b 
ON bb.banquet_id = b.banquet_id

WHERE bb.is_booked = 1 
AND pd.is_active = 1 
AND bb.is_active = 1 
AND b.is_active = 1 
AND bcp.is_active = 1 
AND bb.booked_by = custId$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_booked_conference_by_cust_id` (IN `custId` INT)  BEGIN

SELECT t_conference.conference_id,
t_customer_personal_data.cust_id, t_customer_personal_data.cust_fname, t_customer_personal_data.cust_lname, cl.conf_type, cg.conf_guest,
t_conference.conference_date, t_conference.conf_time, cl.conf_rent

FROM t_customer_personal_data

INNER JOIN t_customer_login 
ON t_customer_personal_data.cust_id = t_customer_login.cust_id


INNER JOIN t_conference
ON t_conference.cust_id = t_customer_login.cust_id 

INNER JOIN t_conference_list cl
ON t_conference.conf_type_id = cl.conf_type_id

INNER JOIN t_conf_guest cg
ON t_conference.conf_guest_id = cg.conf_guest_id

WHERE t_conference.is_booked=1
AND t_conference.cust_id = custId;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_booked_conference_count` (IN `confDate` DATE, IN `confTime` TIME)  BEGIN

SELECT * 
FROM t_conference 
WHERE conference_date = confDate
AND conf_time = confTime
AND is_booked = 1;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_booked_restaurant_by_cust_id` (IN `cusId` INT)  BEGIN
SELECT 	rb.rest_booking_ID ,
		rb.restaurant_id ,
        rb.restaurant_datetime,
        rb.restaurant_guests,
        tr.restaurant_name ,
        tr.restaurant_mode
     
FROM 	t_restaurant_booking rb

INNER JOIN t_restaurants tr 
ON rb.restaurant_id = tr.restaurant_id

WHERE rb.customer_id = cusId 
AND rb.is_booked = 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_booked_rooms_by_cust_id` (IN `custId` INT)  BEGIN

    SELECT 
    t_room_booking.room_booking_id AS room_booking_id,
    t_rooms.room_id AS room_id,
    t_room_type.room_type_id AS room_type_id,
    t_customer_personal_data.cust_id AS cust_id,
    t_customer_personal_data.cust_fname AS cust_fname,
    t_customer_personal_data.cust_lname AS cust_lname,
    t_room_type.room_type AS room_type,
    t_room_booking.adults AS adults,
    t_room_booking.children AS children,
    t_room_booking.check_in AS check_in,
    t_room_booking.check_out AS check_out,
    t_room_type.room_rent AS room_rent,
    t_room_booking.total_rent,
    rf.room_floor, 
    rn.room_number,
    cl.cust_loyalty_points

    FROM t_customer_personal_data
    
    INNER JOIN t_customer_loyalty_points cl
    ON t_customer_personal_data.cust_id = cl.cust_id 

    INNER JOIN t_room_booking 
    ON t_customer_personal_data.cust_id = t_room_booking.booked_by 

    INNER JOIN t_rooms 
    ON t_rooms.room_id = t_room_booking.room_id

    INNER JOIN t_room_type 
    ON t_room_type.room_type_id = t_rooms.room_type_id
    
    INNER JOIN t_room_number_floor_mapping rnfm 
    ON t_rooms.room_num_floor_map_id = rnfm.room_num_floor_map_id
    
    INNER JOIN t_room_floors rf 
    ON rf.room_floor_id = rnfm.room_floor_id
    
    INNER JOIN t_room_number rn 
    ON rn.room_number_id = rnfm.room_number_id

    WHERE t_room_booking.is_booked = 1
    AND t_room_booking.booked_by = custId
    AND t_room_booking.is_active = 1;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_booked_spa_by_cust_id` (IN `custId` INT)  BEGIN

SELECT t_spaa.spa_id,
t_customer_personal_data.cust_id, t_customer_personal_data.cust_fname, t_customer_personal_data.cust_lname, smt.spa_massage_type, 
t_spaa.spa_datetime,
t_spaa.spa_time,
smt.spa_rate

FROM t_customer_personal_data

INNER JOIN t_customer_login 
ON t_customer_personal_data.cust_id = t_customer_login.cust_id

INNER JOIN t_spaa 
ON t_spaa.cust_id = t_customer_login.cust_id 

INNER JOIN t_spa_massage_type smt 
ON t_spaa.spa_massage_type_id = smt.spa_massage_type_id

where t_spaa.is_booked=1
AND t_spaa.cust_id = custId;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_booked_spa_count` (IN `spaDate` DATE, IN `spaTime` TIME(4))  NO SQL
BEGIN

SELECT * 
FROM t_spaa WHERE spa_datetime = spaDate 
AND spa_time = spaTime
AND is_booked = 1;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_capacity_price` ()  SELECT banquet_capacity_price_id, banquet_capacity, banquet_capacity_price FROM t_banquet_capacity_price
WHERE is_active = 1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_conference_list` ()  BEGIN
select conf_id,conf_type, loyalty
from t_conference_list;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_conference_type` ()  BEGIN

SELECT conf_type_id, conf_type
FROM t_conference_list
WHERE is_active = 1;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_conf_guest` ()  BEGIN

SELECT conf_guest_id, conf_guest
FROM t_conf_guest
WHERE is_active = 1;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_conf_price_by_id` (IN `confTypeId` INT)  BEGIN

SELECT conf_rent
FROM t_conference_list
WHERE conf_type_id = confTypeId
AND is_active = 1;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_customer_by_id` (IN `cid` INT(11))  NO SQL
select * from t_customer_personal_data where cust_id = cid$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_customer_by_id_dashboard` (IN `cid` INT(11))  SELECT 	pd.cust_id , 
		pd.cust_fname , 
        pd.cust_mname , 
        pd.cust_lname , 
        pd.cust_dob ,
        pd.cust_phone_number, 
        ca.cust_street,
        ca.cust_city,
        ca.cust_state,
        ca.cust_country,
        id.cust_passport_number,
        id.cust_national_id,
        id.cust_card_details
     
from 	t_customer_personal_data pd 

inner join t_customer_address ca 
on pd.cust_id = ca.cust_id

inner join t_customer_identity_data id 
on pd.cust_id = id.cust_id

where pd.cust_id = cid$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_customer_login` (IN `username` VARCHAR(30), IN `password` VARCHAR(30))  NO SQL
select cust_id from t_customer_login where cust_username = username AND cust_password = password$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_deals_Details_in_room_bill` (IN `cid` INT(30), IN `roomTypeID` INT(30))  select deal_id from t_customer_deals 
where customer_id = cid AND room_type_id = roomTypeID AND is_booked = 1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_departments` ()  SELECT department_id, department_name
FROM t_department
WHERE is_active = 1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_discount_details_by_id` (IN `discountID` INT(30))  select loyalty_points, room_type_id from t_discount_coupon where discount_id = discountID$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_employee_by_id` (IN `empID` INT)  SELECT 	pd.emp_id, 
		pd.emp_fname , 
        pd.emp_mname , 
        pd.emp_lname , 
        pd.emp_dob ,
        pd.emp_phone_number, 
        ea.emp_street,
        ea.emp_city,
        ea.emp_state,
        ea.emp_country,
        bd.IBAN,
        bd.BIC,
        rm.department_id,
        rm.role_id,
        id.emp_passport_number,
        id.emp_national_id,
        ed.department_name,
        er.emp_role
     
from 	t_employee_personal_data pd 

inner join t_employee_address ea 
on pd.emp_id = ea.emp_id

inner join t_employee_bank_details bd 
on pd.emp_id = bd.emp_id

inner join t_employee_department_role_mapping rm 
on pd.emp_id = rm.emp_id

inner join t_employee_identity_data id 
on pd.emp_id = id.emp_id

inner join t_department ed
on rm.department_id = ed.department_id

inner join t_employee_role er
on rm.role_id = er.employee_role_id

where pd.emp_id = empID$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_employee_login` (IN `username` VARCHAR(30), IN `password` VARCHAR(30))  select emp_id from t_employee_login where emp_username = username AND emp_password = password$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_loyalty_points` (IN `cid` INT)  select cust_loyalty_points from t_customer_loyalty_points where cust_id = cid$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_restaurant_availability_by_id` (IN `id` INT(20), IN `time` DATETIME)  SELECT SUM(restaurant_guests) FROM t_restaurant_booking WHERE restaurant_id = id AND restaurant_datetime = time AND is_booked = 1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_roles` ()  SELECT employee_role_id, emp_role
FROM t_employee_role
WHERE is_active = 1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_roomID_by_roomNumber` (IN `roomNumber` INT(11))  select room_number_id from t_room_number
where room_number = roomNumber$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_room_by_room_type_id` (IN `roomTypeId` INT)  BEGIN

SELECT rt.room_type, r.room_floor_number, r.room_number,r.adult_capacity,
	   r.children_capacity, r.price, r.is_booked
FROM t_rooms r
INNER JOIN t_room_type rt
ON r.room_type_id = rt.room_type_id
WHERE r.room_type_id = roomTypeId
AND r.is_active = 1
AND rt.is_active = 1;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_room_details_by_id` (IN `roomID` INT(10))  SELECT room_details,  room_preference, room_amenity_details, room_type,room_loyalty
FROM t_room_details
INNER JOIN t_room_type
ON t_room_details.room_id = t_room_type.room_type_id
where t_room_details.room_id = roomID$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_room_floor_by_roomID` (IN `roomID` INT(30))  select room_floor from t_room_floors
where room_floor_id =roomID$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_room_type` ()  BEGIN

SELECT room_type_id, room_type, room_rent
FROM t_room_type
WHERE is_active = 1;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_spa_massage_type` ()  BEGIN

SELECT spa_massage_type_id, spa_massage_type
FROM t_spa_massage_type
WHERE is_active = 1;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_spa_massage_type_by_id` (IN `spaMassageTypeId` INT)  BEGIN

SELECT spa_massage_type 
FROM t_spa_massage_type
WHERE spa_massage_type_id = spaMassageTypeId
AND is_active = 1;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insert_employee` (IN `empFname` VARCHAR(20), IN `empMname` VARCHAR(20), IN `empLname` VARCHAR(30), IN `empDob` DATE, IN `emp_phone_number` VARCHAR(11), IN `empStreet` VARCHAR(30), IN `empCity` VARCHAR(30), IN `empState` VARCHAR(30), IN `empCountry` VARCHAR(30), IN `empPassport_number` VARCHAR(30), IN `empNational_id` VARCHAR(30), IN `deptId` INT, IN `roleId` INT, IN `iban` VARCHAR(20), IN `bic` VARCHAR(30))  BEGIN

INSERT INTO t_employee_personal_data
			(emp_fname,
            emp_mname,
            emp_lname,
            emp_dob,
            emp_phone_number)
     VALUES(empFname,
            empMname,
            empLname,
            empDob,
            emp_phone_number
     		);
            
SET @emp_id = LAST_INSERT_ID();

INSERT INTO t_employee_address
			(emp_id,
            emp_street,
            emp_city,
            emp_state,
            emp_country)
     VALUES(@emp_id,
            empStreet,
            empCity,
            empState,
            empCountry
     		);

INSERT INTO t_employee_identity_data
			(emp_id,
            emp_passport_number,
            emp_national_id)
     VALUES(@emp_id,
            empPassport_number,
            empNational_id
     		);
            
INSERT INTO t_employee_department_role_mapping
			(emp_id,
            department_id,
            role_id)
     VALUES(@emp_id,
            deptId,
            roleId
     		);
            
INSERT INTO t_employee_bank_details
			(emp_id,
            IBAN,
            BIC)
     VALUES(@emp_id,
            iban,
            bic
     		);
 
/* 
INSERT INTO 
t_employee_login(emp_id,
                   emp_username,
                   emp_password
                   )
                   
            VALUES(@emp_id,
                   username,
                   password
                   );
*/
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_invoice_amenities` (IN `cID` INT(30), IN `billedFor` VARCHAR(60), IN `loyalty` INT(30), IN `finalBill` DECIMAL(7,2), IN `checkin` DATE, IN `checkout` DATE)  BEGIN

UPDATE t_customer_loyalty_points set cust_loyalty_points = cust_loyalty_points-loyalty where cust_id = cID;


UPDATE t_restaurant_booking set is_booked = 0 where ((t_restaurant_booking.restaurant_datetime BETWEEN checkin AND checkout) AND
t_restaurant_booking.customer_id = cID);

UPDATE t_banquet_booking set is_booked = 0 where ((t_banquet_booking.booking_date BETWEEN checkin AND checkout) AND
t_banquet_booking.booked_by = cID);

UPDATE t_spaa set is_booked = 0 where 
((t_spaa.spa_datetime BETWEEN checkin AND 
 checkout) AND
t_spaa.cust_id = cID);

UPDATE t_conference set is_booked = 0 where 
((t_conference.conference_date BETWEEN checkin AND checkout) AND
t_conference.cust_id = cID);


INSERT INTO t_invoice(cust_id,
         invoice_for,
         loyalty_used,
         total_bill)           
VALUES(cID,
     billedFor,
     loyalty,
     finalBill);
                         
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_invoice_banquet` (IN `custId` INT, IN `billedFor` VARCHAR(60), IN `loyalty` INT, IN `finalBill` DECIMAL(7,2), IN `banquetBookingId` INT)  BEGIN

UPDATE t_customer_loyalty_points
SET cust_loyalty_points = cust_loyalty_points-loyalty 
WHERE cust_id = custId
AND is_active = 1;

UPDATE t_banquet_booking 
SET is_booked = 0 
WHERE booked_by = custId
AND banquet_booking_id = banquetBookingId
AND is_active = 1;

INSERT INTO 
t_invoice(cust_id,
         invoice_for,
         loyalty_used,
         total_bill)           
VALUES(custId,
     billedFor,
     loyalty,
     finalBill);
                         
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_invoice_combined` (IN `cID` INT(30), IN `billedFor` VARCHAR(60), IN `loyalty` INT, IN `finalBill` DECIMAL(7,2), IN `checkin` DATE, IN `checkout` DATE)  BEGIN

UPDATE t_customer_loyalty_points set cust_loyalty_points = cust_loyalty_points-loyalty where cust_id = cID;


UPDATE t_room_booking set is_booked = 0 where  
((t_room_booking.check_in BETWEEN checkin AND checkout) AND
t_room_booking.check_out <= checkout AND
t_room_booking.booked_by = cID);

UPDATE t_restaurant_booking set is_booked = 0 where ((t_restaurant_booking.restaurant_datetime BETWEEN checkin AND checkout) AND
t_restaurant_booking.customer_id = cID);

UPDATE t_banquet_booking set is_booked = 0 where ((t_banquet_booking.booking_date BETWEEN checkin AND checkout) AND
t_banquet_booking.booked_by = cID);

UPDATE t_spaa set is_booked = 0 where 
((t_spaa.spa_datetime BETWEEN checkin AND 
 checkout) AND
t_spaa.cust_id = cID);

UPDATE t_conference set is_booked = 0 where 
((t_conference.conference_date BETWEEN checkin AND checkout) AND
t_conference.cust_id = cID);


INSERT INTO t_invoice(cust_id,
         invoice_for,
         loyalty_used,
         total_bill)           
VALUES(cID,
     billedFor,
     loyalty,
     finalBill);
                         
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_invoice_conference` (IN `cid` INT(30), IN `billedFor` VARCHAR(60), IN `loyalty` INT(100), IN `finalBill` DECIMAL(7,2), IN `conferenceId` INT)  BEGIN

UPDATE t_customer_loyalty_points set cust_loyalty_points = cust_loyalty_points-loyalty where cust_id = cid;

UPDATE t_conference 
set is_booked = 0 
where cust_id = cid
AND conference_id = conferenceId;

INSERT INTO 
t_invoice(cust_id,
         invoice_for,
         loyalty_used,
         total_bill)           
VALUES(cid,
     billedFor,
     loyalty,
     finalBill);
                         
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_invoice_restaurant` (IN `cID` INT(30), IN `billedFor` VARCHAR(60), IN `loyalty` INT(100), IN `finalBill` DECIMAL(7,2), IN `restID` INT(20))  NO SQL
BEGIN

UPDATE t_customer_loyalty_points set cust_loyalty_points = cust_loyalty_points-loyalty where cust_id = cID;

UPDATE t_restaurant_booking set is_booked = 0 where rest_booking_ID = restID;

INSERT INTO 
t_invoice(cust_id,
         invoice_for,
         loyalty_used,
         total_bill)           
VALUES(cID,
     billedFor,
     loyalty,
     finalBill);
                         
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_invoice_room` (IN `cID` INT(30), IN `billedFor` VARCHAR(60), IN `loyalty` INT(100), IN `finalBill` DECIMAL(7,2), IN `roomBID` INT(20))  BEGIN

UPDATE t_customer_loyalty_points set cust_loyalty_points = cust_loyalty_points-loyalty where cust_id = cID;

UPDATE t_room_booking SET is_booked = 0 where room_booking_id = roomBID;

INSERT INTO 
t_invoice(cust_id,
         invoice_for,
         loyalty_used,
         total_bill)           
VALUES(cID,
     billedFor,
     loyalty,
     finalBill);
                         
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_invoice_rooms_online` (IN `cID` INT(30), IN `billedFor` VARCHAR(60), IN `loyalty` INT(30), IN `finalBill` DECIMAL(7,2), IN `checkin` DATE, IN `checkout` DATE, IN `ccnumber` INT(30), IN `ccname` VARCHAR(60), IN `bookingId` INT)  NO SQL
BEGIN

UPDATE t_customer_loyalty_points set cust_loyalty_points = cust_loyalty_points-loyalty where cust_id = cID;


UPDATE t_room_booking set is_booked = 0 where  
((t_room_booking.check_in BETWEEN checkin AND checkout) AND
t_room_booking.check_out <= checkout AND
t_room_booking.booked_by = cID AND
t_room_booking.room_booking_id = bookingId);

INSERT INTO t_invoice(cust_id,
         invoice_for,
         loyalty_used,
         total_bill)           
VALUES(cID,
     billedFor,
     loyalty,
     finalBill);

SET @invoice_id = LAST_INSERT_ID();

INSERT INTO t_customer_card_details(invoice_id,
         card_number,
         card_name,
         billed_for,
         total_bill)           
VALUES(@invoice_id,
     ccnumber,
     ccname,
     billedFor,
      finalBill);



                         
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_invoice_spa` (IN `cid` INT(30), IN `billedFor` VARCHAR(60), IN `loyalty` INT(100), IN `finalBill` DECIMAL(7,2))  NO SQL
BEGIN

UPDATE t_customer_loyalty_points set cust_loyalty_points = cust_loyalty_points-loyalty where cust_id = cid;

UPDATE t_spaa set is_booked = 0 where cust_id = cid;

INSERT INTO 
t_invoice(cust_id,
         invoice_for,
         loyalty_used,
         total_bill)           
VALUES(cid,
     billedFor,
     loyalty,
     finalBill);
                         
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_post_conference_booking` (IN `fname` VARCHAR(20), IN `mname` VARCHAR(20), IN `lname` VARCHAR(30), IN `dob` DATE, IN `custmnumber` VARCHAR(11), IN `street` VARCHAR(20), IN `city` VARCHAR(20), IN `state` VARCHAR(20), IN `country` VARCHAR(20), IN `passport` VARCHAR(20), IN `nationalid` VARCHAR(20), IN `cardnumber` VARCHAR(20), IN `confDate` DATE, IN `no_guests` INT(20), IN `isBooked` INT(10), IN `username` VARCHAR(30), IN `password` VARCHAR(30), IN `confTypeId` INT(50), IN `loyalty` INT(20), IN `confTime` TIME)  BEGIN

INSERT INTO 
t_customer_personal_data(cust_fname,
                         cust_mname,
                         cust_lname,
                         cust_dob,
                         cust_phone_number)
                  VALUES(fname,
                         mname,
                         lname,
                         dob,
                         custmnumber);
SET @custId = LAST_INSERT_ID();

INSERT INTO 
t_customer_address(cust_id,
                   cust_street,
                   cust_city,
                   cust_state,
                   cust_country)
            VALUES(@custId,
                   street,
                   city,
                   state,
                   country);
                   
INSERT INTO 
t_customer_identity_data(cust_id,
                         cust_passport_number,
                         cust_national_id,
                         cust_card_details)
                  VALUES(@custId,
                         passport,
                         nationalid,
                         cardnumber);
                         
INSERT INTO 
t_conference(
                  conference_date,
                  conf_type_id,
                  conf_guest_id,
    			  conf_time,
                  cust_id,
                  is_booked)
           VALUES(
                  confDate,
               	  confTypeId,
               	  no_guests,
               	  confTime,
                  @custId,
                  isBooked);
                 
INSERT INTO 
t_customer_login(cust_id,
                   cust_username,
                   cust_password
                   )
                   
            VALUES(@custId,
                   username,
                   password);
                   
INSERT INTO 
t_customer_loyalty_points
				  (cust_id,
                   cust_loyalty_points)
                   
            VALUES(@custId,
                   loyalty);                   

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_post_conference_booking_by_login` (IN `confDate` DATE, IN `confTypeId` VARCHAR(50), IN `isBooked` TINYINT(1), IN `confGuestId` VARCHAR(100), IN `cid` INT(10), IN `confTime` TIME)  NO SQL
BEGIN
INSERT INTO t_conference(conference_date, conf_type_id, is_booked, conf_guest_id,cust_id, conf_time) 
VALUES(confDate, confTypeId, isBooked, confGuestId, cid, confTime);           
                 
update t_customer_loyalty_points set cust_loyalty_points = cust_loyalty_points+300 where cust_id = cid;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_post_customer_deals` (IN `cID` INT, IN `discountID` INT, IN `roomtypeID` INT, IN `loyalty` INT)  BEGIN

UPDATE t_customer_loyalty_points set cust_loyalty_points = cust_loyalty_points-loyalty where cust_id = cID;

INSERT INTO 
t_customer_deals(discount_id,
         room_type_id,
         is_booked,
         customer_id)           
VALUES(discountID,
     roomtypeID,
     1,
     cID);
                         
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_post_rest_booking` (IN `fname` VARCHAR(20), IN `mname` VARCHAR(20), IN `lname` VARCHAR(30), IN `dob` DATE, IN `custmnumber` VARCHAR(11), IN `street` VARCHAR(20), IN `city` VARCHAR(20), IN `state` VARCHAR(20), IN `country` VARCHAR(20), IN `passport` VARCHAR(20), IN `nationalid` VARCHAR(20), IN `cardnumber` VARCHAR(20), IN `rest_id` INT(20), IN `checkin` DATE, IN `timet` TIME, IN `guests` INT(10), IN `isBooked` VARCHAR(10), IN `username` VARCHAR(30), IN `password` VARCHAR(30), IN `loyalty` INT(30))  BEGIN

INSERT INTO 
t_customer_personal_data(cust_fname,
                         cust_mname,
                         cust_lname,
                         cust_dob,
                         cust_phone_number)
                  VALUES(fname,
                         mname,
                         lname,
                         dob,
                         custmnumber);
SET @custId = LAST_INSERT_ID();

INSERT INTO 
t_customer_address(cust_id,
                   cust_street,
                   cust_city,
                   cust_state,
                   cust_country)
            VALUES(@custId,
                   street,
                   city,
                   state,
                   country);
                   
INSERT INTO 
t_customer_identity_data(cust_id,
                         cust_passport_number,
                         cust_national_id,
                         cust_card_details)
                  VALUES(@custId,
                         passport,
                         nationalid,
                         cardnumber);
                         
INSERT INTO 
t_restaurant_booking(restaurant_id,
                  restaurant_datetime,
                     rest_time,
                  restaurant_guests,
                  customer_id,
                  is_booked)
           VALUES(rest_id,
                  checkin,
                  timet,
                  guests,
                  @custId,
                 isBooked);
                 
INSERT INTO 
t_customer_login(cust_id,
                   cust_username,
                   cust_password
                   )
                   
            VALUES(@custId,
                   username,
                   password
                   );

INSERT INTO 
t_customer_loyalty_points(cust_id,
                   cust_loyalty_points)
                   
            VALUES(@custId,
                   loyalty);
                   

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_post_rest_booking_by_login` (IN `cID` INT(10), IN `rest_id` INT(20), IN `date_time` DATE, IN `timet` TIME, IN `guests` INT(10), IN `isBooked` INT(10), IN `loyalty` INT(30))  NO SQL
BEGIN

INSERT INTO 
t_restaurant_booking(restaurant_id,
                  restaurant_datetime,
                     rest_time,
                  restaurant_guests,
                  customer_id,
                  is_booked)
           VALUES(rest_id,
                  date_time,
                  timet,
                  guests,
                  cID,
                 isBooked);
                 
                 
UPDATE t_customer_loyalty_points 
SET cust_loyalty_points = cust_loyalty_points+loyalty 
WHERE cust_id = cID;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_post_roombooking_by_login` (IN `cID` INT(11), IN `room_id` INT(11), IN `adults` INT(11), IN `children` INT(11), IN `check_in` DATE, IN `check_out` DATE, IN `loyalty` INT(30), IN `totalRent` DECIMAL(7,2))  BEGIN
INSERT INTO 

t_room_booking(room_id,
               booked_by,
               adults,
               children,
               check_in,
               check_out,
               is_booked,
               total_rent,
               loyalty_points)
        VALUES(room_id,
              cID,
              adults,
              children,
              check_in,
              check_out,
              1,
              totalRent,
              loyalty);

                 
update t_customer_loyalty_points set cust_loyalty_points = cust_loyalty_points+loyalty where cust_id = cID;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_post_room_booking_registeration` (IN `fname` VARCHAR(20), IN `mname` VARCHAR(20), IN `lname` VARCHAR(30), IN `dob` DATETIME, IN `custmnumber` VARCHAR(11), IN `street` VARCHAR(20), IN `city` VARCHAR(20), IN `state` VARCHAR(20), IN `country` VARCHAR(20), IN `passport` VARCHAR(20), IN `nationalid` VARCHAR(20), IN `cardnumber` VARCHAR(20), IN `room_id` INT(11), IN `adults` INT(11), IN `children` INT(11), IN `check_in` DATE, IN `check_out` DATE, IN `username` VARCHAR(30), IN `password` VARCHAR(30), IN `loyalty` INT(30), IN `totalRent` INT)  BEGIN

INSERT INTO 
t_customer_personal_data(cust_fname,
                         cust_mname,
                         cust_lname,
                         cust_dob,
                         cust_phone_number)
                  VALUES(fname,
                         mname,
                         lname,
                         dob,
                         custmnumber);
SET @custId = LAST_INSERT_ID();

INSERT INTO 
t_customer_address(cust_id,
                   cust_street,
                   cust_city,
                   cust_state,
                   cust_country)
            VALUES(@custId,
                   street,
                   city,
                   state,
                   country);
                   
INSERT INTO 
t_customer_identity_data(cust_id,
                         cust_passport_number,
                         cust_national_id,
                         cust_card_details)
                  VALUES(@custId,
                         passport,
                         nationalid,
                         cardnumber);
                         
INSERT INTO 

t_room_booking(room_id,
               booked_by,
               adults,
               children,
               check_in,
               check_out,
               is_booked,
               total_rent,
               loyalty_points)
        VALUES(room_id,
              @custId,
              adults,
              children,
              check_in,
              check_out,
              1,
              totalRent,
              loyalty);

INSERT INTO 
t_customer_login(cust_id,
                   cust_username,
                   cust_password)
                   
            VALUES(@custId,
                   username,
                   password);
                   
INSERT INTO 
t_customer_loyalty_points(cust_id,
                   cust_loyalty_points)
                   
            VALUES(@custId,
                   loyalty);

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_post_spa_booking_by_login` (IN `date_time` DATE, IN `timet` TIME, IN `spa_massageTypeId` VARCHAR(30), IN `isBooked` TINYINT(10), IN `cid` INT)  BEGIN
INSERT INTO t_spaa (spa_datetime,spa_time, spa_massage_type_id, is_booked, cust_id) VALUES(date_time,timet, spa_massageTypeId, isBooked, cid);           
                 
update t_customer_loyalty_points set cust_loyalty_points = cust_loyalty_points+200 where cust_id = cid;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_update_booked_rooms_by_booking_id` (IN `bookingId` INT, IN `roomId` INT, IN `adults` INT, IN `children` INT, IN `checkIn` DATE, IN `checkOut` DATE, IN `loyalty` INT, IN `totalRent` DECIMAL(7,2), IN `custID` INT)  MODIFIES SQL DATA
BEGIN

DECLARE prevLoyalty INT;
DECLARE prevTotalLoyalty INT;

SELECT loyalty_points INTO @prevLoyalty
FROM t_room_booking
WHERE room_booking_id = bookingId;

SELECT cust_loyalty_points INTO @prevTotalLoyalty
FROM t_customer_loyalty_points
WHERE cust_id = custID;

SET @custLoyalty = @prevTotalLoyalty - @prevLoyalty;

UPDATE t_customer_loyalty_points
SET cust_loyalty_points = @custLoyalty
WHERE cust_id = custID;


UPDATE t_room_booking
SET room_id = roomId,
	adults = adults,
    children = children,
	check_in = checkIn,
	check_out = checkOut,
    loyalty_points = loyalty,
	total_rent = totalRent
WHERE room_booking_id = bookingId;    
    
UPDATE t_customer_loyalty_points 
SET cust_loyalty_points = cust_loyalty_points+loyalty 
WHERE cust_id = custId;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_update_customer_details` (IN `cusFname` VARCHAR(30), IN `cusMname` VARCHAR(30), IN `cusLname` VARCHAR(30), IN `cusDob` DATE, IN `cus_phone_number` VARCHAR(30), IN `cusStreet` VARCHAR(30), IN `cusCity` VARCHAR(30), IN `cusState` VARCHAR(30), IN `cusCountry` VARCHAR(30), IN `cusPassport_number` VARCHAR(30), IN `cusNational_id` VARCHAR(30), IN `cusId` INT, IN `custCard_details` VARCHAR(60))  MODIFIES SQL DATA
BEGIN

UPDATE t_customer_personal_data 
SET cust_fname= cusFname, 
	cust_mname= cusMname,
    cust_lname	= cusLname,
    cust_dob= cusDob,
    cust_phone_number= cus_phone_number
WHERE cust_id = cusId;

UPDATE t_customer_address 
SET 		cust_street= cusStreet,
            cust_city= cusCity,
            cust_state= cusState,
            cust_country= cusCountry
WHERE cust_id = cusId;

UPDATE t_customer_identity_data 
SET 		cust_passport_number= cusPassport_number,
            cust_national_id= cusNational_id,
            cust_card_details = custCard_details
WHERE cust_id = cusId;

UPDATE t_customer_login 
SET 		cust_username = cusLname,
            cust_password = cusPassport_number
WHERE cust_id = cusId;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_update_deals_isbooked_after_payment` (IN `dealID` INT(20))  update  t_customer_deals 
set is_booked = 0 where deal_id = dealID$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_update_employee_details` (IN `empFname` VARCHAR(20), IN `empMname` VARCHAR(20), IN `empLname` VARCHAR(20), IN `empDob` DATE, IN `emp_phone_number` VARCHAR(20), IN `empStreet` VARCHAR(30), IN `empCity` VARCHAR(30), IN `empState` VARCHAR(30), IN `empCountry` VARCHAR(30), IN `empPassport_number` VARCHAR(30), IN `empNational_id` VARCHAR(30), IN `iban` VARCHAR(30), IN `bic` VARCHAR(30), IN `empId` INT)  MODIFIES SQL DATA
BEGIN

UPDATE t_employee_personal_data 
SET emp_fname= empFname, 
	emp_mname= empMname,
    emp_lname= empLname,
    emp_dob= empDob,
    emp_phone_number= emp_phone_number
WHERE emp_id= empId;

UPDATE t_employee_address 
SET 		emp_street= empStreet,
            emp_city= empCity,
            emp_state= empState,
            emp_country= empCountry
WHERE emp_id= empId;

UPDATE t_employee_identity_data 
SET 		emp_passport_number= empPassport_number,
            emp_national_id= empNational_id
WHERE emp_id= empId;

            
UPDATE t_employee_bank_details 
SET 		IBAN= iban,
             BIC= bic
WHERE emp_id= empId;

UPDATE t_employee_login 
SET 		emp_username=empLname,
            emp_password=empPassport_number
WHERE emp_id= empId;

END$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_calculate_existing_loyalty_points` (`custID` INT(30), `loyalty` INT(30)) RETURNS TINYINT(1) BEGIN

DECLARE loyaltyOfCust INT(10);
DECLARE valid BOOLEAN;

set loyaltyOfCust = (SELECT cust_loyalty_points from t_customer_loyalty_points where cust_id = custID);

IF loyalty > loyaltyOfCust THEN
		set valid = false;
        
ELSE
		SET valid =  true;
        
END IF;    
   
RETURN valid;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `fn_calculate_loyalty_discount` (`loyalty` INT(30)) RETURNS DECIMAL(7,2) BEGIN
DECLARE discount DECIMAL(7,2);
DECLARE mnumber INT(10);
DECLARE rnumber INT(10);

IF loyalty = 0 THEN
		SET discount = 0;
        
ELSEIF loyalty = 100 THEN
        SET discount = 0.15;
        
ELSE
		SET mnumber = loyalty / 100;
  	   	SET rnumber = mnumber - 1;
		SET discount = 0.15 + (rnumber * 0.05);
        
END IF;    
   
RETURN discount;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `fn_calculate_restaurant_rate_by_guest` (`guests` INT, `rate` DECIMAL(7,2)) RETURNS DECIMAL(7,2) BEGIN
DECLARE restbill DECIMAL(7,2);

SET restbill = guests * rate;

RETURN restbill;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `fn_calculate_tax` (`restBill` DECIMAL(7,2)) RETURNS DECIMAL(7,2) BEGIN
DECLARE tax DECIMAL(7,2);

SET tax = restBill * 0.05;

RETURN tax;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `fn_get_price_by_days` (`roomTypeId` INT, `checkIn` DATE, `checkOut` DATE) RETURNS DECIMAL(7,2) BEGIN

DECLARE weekdays INT;
DECLARE roomRent DECIMAL(7,2);
DECLARE rentForWeekdays DECIMAL(7,2);
DECLARE rentForWeekends DECIMAL(7,2);
DECLARE noOfWeekends INT;

SET @weekdays = 0;
SET @noOfWeekends = 0;
SET @rentForWeekdays = 0;
SET @rentForWeekends = 0;
SET @totalRent =0;

SET @percent = 0.1;
SET @noOfDays =  datediff(checkOut, checkIn);

IF (@noOfDays = 0) 
	THEN SET @noOfDays = 1;
END IF;
	
SELECT 
COUNT(*) INTO @noOfWeekends
FROM 
(   SELECT ADDDATE(checkIn, INTERVAL @i:=@i+1 DAY) AS DAY
    FROM (
        SELECT a.a
        FROM (SELECT 0 AS a UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) AS a
        CROSS JOIN (SELECT 0 AS a UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) AS b
        CROSS JOIN (SELECT 0 AS a UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) AS c
    ) a
    JOIN (SELECT @i := -1) r1
    WHERE 
    @i < DATEDIFF(checkOut, checkIn)

) AS dateTable
WHERE WEEKDAY(dateTable.Day) IN (5,6);
    
IF(@noOfDays= 1 AND @noOfWeekends = 2)
THEN SET @noOfWeekends = 1;
END IF;
    
SELECT room_rent INTO @roomRent
FROM t_room_type
WHERE room_type_id = roomTypeId;

SET @weekdays = ABS(@noOfDays - @noOfWeekends);

    IF (@noOfWeekends > 0)
    THEN SET @roomRentPercentWeekends = @roomRent * @percent;
         SET @calculateWeekends = @roomRent + @roomRentPercentWeekends;
         SET @rentForWeekends = @calculateWeekends * @noOfWeekends;
    END IF;

    IF (@weekdays > 0)
    THEN 
         SET @rentForWeekdays = @roomRent * @weekdays;
    END IF;
    SET @totalRent = ABS(@rentForWeekdays + @rentForWeekends);


RETURN @totalRent;

END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `fn_restaurant_availability` (`guests` INT(20)) RETURNS TINYINT(1) BEGIN
DECLARE availability Boolean;

IF guests > 100 THEN
		SET availability = false;
    ELSE 
        SET availability = true;
        END IF;
        
RETURN availability;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `login`
--

CREATE TABLE `login` (
  `id` int(10) UNSIGNED NOT NULL,
  `usname` varchar(30) DEFAULT NULL,
  `pass` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `login`
--

INSERT INTO `login` (`id`, `usname`, `pass`) VALUES
(1, 'Admin', '1234'),
(2, 'Prasath', '12345');

-- --------------------------------------------------------

--
-- Table structure for table `t_banquets`
--

CREATE TABLE `t_banquets` (
  `banquet_id` int(11) NOT NULL,
  `banquet_name` varchar(40) NOT NULL,
  `banquet_description` varchar(255) NOT NULL,
  `banquet_rate` varchar(30) NOT NULL,
  `total_capacity` int(11) NOT NULL,
  `seating_capacity` int(11) NOT NULL,
  `banquet_loyalty_points` int(11) NOT NULL,
  `opening_time` time NOT NULL,
  `closing_time` time NOT NULL,
  `created_by` varchar(20) NOT NULL DEFAULT 'System',
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` varchar(20) DEFAULT NULL,
  `updated_on` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `abbr` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `t_banquets`
--

INSERT INTO `t_banquets` (`banquet_id`, `banquet_name`, `banquet_description`, `banquet_rate`, `total_capacity`, `seating_capacity`, `banquet_loyalty_points`, `opening_time`, `closing_time`, `created_by`, `created_on`, `updated_by`, `updated_on`, `is_active`, `abbr`) VALUES
(1, 'The King', 'The King offers 6,100 square feet of banquet space with magnificent ballroom, reception areas and outdoor gardens. The unparalleled service and bespoke menu make The King Mumbai an ideal choice for wedding celebrations.', 'Euros 2000', 500, 280, 200, '10:00:00', '23:30:00', 'System', '2020-05-19 11:13:07', NULL, '2020-05-29 20:17:23', 1, 'BQT'),
(2, 'Enigma', 'This opulent 3,100 square feet pillar less ballroom offers an expansive pre-function area, a built-in stage, projection rooms and a soundproof partition. It can be further partition into two sections and can accommodate up to 500 people.', 'Euros 1000', 500, 150, 150, '10:00:00', '23:30:00', 'System', '2020-05-19 11:26:39', NULL, '2020-05-29 20:17:28', 1, 'BQT');

-- --------------------------------------------------------

--
-- Table structure for table `t_banquet_booking`
--

CREATE TABLE `t_banquet_booking` (
  `banquet_booking_id` int(11) NOT NULL,
  `booked_by` int(11) NOT NULL,
  `banquet_menu_type_id` int(11) NOT NULL,
  `banquet_id` int(11) NOT NULL,
  `banquet_capacity_price_id` int(11) NOT NULL,
  `booking_date` date NOT NULL,
  `booking_time_from` time NOT NULL,
  `booking_time_to` time NOT NULL,
  `is_booked` tinyint(1) NOT NULL DEFAULT '1',
  `created_by` varchar(20) NOT NULL DEFAULT 'System',
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` varchar(20) DEFAULT NULL,
  `updated_on` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `is_active` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `t_banquet_booking`
--

INSERT INTO `t_banquet_booking` (`banquet_booking_id`, `booked_by`, `banquet_menu_type_id`, `banquet_id`, `banquet_capacity_price_id`, `booking_date`, `booking_time_from`, `booking_time_to`, `is_booked`, `created_by`, `created_on`, `updated_by`, `updated_on`, `is_active`) VALUES
(1, 26, 1, 1, 5, '2020-06-27', '10:00:00', '03:00:00', 0, 'System', '2020-06-07 13:19:03', NULL, '2020-06-07 13:20:52', 1),
(2, 26, 1, 1, 5, '2020-07-03', '10:00:00', '03:00:00', 0, 'System', '2020-06-07 13:59:26', NULL, '2020-06-07 14:00:46', 1),
(3, 26, 1, 1, 3, '2020-06-27', '10:00:00', '03:00:00', 0, 'System', '2020-06-07 17:17:37', NULL, '2020-06-07 17:18:26', 1),
(4, 26, 1, 1, 2, '2020-06-27', '10:00:00', '03:00:00', 1, 'System', '2020-06-09 06:54:06', NULL, NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `t_banquet_capacity_price`
--

CREATE TABLE `t_banquet_capacity_price` (
  `banquet_capacity_price_id` int(11) NOT NULL,
  `banquet_capacity` int(11) NOT NULL,
  `banquet_capacity_price` decimal(10,0) NOT NULL,
  `created_by` varchar(20) NOT NULL DEFAULT 'System',
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` varchar(20) DEFAULT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `t_banquet_capacity_price`
--

INSERT INTO `t_banquet_capacity_price` (`banquet_capacity_price_id`, `banquet_capacity`, `banquet_capacity_price`, `created_by`, `created_on`, `updated_by`, `updated_on`, `is_active`) VALUES
(1, 100, '2000', 'System', '2020-05-21 12:36:22', NULL, NULL, 1),
(2, 200, '3500', 'System', '2020-05-21 12:36:22', NULL, NULL, 1),
(3, 300, '6000', 'System', '2020-05-21 12:37:10', NULL, NULL, 1),
(4, 400, '8000', 'System', '2020-05-21 12:37:10', NULL, NULL, 1),
(5, 500, '9000', 'System', '2020-05-21 12:37:20', NULL, NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `t_banquet_menu_type`
--

CREATE TABLE `t_banquet_menu_type` (
  `banquet_menu_type_id` int(11) NOT NULL,
  `banquet_menu_type` varchar(30) NOT NULL,
  `menu_type_price` varchar(20) NOT NULL,
  `created_by` varchar(20) NOT NULL DEFAULT 'System',
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` varchar(20) DEFAULT NULL,
  `updated_on` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `is_active` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `t_banquet_menu_type`
--

INSERT INTO `t_banquet_menu_type` (`banquet_menu_type_id`, `banquet_menu_type`, `menu_type_price`, `created_by`, `created_on`, `updated_by`, `updated_on`, `is_active`) VALUES
(1, 'Veg Platter', 'Euros 200', 'System', '2020-05-19 12:39:31', NULL, NULL, 1),
(2, 'Non Veg Platter', 'Euros 300', 'System', '2020-05-19 12:39:31', NULL, NULL, 1),
(3, 'Veg and Non-veg Platter', 'Euros 350', 'System', '2020-05-19 12:40:03', NULL, NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `t_conference`
--

CREATE TABLE `t_conference` (
  `conference_id` int(11) NOT NULL,
  `conference_date` date NOT NULL,
  `is_booked` tinyint(1) NOT NULL DEFAULT '1',
  `cust_id` int(11) NOT NULL,
  `conf_type_id` int(11) NOT NULL,
  `conf_guest_id` int(11) NOT NULL,
  `conf_time` time NOT NULL,
  `created_by` varchar(20) NOT NULL DEFAULT 'System',
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` varchar(20) DEFAULT NULL,
  `updated_on` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `is_active` tinyint(4) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `t_conference_list`
--

CREATE TABLE `t_conference_list` (
  `conf_type_id` int(11) NOT NULL,
  `conf_type` varchar(60) NOT NULL,
  `created_by` varchar(60) NOT NULL DEFAULT 'System',
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` varchar(60) DEFAULT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `loyalty` varchar(60) DEFAULT NULL,
  `conf_rent` decimal(7,2) NOT NULL,
  `abbr` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `t_conference_list`
--

INSERT INTO `t_conference_list` (`conf_type_id`, `conf_type`, `created_by`, `created_on`, `updated_by`, `updated_on`, `is_active`, `loyalty`, `conf_rent`, `abbr`) VALUES
(1, 'Presentation Meeting', 'System', '2020-05-29 19:13:47', NULL, NULL, 1, '100', '350.00', 'CONF'),
(2, 'Foreign Delegate Meeting', 'System', '2020-05-29 19:13:47', NULL, NULL, 1, '100', '500.00', 'CONF'),
(3, 'Product launch Meeting', 'System', '2020-05-29 19:13:47', NULL, NULL, 1, '100', '750.00', 'CONF'),
(4, 'Interview Meeting', 'System', '2020-05-29 19:13:47', NULL, NULL, 1, '100', '400.00', 'CONF'),
(5, 'Other Meeting', 'System', '2020-05-29 19:13:48', NULL, NULL, 1, '100', '250.00', 'CONF');

-- --------------------------------------------------------

--
-- Table structure for table `t_conf_guest`
--

CREATE TABLE `t_conf_guest` (
  `conf_guest_id` int(11) NOT NULL,
  `conf_guest` varchar(20) NOT NULL,
  `created_by` varchar(20) NOT NULL DEFAULT 'System',
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` varchar(20) DEFAULT NULL,
  `updated_on` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `is_active` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `t_conf_guest`
--

INSERT INTO `t_conf_guest` (`conf_guest_id`, `conf_guest`, `created_by`, `created_on`, `updated_by`, `updated_on`, `is_active`) VALUES
(1, '1 - 10', 'System', '2020-05-30 07:16:48', NULL, NULL, 1),
(2, '10 - 20', 'System', '2020-05-30 07:16:48', NULL, NULL, 1),
(3, '20 - 30', 'System', '2020-05-30 07:17:05', NULL, NULL, 1),
(4, 'Below 40', 'System', '2020-05-30 07:17:05', NULL, NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `t_customer_address`
--

CREATE TABLE `t_customer_address` (
  `cust_address_id` int(11) NOT NULL,
  `cust_id` int(11) NOT NULL,
  `cust_street` varchar(20) NOT NULL,
  `cust_city` varchar(20) NOT NULL,
  `cust_state` varchar(20) NOT NULL,
  `cust_country` varchar(20) NOT NULL,
  `created_by` varchar(20) NOT NULL DEFAULT 'System',
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` varchar(60) DEFAULT NULL,
  `updated_on` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `is_active` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `t_customer_address`
--

INSERT INTO `t_customer_address` (`cust_address_id`, `cust_id`, `cust_street`, `cust_city`, `cust_state`, `cust_country`, `created_by`, `created_on`, `updated_by`, `updated_on`, `is_active`) VALUES
(1, 1, 'pandav kada', 'kharghar', 'maharashtra', 'India', 'System', '2020-05-23 10:12:34', NULL, NULL, 1),
(2, 2, 'Dadar', 'Mahim', 'Maharshtra', 'India', 'System', '2020-05-23 20:06:15', NULL, NULL, 1),
(3, 3, 'vt granda', 'bus depot', 'maharashtraba', 'bali', 'System', '2020-05-23 20:25:32', NULL, NULL, 1),
(4, 4, 'Bang', 'Banglore', 'maharashtra', 'India', 'System', '2020-05-23 21:27:26', NULL, NULL, 1),
(5, 5, 'Dombivli', 'Dombivli', 'maharashtra', 'India', 'System', '2020-05-23 21:29:26', NULL, NULL, 1),
(6, 6, 'mahim', 'dadar', 'maharashtra', 'balad', 'System', '2020-05-23 21:44:50', NULL, NULL, 1),
(7, 7, 'mahi', 'kharghar', 'maha', 'india', 'System', '2020-05-23 21:47:02', NULL, NULL, 1),
(8, 8, 'mahi', 'melbourse', 'maha', 'india', 'System', '2020-05-24 16:15:11', NULL, NULL, 1),
(9, 9, 'mahim', 'melbourse', 'maha', 'ind', 'System', '2020-05-25 08:43:54', NULL, NULL, 1),
(10, 10, '34', 'dfds', 'df', 'sdf', 'System', '2020-05-25 08:47:45', NULL, NULL, 1),
(11, 11, 'julia', 'Mahim', 'Maharshtra', 'bali', 'System', '2020-05-25 08:49:24', NULL, NULL, 1),
(12, 12, 'mahi', 'melbourse', 'maha', 'India', 'System', '2020-05-25 08:51:21', NULL, NULL, 1),
(13, 13, 'julia', 'melbourse', 'Maharshtra', 'bali', 'System', '2020-05-28 15:45:57', NULL, NULL, 1),
(14, 14, 'pandav', 'kharghar', 'maharashtra', 'india', 'System', '2020-05-29 06:35:18', NULL, NULL, 1),
(15, 15, 'julia', 'melbourse', 'Maharshtra', 'balad', 'System', '2020-05-29 11:57:20', NULL, NULL, 1),
(16, 16, 'pandav', 'dadar', 'jumaic', 'balad', 'System', '2020-05-30 08:08:14', NULL, NULL, 1),
(17, 17, 'pandav', 'kharghar', 'maharashtra', 'india', 'System', '2020-05-30 11:36:41', NULL, NULL, 1),
(18, 18, 'gcc', 'Mumbai', 'Maharashtra', 'India', 'System', '2020-06-01 06:46:43', NULL, NULL, 1),
(19, 19, 'sd', '564', '231', '23', 'System', '2020-06-01 08:38:12', NULL, NULL, 1),
(20, 20, 'xc', 'cxz', 'cxc', 'zxx', 'System', '2020-06-01 13:16:01', NULL, NULL, 1),
(21, 21, 'qw', 'zc', 'cxz', 'cxz', 'System', '2020-06-04 05:56:30', NULL, NULL, 1),
(22, 22, 'dszv', 'xcv', 'cxv', 'vxc', 'System', '2020-06-04 06:19:01', NULL, NULL, 1),
(23, 23, 'asd', 'asd', 'asd', 'India', 'System', '2020-06-04 08:48:59', NULL, NULL, 1),
(24, 24, 'asdd', 'dsfsd', 'asd', 'asd', 'System', '2020-06-04 09:05:50', NULL, NULL, 1),
(25, 25, 'sd', 'sad', 'sdf', 'Ind', 'System', '2020-06-04 09:36:28', NULL, NULL, 1),
(26, 26, 'asd', 'asd', 'sdf', 'India', 'System', '2020-06-04 10:10:55', NULL, NULL, 1),
(27, 27, 'zdc', 'xzc', 'zxc', 'czx', 'System', '2020-06-07 09:52:36', NULL, NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `t_customer_card_details`
--

CREATE TABLE `t_customer_card_details` (
  `cc_ID` int(11) NOT NULL,
  `invoice_id` int(30) NOT NULL,
  `card_number` int(50) NOT NULL,
  `card_name` varchar(50) NOT NULL,
  `billed_for` varchar(30) NOT NULL,
  `total_bill` decimal(7,2) NOT NULL,
  `created_by` varchar(20) NOT NULL DEFAULT 'System',
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` varchar(20) DEFAULT NULL,
  `updated_on` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `is_active` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `t_customer_card_details`
--

INSERT INTO `t_customer_card_details` (`cc_ID`, `invoice_id`, `card_number`, `card_name`, `billed_for`, `total_bill`, `created_by`, `created_on`, `updated_by`, `updated_on`, `is_active`) VALUES
(1, 42, 2147483647, 'Sayli Pednekar', 'Rooms - Online', '2184.00', 'System', '2020-05-31 18:17:40', NULL, NULL, 1),
(2, 43, 123, 'A B C', 'Rooms - Online', '312.38', 'System', '2020-06-01 07:01:43', NULL, NULL, 1),
(3, 61, 213, 'A B C', 'Rooms - Online', '1472.63', 'System', '2020-06-04 10:22:49', NULL, NULL, 1),
(4, 63, 2147483647, 'sa', 'Rooms - Online', '4886.44', 'System', '2020-06-07 09:57:54', NULL, NULL, 1),
(5, 65, 12323, 'A B C', 'Rooms - Online', '1050.00', 'System', '2020-06-07 13:10:41', NULL, NULL, 1),
(6, 68, 23467, 'A B C', 'Rooms - Online', '551.25', 'System', '2020-06-07 13:54:10', NULL, NULL, 1),
(7, 71, 12132313, 'A B C', 'Rooms - Online', '808.50', 'System', '2020-06-07 17:12:52', NULL, NULL, 1),
(8, 74, 1323, 'A B C', 'Rooms - Online', '525.00', 'System', '2020-06-09 06:49:28', NULL, NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `t_customer_deals`
--

CREATE TABLE `t_customer_deals` (
  `deal_id` int(11) NOT NULL,
  `created_by` varchar(60) NOT NULL DEFAULT 'System',
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` varchar(60) DEFAULT NULL,
  `updated_on` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `discount_id` int(30) NOT NULL,
  `room_type_id` int(30) DEFAULT NULL,
  `is_booked` int(30) DEFAULT NULL,
  `customer_id` int(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `t_customer_deals`
--

INSERT INTO `t_customer_deals` (`deal_id`, `created_by`, `created_on`, `updated_by`, `updated_on`, `is_active`, `discount_id`, `room_type_id`, `is_booked`, `customer_id`) VALUES
(1, 'System', '2020-05-26 11:03:05', '16:34:15', '2020-05-25 18:30:00', 1, 1, 1, 1, 4),
(2, 'System', '2020-05-26 11:20:15', NULL, NULL, 1, 3, 3, 1, 3),
(3, 'System', '2020-05-26 11:59:19', NULL, NULL, 1, 2, 2, 1, 3),
(4, 'System', '2020-05-26 12:46:11', NULL, '2020-05-29 10:07:57', 1, 1, 1, 0, 3),
(5, 'System', '2020-05-29 09:09:53', NULL, '2020-05-29 10:21:45', 1, 1, 1, 0, 1),
(6, 'System', '2020-06-01 09:30:39', NULL, NULL, 1, 1, 1, 1, 18),
(7, 'System', '2020-06-04 06:55:22', NULL, NULL, 1, 1, 1, 1, 1),
(8, 'System', '2020-06-04 09:53:44', NULL, NULL, 1, 2, 2, 1, 25);

-- --------------------------------------------------------

--
-- Table structure for table `t_customer_identity_data`
--

CREATE TABLE `t_customer_identity_data` (
  `customer_identity_id` int(11) NOT NULL,
  `cust_id` int(11) NOT NULL,
  `cust_passport_number` varchar(20) NOT NULL,
  `cust_national_id` varchar(20) NOT NULL,
  `cust_card_details` varchar(60) NOT NULL,
  `created_by` varchar(60) NOT NULL DEFAULT 'System',
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` varchar(60) DEFAULT NULL,
  `updated_on` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `is_active` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `t_customer_identity_data`
--

INSERT INTO `t_customer_identity_data` (`customer_identity_id`, `cust_id`, `cust_passport_number`, `cust_national_id`, `cust_card_details`, `created_by`, `created_on`, `updated_by`, `updated_on`, `is_active`) VALUES
(1, 1, 'p123456', 'aadhar card', '123456789', 'System', '2020-05-23 10:12:34', NULL, NULL, 1),
(2, 2, 'P111111', 'Adhar', '123456789', 'System', '2020-05-23 20:06:15', NULL, NULL, 1),
(3, 3, 'p000000', 'aadhar', '0987654', 'System', '2020-05-23 20:25:32', NULL, NULL, 1),
(4, 4, 'PAkhila', '12345', '12345', 'System', '2020-05-23 21:27:26', NULL, NULL, 1),
(5, 5, 'ppooja', '12324', '98667808', 'System', '2020-05-23 21:29:26', NULL, NULL, 1),
(6, 6, 'p000000', '12334', '12345678', 'System', '2020-05-23 21:44:50', NULL, NULL, 1),
(7, 7, 'P022644', '12334', '12343', 'System', '2020-05-23 21:47:02', NULL, NULL, 1),
(8, 8, 'p000999', 'aadhar', '9876', 'System', '2020-05-24 16:15:11', NULL, NULL, 1),
(9, 9, 'paditya', '12', '233', 'System', '2020-05-25 08:43:54', NULL, NULL, 1),
(10, 10, 'pspa', '343', '12334', 'System', '2020-05-25 08:47:45', NULL, NULL, 1),
(11, 11, 'pppp', '12', '9384658', 'System', '2020-05-25 08:49:24', NULL, NULL, 1),
(12, 12, '44444', '12334', '12334', 'System', '2020-05-25 08:51:21', NULL, NULL, 1),
(13, 13, 'parjun', '787654', '12345678', 'System', '2020-05-28 15:45:57', NULL, NULL, 1),
(14, 14, 'p090909', '12334', '1243647', 'System', '2020-05-29 06:35:18', NULL, NULL, 1),
(15, 15, 'p000000', '12334', '9384658', 'System', '2020-05-29 11:57:20', NULL, NULL, 1),
(16, 16, 'pshubha', '12334', '12345678', 'System', '2020-05-30 08:08:14', NULL, NULL, 1),
(17, 17, 'p000000', '12334', '12345678', 'System', '2020-05-30 11:36:41', NULL, NULL, 1),
(18, 18, '321', '123', '123', 'System', '2020-06-01 06:46:43', NULL, NULL, 1),
(19, 19, '123', '321', 'sad', 'System', '2020-06-01 08:38:12', NULL, NULL, 1),
(20, 20, '789', 'ds', '213', 'System', '2020-06-01 13:16:01', NULL, NULL, 1),
(21, 21, '123', '321', '123', 'System', '2020-06-04 05:56:30', NULL, NULL, 1),
(22, 22, '123', '123', '12', 'System', '2020-06-04 06:19:01', NULL, NULL, 1),
(23, 23, 'poojab', '657465', '123', 'System', '2020-06-04 08:48:59', NULL, NULL, 1),
(24, 24, 'p000000', '321', '123', 'System', '2020-06-04 09:05:50', NULL, NULL, 1),
(25, 25, 'ashu', '77', '00', 'System', '2020-06-04 09:36:28', NULL, NULL, 1),
(26, 26, 'mg', '765', '123', 'System', '2020-06-04 10:10:55', NULL, NULL, 1),
(27, 27, '123', '231', '123', 'System', '2020-06-07 09:52:36', NULL, NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `t_customer_login`
--

CREATE TABLE `t_customer_login` (
  `login_ID` int(11) NOT NULL,
  `cust_id` int(11) NOT NULL,
  `cust_username` varchar(30) NOT NULL,
  `cust_password` varchar(30) NOT NULL,
  `created_by` varchar(60) NOT NULL DEFAULT 'System',
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` varchar(60) DEFAULT NULL,
  `updated_on` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `is_active` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `t_customer_login`
--

INSERT INTO `t_customer_login` (`login_ID`, `cust_id`, `cust_username`, `cust_password`, `created_by`, `created_on`, `updated_by`, `updated_on`, `is_active`) VALUES
(1, 1, 'Pednekar', 'p123456', 'System', '2020-05-23 10:12:34', NULL, '2020-06-04 06:55:22', 1),
(2, 2, 'Kulkarni', 'P111111', 'System', '2020-05-23 20:06:15', NULL, '2020-05-24 13:58:28', 1),
(3, 3, 'Kulkarni', 'p000000', 'System', '2020-05-23 20:25:32', NULL, '2020-05-31 12:01:35', 1),
(4, 4, 'Srinath', 'PAkhila', 'System', '2020-05-23 21:27:26', NULL, '2020-05-30 08:33:18', 1),
(5, 5, 'Sangle', 'ppooja', 'System', '2020-05-23 21:29:26', NULL, '2020-05-25 08:36:53', 1),
(6, 6, 'Patil', 'p000000', 'System', '2020-05-23 21:44:50', NULL, '2020-05-29 09:06:02', 1),
(7, 7, 'Kambli', 'P022644', 'System', '2020-05-23 21:47:02', NULL, NULL, 1),
(8, 8, 'kuk', 'p000999', 'System', '2020-05-24 16:15:11', NULL, '2020-05-24 16:34:40', 1),
(9, 9, 'borkar', '0', 'System', '2020-05-25 08:43:54', NULL, '2020-05-25 08:44:17', 1),
(10, 10, 'spa', 'pspa', 'System', '2020-05-25 08:47:45', NULL, NULL, 1),
(11, 11, 'pppp', 'pppp', 'System', '2020-05-25 08:49:25', NULL, '2020-05-25 08:52:26', 1),
(12, 12, 'hash', '44444', 'System', '2020-05-25 08:51:21', NULL, '2020-05-25 08:59:14', 1),
(13, 13, 'ped', 'parjun', 'System', '2020-05-28 15:45:57', NULL, NULL, 1),
(14, 14, 'Tej', 'p090909', 'System', '2020-05-29 06:35:18', NULL, NULL, 1),
(15, 15, 'vedu', 'p000000', 'System', '2020-05-29 11:57:20', NULL, NULL, 1),
(16, 16, 'kambli', 'shubha', 'System', '2020-05-30 08:08:14', NULL, '2020-05-30 08:38:49', 1),
(17, 17, 'phatan', 'p000000', 'System', '2020-05-30 11:36:41', NULL, NULL, 1),
(18, 18, 'Borkar', '321', 'System', '2020-06-01 06:46:43', NULL, '2020-06-01 09:32:03', 1),
(19, 19, 'piku', '123', 'System', '2020-06-01 08:38:12', NULL, NULL, 1),
(20, 20, 'kbc', '789', 'System', '2020-06-01 13:16:01', NULL, NULL, 1),
(21, 21, 'mom', '123', 'System', '2020-06-04 05:56:30', NULL, '2020-06-04 07:03:01', 1),
(22, 22, 'rain', '123', 'System', '2020-06-04 06:19:01', NULL, NULL, 1),
(23, 23, 'borkar1', 'poojab', 'System', '2020-06-04 08:49:00', NULL, '2020-06-04 08:50:57', 1),
(24, 24, 'Ped', 'p000000', 'System', '2020-06-04 09:05:51', NULL, NULL, 1),
(25, 25, 'ashu', 'ashu', 'System', '2020-06-04 09:36:28', NULL, NULL, 1),
(26, 26, 'mg', 'mg', 'System', '2020-06-04 10:10:55', NULL, NULL, 1),
(27, 27, 'ash', '123', 'System', '2020-06-07 09:52:37', NULL, NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `t_customer_loyalty_points`
--

CREATE TABLE `t_customer_loyalty_points` (
  `cust_loyalty_points_id` int(11) NOT NULL,
  `cust_id` int(11) NOT NULL,
  `cust_loyalty_points` int(11) NOT NULL,
  `created_by` varchar(20) NOT NULL DEFAULT 'System',
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` varchar(20) DEFAULT NULL,
  `updated_on` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `is_active` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `t_customer_loyalty_points`
--

INSERT INTO `t_customer_loyalty_points` (`cust_loyalty_points_id`, `cust_id`, `cust_loyalty_points`, `created_by`, `created_on`, `updated_by`, `updated_on`, `is_active`) VALUES
(1, 21, 300, 'System', '2020-06-04 05:56:30', NULL, '2020-06-04 06:05:09', 1),
(2, 22, 0, 'System', '2020-06-04 06:19:01', NULL, '2020-06-04 06:20:49', 1),
(3, 23, 500, 'System', '2020-06-04 08:49:00', NULL, '2020-06-04 09:03:37', 1),
(4, 24, 700, 'System', '2020-06-04 09:05:51', NULL, '2020-06-04 09:28:47', 1),
(5, 25, 200, 'System', '2020-06-04 09:36:28', NULL, '2020-06-04 09:53:44', 1),
(6, 26, 4200, 'System', '2020-06-04 10:10:56', NULL, '2020-06-09 06:54:06', 1),
(7, 27, 500, 'System', '2020-06-07 09:52:37', NULL, '2020-06-07 10:05:55', 1);

-- --------------------------------------------------------

--
-- Table structure for table `t_customer_personal_data`
--

CREATE TABLE `t_customer_personal_data` (
  `cust_id` int(11) NOT NULL,
  `cust_fname` varchar(20) NOT NULL,
  `cust_mname` varchar(20) NOT NULL,
  `cust_lname` varchar(30) NOT NULL,
  `cust_dob` date NOT NULL,
  `cust_phone_number` varchar(20) NOT NULL,
  `created_by` varchar(25) NOT NULL DEFAULT 'System',
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` varchar(60) DEFAULT NULL,
  `updated_on` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `is_active` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `t_customer_personal_data`
--

INSERT INTO `t_customer_personal_data` (`cust_id`, `cust_fname`, `cust_mname`, `cust_lname`, `cust_dob`, `cust_phone_number`, `created_by`, `created_on`, `updated_by`, `updated_on`, `is_active`) VALUES
(1, 'Sayli', 'Arjun', 'Pednekar', '2020-05-01', '12', 'System', '2020-05-23 10:12:34', NULL, '2020-06-04 07:10:43', 1),
(2, 'Rani', 'Vishal', 'Kulkarni', '0000-00-00', '897654678', 'System', '2020-05-23 20:06:15', NULL, '2020-05-25 08:32:18', 1),
(3, 'Ved', 'V', 'Kulkarni', '2020-05-30', '123453625', 'System', '2020-05-23 20:25:32', NULL, '2020-05-25 08:32:48', 1),
(4, 'Akhila', 's', 'Srinath', '2020-05-29', '878765654', 'System', '2020-05-23 21:27:26', NULL, '2020-05-25 08:32:52', 1),
(5, 'Pooja', 'a', 'Sangle', '2020-05-09', '876543', 'System', '2020-05-23 21:29:26', NULL, '2020-05-25 08:32:57', 1),
(6, 'yash', 'p', 'Patil', '2020-05-30', '9167361161', 'System', '2020-05-23 21:44:50', NULL, '2020-05-25 08:33:01', 1),
(7, 'Shubha', 'a', 'Kambli', '2020-05-20', '345345', 'System', '2020-05-23 21:47:02', NULL, '2020-05-25 08:33:04', 1),
(8, 'Vedya', 'a', 'kuk', '2020-05-29', '9786654', 'System', '2020-05-24 16:15:11', NULL, '2020-05-25 08:33:08', 1),
(9, 'aditya', 'a', 'borkar', '2020-05-15', '87677', 'System', '2020-05-25 08:43:54', NULL, NULL, 1),
(10, 'kk', 'aa', 'spa', '2020-05-15', '32424', 'System', '2020-05-25 08:47:45', NULL, NULL, 1),
(11, 'pspa', 'd', 'pppp', '2020-05-08', '44', 'System', '2020-05-25 08:49:24', NULL, NULL, 1),
(12, 'sayli', 'a', 'hash', '2020-05-23', '7564837465', 'System', '2020-05-25 08:51:21', NULL, NULL, 1),
(13, 'arjun', 'v', 'ped', '2020-06-01', '87878798', 'System', '2020-05-28 15:45:57', NULL, NULL, 1),
(14, 'RaniTej', 'v', 'Tej', '2020-05-30', '7564837465', 'System', '2020-05-29 06:35:18', NULL, NULL, 1),
(15, 'vedant', 'h', 'vedu', '2020-05-30', '7564837465', 'System', '2020-05-29 11:57:20', NULL, NULL, 1),
(16, 'shubha', 'a', 'kambli', '2020-05-02', '98765432', 'System', '2020-05-30 08:08:14', NULL, NULL, 1),
(17, 'onkar', 'a', 'phatan', '2020-05-30', '7564837465', 'System', '2020-05-30 11:36:41', NULL, NULL, 1),
(18, 'Aditya', 'K', 'Borkar', '2020-05-24', '123', 'System', '2020-06-01 06:46:43', NULL, NULL, 1),
(19, 'qwer', 'sa', 'piku', '2020-05-04', '123', 'System', '2020-06-01 08:38:12', NULL, NULL, 1),
(20, 'psyduck', 'sad', 'kbc', '2020-06-20', 'asd', 'System', '2020-06-01 13:16:01', NULL, NULL, 1),
(21, 'dad', 'k', 'mom', '2020-06-01', '132', 'System', '2020-06-04 05:56:30', NULL, NULL, 1),
(22, 'avc', 'xc', 'rain', '2020-06-01', '1212', 'System', '2020-06-04 06:19:01', NULL, NULL, 1),
(23, 'PoojaA', 'A', 'borkar1', '2020-06-13', '98766565', 'System', '2020-06-04 08:48:59', NULL, NULL, 1),
(24, 'Sayli', 'a', 'Ped', '2020-06-19', '44', 'System', '2020-06-04 09:05:50', NULL, NULL, 1),
(25, 'ashu', 'a', 'ashu', '2020-06-27', '98667', 'System', '2020-06-04 09:36:28', NULL, NULL, 1),
(26, 'akhilaa', 'a', 'mg', '2020-06-06', '1234', 'System', '2020-06-04 10:10:55', NULL, '2020-06-07 10:04:43', 1),
(27, 'psyduck', 'sad', 'ash', '2020-06-13', '123', 'System', '2020-06-07 09:52:36', NULL, NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `t_department`
--

CREATE TABLE `t_department` (
  `department_id` int(11) NOT NULL,
  `department_name` varchar(30) NOT NULL,
  `created_by` varchar(20) NOT NULL DEFAULT 'System',
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` varchar(20) DEFAULT NULL,
  `updated_on` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `is_active` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `t_department`
--

INSERT INTO `t_department` (`department_id`, `department_name`, `created_by`, `created_on`, `updated_by`, `updated_on`, `is_active`) VALUES
(1, 'Management', 'System', '2020-05-24 20:55:19', NULL, '0000-00-00 00:00:00', 1),
(2, 'Finance', 'System', '2020-05-24 20:55:19', NULL, '0000-00-00 00:00:00', 1),
(3, 'Human Resource', 'System', '2020-05-24 20:55:32', NULL, '0000-00-00 00:00:00', 1);

-- --------------------------------------------------------

--
-- Table structure for table `t_discount_coupon`
--

CREATE TABLE `t_discount_coupon` (
  `id` int(8) NOT NULL,
  `discount_id` int(255) NOT NULL,
  `is_active` int(10) DEFAULT '1',
  `loyalty_points` int(30) NOT NULL,
  `room_type_id` int(30) NOT NULL,
  `created_by` varchar(20) NOT NULL DEFAULT 'System',
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` varchar(20) DEFAULT NULL,
  `updated_on` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `t_discount_coupon`
--

INSERT INTO `t_discount_coupon` (`id`, `discount_id`, `is_active`, `loyalty_points`, `room_type_id`, `created_by`, `created_on`, `updated_by`, `updated_on`) VALUES
(1, 1, 1, 300, 1, 'System', '2020-06-03 14:22:50', NULL, NULL),
(2, 2, 1, 500, 2, 'System', '2020-06-03 14:22:50', NULL, NULL),
(3, 3, 1, 800, 3, 'System', '2020-06-03 14:22:50', NULL, NULL),
(4, 4, 1, 1500, 4, 'System', '2020-06-03 14:22:50', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `t_employee_address`
--

CREATE TABLE `t_employee_address` (
  `employee_address_id` int(11) NOT NULL,
  `emp_id` int(11) NOT NULL,
  `emp_street` varchar(20) NOT NULL,
  `emp_city` varchar(20) NOT NULL,
  `emp_state` varchar(20) NOT NULL,
  `emp_country` varchar(20) NOT NULL,
  `created_by` varchar(20) NOT NULL DEFAULT 'System',
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` varchar(20) DEFAULT NULL,
  `updated_on` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `is_active` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `t_employee_address`
--

INSERT INTO `t_employee_address` (`employee_address_id`, `emp_id`, `emp_street`, `emp_city`, `emp_state`, `emp_country`, `created_by`, `created_on`, `updated_by`, `updated_on`, `is_active`) VALUES
(1, 1, 'as', 'dsad', 'sad', 'asd', 'System', '2020-05-24 21:46:26', NULL, NULL, 1),
(2, 2, 'sd', 'asd', 'sad', 'India', 'System', '2020-05-24 22:18:17', NULL, NULL, 1),
(3, 3, 'dddd', 'www', 'jkkj', 'asas', 'System', '2020-05-26 09:51:13', NULL, NULL, 1),
(4, 4, '2cc', 'c xv', 'xc', 'xcv', 'System', '2020-05-26 09:58:26', NULL, NULL, 1),
(5, 5, 'df', 'sdf', 'dsf', 'sdf', 'System', '2020-05-26 10:02:17', NULL, NULL, 1),
(6, 6, 'panch g', 'd', 'm', 'India', 'System', '2020-05-26 10:06:53', NULL, '2020-05-28 12:20:04', 1),
(7, 7, 'bbbb', 'mumbai', 'dddd', 'bbbb', 'System', '2020-05-28 11:08:52', NULL, NULL, 1),
(8, 8, 'mumbai', 'bangalore', 'mumbai', 'mumbai', 'System', '2020-05-28 14:04:08', NULL, '2020-05-28 14:05:38', 1),
(9, 9, 'sda', 'asd', 'dsa', 'dsa', 'System', '2020-06-01 13:27:38', NULL, NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `t_employee_bank_details`
--

CREATE TABLE `t_employee_bank_details` (
  `emp_bank_id` int(11) NOT NULL,
  `emp_id` int(11) NOT NULL,
  `IBAN` varchar(20) NOT NULL,
  `BIC` varchar(30) NOT NULL,
  `created_by` varchar(20) NOT NULL DEFAULT 'Sysrem',
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` varchar(20) DEFAULT NULL,
  `updated_on` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `is_active` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `t_employee_bank_details`
--

INSERT INTO `t_employee_bank_details` (`emp_bank_id`, `emp_id`, `IBAN`, `BIC`, `created_by`, `created_on`, `updated_by`, `updated_on`, `is_active`) VALUES
(1, 2, '1231', '3211', 'Sysrem', '2020-05-24 22:18:17', NULL, NULL, 1),
(2, 3, '9999', '5656', 'Sysrem', '2020-05-26 09:51:13', NULL, NULL, 1),
(3, 4, 'cxv', 'xcv', 'Sysrem', '2020-05-26 09:58:26', NULL, NULL, 1),
(4, 5, '1651', '455', 'Sysrem', '2020-05-26 10:02:17', NULL, NULL, 1),
(5, 6, 'dsf', 'cxvc', 'Sysrem', '2020-05-26 10:06:53', NULL, '2020-05-28 12:20:04', 1),
(6, 7, '9999', '5656', 'Sysrem', '2020-05-28 11:08:53', NULL, NULL, 1),
(7, 8, '22222', '33333', 'Sysrem', '2020-05-28 14:04:08', NULL, NULL, 1),
(8, 9, 'sd', 'asd', 'Sysrem', '2020-06-01 13:27:38', NULL, NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `t_employee_department_role_mapping`
--

CREATE TABLE `t_employee_department_role_mapping` (
  `emp_dept_desg_map_id` int(11) NOT NULL,
  `emp_id` int(11) NOT NULL,
  `department_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  `created_by` varchar(20) NOT NULL DEFAULT 'System',
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` varchar(20) DEFAULT NULL,
  `updated_on` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `is_active` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `t_employee_department_role_mapping`
--

INSERT INTO `t_employee_department_role_mapping` (`emp_dept_desg_map_id`, `emp_id`, `department_id`, `role_id`, `created_by`, `created_on`, `updated_by`, `updated_on`, `is_active`) VALUES
(1, 1, 1, 1, 'System', '2020-05-24 21:46:26', NULL, '0000-00-00 00:00:00', 1),
(2, 2, 1, 1, 'System', '2020-05-24 22:18:17', NULL, '0000-00-00 00:00:00', 1),
(3, 3, 1, 1, 'System', '2020-05-26 09:51:13', NULL, '0000-00-00 00:00:00', 1),
(4, 4, 2, 2, 'System', '2020-05-26 09:58:26', NULL, '0000-00-00 00:00:00', 1),
(5, 5, 1, 1, 'System', '2020-05-26 10:02:17', NULL, '0000-00-00 00:00:00', 1),
(6, 6, 1, 1, 'System', '2020-05-26 10:06:53', NULL, '0000-00-00 00:00:00', 1),
(7, 7, 1, 1, 'System', '2020-05-28 11:08:52', NULL, '2020-06-04 20:37:34', 1),
(8, 8, 1, 1, 'System', '2020-05-28 14:04:08', NULL, '0000-00-00 00:00:00', 1),
(9, 9, 1, 1, 'System', '2020-06-01 13:27:38', NULL, '0000-00-00 00:00:00', 1);

-- --------------------------------------------------------

--
-- Table structure for table `t_employee_identity_data`
--

CREATE TABLE `t_employee_identity_data` (
  `employee_identity_id` int(11) NOT NULL,
  `emp_id` int(11) NOT NULL,
  `emp_passport_number` varchar(15) NOT NULL,
  `emp_national_id` varchar(20) NOT NULL,
  `created_by` varchar(20) NOT NULL DEFAULT 'System',
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` varchar(20) DEFAULT NULL,
  `updated_on` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `is_active` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `t_employee_identity_data`
--

INSERT INTO `t_employee_identity_data` (`employee_identity_id`, `emp_id`, `emp_passport_number`, `emp_national_id`, `created_by`, `created_on`, `updated_by`, `updated_on`, `is_active`) VALUES
(1, 1, '123', '213', 'System', '2020-05-24 21:46:26', NULL, NULL, 1),
(2, 2, '23', '32', 'System', '2020-05-24 22:18:17', NULL, NULL, 1),
(3, 3, '333', '0202', 'System', '2020-05-26 09:51:13', NULL, NULL, 1),
(4, 4, 'ab', '2313', 'System', '2020-05-26 09:58:26', NULL, NULL, 1),
(5, 5, '123', 'fds', 'System', '2020-05-26 10:02:17', NULL, NULL, 1),
(6, 6, '456', '07', 'System', '2020-05-26 10:06:53', NULL, '2020-05-29 12:47:16', 1),
(7, 7, '111', '0202', 'System', '2020-05-28 11:08:52', NULL, NULL, 1),
(8, 8, '99999', '55555', 'System', '2020-05-28 14:04:08', NULL, '2020-05-28 14:05:38', 1),
(9, 9, '123', 'dsc', 'System', '2020-06-01 13:27:38', NULL, NULL, 1);

--
-- Triggers `t_employee_identity_data`
--
DELIMITER $$
CREATE TRIGGER `trig_after_insert_emp_identity_data` AFTER INSERT ON `t_employee_identity_data` FOR EACH ROW UPDATE t_employee_login
SET emp_password = NEW.emp_passport_number
WHERE emp_id = NEW.emp_id
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `t_employee_login`
--

CREATE TABLE `t_employee_login` (
  `login_id` int(11) NOT NULL,
  `emp_id` int(11) NOT NULL,
  `emp_username` varchar(60) NOT NULL,
  `emp_password` varchar(60) NOT NULL,
  `created_by` varchar(60) NOT NULL DEFAULT 'System',
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` varchar(60) DEFAULT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `t_employee_login`
--

INSERT INTO `t_employee_login` (`login_id`, `emp_id`, `emp_username`, `emp_password`, `created_by`, `created_on`, `updated_by`, `updated_on`, `is_active`) VALUES
(4, 6, 'sangle', '456', 'System', '2020-05-26 10:06:53', NULL, NULL, 1),
(5, 7, 'srinath', '111', 'System', '2020-05-28 11:08:53', NULL, NULL, 1),
(6, 8, 'lenovo', '99999', 'System', '2020-05-28 14:04:09', NULL, NULL, 1),
(7, 9, 'c', '123', 'System', '2020-06-01 13:27:38', NULL, NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `t_employee_personal_data`
--

CREATE TABLE `t_employee_personal_data` (
  `emp_id` int(11) NOT NULL,
  `emp_fname` varchar(20) NOT NULL,
  `emp_mname` varchar(20) NOT NULL,
  `emp_lname` varchar(30) NOT NULL,
  `emp_dob` date NOT NULL,
  `emp_phone_number` varchar(11) NOT NULL,
  `created_by` varchar(20) NOT NULL DEFAULT 'System',
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` varchar(20) DEFAULT NULL,
  `updated_on` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `is_active` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `t_employee_personal_data`
--

INSERT INTO `t_employee_personal_data` (`emp_id`, `emp_fname`, `emp_mname`, `emp_lname`, `emp_dob`, `emp_phone_number`, `created_by`, `created_on`, `updated_by`, `updated_on`, `is_active`) VALUES
(1, 'Aditya', 'k', 'borkar', '1990-05-02', '54565120', 'System', '2020-05-24 21:46:26', NULL, NULL, 1),
(2, 'Aditya', 'scas', 'sds', '2020-05-31', '121', 'System', '2020-05-24 22:18:17', NULL, NULL, 1),
(3, 'akhila', 'srinath', 'srinath', '2020-05-01', '878', 'System', '2020-05-26 09:51:13', NULL, NULL, 1),
(4, 'asd', 'sad', 'ab', '2013-11-01', '112', 'System', '2020-05-26 09:58:26', NULL, NULL, 1),
(5, 'abc', 'abc', 'bac', '2020-05-05', '321', 'System', '2020-05-26 10:02:17', NULL, NULL, 1),
(6, 'aditya', 'ab', 'sangle', '2018-12-04', '123', 'System', '2020-05-26 10:06:53', NULL, '2020-05-29 12:47:16', 1),
(7, 'pooja', 'srinath', 'srinath', '2020-05-01', '7878', 'System', '2020-05-28 11:08:51', NULL, NULL, 1),
(8, 'pooja', 'vijay', 'lenovo', '2020-05-22', '11111', 'System', '2020-05-28 14:04:08', NULL, '2020-05-28 14:05:38', 1),
(9, 'a', 'b', 'c', '2020-05-05', '12', 'System', '2020-06-01 13:27:38', NULL, NULL, 1);

--
-- Triggers `t_employee_personal_data`
--
DELIMITER $$
CREATE TRIGGER `trig_after_insert_emp_personal_data` AFTER INSERT ON `t_employee_personal_data` FOR EACH ROW INSERT INTO t_employee_login(emp_id,
                 emp_username
                 )
                   
          VALUES(NEW.emp_id,
                 NEW.emp_lname
                 )
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `t_employee_role`
--

CREATE TABLE `t_employee_role` (
  `employee_role_id` int(11) NOT NULL,
  `emp_role` varchar(20) NOT NULL,
  `created_by` varchar(20) NOT NULL DEFAULT 'System',
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` varchar(20) DEFAULT NULL,
  `updated_on` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `is_active` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `t_employee_role`
--

INSERT INTO `t_employee_role` (`employee_role_id`, `emp_role`, `created_by`, `created_on`, `updated_by`, `updated_on`, `is_active`) VALUES
(1, 'Room Cleaner', 'System', '2020-05-24 20:58:32', NULL, NULL, 1),
(2, 'CA', 'System', '2020-05-24 20:58:32', NULL, '2020-05-24 20:59:53', 1);

-- --------------------------------------------------------

--
-- Table structure for table `t_invoice`
--

CREATE TABLE `t_invoice` (
  `invoice_id` int(11) NOT NULL,
  `cust_id` int(11) NOT NULL,
  `invoice_for` varchar(60) NOT NULL,
  `loyalty_used` int(100) NOT NULL,
  `total_bill` decimal(7,2) DEFAULT NULL,
  `created_by` varchar(60) NOT NULL DEFAULT 'System',
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` varchar(60) DEFAULT NULL,
  `updated_on` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `is_active` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `t_invoice`
--

INSERT INTO `t_invoice` (`invoice_id`, `cust_id`, `invoice_for`, `loyalty_used`, `total_bill`, `created_by`, `created_on`, `updated_by`, `updated_on`, `is_active`) VALUES
(1, 1, 'Restaurant', 0, '630.00', 'System', '2020-05-23 20:12:32', NULL, NULL, 1),
(2, 2, 'Restaurant', 0, '840.00', 'System', '2020-05-23 20:15:23', NULL, NULL, 1),
(3, 3, 'Restaurant', 0, '945.00', 'System', '2020-05-23 20:25:56', NULL, NULL, 1),
(4, 6, 'Restaurant', 100, '704.18', 'System', '2020-05-23 21:48:21', NULL, NULL, 1),
(5, 7, 'Restaurant', 0, '803.25', 'System', '2020-05-23 22:38:05', NULL, NULL, 1),
(6, 4, 'Restaurant', 100, '714.00', 'System', '2020-05-23 22:50:49', NULL, NULL, 1),
(7, 6, 'Restaurant', 0, '1036.35', 'System', '2020-05-24 10:12:05', NULL, NULL, 1),
(8, 3, 'Restaurant', 0, '840.00', 'System', '2020-05-24 13:56:09', NULL, NULL, 1),
(9, 2, 'Restaurant', 200, '672.00', 'System', '2020-05-24 13:58:28', NULL, NULL, 1),
(10, 5, 'Restaurant', 100, '704.18', 'System', '2020-05-24 14:10:08', NULL, NULL, 1),
(11, 5, 'Restaurant', 200, '662.76', 'System', '2020-05-24 16:05:00', NULL, NULL, 1),
(12, 8, 'Restaurant', 100, '794.33', 'System', '2020-05-24 16:18:22', NULL, NULL, 1),
(13, 8, 'Restaurant', 0, '934.50', 'System', '2020-05-24 16:21:44', NULL, NULL, 1),
(14, 8, 'Restaurant', 0, '919.80', 'System', '2020-05-24 16:32:33', NULL, NULL, 1),
(15, 5, 'Banquet', 100, '7041.83', 'System', '2020-05-25 08:36:53', NULL, NULL, 1),
(16, 9, 'Banquet', 100, '714.00', 'System', '2020-05-25 08:44:17', NULL, NULL, 1),
(17, 11, 'Banquet', 100, '8815.22', 'System', '2020-05-25 08:52:26', NULL, NULL, 1),
(18, 4, 'Restaurant', 100, '880.01', 'System', '2020-05-25 08:58:38', NULL, NULL, 1),
(19, 12, 'Banquet', 300, '681.19', 'System', '2020-05-25 08:59:14', NULL, NULL, 1),
(20, 6, 'Banquet', 400, '562.28', 'System', '2020-05-25 09:03:54', NULL, NULL, 1),
(21, 4, 'Restaurant', 0, '828.45', 'System', '2020-05-25 18:21:57', NULL, NULL, 1),
(22, 1, 'tspa', 100, '312.38', 'System', '2020-05-26 18:50:27', NULL, NULL, 1),
(23, 4, 'tspa', 0, '126.00', 'System', '2020-05-26 18:55:40', NULL, NULL, 1),
(24, 4, 'tspa', 0, '995.40', 'System', '2020-05-26 18:56:10', NULL, NULL, 1),
(25, 1, 'Room', 100, '343.61', 'System', '2020-05-29 08:44:23', NULL, NULL, 1),
(26, 6, 'Room', 200, '693.00', 'System', '2020-05-29 09:02:57', NULL, NULL, 1),
(27, 6, 'Room', 200, '693.00', 'System', '2020-05-29 09:06:02', NULL, NULL, 1),
(28, 1, 'Room', 100, '343.61', 'System', '2020-05-29 09:11:10', NULL, NULL, 1),
(29, 7, 'Room', 0, '404.25', 'System', '2020-05-29 09:46:52', NULL, NULL, 1),
(30, 1, 'Room', 0, '404.25', 'System', '2020-05-29 10:17:05', NULL, NULL, 1),
(31, 1, 'Room', 0, '404.25', 'System', '2020-05-29 10:20:15', NULL, NULL, 1),
(32, 1, 'Room', 0, '404.25', 'System', '2020-05-29 10:22:10', NULL, NULL, 1),
(33, 16, 'Restaurant', 0, '315.00', 'System', '2020-05-30 08:21:57', NULL, NULL, 1),
(34, 16, 'tspa', 0, '924.00', 'System', '2020-05-30 08:39:16', NULL, NULL, 1),
(35, 1, 'tcon', 0, '420.00', 'System', '2020-05-30 11:33:51', NULL, NULL, 1),
(36, 1, 'Rooms & Amenities', 200, '643.44', 'System', '2020-05-31 11:31:25', NULL, NULL, 1),
(37, 1, 'Rooms & Amenities', 100, '536.39', 'System', '2020-05-31 11:42:57', NULL, NULL, 1),
(38, 3, 'Amenities', 200, '181.44', 'System', '2020-05-31 12:01:35', NULL, NULL, 1),
(39, 17, 'Amenities', 0, '420.00', 'System', '2020-05-31 12:09:52', NULL, NULL, 1),
(40, 6, 'Amenities', 0, '420.00', 'System', '2020-05-31 12:14:19', NULL, NULL, 1),
(41, 1, 'Rooms - Online', 200, '1755.60', 'System', '2020-05-31 18:13:50', NULL, NULL, 1),
(42, 1, 'Rooms - Online', 200, '2184.00', 'System', '2020-05-31 18:17:40', NULL, NULL, 1),
(43, 18, 'Rooms - Online', 100, '312.38', 'System', '2020-06-01 07:01:43', NULL, NULL, 1),
(44, 18, 'Room', 100, '312.38', 'System', '2020-06-01 08:07:19', NULL, NULL, 1),
(45, 21, 'Banquet', 100, '3123.75', 'System', '2020-06-04 06:05:10', NULL, NULL, 1),
(46, 22, 'Restaurant', 100, '446.25', 'System', '2020-06-04 06:20:49', NULL, NULL, 1),
(47, 21, 'Room', 200, '2146.20', 'System', '2020-06-04 06:50:46', NULL, NULL, 1),
(48, 23, 'Amenities', 100, '133.88', 'System', '2020-06-04 08:50:57', NULL, NULL, 1),
(49, 23, 'Amenities', 100, '107.10', 'System', '2020-06-04 09:01:34', NULL, NULL, 1),
(50, 23, 'Restaurant', 100, '535.50', 'System', '2020-06-04 09:03:38', NULL, NULL, 1),
(51, 24, 'Banquet', 100, '1785.00', 'System', '2020-06-04 09:07:25', NULL, NULL, 1),
(52, 24, 'Banquet', 100, '3123.75', 'System', '2020-06-04 09:19:32', NULL, NULL, 1),
(53, 24, 'Amenities', 0, '3675.00', 'System', '2020-06-04 09:20:16', NULL, NULL, 1),
(54, 24, 'Amenities', 200, '45.36', 'System', '2020-06-04 09:28:02', NULL, NULL, 1),
(55, 24, 'tspa', 100, '535.50', 'System', '2020-06-04 09:28:47', NULL, NULL, 1),
(56, 25, 'tcon', 300, '315.00', 'System', '2020-06-04 09:37:36', NULL, NULL, 1),
(57, 25, 'tcon', 100, '669.38', 'System', '2020-06-04 09:43:58', NULL, NULL, 1),
(58, 25, 'tcon', 100, '669.38', 'System', '2020-06-04 09:44:40', NULL, NULL, 1),
(59, 26, 'Rooms & Amenities', 100, '1040.66', 'System', '2020-06-04 10:18:38', NULL, NULL, 1),
(60, 26, 'Room', 100, '892.50', 'System', '2020-06-04 10:19:39', NULL, NULL, 1),
(61, 26, 'Rooms - Online', 100, '1472.63', 'System', '2020-06-04 10:22:49', NULL, NULL, 1),
(62, 27, 'Banquet', 100, '5355.00', 'System', '2020-06-07 09:55:31', NULL, NULL, 1),
(63, 26, 'Rooms - Online', 100, '4886.44', 'System', '2020-06-07 09:57:54', NULL, NULL, 1),
(64, 26, 'Rooms & Amenities', 200, '4704.00', 'System', '2020-06-07 10:00:31', NULL, NULL, 1),
(65, 26, 'Rooms - Online', 200, '1050.00', 'System', '2020-06-07 13:10:40', NULL, NULL, 1),
(66, 26, 'Rooms & Amenities', 200, '1591.80', 'System', '2020-06-07 13:16:26', NULL, NULL, 1),
(67, 26, 'Banquet', 500, '6142.50', 'System', '2020-06-07 13:20:52', NULL, NULL, 1),
(68, 26, 'Rooms - Online', 400, '551.25', 'System', '2020-06-07 13:54:10', NULL, NULL, 1),
(69, 26, 'Rooms & Amenities', 200, '2247.00', 'System', '2020-06-07 13:58:15', NULL, NULL, 1),
(70, 26, 'Banquet', 200, '7560.00', 'System', '2020-06-07 14:00:46', NULL, NULL, 1),
(71, 26, 'Rooms - Online', 400, '808.50', 'System', '2020-06-07 17:12:52', NULL, NULL, 1),
(72, 26, 'Rooms & Amenities', 200, '2247.00', 'System', '2020-06-07 17:16:19', NULL, NULL, 1),
(73, 26, 'Banquet', 200, '5040.00', 'System', '2020-06-07 17:18:26', NULL, NULL, 1),
(74, 26, 'Rooms - Online', 800, '525.00', 'System', '2020-06-09 06:49:28', NULL, NULL, 1),
(75, 26, 'Rooms & Amenities', 200, '1584.24', 'System', '2020-06-09 06:52:58', NULL, NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `t_restaurants`
--

CREATE TABLE `t_restaurants` (
  `restaurant_id` int(11) NOT NULL,
  `restaurant_name` varchar(60) NOT NULL,
  `restaurant_detail` varchar(255) NOT NULL,
  `restaurant_mode` varchar(20) NOT NULL,
  `restaurant_rates` varchar(30) NOT NULL,
  `restaurant_max_loyalty_points` varchar(30) NOT NULL,
  `restaurant_open_time` time NOT NULL,
  `restaurant_close_time` time NOT NULL,
  `created_by` varchar(60) NOT NULL DEFAULT 'System',
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` varchar(60) DEFAULT NULL,
  `updated_on` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `rest_abbr` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `t_restaurants`
--

INSERT INTO `t_restaurants` (`restaurant_id`, `restaurant_name`, `restaurant_detail`, `restaurant_mode`, `restaurant_rates`, `restaurant_max_loyalty_points`, `restaurant_open_time`, `restaurant_close_time`, `created_by`, `created_on`, `updated_by`, `updated_on`, `is_active`, `rest_abbr`) VALUES
(1, 'Seven Kitchens', 'Treat your taste buds to a lavish spread of global cuisine with a delectable array of fine dining opportunities at Seven Kitchens. Top Dishes People Order\r\nSalad, Sushi, Pasta, Pizza, Waffles, Chaat, Panipuri', 'Both', '75', '100', '09:00:00', '24:00:00', 'System', '2020-05-18 21:43:40', NULL, '2020-05-30 11:08:43', 1, 'REST'),
(2, 'Bar Stock Exchange', 'The upbeat quality of the ambience that will make you forget the outside world. Top Dishes People Order Cocktails, Nachos, Long Island Iced Tea, Burgers, Fries, Chicken Wings, Beer', 'Both', '70', '50', '08:00:00', '23:00:00', 'System', '2020-05-18 21:51:07', NULL, '2020-05-30 11:08:47', 1, 'REST'),
(3, 'The Rooftop Cafe', 'Perfect venue for a alone time with your loved ones on the Rooftop.Top Dishes People Order Cocktails, Mocktails, Brownie, Butter Chicken, Cajun Chicken, Noodle, Salad.', 'Both', '60', '50', '07:00:00', '23:00:00', 'System', '2020-05-18 21:58:54', NULL, '2020-05-30 11:08:20', 1, 'REST');

-- --------------------------------------------------------

--
-- Table structure for table `t_restaurant_booking`
--

CREATE TABLE `t_restaurant_booking` (
  `rest_booking_ID` int(20) NOT NULL,
  `restaurant_id` int(20) NOT NULL,
  `restaurant_datetime` date NOT NULL,
  `rest_time` time NOT NULL,
  `restaurant_guests` int(10) NOT NULL,
  `created_by` varchar(60) NOT NULL DEFAULT 'System',
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` varchar(60) DEFAULT NULL,
  `updated_on` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `is_booked` tinyint(1) NOT NULL DEFAULT '1',
  `customer_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `t_restaurant_cuisine`
--

CREATE TABLE `t_restaurant_cuisine` (
  `cuisine_id` int(11) NOT NULL,
  `cuisine_type` varchar(20) NOT NULL,
  `created_by` varchar(20) NOT NULL DEFAULT 'System',
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` varchar(60) DEFAULT NULL,
  `updated_on` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `restaurant_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `t_restaurant_cuisine`
--

INSERT INTO `t_restaurant_cuisine` (`cuisine_id`, `cuisine_type`, `created_by`, `created_on`, `updated_by`, `updated_on`, `is_active`, `restaurant_id`) VALUES
(1, 'Italian', 'System', '2020-05-19 07:19:03', NULL, NULL, 1, 1),
(2, 'North Indian', 'System', '2020-05-19 07:19:03', NULL, NULL, 1, 1),
(3, 'Chinese', 'System', '2020-05-19 07:19:03', NULL, '2020-05-19 11:56:09', 1, 1),
(4, 'Continental', 'System', '2020-05-19 07:20:05', NULL, '2020-05-19 11:56:17', 1, 2),
(5, 'Bar Food', 'System', '2020-05-19 07:20:05', NULL, '2020-05-19 11:56:28', 1, 2),
(6, 'Mexican', 'System', '2020-05-19 07:20:40', NULL, '2020-05-19 11:56:35', 1, 3),
(7, 'Chinese', 'System', '2020-05-19 07:20:40', NULL, '2020-05-19 11:56:40', 1, 3);

-- --------------------------------------------------------

--
-- Table structure for table `t_rooms`
--

CREATE TABLE `t_rooms` (
  `room_id` int(11) NOT NULL,
  `room_type_id` int(11) NOT NULL,
  `room_num_floor_map_id` int(11) NOT NULL,
  `adult_children_capacity_map_id` int(11) NOT NULL,
  `created_by` varchar(20) NOT NULL DEFAULT 'System',
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` varchar(20) DEFAULT NULL,
  `updated_on` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `room_details_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `t_rooms`
--

INSERT INTO `t_rooms` (`room_id`, `room_type_id`, `room_num_floor_map_id`, `adult_children_capacity_map_id`, `created_by`, `created_on`, `updated_by`, `updated_on`, `is_active`, `room_details_id`) VALUES
(1, 1, 1, 1, 'Sysrem', '2020-05-26 07:53:40', NULL, '2020-06-04 11:01:02', 1, 1),
(2, 1, 2, 1, 'Sysrem', '2020-05-26 07:53:40', NULL, '2020-06-04 11:01:18', 1, 1),
(3, 1, 3, 1, 'Sysrem', '2020-05-26 07:54:16', NULL, '2020-06-04 11:01:22', 1, 1),
(4, 1, 4, 1, 'Sysrem', '2020-05-26 07:54:16', NULL, '2020-06-04 11:01:24', 1, 1),
(5, 1, 5, 1, 'System', '2020-05-26 07:59:12', NULL, '2020-06-04 11:01:27', 1, 1),
(6, 1, 6, 1, 'System', '2020-05-26 07:59:12', NULL, '2020-06-04 11:01:30', 1, 1),
(7, 1, 7, 1, 'System', '2020-05-26 07:59:12', NULL, '2020-06-04 11:01:34', 1, 1),
(8, 1, 8, 1, 'System', '2020-05-26 07:59:12', NULL, '2020-06-04 11:01:37', 1, 1),
(9, 1, 9, 1, 'System', '2020-05-26 07:59:12', NULL, '2020-06-04 11:01:40', 1, 1),
(10, 1, 10, 1, 'System', '2020-05-26 07:59:12', NULL, '2020-06-04 11:01:44', 1, 1),
(11, 2, 11, 2, 'System', '2020-05-26 07:59:12', NULL, '2020-06-04 11:01:52', 1, 2),
(12, 2, 12, 2, 'System', '2020-05-26 07:59:12', NULL, '2020-06-04 11:01:54', 1, 2),
(13, 2, 13, 2, 'System', '2020-05-26 07:59:12', NULL, '2020-06-04 11:01:57', 1, 2),
(14, 2, 14, 2, 'System', '2020-05-26 07:59:12', NULL, '2020-06-04 11:02:00', 1, 2),
(15, 2, 15, 2, 'System', '2020-05-26 07:59:12', NULL, '2020-06-04 11:02:03', 1, 2),
(16, 2, 16, 2, 'System', '2020-05-26 07:59:12', NULL, '2020-06-04 11:02:06', 1, 2),
(17, 2, 17, 2, 'System', '2020-05-26 07:59:12', NULL, '2020-06-04 11:02:09', 1, 2),
(18, 2, 18, 2, 'System', '2020-05-26 07:59:12', NULL, '2020-06-04 11:02:12', 1, 2),
(19, 2, 19, 2, 'System', '2020-05-26 07:59:12', NULL, '2020-06-04 11:02:15', 1, 2),
(20, 2, 20, 2, 'System', '2020-05-26 07:59:12', NULL, '2020-06-04 11:02:19', 1, 2),
(21, 3, 21, 3, 'System', '2020-05-26 07:59:12', NULL, '2020-06-04 11:02:25', 1, 3),
(22, 3, 22, 3, 'System', '2020-05-26 07:59:12', NULL, '2020-06-04 11:02:28', 1, 3),
(23, 3, 23, 3, 'System', '2020-05-26 07:59:12', NULL, '2020-06-04 11:02:33', 1, 3),
(24, 3, 24, 3, 'System', '2020-05-26 07:59:12', NULL, '2020-06-04 11:02:36', 1, 3),
(25, 3, 25, 3, 'System', '2020-05-26 07:59:12', NULL, '2020-06-04 11:02:39', 1, 3),
(26, 3, 26, 3, 'System', '2020-05-26 07:59:12', NULL, '2020-06-04 11:02:52', 1, 3),
(27, 3, 27, 3, 'System', '2020-05-26 07:59:12', NULL, '2020-06-04 11:02:56', 1, 3),
(28, 3, 28, 3, 'System', '2020-05-26 07:59:12', NULL, '2020-06-04 11:02:58', 1, 3),
(29, 3, 29, 3, 'System', '2020-05-26 07:59:12', NULL, '2020-06-04 11:03:01', 1, 3),
(30, 3, 30, 3, 'System', '2020-05-26 07:59:12', NULL, '2020-06-04 11:03:06', 1, 3),
(31, 4, 31, 4, 'System', '2020-05-26 07:59:12', NULL, '2020-06-04 11:03:12', 1, 4),
(32, 4, 32, 4, 'System', '2020-05-26 07:59:12', NULL, '2020-06-04 11:03:14', 1, 4),
(33, 4, 33, 4, 'System', '2020-05-26 07:59:12', NULL, '2020-06-04 11:03:18', 1, 4),
(34, 4, 34, 4, 'System', '2020-05-26 07:59:12', NULL, '2020-06-04 11:03:21', 1, 4),
(35, 4, 35, 4, 'System', '2020-05-26 07:59:12', NULL, '2020-06-04 11:03:24', 1, 4),
(36, 4, 36, 4, 'System', '2020-05-26 07:59:12', NULL, '2020-06-04 11:03:28', 1, 4),
(37, 4, 37, 4, 'System', '2020-05-26 07:59:12', NULL, '2020-06-04 11:03:31', 1, 4),
(38, 4, 38, 4, 'System', '2020-05-26 07:59:12', NULL, '2020-06-04 11:03:34', 1, 4),
(39, 4, 39, 4, 'System', '2020-05-26 07:59:12', NULL, '2020-06-04 11:03:37', 1, 4),
(40, 4, 40, 4, 'System', '2020-05-26 07:59:12', NULL, '2020-06-04 11:03:41', 1, 4);

-- --------------------------------------------------------

--
-- Table structure for table `t_room_adult_capacity`
--

CREATE TABLE `t_room_adult_capacity` (
  `adult_capacity_id` int(11) NOT NULL,
  `adult_capacity` int(11) NOT NULL,
  `created_by` varchar(20) NOT NULL DEFAULT 'System',
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` varchar(20) DEFAULT NULL,
  `updated_on` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `is_active` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `t_room_adult_capacity`
--

INSERT INTO `t_room_adult_capacity` (`adult_capacity_id`, `adult_capacity`, `created_by`, `created_on`, `updated_by`, `updated_on`, `is_active`) VALUES
(1, 2, 'System', '2020-05-26 12:06:44', NULL, NULL, 1),
(2, 3, 'System', '2020-05-26 12:06:44', NULL, NULL, 1),
(3, 4, 'System', '2020-05-26 12:06:53', NULL, NULL, 1),
(4, 5, 'System', '2020-05-26 12:06:53', NULL, NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `t_room_adult_children_capacity_mapping`
--

CREATE TABLE `t_room_adult_children_capacity_mapping` (
  `adult_children_capacity_map_id` int(11) NOT NULL,
  `adult_capacity_id` int(11) NOT NULL,
  `children_capacity_id` int(11) NOT NULL,
  `created_by` varchar(20) NOT NULL DEFAULT 'System',
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` varchar(20) DEFAULT NULL,
  `updated_on` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `is_active` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `t_room_adult_children_capacity_mapping`
--

INSERT INTO `t_room_adult_children_capacity_mapping` (`adult_children_capacity_map_id`, `adult_capacity_id`, `children_capacity_id`, `created_by`, `created_on`, `updated_by`, `updated_on`, `is_active`) VALUES
(1, 1, 1, 'System', '2020-05-26 13:20:29', NULL, NULL, 1),
(2, 2, 1, 'System', '2020-05-26 13:20:29', NULL, NULL, 1),
(3, 3, 2, 'System', '2020-05-26 13:20:55', NULL, NULL, 1),
(4, 4, 3, 'System', '2020-05-26 13:20:55', NULL, NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `t_room_booking`
--

CREATE TABLE `t_room_booking` (
  `room_booking_id` int(11) NOT NULL,
  `room_id` int(11) NOT NULL,
  `booked_by` int(11) NOT NULL,
  `adults` int(11) NOT NULL,
  `children` int(11) NOT NULL,
  `check_in` date NOT NULL,
  `check_out` date NOT NULL,
  `is_booked` tinyint(1) NOT NULL DEFAULT '1',
  `created_by` varchar(20) NOT NULL DEFAULT 'System',
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` varchar(20) DEFAULT NULL,
  `updated_on` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `total_rent` decimal(7,2) NOT NULL,
  `loyalty_points` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `t_room_booking`
--

INSERT INTO `t_room_booking` (`room_booking_id`, `room_id`, `booked_by`, `adults`, `children`, `check_in`, `check_out`, `is_booked`, `created_by`, `created_on`, `updated_by`, `updated_on`, `is_active`, `total_rent`, `loyalty_points`) VALUES
(1, 1, 26, 2, 2, '2020-06-25', '2020-06-30', 0, 'System', '2020-06-07 12:45:02', NULL, '2020-06-07 13:16:25', 1, '1820.00', 250),
(2, 11, 26, 3, 2, '2020-06-18', '2020-06-19', 0, 'System', '2020-06-07 12:45:34', NULL, '2020-06-07 13:10:40', 1, '500.00', 300),
(3, 21, 26, 4, 3, '2020-06-18', '2020-06-19', 0, 'System', '2020-06-07 13:08:00', NULL, '2020-06-07 13:10:40', 1, '750.00', 400),
(4, 1, 26, 2, 2, '2020-06-18', '2020-06-19', 0, 'System', '2020-06-07 13:43:14', NULL, '2020-06-07 17:13:22', 0, '350.00', 250),
(5, 12, 26, 3, 2, '2020-06-25', '2020-06-30', 0, 'System', '2020-06-07 13:43:51', NULL, '2020-06-07 13:58:15', 1, '2600.00', 300),
(6, 23, 26, 4, 3, '2020-06-29', '2020-06-30', 0, 'System', '2020-06-07 13:51:50', NULL, '2020-06-07 13:54:10', 1, '750.00', 400),
(7, 24, 26, 4, 3, '2020-06-18', '2020-06-19', 0, 'System', '2020-06-07 17:10:18', NULL, '2020-06-07 17:12:52', 1, '750.00', 400),
(8, 11, 26, 3, 2, '2020-06-25', '2020-06-30', 0, 'System', '2020-06-07 17:13:57', NULL, '2020-06-07 17:16:19', 1, '2600.00', 300),
(9, 2, 26, 2, 2, '2020-06-25', '2020-06-30', 0, 'System', '2020-06-09 06:25:43', NULL, '2020-06-09 06:52:58', 1, '1820.00', 250),
(10, 34, 26, 5, 5, '2020-06-18', '2020-06-19', 0, 'System', '2020-06-09 06:46:30', NULL, '2020-06-09 06:49:28', 1, '1000.00', 500);

-- --------------------------------------------------------

--
-- Table structure for table `t_room_children_capacity`
--

CREATE TABLE `t_room_children_capacity` (
  `children_capacity_id` int(11) NOT NULL,
  `children_capacity` int(11) NOT NULL,
  `created_by` varchar(20) NOT NULL DEFAULT 'System',
  `created_on` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` varchar(20) DEFAULT NULL,
  `updated_on` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `is_active` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `t_room_children_capacity`
--

INSERT INTO `t_room_children_capacity` (`children_capacity_id`, `children_capacity`, `created_by`, `created_on`, `updated_by`, `updated_on`, `is_active`) VALUES
(1, 2, 'System', '2020-05-26 17:37:38', NULL, NULL, 1),
(2, 3, 'System', '2020-05-26 17:37:38', NULL, NULL, 1),
(3, 5, 'System', '2020-05-26 17:37:47', NULL, NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `t_room_deals`
--

CREATE TABLE `t_room_deals` (
  `id` int(8) NOT NULL,
  `name` varchar(255) NOT NULL,
  `code` varchar(255) NOT NULL,
  `image` text NOT NULL,
  `price` int(10) NOT NULL,
  `created_by` varchar(20) NOT NULL DEFAULT 'System',
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` varchar(20) DEFAULT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `t_room_deals`
--

INSERT INTO `t_room_deals` (`id`, `name`, `code`, `image`, `price`, `created_by`, `created_on`, `updated_by`, `updated_on`, `is_active`) VALUES
(1, 'Deluxe\r\n', 'deluxe01', 'images/product-images/deluxe.jpg', 300, 'System', '2020-06-03 14:04:35', NULL, NULL, 1),
(2, 'Super Deluxe\r\n\r\n', 'super02', 'images/product-images/super.jpg', 500, 'System', '2020-06-03 14:04:35', NULL, NULL, 1),
(3, 'Premium\r\n\r\n', 'suite03', 'images/product-images/suite.jpg', 800, 'System', '2020-06-03 14:04:35', NULL, NULL, 1),
(4, 'Villa', 'villa45', 'images/product-images/villa.jpg', 1500, 'System', '2020-06-03 14:04:35', NULL, NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `t_room_details`
--

CREATE TABLE `t_room_details` (
  `room_id` int(11) NOT NULL,
  `room_details` varchar(255) NOT NULL,
  `room_preference` varchar(60) NOT NULL,
  `room_amenity_details` varchar(255) NOT NULL,
  `created_by` varchar(60) NOT NULL DEFAULT 'System',
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` varchar(60) DEFAULT NULL,
  `updated_on` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `room_image` text,
  `room_loyalty` int(30) DEFAULT NULL,
  `room_discount_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `t_room_details`
--

INSERT INTO `t_room_details` (`room_id`, `room_details`, `room_preference`, `room_amenity_details`, `created_by`, `created_on`, `updated_by`, `updated_on`, `is_active`, `room_image`, `room_loyalty`, `room_discount_id`) VALUES
(1, '45sqm/484sqft Air-conditioned Deluxe rooms on 5th floor of the Hotel. Room service is 24-Hour.\r\nBottled water is complimentary. Includes Mini-refrigerator Complimentary on-site parking and valet parking.', 'Smoking Allowed', 'Wireless Internet comes complimentary. We provide marble bathrooms. 32 inches TV for our guests with 1 landline phone. Bathroom includes Bathtub, oversized, Bathtub and shower separate, Lighted makeup mirror, Hair dryer, Robe, Slippers.', 'System', '2020-05-24 18:56:49', NULL, '2020-06-04 11:16:24', 1, 'images/rdeluxe.jpg', 250, 1),
(2, '50sqm/584sqft Air-conditioned Super Deluxe rooms on 6th floor of the Hotel. Room service is 24-Hour. Bottled water is complimentary. Includes Mini-refrigerator Complimentary on-site parking and valet parking.', 'Smoking Allowed', 'Along with other complimentary amenities, we also include Bathtub with spray jets, HD Tv 46 inches, with 2 landline phones. Balcony rooms available. High speed internet for free. Also includes designer toileteries and a safe.', 'System', '2020-05-24 18:56:49', NULL, '2020-06-04 11:16:27', 1, 'images/rsuperdeluxe.jpg', 300, 2),
(3, '60sqm/604sqft Air-conditioned Premium Deluxe rooms on 7th floor of the Hotel with an race course view. Room service is 24-Hour. Bottled water is complimentary. Includes Mini-refrigerator Complimentary on-site parking and valet parking.', 'Smoking Allowed', 'Extra amenities for 56 inches TV includes Cable/satellite, International cable/satellite,CNN, ESPN, and HBO. King sized bed, Desk, writing / work, with ergonomic chair, and electrical outlet. Complimentary pressing, 2 garments per night. ', 'System', '2020-05-24 18:56:49', NULL, '2020-06-04 11:16:30', 1, 'images/rsuite.jpg', 400, 3),
(4, '90sqm/904sqft Grand Villa with maximum occupancy of 5 on 8th floor of the hotel with a ocean view. Room service is 24-Hour. Bottled water is complimentary. Includes Mini-refrigerator Complimentary on-site parking and valet parking.', 'Smoking Allowed', 'This suite allowes you to have a private pool on the ground floor of the hotel. Plug-In High Tech room, Premium movie channels, iPod dock, Trouser press. Also comes with Complimentary Cocktails, Complimentary business services and Comp. Airport drop', 'System', '2020-05-24 18:56:49', NULL, '2020-06-04 11:16:33', 1, 'images/rvilla.jpg', 500, 4);

-- --------------------------------------------------------

--
-- Table structure for table `t_room_floors`
--

CREATE TABLE `t_room_floors` (
  `room_floor_id` int(11) NOT NULL,
  `room_floor` int(11) NOT NULL,
  `created_by` varchar(20) NOT NULL DEFAULT 'System',
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` varchar(20) DEFAULT NULL,
  `updated_on` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `is_active` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `t_room_floors`
--

INSERT INTO `t_room_floors` (`room_floor_id`, `room_floor`, `created_by`, `created_on`, `updated_by`, `updated_on`, `is_active`) VALUES
(1, 1, 'System', '2020-05-26 08:04:19', NULL, NULL, 1),
(2, 2, 'System', '2020-05-26 08:04:19', NULL, NULL, 1),
(3, 3, 'System', '2020-05-26 08:04:35', NULL, NULL, 1),
(4, 4, 'System', '2020-05-26 08:04:35', NULL, NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `t_room_number`
--

CREATE TABLE `t_room_number` (
  `room_number_id` int(11) NOT NULL,
  `room_number` int(11) NOT NULL,
  `created_by` varchar(20) NOT NULL DEFAULT 'System',
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` varchar(20) DEFAULT NULL,
  `updated_on` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `is_active` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `t_room_number`
--

INSERT INTO `t_room_number` (`room_number_id`, `room_number`, `created_by`, `created_on`, `updated_by`, `updated_on`, `is_active`) VALUES
(1, 101, 'System', '2020-05-26 08:09:39', NULL, NULL, 1),
(2, 102, 'System', '2020-05-26 08:09:39', NULL, NULL, 1),
(3, 103, 'System', '2020-05-26 08:14:25', NULL, NULL, 1),
(4, 104, 'System', '2020-05-26 08:14:25', NULL, NULL, 1),
(5, 105, 'System', '2020-05-26 08:14:25', NULL, NULL, 1),
(6, 106, 'System', '2020-05-26 08:14:25', NULL, NULL, 1),
(7, 107, 'System', '2020-05-26 08:14:25', NULL, NULL, 1),
(8, 108, 'System', '2020-05-26 08:14:25', NULL, NULL, 1),
(9, 109, 'System', '2020-05-26 08:14:25', NULL, NULL, 1),
(10, 110, 'System', '2020-05-26 08:14:25', NULL, NULL, 1),
(11, 201, 'System', '2020-05-26 08:14:25', NULL, NULL, 1),
(12, 202, 'System', '2020-05-26 08:14:25', NULL, NULL, 1),
(13, 203, 'System', '2020-05-26 08:14:25', NULL, NULL, 1),
(14, 204, 'System', '2020-05-26 08:14:25', NULL, NULL, 1),
(15, 205, 'System', '2020-05-26 08:14:25', NULL, NULL, 1),
(16, 206, 'System', '2020-05-26 08:14:25', NULL, NULL, 1),
(17, 207, 'System', '2020-05-26 08:14:25', NULL, NULL, 1),
(18, 208, 'System', '2020-05-26 08:14:25', NULL, NULL, 1),
(19, 209, 'System', '2020-05-26 08:14:25', NULL, NULL, 1),
(20, 210, 'System', '2020-05-26 08:14:25', NULL, NULL, 1),
(21, 301, 'System', '2020-05-26 08:14:25', NULL, NULL, 1),
(22, 302, 'System', '2020-05-26 08:14:25', NULL, NULL, 1),
(23, 303, 'System', '2020-05-26 08:14:25', NULL, NULL, 1),
(24, 304, 'System', '2020-05-26 08:14:25', NULL, NULL, 1),
(25, 305, 'System', '2020-05-26 08:14:25', NULL, NULL, 1),
(26, 306, 'System', '2020-05-26 08:14:25', NULL, NULL, 1),
(27, 307, 'System', '2020-05-26 08:14:25', NULL, NULL, 1),
(28, 308, 'System', '2020-05-26 08:14:25', NULL, NULL, 1),
(29, 309, 'System', '2020-05-26 08:14:25', NULL, NULL, 1),
(30, 310, 'System', '2020-05-26 08:14:25', NULL, NULL, 1),
(31, 401, 'System', '2020-05-26 08:14:25', NULL, NULL, 1),
(32, 402, 'System', '2020-05-26 08:14:25', NULL, NULL, 1),
(33, 403, 'System', '2020-05-26 08:14:25', NULL, NULL, 1),
(34, 404, 'System', '2020-05-26 08:14:25', NULL, NULL, 1),
(35, 405, 'System', '2020-05-26 08:14:25', NULL, NULL, 1),
(36, 406, 'System', '2020-05-26 08:14:25', NULL, NULL, 1),
(37, 407, 'System', '2020-05-26 08:14:25', NULL, NULL, 1),
(38, 408, 'System', '2020-05-26 08:14:25', NULL, NULL, 1),
(39, 409, 'System', '2020-05-26 08:14:25', NULL, NULL, 1),
(40, 410, 'System', '2020-05-26 08:14:25', NULL, NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `t_room_number_floor_mapping`
--

CREATE TABLE `t_room_number_floor_mapping` (
  `room_num_floor_map_id` int(11) NOT NULL,
  `room_floor_id` int(11) NOT NULL,
  `room_number_id` int(11) NOT NULL,
  `created_by` varchar(20) NOT NULL DEFAULT 'System',
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` varchar(20) DEFAULT NULL,
  `updated_on` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `is_active` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `t_room_number_floor_mapping`
--

INSERT INTO `t_room_number_floor_mapping` (`room_num_floor_map_id`, `room_floor_id`, `room_number_id`, `created_by`, `created_on`, `updated_by`, `updated_on`, `is_active`) VALUES
(1, 1, 1, 'System', '2020-05-26 08:28:03', NULL, NULL, 1),
(2, 1, 2, 'System', '2020-05-26 08:28:03', NULL, NULL, 1),
(3, 1, 3, 'System', '2020-05-26 08:28:39', NULL, NULL, 1),
(4, 1, 4, 'System', '2020-05-26 08:28:39', NULL, NULL, 1),
(5, 1, 5, 'System', '2020-05-26 11:47:05', NULL, NULL, 1),
(6, 1, 6, 'System', '2020-05-26 11:47:05', NULL, NULL, 1),
(7, 1, 7, 'System', '2020-05-26 11:49:50', NULL, NULL, 1),
(8, 1, 8, 'System', '2020-05-26 11:49:50', NULL, NULL, 1),
(9, 1, 9, 'System', '2020-05-26 11:49:50', NULL, NULL, 1),
(10, 1, 10, 'System', '2020-05-26 11:49:50', NULL, NULL, 1),
(11, 2, 11, 'System', '2020-05-26 11:49:50', NULL, '2020-05-27 15:41:03', 1),
(12, 2, 12, 'System', '2020-05-26 11:49:50', NULL, '2020-05-27 15:41:08', 1),
(13, 2, 13, 'System', '2020-05-26 11:49:50', NULL, '2020-05-27 15:41:12', 1),
(14, 2, 14, 'System', '2020-05-26 11:49:50', NULL, '2020-05-27 15:41:16', 1),
(15, 2, 15, 'System', '2020-05-26 11:49:50', NULL, '2020-05-27 15:41:21', 1),
(16, 2, 16, 'System', '2020-05-26 11:49:50', NULL, '2020-05-27 15:41:25', 1),
(17, 2, 17, 'System', '2020-05-26 11:49:50', NULL, '2020-05-27 15:41:29', 1),
(18, 2, 18, 'System', '2020-05-26 11:49:50', NULL, '2020-05-27 15:41:33', 1),
(19, 2, 19, 'System', '2020-05-26 11:49:50', NULL, '2020-05-27 15:41:38', 1),
(20, 2, 20, 'System', '2020-05-26 11:49:50', NULL, '2020-05-27 15:41:43', 1),
(21, 3, 21, 'System', '2020-05-26 11:49:50', NULL, '2020-05-27 15:41:47', 1),
(22, 3, 22, 'System', '2020-05-26 11:49:50', NULL, '2020-05-27 15:41:52', 1),
(23, 3, 23, 'System', '2020-05-26 11:49:50', NULL, '2020-05-27 15:41:56', 1),
(24, 3, 24, 'System', '2020-05-26 11:49:50', NULL, '2020-05-27 15:42:00', 1),
(25, 3, 25, 'System', '2020-05-26 11:49:50', NULL, '2020-05-27 15:42:05', 1),
(26, 3, 26, 'System', '2020-05-26 11:49:50', NULL, '2020-05-27 15:42:27', 1),
(27, 3, 27, 'System', '2020-05-26 11:49:50', NULL, '2020-05-27 15:42:31', 1),
(28, 3, 28, 'System', '2020-05-26 11:49:50', NULL, '2020-05-27 15:42:35', 1),
(29, 3, 29, 'System', '2020-05-26 11:49:50', NULL, '2020-05-27 15:42:40', 1),
(30, 3, 30, 'System', '2020-05-26 11:49:50', NULL, '2020-05-27 15:42:44', 1),
(31, 4, 31, 'System', '2020-05-26 11:49:50', NULL, '2020-05-27 15:42:48', 1),
(32, 4, 32, 'System', '2020-05-26 11:49:50', NULL, '2020-05-27 15:42:52', 1),
(33, 4, 33, 'System', '2020-05-26 11:49:50', NULL, '2020-05-27 15:42:56', 1),
(34, 4, 34, 'System', '2020-05-26 11:49:50', NULL, '2020-05-27 15:42:59', 1),
(35, 4, 35, 'System', '2020-05-26 11:49:50', NULL, '2020-05-27 15:43:03', 1),
(36, 4, 36, 'System', '2020-05-26 11:49:50', NULL, '2020-05-27 15:43:07', 1),
(37, 4, 37, 'System', '2020-05-26 11:49:50', NULL, '2020-05-27 15:43:12', 1),
(38, 4, 38, 'System', '2020-05-26 11:49:50', NULL, '2020-05-27 15:43:15', 1),
(39, 4, 39, 'System', '2020-05-26 11:49:50', NULL, '2020-05-27 15:43:20', 1),
(40, 4, 40, 'System', '2020-05-26 11:49:50', NULL, '2020-05-27 15:43:25', 1);

-- --------------------------------------------------------

--
-- Table structure for table `t_room_type`
--

CREATE TABLE `t_room_type` (
  `room_type_id` int(11) NOT NULL,
  `room_type` varchar(20) NOT NULL,
  `room_rent` decimal(7,2) NOT NULL,
  `created_by` varchar(20) NOT NULL DEFAULT 'System',
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` varchar(20) DEFAULT NULL,
  `updated_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `abbr` varchar(60) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `t_room_type`
--

INSERT INTO `t_room_type` (`room_type_id`, `room_type`, `room_rent`, `created_by`, `created_on`, `updated_by`, `updated_on`, `is_active`, `abbr`) VALUES
(1, 'Deluxe', '350.00', 'System', '2020-05-22 16:57:05', '2020-05-26 13:06:21', '2020-05-29 20:25:16', 1, 'RM'),
(2, 'Super Deluxe', '500.00', 'System', '2020-05-22 16:57:05', '2020-05-26 13:06:21', '2020-05-29 20:25:24', 1, 'RM'),
(3, 'Premium', '750.00', 'System', '2020-05-22 16:57:22', '2020-05-26 13:06:21', '2020-05-29 20:25:20', 1, 'RM'),
(4, 'Villa', '1000.00', 'System', '2020-05-22 16:57:22', '2020-05-26 13:06:21', '2020-05-29 20:25:27', 1, 'RM');

-- --------------------------------------------------------

--
-- Table structure for table `t_spaa`
--

CREATE TABLE `t_spaa` (
  `spa_id` int(11) NOT NULL,
  `spa_massage_type_id` int(11) NOT NULL,
  `spa_datetime` date NOT NULL,
  `spa_time` time NOT NULL,
  `is_booked` tinyint(1) NOT NULL DEFAULT '1',
  `cust_id` int(10) NOT NULL,
  `created_by` varchar(20) NOT NULL DEFAULT 'System',
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` varchar(20) DEFAULT NULL,
  `updated_on` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `is_active` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `t_spaa`
--

INSERT INTO `t_spaa` (`spa_id`, `spa_massage_type_id`, `spa_datetime`, `spa_time`, `is_booked`, `cust_id`, `created_by`, `created_on`, `updated_by`, `updated_on`, `is_active`) VALUES
(1, 1, '2020-06-26', '11:00:00', 0, 26, 'System', '2020-06-07 13:14:21', NULL, '2020-06-07 13:16:26', 1),
(2, 1, '2020-06-26', '11:00:00', 0, 26, 'System', '2020-06-07 13:56:43', NULL, '2020-06-07 13:58:15', 1),
(3, 1, '2020-06-26', '18:00:00', 0, 26, 'System', '2020-06-07 17:15:08', NULL, '2020-06-07 17:16:19', 1),
(4, 2, '2020-06-26', '18:00:00', 0, 26, 'System', '2020-06-09 06:51:42', NULL, '2020-06-09 06:52:58', 1);

-- --------------------------------------------------------

--
-- Table structure for table `t_spa_massage_type`
--

CREATE TABLE `t_spa_massage_type` (
  `spa_massage_type_id` int(11) NOT NULL,
  `spa_massage_type` varchar(40) NOT NULL,
  `spa_rate` decimal(7,2) NOT NULL,
  `created_by` varchar(20) NOT NULL DEFAULT 'System',
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` varchar(20) DEFAULT NULL,
  `updated_on` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `abbr` varchar(60) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `t_spa_massage_type`
--

INSERT INTO `t_spa_massage_type` (`spa_massage_type_id`, `spa_massage_type`, `spa_rate`, `created_by`, `created_on`, `updated_by`, `updated_on`, `is_active`, `abbr`) VALUES
(1, 'Deep Tissue Massage', '75.00', 'System', '2020-05-29 19:21:40', '2020-05-06 11:19:07', '2020-05-30 05:49:19', 1, 'SPA'),
(2, 'Healing Hot Stone Massage', '66.00', 'System', '2020-05-29 19:21:40', '2020-05-06 11:19:07', '2020-05-30 05:49:22', 1, 'SPA'),
(3, 'Soothing Foot Therapy', '54.00', 'System', '2020-05-29 19:22:05', '2020-05-06 11:19:07', '2020-05-30 05:49:25', 1, 'SPA'),
(4, 'Aroma Massage Therapy', '90.00', 'System', '2020-05-29 19:22:05', '2020-05-06 11:19:07', '2020-05-30 05:49:28', 1, 'SPA');

-- --------------------------------------------------------

--
-- Table structure for table `t_support_online_form`
--

CREATE TABLE `t_support_online_form` (
  `support_form_id` int(30) NOT NULL,
  `cust_fname` varchar(20) NOT NULL,
  `cust_lname` varchar(20) NOT NULL,
  `cust_email` varchar(30) NOT NULL,
  `cust_number` varchar(30) NOT NULL,
  `cust_queries` varchar(30) NOT NULL,
  `created_by` varchar(60) NOT NULL DEFAULT 'System',
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` varchar(60) DEFAULT NULL,
  `updated_on` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `is_active` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `t_support_online_form`
--

INSERT INTO `t_support_online_form` (`support_form_id`, `cust_fname`, `cust_lname`, `cust_email`, `cust_number`, `cust_queries`, `created_by`, `created_on`, `updated_by`, `updated_on`, `is_active`) VALUES
(32, 'omggggggggg', 'wtfff', 'me.sayli19@gmail.com', '9178654635', 'yayyyyyy', 'System', '2020-05-18 07:20:56', NULL, NULL, 1),
(33, 'sayli', 'pednekar', 'sayli12@gaga.com', '9167453425', 'hello let me knw you r room de', 'System', '2020-05-18 07:46:47', NULL, NULL, 1),
(34, '76778768', '321', 'me.sayli19@gmail.com', '9178654635', '213', 'System', '2020-05-18 07:52:51', NULL, NULL, 1),
(35, '12321', 'qw', 'me.sayli19@gmail.com', '9178654635', 'qw', 'System', '2020-05-18 07:53:14', NULL, NULL, 1),
(36, 'QQ', 'asd', 'freelibrary.org@h', '9178654635', 'SW', 'System', '2020-05-18 08:00:52', NULL, NULL, 1),
(37, 'aa', 'pednekar', 'freelibrary.org@h', 'd', 'da', 'System', '2020-05-18 08:01:10', NULL, NULL, 1),
(38, 'sS', 'ss', 'freelibrary.org@h', '9178654635', 'sS', 'System', '2020-05-18 08:03:33', NULL, NULL, 1),
(39, 'sayli', 'pednekar', 'me.sayli19@gmail.com', '917865463', 'kjh;k', 'System', '2020-05-18 08:07:12', NULL, NULL, 1),
(40, 'ds', 'ddw', 'saylipednekar19@gmail.com', '343434', 'sas', 'System', '2020-05-18 08:39:46', NULL, NULL, 1);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_get_booked_banquets_admin`
-- (See below for the actual view)
--
CREATE TABLE `v_get_booked_banquets_admin` (
`cust_id` int(11)
,`banquet_booking_id` int(11)
,`cust_fname` varchar(20)
,`cust_lname` varchar(30)
,`banquet_name` varchar(40)
,`banquet_capacity` int(11)
,`banquet_capacity_price` decimal(10,0)
,`booking_date` date
,`booking_time_from` time
,`booking_time_to` time
,`created_on` timestamp
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_get_booked_rest_admin`
-- (See below for the actual view)
--
CREATE TABLE `v_get_booked_rest_admin` (
`rest_booking_ID` int(20)
,`cust_id` int(11)
,`cust_fname` varchar(20)
,`cust_lname` varchar(30)
,`restaurant_name` varchar(60)
,`restaurant_guests` int(10)
,`restaurant_datetime` date
,`rest_time` time
,`created_on` timestamp
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_get_booked_rooms_admin`
-- (See below for the actual view)
--
CREATE TABLE `v_get_booked_rooms_admin` (
`room_booking_id` int(11)
,`room_id` int(11)
,`room_type_id` int(11)
,`cust_id` int(11)
,`cust_fname` varchar(20)
,`cust_lname` varchar(30)
,`room_type` varchar(20)
,`adults` int(11)
,`children` int(11)
,`check_in` date
,`check_out` date
,`total_rent` decimal(7,2)
,`room_rent` decimal(7,2)
,`room_floor` int(11)
,`room_number` int(11)
,`cust_loyalty_points` int(11)
,`created_on` timestamp
);

-- --------------------------------------------------------

--
-- Structure for view `v_get_booked_banquets_admin`
--
DROP TABLE IF EXISTS `v_get_booked_banquets_admin`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_get_booked_banquets_admin`  AS  select `pd`.`cust_id` AS `cust_id`,`bb`.`banquet_booking_id` AS `banquet_booking_id`,`pd`.`cust_fname` AS `cust_fname`,`pd`.`cust_lname` AS `cust_lname`,`b`.`banquet_name` AS `banquet_name`,`bcp`.`banquet_capacity` AS `banquet_capacity`,`bcp`.`banquet_capacity_price` AS `banquet_capacity_price`,`bb`.`booking_date` AS `booking_date`,`bb`.`booking_time_from` AS `booking_time_from`,`bb`.`booking_time_to` AS `booking_time_to`,`bb`.`created_on` AS `created_on` from (((`t_customer_personal_data` `pd` join `t_banquet_booking` `bb` on((`bb`.`booked_by` = `pd`.`cust_id`))) join `t_banquet_capacity_price` `bcp` on((`bcp`.`banquet_capacity_price_id` = `bb`.`banquet_capacity_price_id`))) join `t_banquets` `b` on((`bb`.`banquet_id` = `b`.`banquet_id`))) where ((`bb`.`is_booked` = 1) and (`pd`.`is_active` = 1) and (`bb`.`is_active` = 1) and (`b`.`is_active` = 1) and (`bcp`.`is_active` = 1) and (`bb`.`booked_by` = `pd`.`cust_id`)) group by `bb`.`created_on` order by `bb`.`created_on` desc ;

-- --------------------------------------------------------

--
-- Structure for view `v_get_booked_rest_admin`
--
DROP TABLE IF EXISTS `v_get_booked_rest_admin`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_get_booked_rest_admin`  AS  select `t_restaurant_booking`.`rest_booking_ID` AS `rest_booking_ID`,`t_customer_personal_data`.`cust_id` AS `cust_id`,`t_customer_personal_data`.`cust_fname` AS `cust_fname`,`t_customer_personal_data`.`cust_lname` AS `cust_lname`,`t_restaurants`.`restaurant_name` AS `restaurant_name`,`t_restaurant_booking`.`restaurant_guests` AS `restaurant_guests`,`t_restaurant_booking`.`restaurant_datetime` AS `restaurant_datetime`,`t_restaurant_booking`.`rest_time` AS `rest_time`,`t_restaurant_booking`.`created_on` AS `created_on` from (((`t_customer_personal_data` join `t_customer_login` on((`t_customer_personal_data`.`cust_id` = `t_customer_login`.`cust_id`))) join `t_restaurant_booking` on((`t_restaurant_booking`.`customer_id` = `t_customer_login`.`cust_id`))) join `t_restaurants` on((`t_restaurant_booking`.`restaurant_id` = `t_restaurants`.`restaurant_id`))) where (`t_restaurant_booking`.`is_booked` = 1) group by `t_restaurant_booking`.`created_on` order by `t_restaurant_booking`.`created_on` desc ;

-- --------------------------------------------------------

--
-- Structure for view `v_get_booked_rooms_admin`
--
DROP TABLE IF EXISTS `v_get_booked_rooms_admin`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_get_booked_rooms_admin`  AS  select `t_room_booking`.`room_booking_id` AS `room_booking_id`,`t_rooms`.`room_id` AS `room_id`,`t_room_type`.`room_type_id` AS `room_type_id`,`t_customer_personal_data`.`cust_id` AS `cust_id`,`t_customer_personal_data`.`cust_fname` AS `cust_fname`,`t_customer_personal_data`.`cust_lname` AS `cust_lname`,`t_room_type`.`room_type` AS `room_type`,`t_room_booking`.`adults` AS `adults`,`t_room_booking`.`children` AS `children`,`t_room_booking`.`check_in` AS `check_in`,`t_room_booking`.`check_out` AS `check_out`,`t_room_booking`.`total_rent` AS `total_rent`,`t_room_type`.`room_rent` AS `room_rent`,`rf`.`room_floor` AS `room_floor`,`rn`.`room_number` AS `room_number`,`cl`.`cust_loyalty_points` AS `cust_loyalty_points`,`t_room_booking`.`created_on` AS `created_on` from (((((((`t_customer_personal_data` join `t_customer_loyalty_points` `cl` on((`t_customer_personal_data`.`cust_id` = `cl`.`cust_id`))) join `t_room_booking` on((`t_customer_personal_data`.`cust_id` = `t_room_booking`.`booked_by`))) join `t_rooms` on((`t_rooms`.`room_id` = `t_room_booking`.`room_id`))) join `t_room_type` on((`t_room_type`.`room_type_id` = `t_rooms`.`room_type_id`))) join `t_room_number_floor_mapping` `rnfm` on((`t_rooms`.`room_num_floor_map_id` = `rnfm`.`room_num_floor_map_id`))) join `t_room_floors` `rf` on((`rf`.`room_floor_id` = `rnfm`.`room_floor_id`))) join `t_room_number` `rn` on((`rn`.`room_number_id` = `rnfm`.`room_number_id`))) where ((`t_room_booking`.`is_booked` = 1) and (`t_room_booking`.`is_active` = 1)) group by `t_room_booking`.`created_on` order by `t_room_booking`.`created_on` desc ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `login`
--
ALTER TABLE `login`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `t_banquets`
--
ALTER TABLE `t_banquets`
  ADD PRIMARY KEY (`banquet_id`);

--
-- Indexes for table `t_banquet_booking`
--
ALTER TABLE `t_banquet_booking`
  ADD PRIMARY KEY (`banquet_booking_id`),
  ADD KEY `t_booked_by_kf` (`booked_by`),
  ADD KEY `t_banquet_menu_type_id_fk` (`banquet_menu_type_id`),
  ADD KEY `t_banquet_id_fk` (`banquet_id`),
  ADD KEY `t_banquet_capacity_price_id_fk` (`banquet_capacity_price_id`);

--
-- Indexes for table `t_banquet_capacity_price`
--
ALTER TABLE `t_banquet_capacity_price`
  ADD PRIMARY KEY (`banquet_capacity_price_id`);

--
-- Indexes for table `t_banquet_menu_type`
--
ALTER TABLE `t_banquet_menu_type`
  ADD PRIMARY KEY (`banquet_menu_type_id`);

--
-- Indexes for table `t_conference`
--
ALTER TABLE `t_conference`
  ADD PRIMARY KEY (`conference_id`),
  ADD KEY `t_conf_type_id_fk` (`conf_type_id`),
  ADD KEY `t_conf_guest_id_fk` (`conf_guest_id`),
  ADD KEY `t_cust_id_fk` (`cust_id`);

--
-- Indexes for table `t_conference_list`
--
ALTER TABLE `t_conference_list`
  ADD PRIMARY KEY (`conf_type_id`);

--
-- Indexes for table `t_conf_guest`
--
ALTER TABLE `t_conf_guest`
  ADD PRIMARY KEY (`conf_guest_id`);

--
-- Indexes for table `t_customer_address`
--
ALTER TABLE `t_customer_address`
  ADD PRIMARY KEY (`cust_address_id`),
  ADD KEY `t_cust_id_address_fk` (`cust_id`);

--
-- Indexes for table `t_customer_card_details`
--
ALTER TABLE `t_customer_card_details`
  ADD PRIMARY KEY (`cc_ID`),
  ADD KEY `t_invoice_id_fk` (`invoice_id`);

--
-- Indexes for table `t_customer_deals`
--
ALTER TABLE `t_customer_deals`
  ADD PRIMARY KEY (`deal_id`),
  ADD KEY `t_discount_id_fk` (`discount_id`);

--
-- Indexes for table `t_customer_identity_data`
--
ALTER TABLE `t_customer_identity_data`
  ADD PRIMARY KEY (`customer_identity_id`),
  ADD KEY `t_cust_identity_fk` (`cust_id`);

--
-- Indexes for table `t_customer_login`
--
ALTER TABLE `t_customer_login`
  ADD PRIMARY KEY (`login_ID`),
  ADD KEY `t_cust_login_fk` (`cust_id`);

--
-- Indexes for table `t_customer_loyalty_points`
--
ALTER TABLE `t_customer_loyalty_points`
  ADD PRIMARY KEY (`cust_loyalty_points_id`),
  ADD KEY `t_cust_id_fk5` (`cust_id`);

--
-- Indexes for table `t_customer_personal_data`
--
ALTER TABLE `t_customer_personal_data`
  ADD PRIMARY KEY (`cust_id`);

--
-- Indexes for table `t_department`
--
ALTER TABLE `t_department`
  ADD PRIMARY KEY (`department_id`);

--
-- Indexes for table `t_discount_coupon`
--
ALTER TABLE `t_discount_coupon`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `t_employee_address`
--
ALTER TABLE `t_employee_address`
  ADD PRIMARY KEY (`employee_address_id`),
  ADD KEY `t_emp_id_fk1` (`emp_id`);

--
-- Indexes for table `t_employee_bank_details`
--
ALTER TABLE `t_employee_bank_details`
  ADD PRIMARY KEY (`emp_bank_id`),
  ADD KEY `t_emp_id_fk2` (`emp_id`);

--
-- Indexes for table `t_employee_department_role_mapping`
--
ALTER TABLE `t_employee_department_role_mapping`
  ADD PRIMARY KEY (`emp_dept_desg_map_id`),
  ADD KEY `t_emp_id_fk3` (`emp_id`),
  ADD KEY `t_dept_id_fk` (`department_id`),
  ADD KEY `t_emp_role_id_fk` (`role_id`);

--
-- Indexes for table `t_employee_identity_data`
--
ALTER TABLE `t_employee_identity_data`
  ADD PRIMARY KEY (`employee_identity_id`),
  ADD KEY `t_emp_id_fk4` (`emp_id`);

--
-- Indexes for table `t_employee_login`
--
ALTER TABLE `t_employee_login`
  ADD PRIMARY KEY (`login_id`),
  ADD KEY `t_emp_id_fk5` (`emp_id`);

--
-- Indexes for table `t_employee_personal_data`
--
ALTER TABLE `t_employee_personal_data`
  ADD PRIMARY KEY (`emp_id`);

--
-- Indexes for table `t_employee_role`
--
ALTER TABLE `t_employee_role`
  ADD PRIMARY KEY (`employee_role_id`);

--
-- Indexes for table `t_invoice`
--
ALTER TABLE `t_invoice`
  ADD PRIMARY KEY (`invoice_id`),
  ADD KEY `t_cust_id_fk1` (`cust_id`);

--
-- Indexes for table `t_restaurants`
--
ALTER TABLE `t_restaurants`
  ADD PRIMARY KEY (`restaurant_id`);

--
-- Indexes for table `t_restaurant_booking`
--
ALTER TABLE `t_restaurant_booking`
  ADD PRIMARY KEY (`rest_booking_ID`),
  ADD KEY `t_restaurant_booking_fk` (`restaurant_id`),
  ADD KEY `t_cust_id_fk2` (`customer_id`);

--
-- Indexes for table `t_restaurant_cuisine`
--
ALTER TABLE `t_restaurant_cuisine`
  ADD PRIMARY KEY (`cuisine_id`),
  ADD KEY `restaurant_id` (`restaurant_id`);

--
-- Indexes for table `t_rooms`
--
ALTER TABLE `t_rooms`
  ADD PRIMARY KEY (`room_id`),
  ADD KEY `t_room_details_id_fk` (`room_details_id`),
  ADD KEY `t_room_type_id_fk` (`room_type_id`),
  ADD KEY `t_room_num_floor_map_id_fk` (`room_num_floor_map_id`),
  ADD KEY `t_adult_children_capacity_map_id_fk` (`adult_children_capacity_map_id`);

--
-- Indexes for table `t_room_adult_capacity`
--
ALTER TABLE `t_room_adult_capacity`
  ADD PRIMARY KEY (`adult_capacity_id`);

--
-- Indexes for table `t_room_adult_children_capacity_mapping`
--
ALTER TABLE `t_room_adult_children_capacity_mapping`
  ADD PRIMARY KEY (`adult_children_capacity_map_id`),
  ADD KEY `t_children_capacity_id_fk` (`children_capacity_id`),
  ADD KEY `t_adult_capacity_id_fk` (`adult_capacity_id`);

--
-- Indexes for table `t_room_booking`
--
ALTER TABLE `t_room_booking`
  ADD PRIMARY KEY (`room_booking_id`),
  ADD KEY `t_room_id` (`room_id`),
  ADD KEY `t_booked_by_fk1` (`booked_by`);

--
-- Indexes for table `t_room_children_capacity`
--
ALTER TABLE `t_room_children_capacity`
  ADD PRIMARY KEY (`children_capacity_id`);

--
-- Indexes for table `t_room_deals`
--
ALTER TABLE `t_room_deals`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `t_room_details`
--
ALTER TABLE `t_room_details`
  ADD PRIMARY KEY (`room_id`),
  ADD KEY `t_room_discount_id_fk` (`room_discount_id`);

--
-- Indexes for table `t_room_floors`
--
ALTER TABLE `t_room_floors`
  ADD PRIMARY KEY (`room_floor_id`);

--
-- Indexes for table `t_room_number`
--
ALTER TABLE `t_room_number`
  ADD PRIMARY KEY (`room_number_id`);

--
-- Indexes for table `t_room_number_floor_mapping`
--
ALTER TABLE `t_room_number_floor_mapping`
  ADD PRIMARY KEY (`room_num_floor_map_id`),
  ADD KEY `t_room_floor_id_fk` (`room_floor_id`),
  ADD KEY `t_room_number_id_fk` (`room_number_id`);

--
-- Indexes for table `t_room_type`
--
ALTER TABLE `t_room_type`
  ADD PRIMARY KEY (`room_type_id`);

--
-- Indexes for table `t_spaa`
--
ALTER TABLE `t_spaa`
  ADD PRIMARY KEY (`spa_id`),
  ADD KEY `t_spa_massage_type_id_fk` (`spa_massage_type_id`),
  ADD KEY `t_cust_id_fk4` (`cust_id`);

--
-- Indexes for table `t_spa_massage_type`
--
ALTER TABLE `t_spa_massage_type`
  ADD PRIMARY KEY (`spa_massage_type_id`);

--
-- Indexes for table `t_support_online_form`
--
ALTER TABLE `t_support_online_form`
  ADD PRIMARY KEY (`support_form_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `login`
--
ALTER TABLE `login`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `t_banquets`
--
ALTER TABLE `t_banquets`
  MODIFY `banquet_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `t_banquet_booking`
--
ALTER TABLE `t_banquet_booking`
  MODIFY `banquet_booking_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `t_banquet_capacity_price`
--
ALTER TABLE `t_banquet_capacity_price`
  MODIFY `banquet_capacity_price_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `t_banquet_menu_type`
--
ALTER TABLE `t_banquet_menu_type`
  MODIFY `banquet_menu_type_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `t_conference`
--
ALTER TABLE `t_conference`
  MODIFY `conference_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `t_conference_list`
--
ALTER TABLE `t_conference_list`
  MODIFY `conf_type_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `t_conf_guest`
--
ALTER TABLE `t_conf_guest`
  MODIFY `conf_guest_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `t_customer_address`
--
ALTER TABLE `t_customer_address`
  MODIFY `cust_address_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `t_customer_card_details`
--
ALTER TABLE `t_customer_card_details`
  MODIFY `cc_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `t_customer_deals`
--
ALTER TABLE `t_customer_deals`
  MODIFY `deal_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `t_customer_identity_data`
--
ALTER TABLE `t_customer_identity_data`
  MODIFY `customer_identity_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `t_customer_login`
--
ALTER TABLE `t_customer_login`
  MODIFY `login_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `t_customer_loyalty_points`
--
ALTER TABLE `t_customer_loyalty_points`
  MODIFY `cust_loyalty_points_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `t_customer_personal_data`
--
ALTER TABLE `t_customer_personal_data`
  MODIFY `cust_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `t_department`
--
ALTER TABLE `t_department`
  MODIFY `department_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `t_discount_coupon`
--
ALTER TABLE `t_discount_coupon`
  MODIFY `id` int(8) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `t_employee_address`
--
ALTER TABLE `t_employee_address`
  MODIFY `employee_address_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `t_employee_bank_details`
--
ALTER TABLE `t_employee_bank_details`
  MODIFY `emp_bank_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `t_employee_department_role_mapping`
--
ALTER TABLE `t_employee_department_role_mapping`
  MODIFY `emp_dept_desg_map_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `t_employee_identity_data`
--
ALTER TABLE `t_employee_identity_data`
  MODIFY `employee_identity_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `t_employee_login`
--
ALTER TABLE `t_employee_login`
  MODIFY `login_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `t_employee_personal_data`
--
ALTER TABLE `t_employee_personal_data`
  MODIFY `emp_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `t_employee_role`
--
ALTER TABLE `t_employee_role`
  MODIFY `employee_role_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `t_invoice`
--
ALTER TABLE `t_invoice`
  MODIFY `invoice_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=76;

--
-- AUTO_INCREMENT for table `t_restaurants`
--
ALTER TABLE `t_restaurants`
  MODIFY `restaurant_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `t_restaurant_booking`
--
ALTER TABLE `t_restaurant_booking`
  MODIFY `rest_booking_ID` int(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `t_restaurant_cuisine`
--
ALTER TABLE `t_restaurant_cuisine`
  MODIFY `cuisine_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `t_rooms`
--
ALTER TABLE `t_rooms`
  MODIFY `room_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `t_room_adult_capacity`
--
ALTER TABLE `t_room_adult_capacity`
  MODIFY `adult_capacity_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `t_room_adult_children_capacity_mapping`
--
ALTER TABLE `t_room_adult_children_capacity_mapping`
  MODIFY `adult_children_capacity_map_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `t_room_booking`
--
ALTER TABLE `t_room_booking`
  MODIFY `room_booking_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `t_room_children_capacity`
--
ALTER TABLE `t_room_children_capacity`
  MODIFY `children_capacity_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `t_room_deals`
--
ALTER TABLE `t_room_deals`
  MODIFY `id` int(8) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `t_room_details`
--
ALTER TABLE `t_room_details`
  MODIFY `room_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `t_room_floors`
--
ALTER TABLE `t_room_floors`
  MODIFY `room_floor_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `t_room_number`
--
ALTER TABLE `t_room_number`
  MODIFY `room_number_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `t_room_number_floor_mapping`
--
ALTER TABLE `t_room_number_floor_mapping`
  MODIFY `room_num_floor_map_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `t_room_type`
--
ALTER TABLE `t_room_type`
  MODIFY `room_type_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `t_spaa`
--
ALTER TABLE `t_spaa`
  MODIFY `spa_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `t_spa_massage_type`
--
ALTER TABLE `t_spa_massage_type`
  MODIFY `spa_massage_type_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `t_support_online_form`
--
ALTER TABLE `t_support_online_form`
  MODIFY `support_form_id` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `t_banquet_booking`
--
ALTER TABLE `t_banquet_booking`
  ADD CONSTRAINT `t_banquet_capacity_price_id_fk` FOREIGN KEY (`banquet_capacity_price_id`) REFERENCES `t_banquet_capacity_price` (`banquet_capacity_price_id`),
  ADD CONSTRAINT `t_banquet_id_fk` FOREIGN KEY (`banquet_id`) REFERENCES `t_banquets` (`banquet_id`),
  ADD CONSTRAINT `t_banquet_menu_type_id_fk` FOREIGN KEY (`banquet_menu_type_id`) REFERENCES `t_banquet_menu_type` (`banquet_menu_type_id`),
  ADD CONSTRAINT `t_booked_by_kf` FOREIGN KEY (`booked_by`) REFERENCES `t_customer_personal_data` (`cust_id`);

--
-- Constraints for table `t_conference`
--
ALTER TABLE `t_conference`
  ADD CONSTRAINT `t_conf_guest_id_fk` FOREIGN KEY (`conf_guest_id`) REFERENCES `t_conf_guest` (`conf_guest_id`),
  ADD CONSTRAINT `t_conf_type_id_fk` FOREIGN KEY (`conf_type_id`) REFERENCES `t_conference_list` (`conf_type_id`),
  ADD CONSTRAINT `t_cust_id_fk` FOREIGN KEY (`cust_id`) REFERENCES `t_customer_personal_data` (`cust_id`);

--
-- Constraints for table `t_customer_address`
--
ALTER TABLE `t_customer_address`
  ADD CONSTRAINT `t_cust_id_address_fk` FOREIGN KEY (`cust_id`) REFERENCES `t_customer_personal_data` (`cust_id`);

--
-- Constraints for table `t_customer_card_details`
--
ALTER TABLE `t_customer_card_details`
  ADD CONSTRAINT `t_invoice_id_fk` FOREIGN KEY (`invoice_id`) REFERENCES `t_invoice` (`invoice_id`);

--
-- Constraints for table `t_customer_deals`
--
ALTER TABLE `t_customer_deals`
  ADD CONSTRAINT `t_discount_id_fk` FOREIGN KEY (`discount_id`) REFERENCES `t_discount_coupon` (`id`);

--
-- Constraints for table `t_customer_identity_data`
--
ALTER TABLE `t_customer_identity_data`
  ADD CONSTRAINT `t_cust_identity_fk` FOREIGN KEY (`cust_id`) REFERENCES `t_customer_personal_data` (`cust_id`);

--
-- Constraints for table `t_customer_login`
--
ALTER TABLE `t_customer_login`
  ADD CONSTRAINT `t_cust_login_fk` FOREIGN KEY (`cust_id`) REFERENCES `t_customer_personal_data` (`cust_id`);

--
-- Constraints for table `t_customer_loyalty_points`
--
ALTER TABLE `t_customer_loyalty_points`
  ADD CONSTRAINT `t_cust_id_fk5` FOREIGN KEY (`cust_id`) REFERENCES `t_customer_personal_data` (`cust_id`);

--
-- Constraints for table `t_employee_address`
--
ALTER TABLE `t_employee_address`
  ADD CONSTRAINT `t_emp_id_fk1` FOREIGN KEY (`emp_id`) REFERENCES `t_employee_personal_data` (`emp_id`);

--
-- Constraints for table `t_employee_bank_details`
--
ALTER TABLE `t_employee_bank_details`
  ADD CONSTRAINT `t_emp_id_fk2` FOREIGN KEY (`emp_id`) REFERENCES `t_employee_personal_data` (`emp_id`);

--
-- Constraints for table `t_employee_department_role_mapping`
--
ALTER TABLE `t_employee_department_role_mapping`
  ADD CONSTRAINT `t_dept_id_fk` FOREIGN KEY (`department_id`) REFERENCES `t_department` (`department_id`),
  ADD CONSTRAINT `t_emp_id_fk3` FOREIGN KEY (`emp_id`) REFERENCES `t_employee_personal_data` (`emp_id`),
  ADD CONSTRAINT `t_emp_role_id_fk` FOREIGN KEY (`role_id`) REFERENCES `t_employee_role` (`employee_role_id`);

--
-- Constraints for table `t_employee_identity_data`
--
ALTER TABLE `t_employee_identity_data`
  ADD CONSTRAINT `t_emp_id_fk4` FOREIGN KEY (`emp_id`) REFERENCES `t_employee_personal_data` (`emp_id`);

--
-- Constraints for table `t_employee_login`
--
ALTER TABLE `t_employee_login`
  ADD CONSTRAINT `t_emp_id_fk5` FOREIGN KEY (`emp_id`) REFERENCES `t_employee_personal_data` (`emp_id`);

--
-- Constraints for table `t_invoice`
--
ALTER TABLE `t_invoice`
  ADD CONSTRAINT `t_cust_id_fk1` FOREIGN KEY (`cust_id`) REFERENCES `t_customer_personal_data` (`cust_id`);

--
-- Constraints for table `t_restaurant_booking`
--
ALTER TABLE `t_restaurant_booking`
  ADD CONSTRAINT `t_cust_id_fk2` FOREIGN KEY (`customer_id`) REFERENCES `t_customer_personal_data` (`cust_id`),
  ADD CONSTRAINT `t_restaurant_booking_fk` FOREIGN KEY (`restaurant_id`) REFERENCES `t_restaurants` (`restaurant_id`);

--
-- Constraints for table `t_restaurant_cuisine`
--
ALTER TABLE `t_restaurant_cuisine`
  ADD CONSTRAINT `t_restaurant_cuisine_ibfk_1` FOREIGN KEY (`restaurant_id`) REFERENCES `t_restaurants` (`restaurant_id`);

--
-- Constraints for table `t_rooms`
--
ALTER TABLE `t_rooms`
  ADD CONSTRAINT `t_adult_children_capacity_map_id_fk` FOREIGN KEY (`adult_children_capacity_map_id`) REFERENCES `t_room_adult_children_capacity_mapping` (`adult_children_capacity_map_id`),
  ADD CONSTRAINT `t_room_details_id_fk` FOREIGN KEY (`room_details_id`) REFERENCES `t_room_details` (`room_id`),
  ADD CONSTRAINT `t_room_num_floor_map_id_fk` FOREIGN KEY (`room_num_floor_map_id`) REFERENCES `t_room_number_floor_mapping` (`room_num_floor_map_id`),
  ADD CONSTRAINT `t_room_type_id_fk` FOREIGN KEY (`room_type_id`) REFERENCES `t_room_type` (`room_type_id`);

--
-- Constraints for table `t_room_adult_children_capacity_mapping`
--
ALTER TABLE `t_room_adult_children_capacity_mapping`
  ADD CONSTRAINT `t_adult_capacity_id_fk` FOREIGN KEY (`adult_capacity_id`) REFERENCES `t_room_adult_capacity` (`adult_capacity_id`),
  ADD CONSTRAINT `t_children_capacity_id_fk` FOREIGN KEY (`children_capacity_id`) REFERENCES `t_room_children_capacity` (`children_capacity_id`);

--
-- Constraints for table `t_room_booking`
--
ALTER TABLE `t_room_booking`
  ADD CONSTRAINT `t_booked_by_fk1` FOREIGN KEY (`booked_by`) REFERENCES `t_customer_personal_data` (`cust_id`),
  ADD CONSTRAINT `t_room_id` FOREIGN KEY (`room_id`) REFERENCES `t_rooms` (`room_id`);

--
-- Constraints for table `t_room_details`
--
ALTER TABLE `t_room_details`
  ADD CONSTRAINT `t_room_discount_id_fk` FOREIGN KEY (`room_discount_id`) REFERENCES `t_room_deals` (`id`);

--
-- Constraints for table `t_room_number_floor_mapping`
--
ALTER TABLE `t_room_number_floor_mapping`
  ADD CONSTRAINT `t_room_floor_id_fk` FOREIGN KEY (`room_floor_id`) REFERENCES `t_room_floors` (`room_floor_id`),
  ADD CONSTRAINT `t_room_number_id_fk` FOREIGN KEY (`room_number_id`) REFERENCES `t_room_number` (`room_number_id`);

--
-- Constraints for table `t_spaa`
--
ALTER TABLE `t_spaa`
  ADD CONSTRAINT `t_cust_id_fk4` FOREIGN KEY (`cust_id`) REFERENCES `t_customer_personal_data` (`cust_id`),
  ADD CONSTRAINT `t_spa_massage_type_id_fk` FOREIGN KEY (`spa_massage_type_id`) REFERENCES `t_spa_massage_type` (`spa_massage_type_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
