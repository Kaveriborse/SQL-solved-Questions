#Q1. Query all columns for all American cities in the CITY table with populations larger than 100000.
use sales;
create table CITY(
ID INT,
FULL_NAME VARCHAR(17),
COUNTRYCODE VARCHAR(3),
DISTRICT VARCHAR(20),
POPULATION INT
);

select * from CITY;

SELECT * FROM CITY
WHERE COUNTRYCODE = 'USA' AND POPULATION > 100000;

# Q2. Query the NAME field for all American cities in the CITY table with populations larger than 120000.
SELECT NAME FROM CITY
WHERE COUNTRYCODE = 'USA' AND POPULATION > 120000;

#Q3. Query all columns (attributes) for every row in the CITY table.
select * from CITY;

#Q4. Query all columns for a city in CITY with the ID 1661.
select * from CITY where ID=1661;

# Q5. Query all attributes of every Japanese city in the CITY table. The COUNTRYCODE for Japan is JPN.
select * from CITY where COUNTRYCODE="JPN";

# Q6. Query the names of all the Japanese cities in the CITY table. The COUNTRYCODE for Japan is JPN.
SELECT NAME FROM CITY WHERE COUNTRYCODE = 'JPN';

#Q7. Query a list of CITY and STATE from the STATION table.where LAT_N is the northern latitude and LONG_W is the western longitude.
#import tha table station
drop table STATION;
create table STATION(
Id INT,
City VARCHAR(21),
State VARCHAR(2),
Lat_N int,
Long_W int
);
select * from STATION;

SELECT City, State
FROM STATION;
# OR
CREATE VIEW list_city_state AS
select City, State from  STATION;

# Q8. Query a list of CITY names from STATION for cities that have an even ID number. Print the results in any order, but exclude duplicates from the answer.
SELECT DISTINCT City FROM STATION WHERE Id % 2 = 0;

#Q9. Find the difference between the total number of CITY entries in the table and the number of distinct CITY entries in the table

SELECT
    (SELECT COUNT(City) FROM STATION) AS total_city_entries,
    (SELECT COUNT(DISTINCT City) FROM STATION) AS distinct_city_entries,
    (SELECT COUNT(City) FROM STATION) - (SELECT COUNT(DISTINCT CITY) FROM STATION) AS difference;
    
/*
Q10. Query the two cities in STATION with the shortest and longest CITY names, as well as their
respective lengths (i.e.: number of characters in the name). If there is more than one smallest or
largest city, choose the one that comes first when ordered alphabetically.
The STATION table is described as follows:
*/
SELECT City, LENGTH(City) AS name_length
FROM STATION
ORDER BY name_length ASC, City ASC
LIMIT 1;

SELECT City, LENGTH(City) AS name_length
FROM STATION
ORDER BY name_length DESC, City ASC
LIMIT 1;

/*
Q11. Query the list of CITY names starting with vowels (i.e., a, e, i, o, or u) from STATION. Your result
cannot contain duplicates.
*/
SELECT DISTINCT City
FROM STATION
WHERE City REGEXP '^[AEIOUaeiou]'
ORDER BY City;

/*
Q12. Query the list of CITY names ending with vowels (a, e, i, o, u) from STATION. Your result cannot
contain duplicates.
*/
SELECT DISTINCT City
FROM STATION
WHERE City REGEXP '[AEIOUaeiou]$'
ORDER BY City;

#Q13. Query the list of CITY names from STATION that do not start with vowels. Your result cannot contain duplicates.
SELECT DISTINCT City
FROM STATION
WHERE City NOT REGEXP '^[AEIOUaeiou]'
ORDER BY City;

#Q14. Query the list of CITY names from STATION that do not end with vowels. Your result cannot contain duplicates
SELECT DISTINCT City
FROM STATION
WHERE City NOT REGEXP '[AEIOUaeiou]$'
ORDER BY City;

/*
Q15. Query the list of CITY names from STATION that either do not start with vowels or do not end
with vowels. Your result cannot contain duplicates
*/
SELECT DISTINCT City
FROM STATION
WHERE City NOT REGEXP '^[AEIOUaeiou]' OR City NOT REGEXP '[AEIOUaeiou]$'
ORDER BY City;

#Q16. Query the list of CITY names from STATION that do not start with vowels and do not end with vowels. Your result cannot contain duplicates.
SELECT DISTINCT City
FROM STATION
WHERE City NOT REGEXP '^[AEIOUaeiou]' AND City NOT REGEXP '[AEIOUaeiou]$'
ORDER BY City;

drop table Product;
#17
create table Product(
product_id int,
product_name varchar (25),
unit_id int,
primary key(product_id)
);

create table Sales(
seller_id int,
product_id int,
buyer_id int,
sale_date date,
quantity int,
price int
);


create index idx_product_id on Sales(product_id);
create index idxproduct_id on Sales(product_id);


alter table Product
add constraint fk_product_id
foreign key(product_id) references Sales(product_id);

insert into Product values
(1,"S8",1000),
(2,'G4',800),
(3,'iPhone',1400);

insert into Sales values
(1,1,1,'2019-1-21',2,2000),
(1,2,2,'2019-02-17',1,800),
(2,2,3,'2019-06-02',1,800),
(3,3,4,'2019-05-13',2,2800);

select * from Product;
desc Product;






drop table Views;
/*18
Write an SQL query to find all the authors that viewed at least one of their own articles.
Return the result table sorted by id in ascending order.
*/
create table Views(
article_id int,
author_id int,
viewer_id int,
view_date date
);

Alter table Views
add constraint uk_Views unique(author_id,viewer_id);

desc Views;

insert into Views values
(1,3,5,'2019-8-1'),
(1,3,6,'2019-8-2'),
(2,7,7,'2019-8-1'),
(2,7,6,'2019-8-2'),
(4,7,1,'2019-7-22'),
(3,4,4,'2019-7-21'),
(3,4,4,'2019-7-21');

select distinct V.author_id as id
from Views as V
join (select distinct author_id, article_id from Views) as A on V.author_id = A.author_id and V.article_id = A.article_id
where V.author_id = V.viewer_id
order by V.author_id asc;


/*19
If the customer's preferred delivery date is the same as the order date, then the order is called
immediately; otherwise, it is called scheduled.
Write an SQL query to find the percentage of immediate orders in the table, rounded to 2 decimal
places.
*/
create table Delivery(
delivery_id int,
customer_id int,
delivery_date date,
customer_pref_delivery_date date
);

alter table Delivery
add primary key pk_delivery_id(delivery_id);

desc Delivery;

insert into Delivery values
(1,1,'2019-08-01','2019-08-02'),
(2,5,'2019-08-02','2019-08-02'),
(3,1,'2019-08-11','2019-08-11'),
(4,3,'2019-08-24','2019-08-26'),
(5,4,'2019-08-21','2019-08-22'),
(6,2,'2019-08-11','2019-08-13');

update table Delivery
select * from Delivery;
select round((select count(*) from Delivery where delivery_date=customer_pref_delivery_date)/count(*)*100,2) 
as immidiate_percentage from Delivery;



/*20
Write an SQL query to find the ctr of each Ad. Round ctr to two decimal points.
Return the result table ordered by ctr in descending order and by ad_id in ascending order in case of a tie.
*/
drop table Ads;
create table Ads(
ad_id int,
user_id int,
action varchar(20),
primary key (ad_id,user_id)
);

desc Ads;
insert into Ads values
(1,1,'Clicked'),
(2,2,'Clicked'),
(3,3,'Vieved'),
(5,5,'Ignored'),
(1,7,'Ignored'),
(2,7,'Vieved'),
(3,5,'Clicked'),
(1,4,'Vieved'),
(2,11,'Vieved'),
(1,2,'Clicked');

select * from Ads;
SELECT ad_id,
       ROUND(SUM(CASE WHEN action = 'Clicked' THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS ctr
FROM Ads
GROUP BY ad_id
ORDER BY ctr DESC, ad_id ASC;

/*21
Write an SQL query to find the team size of each of the employees. Return result table in any order.
*/

drop table Employee;
create table Employee(
employee_id int,
team_id int,
primary key (employee_id)
);
desc Employee;

insert into Employee values
(1,8),
(2,8),
(3,8),
(4,7),
(5,9),
(6,9);

select * from Employee;
select employee_id, count(team_id) over (partition by team_id) as team_size from employee order by employee_id;


/*22
Write an SQL query to find the type of weather in each country for November 2019. The type of weather is:
● Cold if the average weather_state is less than or equal 15,
● Hot if the average weather_state is greater than or equal to 25, and
● Warm otherwise.
*/
drop table countries;
create table countries(
country_id int,
country_name varchar(20)
);

alter table countries 
add constraint primary key(country_id);

desc countries;
insert into countries values
(2,'USA'),
(3,'Australia'),
(7,'Peru'),
(5,'China'),
(8,'Morocco'),
(9,'Spain');

drop table weather;
create table weather(
country_id int,
weather_state int,
day date);

alter table weather
add constraint primary key(country_id,day);

insert into weather values
(2,15,'2019-11-01'),
(2,12,'2019-10-28'),
(2,12,'2019-11-27'),
(3,-2,'2019-11-10'),
(3,0,'2019-11-11'),
(3,3,'2019-11-12'),
(5,16,'2019-11-07'),
(5,18,'2019-11-09'),
(5,21,'2019-11-23'),
(7,25,'2019-11-28'),
(7,22,'2019-12-01'),
(7,20,'2019-12-02'),
(8,25,'2019-11-05'),
(8,27,'2019-11-15'),
(8,31,'2019-11-25'),
(9,7,'2019-10-03'),
(9,3,'2019-12-03');

select c.country_name, case 
when avg(weather_state) <= 15 then 'Cold' 
when avg(weather_state) >= 25 then 'Hot' 
else 'Warm' end 
as weather_state 
from countries c left join weather w 
on c.country_id = w.country_id 
where month(day) = 11 group by c.country_name;

/*23
Write an SQL query to find the average selling price for each product. average_price should be rounded to 2 decimal places.
Return the result table in any order.
*/
create table Unitsold(
product_id int,
purchase_date date,
units int);

insert into Unitsold values
(1,'2019-2-25',100),
(1,'2019-3-01',15),
(2,'2019-2-10',200),
(2,'2019-3-22',30);

create table Prices(
product_id int,
start_date date,
end_date date,
price int);

alter table Prices
add constraint primary key(product_id,start_date,end_date);

insert into Prices values
(1,'2019-02-17','2019-02-28',5),
(1,'2019-03-01','2019-03-22',20),
(2,'2019-02-01','2019-02-20',15),
(2,'2019-03-21','2019-03-31',30);

select p.product_id,round(sum(u.units*p.price)/sum(u.units),2) 
as average_price from Prices p left join Unitsold u on p.product_id=u.product_id
where u.purchase_date>=start_date and u.purchase_date<=end_date
group by product_id
order by product_id;

/*24
Write an SQL query to report the first login date
for each player. Return the result table in any order
*/
create table Activity(
player_id int,
device_id int,
event_date date,
games_played int);

alter table Activity
add constraint primary key(player_id,event_date);

insert into Activity values
(1,2,'2016-03-01',5),
(1,2,'2016-05-02',6),
(2,3,'2017-06-25',1),
(3,1,'2016-03-02',0),
(3,4,'2018-07-03',5);

SELECT player_id, MIN(event_date) AS first_login_date
FROM Activity
GROUP BY player_id;


/*25
Write an SQL query to report the device that is first logged 
in for each player. Return the result table in any order.
*/
create table Activity(
player_id int,
device_id int,
event_date date,
games_played int
);

alter table Activity
add constraint primary key(player_id,event_date);

insert into Activity values
(1,2,'2016-03-01',5),
(1,2,'2016-05-02',6),
(2,3,'2017-06-25',1),
(3,1,'2016-03-02',0),
(3,4,'2018-07-03',5);
select t.player_id, t.device_id from (select player_id, device_id, 
row_number() over(partition by player_id order by event_date) as 
num from activity)t where t.num = 1;

/*26
Write an SQL query to get the names of products that have at 
least 100 units ordered in February 2020 and their amount.
Return result table in any order.
*/
drop table Products;
create table Products(
product_id int,
product_name varchar(20),
product_category varchar(20),
primary key(product_id)
);

insert into Products values
(1,'Leetcodesolutions','Book'),
(2,'JewelsofStringology','Book'),
(3,'HP','Laptop'),
(4,'Lenovo','Laptop'),
(5,'Leetcode Kit','T-shirt');

create table Orders(
product_id int,
order_id date,
Unit int);


insert into Orders values
(1,'2020-02-05',60),
(1,'2020-02-10',70),
(2,'2020-01-11',30),
(2,'2020-02-18',80),
(3,'2020-02-17',2),
(3,'2020-02-24',3),
(4,'2020-03-01',20),
(4,'2020-03-04',30),
(4,'2020-03-04',60),
(5,'2020-02-25',50),
(5,'2020-02-27',50),
(5,'2020-03-01',50);


select Products.product_name, sum(o.unit) as unit from Products 
left join Orders O
on Products.product_id=O.product_id
where month(O.order_id)=2 and year(O.order_id)=2020
group by Products.product_id
having unit>=100;


/*27
Write an SQL query to find the users who have valid emails. A valid e-mail has a prefix name and a domain where:
● The prefix name is a string that may contain letters (upper or lower case), digits, underscore '_', period '.', and/or dash '-'. The prefix name must start with a letter.
● The domain is '@leetcode.com'. Return the result table in any order
*/
drop table Users
create table Users(
user_id int,
name varchar(20),
mail varchar(20)
);
alter table Users
add constraint primary key(user_id);

insert into Users values

(1,'Winston','winston@leetcode.com'),
(2,'Jonathan','jonathanisgreat'),
(3,'Annabelle','bella-@leetcode.com'),
(4,'Sally','sally.come@leetcode.com'),
(5,'David','quarz#2020@leetcode.com'),
(6,'David','david69@gmail.com'),
(7,'Shapiro','.shapo@leetcode.com');

select user_id, name,mail from Users
where
mail regexp '^[a-zA-Z]+[a-zA-Z0-9_\.\-]*@leetcode[\.]com'
order by user_id;

/*28
Write an SQL query to report the customer_id and customer_name of customers who have spent at
least $100 in each month of June and July 2020.
*/
create table Customers(
customer_id int,
name varchar(20),
country varchar(20)
);
alter table Customers
add constraint primary key(customer_id);

 insert into Customers values
 (1,'Winston','USA'),
 (2,'Jonathan','Peru'),
 (3,'Moustafa','Egypt');
 
 drop table product;
 create table Product(
 prod_id int,
 description varchar(20),
 price int,
 primary key (prod_id)
 );
 insert into product values
 (10,'LC Phone',300),
 (20,'LC T-shirt',10),
  (30,'LC book',45),
   (40,'LC keychain',2);
   
drop table orders;
create table orders(
order_id int,
customer_id int,
prod_id int,
order_date date,
quantity int,
primary key(order_id)
);

insert into orders values
(1,1,10,'2020-06-10',1),
(2,1,20,'2020-07-01',1),
(3,1,30,'2020-07-08',2),
(4,2,10,'2020-06-15',2),
(5,2,40,'2020-07-01',10),
(6,3,20,'2020-06-24',2),
(7,3,30,'2020-06-25',2),
(9,3,30,'2020-05-08',3);

select t.customer_id, t.name from 
(select c.customer_id, c.name, 
sum(case when month(o.order_date) = 6 and year(o.order_date) = 2020 then
 p.price*o.quantity else 0 end) as june_spent,
 sum(case when month(o.order_date) = 7 and year(o.order_date) = 2020 then
 p.price*o.quantity else 0 end) as july_spent
 from 
 Orders o 
 left join
 Product p
 on o.prod_id = p.prod_id 
 left join 
 Customers c 
 on o.customer_id = c.customer_id group by c.customer_id) t 
 where june_spent >= 100 and july_spent >= 100;

/*29
Write an SQL query to report the distinct titles of the kid-friendly movies streamed in June 2020.
 Return the result table in any order.
 */
 create table TVProgram(
 program_date date,
 content_id int,
 channel varchar(20),
 primary key(program_date,content_id)
 );
 insert into tvprogram values
 ('2020-6-10',1,'LC.channel'),
  ('2020-5-11',2,'LC.channel'),
   ('2020-5-12',3,'LC.channel'),
    ('2020-5-13',4,'Diseney ch'),
    ('2020-6-18',4,'Diseney ch'),
     ('2020-7-15',5,'Diseney ch');
     
 create table content(
 content_id int,
 title varchar(20),
 kids_content varchar(1),
 content_type varchar(20),
 primary key(content_id)
 );
 insert into content values
 (1,'leetcode movie','N','movies'),
  (2,'Alg. for Kids','Y','Series'),
   (3,'Database Sols','N','series'),
    (4,'Aladdin','Y','movies'),
     (5,'Cinderella','Y','movies');

select c.Title from Content c 
left join 
TVProgram t on c.content_id = t.content_id
 where c.Kids_content = 'Y' and c.content_type = 'Movies' and 
 month(t.program_date) = 6 and year(t.program_date) = 2020;

/*30
Write an SQL query to find the npv of each query of the
 Queries table. Return the result table in any order.
 */
 create table NPV(
 id int,
 year int,
 npv int,
 primary key(id,year)
 );
 insert into npv values
 (1,2018,100),
 (7,2020,30),
 (13,2019,40),
 (1,2019,113),
 (2,2018,121),
 (3,2019,12),
 (11,2020,99),
 (7,2019,0);
 
  create table querries(
  id int,
  year int,
  primary key(id,year)
  );
  insert into querries values
  (1,2019),
  (2,2008),
  (3,2009),
  (7,2018),
  (7,2019),
  (7,2020),
(13,2019);

select q.*, coalesce(n.Npv,0) as Npv from Querries q 
left join
 NPV n on q.Id = n.Id and q.Year = n.Year;

drop table npv;
/*31
Write an SQL query to find the npv of each query of the Queries table.
 Return the result table in any order.
 */
 create table npv(
 id int,
 year int,
 npv int,
 primary key (id,year)
 );
 insert into npv values
 (1,2018,100),
 (7,2020,30),
 (13,2019,40),
 (1,2019,113),
 (2,2018,121),
 (3,2019,12),
 (11,2020,99),
 (7,2019,0);
 
 drop table querries;
 create table querries(
  id int,
  year int,
  primary key(id,year)
  );
   insert into querries values
  (1,2019),
  (2,2008),
  (3,2009),
  (7,2018),
  (7,2019),
  (7,2020),
(13,2019);

select q.*, coalesce(n.Npv,0) as Npv 
from Querries q
 left join
 NPV n 
 on
 q.Id = n.Id and q.Year = n.Year;
 
/*32
Write an SQL query to show the unique ID of each user, If a user does not have a unique ID replace just show null.
Return the result table in any order.
The query result format is in the following
*/
create table employees(
id int,
name varchar (20),
primary key(id)
);
insert into employees values
(1,'Alice'),
(7,'Bob'),
(11,'Meir'),
(90,'Winston'),
(3,'Jonathan');

 create table employeeUNI (
 id int,
 unique_id int,
 primary key(id,unique_id)
 );
insert into employeeUNI values
(3,1),
(11,2),
(90,3);
select u.unique_id, e.name 
from employees e 
left join
 employeeUNI u on e.id = u.id;
 
 /*33
 Write an SQL query to report the distance travelled by each user.
Return the result table ordered by travelled_distance in descending 
order, if two or more users travelled the same distance, order them 
by their name in ascending order.
*/
drop table users;
create table users(
id int,
name varchar (20),
primary key(id)
);
insert into users values
(1,'Alice'),
(2,'Bob'),
(3,'Alex'),
(4,'Donald'),
(7,'Lee'),
(13,'Jonathan'),
(19,'Elvis');

create table Rides(
id int,
user_id int,
distance int,
primary key(id)
);
 insert into Rides values
(1,1,120),
(2,2,317),
(3,3,222),
 (4,7,100),
 (5,13,312),
(6,19,50),
(7,7,120),
(8,19,400),
(9,7,230);
select u.name, coalesce(sum(r.distance),0) as travelled_distance 
from users u 
left join rides r on u.id = r.user_id
 group by u.name 
 order by travelled_distance desc, u.name;
 
 /*34
 Write an SQL query to get the names of products that have at least 100 units ordered in February 2020 and their amount.
Return result table in any order.
*/
drop table products;
create table products(
product_id int,
product_name varchar(20),
product_category varchar(20)
);
alter table products
add constraint primary key(product_id);
insert into products values
(1,'leetcode solutions','book'),
(2,'Jewels of Stringology','book'),
(3,'HP','laptop'),
(4,'Lenovo','laptop'),
(5,'leetcode kit','T-shirt');

drop table orders;
create table orders(
product_id int,
order_date date,
unit int);
insert into orders values
(1,'2020-02-05',60),
(1,'2020-02-05',60),
(2,'2020-02-05',60),
(2,'2020-205',60),
(3,'020-02-05',60),
(3,'20-02-05',60),
(4,'2020-02-05',60),
(4,'2020-02-05',60),
(4,'2020-02-05',60),
(5,'2020-02-05',60),
(5,'2020-02-05',60),
(5,'2020-02-05',60);
select p.product_name, sum(o.unit) as unit
 from Products p 
 left join Orders o on p.product_id = o.product_id 
 where month(o.order_date) = 2 and 
 year(o.order_date) = 2020
 group by p.product_id 
 having unit >= 100;

/*35
Write an SQL query to:
● Find the name of the user who has rated the greatest number of movies. In case of a tie, return the lexicographically smaller user name.
● Find the movie name with the highest average rating in February 2020. In case of a tie, return the lexicographically smaller movie name.
*/
create table movies(
movie_id int,
title varchar(20),
primary key(movie_id)
);
insert into movies values
(1,'Avengers'),
 (2,'Frozen 2'),
 (3,'Joker');
 
 drop table user;
create table users(
user_id int,
name varchar(20),
primary key(user_id)
);

insert into users values
(1,'Daniel'),
(2,'Monica'),
(3,'Maria'),
(4,'James');

create table movierating(
movie_id int,
user_id int,
rating int,
created_at date,
primary key(movie_id,user_id)
);
insert into movierating values
(1,1,3,'2020-01-12'),
(1,2,4,'2020-02-11'),
(1,3,2,'2020-02-12'),
(1,4,1,'2020-01-01'),
(2,1,5,'2020-02-17'),
(2,2,2,'2020-02-01'),
(2,3,2,'2020-03-01'),
(3,1,3,'2020-02-22'),
(3,2,4,'2020-02-25');
(select t1.name as Results from 
(select u.name, count(u.user_id), dense_rank() over(order by count(user_id) 
desc, u.name) as r1 FROM 
Users u 
left join 
MovieRating m 
on u.user_id = m.user_id 
group by u.user_id) t1 
where r1 = 1) 
union 
(select t2.title as Results from 
(select mo.title, avg(m.rating), dense_rank() over(order by avg(m.rating)desc, mo.title) as r2 from
Movies mo 
left join 
MovieRating m on mo.movie_id = m.movie_id
where month(m.created_at) = 2 and year(m.created_at) = 2020 
group by m.movie_id) t2 
where r2 = 1);

/*36
Write an SQL query to report the distance travelled by each user.
Return the result table ordered by travelled_distance in descending order, if two or more users travelled the same distance, order them by their name in ascending order.
*/
drop table users;
create table users(
id int,
name varchar(20),
primary key(id)
);
insert into users values
(1,'Alice'),
(2,'Bob'),
(3,'Alex'),
(4,'Donald'),
(7,'Lee'),
(13,'Jonathan'),
(19,'Elvis');

drop table rides;
create table rides(
id int,
user_id int,
distance int,
primary key(id)
);
insert into rides values
(1,1 ,120),
(2,2 ,317),
(3,3 ,222),
(4,7 ,100),
(5,13,312),
(6,19,50),
(7,7,120),
(8,10,480),
(9,7,250);

select u.name, coalesce(sum(r.distance),0) as travelled_distance 
from 
users u 
left join 
rides r on u.id = r.user_id 
group by u.name 
order by travelled_distance desc, u.name;

/*37
Write an SQL query to show the unique ID of each user, If a user does not have a unique ID replace just show null.
*/
drop table employees;
create table employees(
id int,
name varchar(20),
primary key(id)
);
insert into employees values
(1,'Alice'),
(7,'Bob'),
(11,'Meir'),
(90,'Winston'),
(3,'Jonathan');

drop table employeeUNI;
create table employeeUNI(
id int,
unique_id int,
primary key(id,unique_id)
);
insert into employeeUNI values
(3,1),
(11,2),
(90,3);

select u.unique_id, e.name 
from employees e 
left join employeeUNI u on e.id = u.id;

/*38
Write an SQL query to find the id and the name of all students who are enrolled in departments that no longer exist.
*/
create table departments(
id int,
name varchar(20),
primary key(id)
);
insert into departments values
(1,'ElectricalEngi'),
(7,'ComputerEngi'),
(13,'BusinessAdmini');

create table students(
id int,
name varchar(20),
department_id int,
primary key(id)
);
insert into students values
(23,'Alice',1),
(1,'Bob',7),
(5,'Jennifer',13),
(2,'John',14),
(4,'Jasmine',77),
(3,'Sterv',74),
(6,'Luis',1),
(8,'Jonathan',7),
(7,'Daiana',33),
(11,'Madelynn',1);

select id, name 
from Students 
where 
department_id not in (select id from Departments);

/*39
Write an SQL query to report the number of calls and the total call duration between each pair of distinct persons (person1, person2) where person1 < person2.
Return the result table in any order
*/
create table calls(
from_id int,
to_id int,
duration int);
insert into calls values
(1,2,59),
(2,1,11),
(1,3,20),
(3,4,100),
(3,4,200),
(3,4,200),
(4,3,499);

select t.person1, t.person2, count(*) 
as call_count, sum(t.duration) as total_duration
from (select duration, 
case when from_id < to_id then from_id else to_id end as person1, 
case when from_id > to_id then from_id else to_id end as person2 
from Calls) t 
group by t.person1, t.person2;

/*40
Write an SQL query to find the average selling price for each product. average_price should be rounded to 2 decimal places.
Return the result table in any order.
*/

drop table prices;
create table prices(
product_id int,
start_date date,
end_date date,
price int,
primary key(product_id,start_date,end_date)
);
insert into prices values
(1,'2019-02-17','2019-02-28',5),
(1,'2019-03-01','2019-03-22',20),
(2,'2019-02-01','2019-02-20',15),
(2,'2019-02-21','2019-03-31',30);

drop table unitsold;
create table unitsold(
product_id int,
purchase_date date,
units int);
insert into unitsold values
(1,'2019-02-25',100),
(1,'2019-03-01',15),
(2,'2019-02-10',200),
(2,'2019-02-22',30);

select p.product_id, round(sum(u.units*p.price)/sum(u.units),2) as average_price 
from
prices p 
left join 
unitsold u on p.product_id = u.product_id 
where u.purchase_date >= start_date and u.purchase_date <= end_date 
group by product_id 
order by product_id;

/*41
Write an SQL query to report the number of cubic feet of volume the inventory occupies in each warehouse.
Return the result table in any order.
The query result format is in the following
*/
create table warehouse(
name varchar(20),
product_id int,
units int,
primary key(name,product_id)
);
insert into warehouse values
('LCHouse1',1,1),
('LCHouse1',2,10),
('LCHouse1',3,5),
('LCHouse2',1,2),
('LCHouse2',2,2),
('LCHouse3',4,1);

drop table products;
create table products(
product_id int,
product_name varchar(20),
width int,
length int,
height int,
primary key(product_id)
);
insert into products values
(1,'LC.TV',5,50,40),
(2,'LC.keychain',5,5,5),
(3,'LC.phone',2,10,10),
(4,'LC.T.Shirt',4,10,20);

select w.name as warehouse_name, sum(p.width*p.length*p.height*w.units) as 
volume from warehouse w 
left join 
products p on w.product_id = p.product_id 
group by w.name order by w.name;

/*42
Write an SQL query to report the difference between the number of apples and oranges sold each day. Return the result table ordered by sale_date.
*/
create table sales(
sale_date date,
fruit varchar(20),
sold_num int,
primary key(sale_date,fruit)
);
insert into sales values
('2020-05-01','apples',10),
('2020-05-01','oranges',8),
('2020-05-02','apples',15),
('2020-05-02','oranges',15),
('2020-05-03','apples',20),
('2020-05-03','oranges',0),
('2020-05-04','apples',15),
('2020-05-04','oranges',16);

select t.sale_date, (t.apples_sold - t.oranges_sold) as diff 
from 
(select sale_date, 
	max(CASE WHEN fruit = 'apples' THEN sold_num ELSE 0 END )as apples_sold, 
    max(CASE WHEN fruit = 'oranges' THEN sold_num ELSE 0 END )as oranges_sold 
FROM sales 
group by sale_date) t 
ORDER BY t.sale_date;

/*43
Write an SQL query to report the fraction of players that logged in again on the day after the day they first logged in, rounded to 2 decimal places.
 In other words, you need to count the number of players that logged in for at least two consecutive days starting from their first login date, then
 divide that number by the total number of players.
*/
drop table activity;
create table activity(
player_id int,
device_id int,
event_date date,
games_played int,
primary key(player_id,event_date)
);
insert into activity values
(1,2,'2016-03-01',5),
(1,2,'2016-03-02',6),
(2,3,'2017-06-05',1),
(3,1,'2016-03-02',0),
(3,4,'2018-07-03',5);

select round(t.player_id/(select count(distinct player_id) from activity),2) as fraction 
from 
( select distinct player_id, 
datediff(event_date, lead(event_date, 1) over(partition by player_id order by event_date)) 
as diff from activity ) t 
where diff = -1;

/*44
Write an SQL query to report the managers with at least five direct reports. Return the result table in any order.
*/
drop table employee;
create table employee(
id int,
name varchar(20),
department varchar(20),
managerid int,
primary key(id)
);
insert into employee values
(101,'john','A',Null),
(102,'Dan ','A',101),
(103,'James','A',101),
(104,'Amy','A',101),
(105,'Anny','A',101),
(106,'Ron','B',101);

select t.name from 
(select a.id, a.name, count(b.managerID) as no_of_direct_reports 
from employee a 
INNER JOIN 
employee b on a.id = b.managerID group by b.managerID) t 
where no_of_direct_reports >= 5 
order by t.name;

/*45
Write an SQL query to report the respective department name and number of students majoring in each department for all departments in the Department 
table (even ones with no current students). Return the result table ordered by student_number in descending order. In case of a tie, order them by 
dept_name alphabetically.
*/
drop table student;
create table student(
student_id int,
student_name varchar(20),
gender varchar(20),
dept_id int,
primary key(student_id)
);
insert into student values
(1,'Jack','M',1),
(2,'Jane','F',1),
(3,'Mark','M',2);

create table department(
dept_id int,
dept_name varchar(20),
primary key(dept_id)
);
insert into department values
(1,'Engineering'),
(2,'Science'),
(3,'Law');

select d.dept_name, count(s.dept_id) as student_number 
from department d 
left join 
student s on s.dept_id = d.dept_id 
group by d.dept_id 
order by student_number desc, dept_name;

/*46
Write an SQL query to report the customer ids from the Customer table that bought all the products in the Product table.
Return the result table in any order.
*/
create table customer(
customer_id int,
product_key int);

insert into customer values
(1,5),
(2,6),
(3,5),
(3,6),
(1,6);

create table product(
product_key int,
primary key(product_key)
);
insert into product values
(5),
(6);

select customer_id from customer 
group by customer_id 
having count(distinct product_key)=(select count(*) from product);

/*47
Write an SQL query that reports the most experienced employees in each project. In case of a tie, report all employees with the maximum number of experience years.
Return the result table in any order.
*/
create table project(
project_id int,
employee_id int,
primary key(project_id,employee_id)
);
insert into project values
(1,1),
(1,2),
(1,3),
(2,1),
(2,4);

drop table employee;
create table employee(
employee_id int,
name varchar(20),
experience_years int,
primary key(employee_id)
);
insert into employee values
(1,'Khaled',3),
(2,'Ali',2),
(3,'John',3),
(4,'Doe',2);

select t.project_id, t.employee_id 
from 
(select p.project_id, e.employee_id, dense_rank() over(partition by p.project_id order by e.experience_years desc) as r 
from project p 
left join 
employee e on p.employee_id = e.employee_id) t 
where r = 1 
order by t.project_id;

/*48
Write an SQL query that reports the books that have sold less than 10 copies in the last year, excluding books that have been available for less than one month from today. Assume today is 2019-06-23.
Return the result table in any order.
*/
create table books(
book_id int,
name varchar(20),
available_from date,
primary key(book_id)
);
insert into books values
(1,'Kalia and Demna','2010-01-01'),
(2,'28 letters','2012-05-12'),
(3,'The habbit','2019-06-10'),
(4,'13 reasons why','2019-06-01'),
(5,'The hunger games','2008-09-21');

drop table orders;
create table orders(
order_id int,
book_id int,
quantity int,
dispach_date date,
primary key(order_id),
foreign key(book_id) references books(book_id));
insert into orders values
(1,1,2,'2018-07-26'),
(2,1,1,'2018-11-05'),
(3,3,8,'2019-06-11'),
(4,4,6,'2019-06-05'),
(5,4,5,'2019-06-20'),
(6,5,9,'2009-02-02'),
(7,5,8,'2010-04-13');

select t1.book_id, t1.name 
from 
( 
(select book_id, name from Books where 
available_from < '2019-05-23') t1 
left join 
(select book_id, sum(quantity) as quantity 
from Orders 
where dispatch_date > '2018-06-23' and dispatch_date<= '2019-06-23' 
group by book_id having quantity < 10) t2 
on t1.book_id = t2.book_id );

/*49
Write a SQL query to find the highest grade with its corresponding course for each student. In case of a tie, you should find the course with the smallest course_id.
Return the result table ordered by student_id in ascending order
*/
create table enrollments(
student_id int,
course_id int,
grade int,
primary key(student_id,course_id)
);
insert into enrollments values
(2,2,95),
(2,3,95),
(1,1,90),
(1,2,99),
(3,1,80),
(3,2,75),
(3,3,82);

select t.student_id, t.course_id, t.grade 
from 
(select student_id, course_id, grade, dense_rank() over(partition by student_id 
order by grade desc, course_id) as r from enrollments) t 
where r = 1 
order by t.student_id;

/*50
The winner in each group is the player who scored the maximum total points within the group. In the case of a tie, the lowest player_id wins.
Write an SQL query to find the winner in each group. Return the result table in any order.
*/
create table players(
player_id int,
group_id int,
primary key(player_id)
);
insert into players values
(15,1),
(25,1),
(30,1),
(45,1),
(10,2),
(35,2),
(50,2),
(20,3),
(40,3);

drop table matches;
create table matches(
match_id int,
first_player int,
second_player int,
first_score int,
second_score int,
primary key(match_id)
);
insert into matches values
(1,15,45,3,0),
(2,3,25,1,2),
(3,30,15,2,0),
(4,40,20,5,2),
(5,35,50,1,1);

select t2.group_id, t2.player_id from 
( 
	select t1.group_id, t1.player_id, 
dense_rank() over(partition by group_id order by score desc, player_id) as r 
from 
( 
	select p.*, case when p.player_id = m.first_player then m.first_score 
when p.player_id = m.second_player then m.second_score 
end as score 
from 
Players p, Matches m 
where player_id in (first_player, second_player) 
	) t1 
) t2 
where r = 1;