create database TravelAssistance;
use TravelAssistance;
create table UserInfo
(national_id int primary key not null,
Fname varchar(15) not null,
Lname varchar(15) not null,
phone_num varchar(10) not null,
pwd varchar(20) not null,
email varchar(45) unique not null);


create table EscortInfo
(user_id int references UserInfo(National_id),
email varchar(45) unique not null,
age int not null,
numberOfEscorts varchar(2) not null);

create table PaymentBill
(bill_id int primary key not null,
total_price int not null ,
flight_ticket varchar(45) not null,
hotel_price int not null);

create table Destination
(city varchar(15) primary key not null,
country varchar(15) not null,
land_mark varchar(20) not null);

create table Hotel
(hotel_number int primary key not null,
hotel_name varchar(45) not null,
city varchar(15) references Destination(city));

insert into UserInfo values (111354671, 'Ahmad', 'Asiri','050234568','ahmad-123','a_asiri@hotmail.com'),
(211374372, 'sarah', 'qahtani','059875568','soso2_1','sara.qahtani@gmailmail.com'), 
(311314625, 'khalid', 'ghamdi','053677568','k_12349','khalid_a@outlook.com'), 
(411954348, 'reem', 'alotibi','0524568988','reem_otb12','reem_1122@yahoo.com'); 

insert into EscortInfo values(221008986, 'suha10@gmail.com', 25, 2),
(221007724, 'hind11@yahoo.com',27,12);

insert into PaymentBill values(1, 300 , 2500 , 2800),
(2,450, 1500, 1950),
(3,100 , 500, 600);

insert into Destination values ('London', 'UK' , 'big ben'),
( 'Tokyo', 'Japan' , 'Sky Tree'),
( 'Paris', 'France', 'Effil tower');

insert into Hotel values ( '+0445729295','New road hotel','London'),
( '+0813567392','palace hotel Tokyo','Tokyo'),
( '+0334658392','the four season','Paris');


select Fname, Lname
from UserInfo
where national_id=any (select user_id from EscortInfo 
);
 
 select hotel_number,hotel_name  from Hotel
 order by hotel_number desc;
 
 select bill_id 
 from PaymentBill
 group by bill_id
 having max(total_price) > all (
 select avg(total_price) 
 from PaymentBill 
 group by bill_id);
 
  Delimiter //
CREATE TRIGGER escortnum BEFORE INSERT
ON EscortInfo
FOR EACH ROW IF new.numberOfEscorts>10
then signal SQLSTATE '45000' set message_text = " numberOfEscorts can't be more than 10";
 end if;
 show trigger;
 Delimiter ;
 
 select * from Destination D inner join HOTEL H on H.city = D.city ;
 
 select u.Fname,u.Lname ,u.Email
from UserInfo as u 
where exists ( select *
from EscortInfo
  where National_id=User_id);
  
  select land_mark, count(*)
from Destination
Group by Country;


ALTER TABLE UserInfo
add username varchar(45) not null
after Lname;

ALTER TABLE UserInfo
modify pwd varchar(20) not null After username;
 
 UPDATE userinfo SET `Fname` = 'Fajer', `Lname` = 'Qahtani', `pwd` = 'fofo123' WHERE (`national_id` = '1113459884');
 UPDATE destination SET `city` = 'NYC', `country` = 'USA', `land_marl` = 'Statue of Liberty' WHERE (`city` = 'London');
 
 ALTER Table EscortInfo 
 drop column email;
 
 ALTER Table EscortInfo 
 drop column age;
 
 create table FlightTicket
 (company_id int primary key not null,
 company_name varchar(45) not null,
 Ticket_price double not null);
 
 ALTER table Hotel
 add hotelPrice double not null;
 
 ALTER table PaymentBill
 modify total_price int not null after hotel_price;
 
 DELETE FROM hotel WHERE (`hotel_number` = '445729295');
 
 create table AdminInfo
 (admin_id int primary key not null,
 admin_username varchar(45) not null,
 admin_pwd varchar(45) not null);
 
 delimiter \\
 create function tax (total_price double)
 returns double DETERMINISTIC
 begin
 declare newTotalPrice double;
 select (total_price_tp * 0.15) + total_price_tp into newTotalPrice from PaymentBill;
 return newTotalPrice;
 end \\ 
 delimiter ; 
 select bill_id, tax(total_price_tp)
 as newTotalPrice from PaymentBill;
 
 USE `travelassistance`;
DROP function IF EXISTS `taxes`;

USE `travelassistance`;
DROP function IF EXISTS `travelassistance`.`taxes`;
;

DELIMITER $$
USE travelassistance $$
CREATE FUNCTION taxes (tp double) RETURNS double
    DETERMINISTIC
begin
 declare newTotalPrice double;
select (total_price* 0.15) + total_price into newTotalPrice;
 return newTotalPrice;
 end$$

DELIMITER ;

INSERT INTO admininfo (`admin_id`, `admin_username`, `admin_pwd`) VALUES ('1001', 'fajer.qahtani', 'fajer123');
INSERT INTO  admininfo (`admin_id`, `admin_username`, `admin_pwd`) VALUES ('1002', 'muneera2', 'm2002');
INSERT INTO  admininfo  (`admin_id`, `admin_username`, `admin_pwd`) VALUES ('1003', 'w_1003', 'w056');
INSERT INTO  admininfo  (`admin_id`, `admin_username`, `admin_pwd`) VALUES ('1004', 'ameena_gh', 'a_10');

alter table Hotel
modify hotel_name varchar(45) not null ;
 
 UPDATE `hotel` SET `hotel_number` = '100', `hotelPrice` = '2500' WHERE (`hotel_number` = '334658392');
UPDATE `hotel` SET `hotel_number` = '201', `hotel_name` = 'palace hotel ', `hotelPrice` = '900' WHERE (`hotel_number` = '813567392');
INSERT INTO `hotel` (`hotel_number`, `hotel_name`, `city`, `hotelPrice`) VALUES ('202', 'prince gallery ', 'Tokyo', '1200');
INSERT INTO `hotel` (`hotel_number`, `hotel_name`, `city`, `hotelPrice`) VALUES ('203', 'imperial hotel ', 'Tokyo', '2199');
INSERT INTO `hotel` (`hotel_number`, `hotel_name`, `city`, `hotelPrice`) VALUES ('101', 'paris Marriott Champs Elysees', 'Paris', '4599');
INSERT INTO `hotel` (`hotel_number`, `hotel_name`, `city`, `hotelPrice`) VALUES ('102', 'napoleon paris', 'Paris', '7800');
INSERT INTO `hotel` (`hotel_number`, `hotel_name`, `city`, `hotelPrice`) VALUES ('103', 'Pullman  Montparnasse', 'Paris', '3459');
INSERT INTO `hotel` (`hotel_number`, `hotel_name`, `city`, `hotelPrice`) VALUES ('300', 'The Langham', 'New York', '3500');
INSERT INTO `hotel` (`hotel_number`, `hotel_name`, `city`, `hotelPrice`) VALUES ('301', 'Waldrof-astoria', 'New York', '6399');
INSERT INTO `hotel` (`hotel_number`, `hotel_name`, `city`, `hotelPrice`) VALUES ('302', 'the ritz-carlton', 'New York', '10000');

 alter table FlightTicket 
 modify ticket_price double not null;
 
 UPDATE `flightticket` SET `company_id` = '111', `company_name` = 'Saudia Airlines' WHERE (`company_id` = '110');
UPDATE `flightticket` SET `company_id` = '310', `ticket_price` = '7500' WHERE (`company_id` = '320');
UPDATE `flightticket` SET `company_id` = '510', `company_name` = 'Qatari Airlines' WHERE (`company_id` = '540');

alter table UserInfo 
 modify National_id varchar(11) not null;
 
 alter table UserInfo 
 modify phone_num varchar(11) not null;
 
 