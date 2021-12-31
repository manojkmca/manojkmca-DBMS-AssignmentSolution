-- Create Database TravelOnTheGo 
drop database if exists `TravelOnTheGo`;

create database if not exists `TravelOnTheGo`;

use `TravelOnTheGo`;

-- Create table Passenger, check if exists already, drop it before creating it.
drop table if exists `PASSENGER`;

create table if not exists `PASSENGER`(
Passenger_name varchar(100),
Category Varchar(10),
Gender Varchar(1),
Boarding_City Varchar(50),
Destination_City Varchar(50),
Distance int,
Bus_Type Varchar(20)
); 

-- Create table Price, check if exists already, drop it before creating it.
drop table if exists `PRICE`;

create table if not exists `PRICE`(
Bus_Type Varchar(50),
Distance int,
Price int,
constraint unique_Price UNIQUE (Bus_Type, Distance, Price)
);

-- Insert the values in Passenger Table 
insert into PASSENGER values("Sejal","AC","F","Bengaluru","Chennai",350,"Sleeper");
insert into PASSENGER values("Anmol","Non-AC","M","Mumbai","Hyderabad",700,"Sitting");
insert into PASSENGER values("Pallavi","AC","F","Panji","Bengaluru",600,"Sleeper");
insert into PASSENGER values("Khusboo","AC","F","Chennai","Mumbai",1500,"Sleeper");
insert into PASSENGER values("Udit","Non-AC","M","Trivandrum","Panji",1000,"Sleeper");
insert into PASSENGER values("Ankur","AC","M","Nagpur","Hyderabad",500,"Sitting");
insert into PASSENGER values("Hemant","Non-AC","M","Panji","Mumbai",700,"Sleeper");
insert into PASSENGER values("Manish","Non-AC","M","Hyderabad","Bengaluru",500,"Sitting");
insert into PASSENGER values("Piyush","AC","M","Pune","Nagpur",700,"Sitting");

-- Insert the Values in Price Table 
insert into PRICE values("Sleeper",350,770);
insert into PRICE values("Sleeper",500,1100);
insert into PRICE values("Sleeper",600,1320);
insert into PRICE values("Sleeper",700,1540);
insert into PRICE values("Sleeper",1000,2200);
insert into PRICE values("Sleeper",1200,2640);
insert into PRICE values("Sleeper",350,434);
insert into PRICE values("Sitting",500,620);
insert into PRICE values("Sitting",500,620);
insert into PRICE values("Sitting",600,744);
insert into PRICE values("Sitting",700,868);
insert into PRICE values("Sitting",1000,1240);
insert into PRICE values("Sitting",1200,1488);
insert into PRICE values("Sitting",1500,1860);

-- 3) How many females and how many male passengers travelled for a minimum distance of 600 KMs?
SELECT Gender, COUNT(*) as "Total Passengers" FROM PASSENGER where Distance>=600 group by gender;

-- 4) Find the minimum ticket price for Sleeper Bus. 
SELECT min(price) as 'Minimum Sleeper Price' from PRICE where Bus_Type='Sleeper';

-- 5) Select passenger names whose names start with character 'S' 
SELECT Passenger_Name from PASSENGER where Passenger_Name like 'S%';

-- 6) Calculate price charged for each passenger displaying Passenger name, Boarding City, Destination City, Bus_Type, Price in the output
SELECT Passenger_Name, Boarding_City, Destination_City, Passenger.Bus_Type, Price 
from PASSENGER left join PRICE 
ON PASSENGER.Bus_Type=PRICE.Bus_Type AND PASSENGER.Distance=PRICE.Distance;

-- 7) What is the passenger name and his/her ticket price who travelled in Sitting bus for a distance of 1000 KM s 
SELECT Passenger_Name 
from PASSENGER as psgr inner join PRICE as prc 
on psgr.bus_type = prc.bus_type and psgr.distance = prc.distance
where psgr.Bus_Type="Sitting" AND psgr.distance = 1000;

-- 8) What will be the Sitting and Sleeper bus charge for Pallavi to travel from Bangalore to Panaji?
-- Question: Can we solve this problem using join? 
SELECT Bus_Type, Price FROM PRICE WHERE Distance
IN
(SELECT distance from PASSENGER where Passenger_Name="Pallavi" and Destination_City="Bengaluru" and Boarding_City="Panji");

-- 9) List the distances from the "Passenger" table which are unique (non-repeated distances) in descending order.
SELECT DISTINCT Distance from PASSENGER;

-- 10) Display the passenger name and percentage of distance travelled by that passenger from the total distance travelled by all passengers without using user variables
select passenger_name as 'passenger name', distance * 100.0/sum(distance) over() as '% of total distance'
from passenger;

-- Display the distance, price in three categories in table Price
-- a) Expensive if the cost is more than 1000
-- b) Average Cost if the cost is less than 1000 and greater than 500
-- c) Cheap otherwise

delimiter &&
create procedure cat()
begin
select distance, price,
case
when price>1000 then 'Expensive'
when price>500 AND price <1000 then 'Average Cost'
else 'Cheap'
end as Category
from Price;
end &&

call cat();