/* ISYS3414: Assignemnt 2: ER Modelling
Group 25:
Nguyen Quang Linh - s3697110
Nguyen Thanh Dat - s3697822
Nguyen Quang Huy - s369727
File created: 04/05/2020
File updated:
*/

SET FOREIGN_KEY_CHECKS=0;
DROP TABLE IF EXISTS Equipment;
DROP TABLE IF EXISTS Supplier;
DROP TABLE IF EXISTS Category;
DROP TABLE IF EXISTS Stock;
DROP TABLE IF EXISTS Transaction;
DROP TABLE IF EXISTS `Return`;
DROP TABLE IF EXISTS Log;
DROP TABLE IF EXISTS Customer;
DROP TABLE IF EXISTS PrivateCustomer;
DROP TABLE IF EXISTS BusinessCustomer;
DROP TABLE IF EXISTS Membership;

CREATE TABLE Equipment
(
    equip_code INT NOT NULL,
    equip_name VARCHAR(30) NOT NULL,
    brand      VARCHAR(20) NOT NULL,
    price      FLOAT NOT NULL,
    e_quantity INT NOT NULL,
    sup_name   VARCHAR(20) NOT NULL,
    cate_name  VARCHAR(30) NOT NULL,
    PRIMARY KEY (equip_code, equip_name)
);

CREATE TABLE Supplier
(
    sup_name        VARCHAR(20) NOT NULL,
    sup_contact     VARCHAR(30) NOT NULL,
    sup_address     VARCHAR(50) NOT NULL,
    PRIMARY KEY (sup_name)
);

CREATE TABLE Category
(
    cate_name       VARCHAR(30) NOT NULL,
    PRIMARY KEY(cate_name)
);

CREATE TABLE Stock
(
    equip_code INTEGER(10) NOT NULL,
    equip_name VARCHAR(30) NOT NULL,
    cate_name  VARCHAR(30) NOT NULL,
    s_quantity   INTEGER(5)  NOT NULL,
    PRIMARY KEY (equip_code)
);

CREATE TABLE Transaction
(
    trans_code              INTEGER(10) NOT NULL,
    hiring_date             DATE        NOT NULL,
    t_quantity              INTEGER(5)  NOT NULL,
    delivery_time           FLOAT,
    cost                    FLOAT NOT NULL,
    total_cost              FLOAT,
    expected_return_date    DATE        NOT NULL,
    equip_code              INTEGER     NOT NULL,
    cus_ID                  INTEGER     NOT NULL,
    PRIMARY KEY (trans_code, equip_code, cus_ID)
);

CREATE TABLE `Return`
(
    actual_date DATE        NOT NULL,
    equip_code  INTEGER(10) NOT NULL,
    cus_ID      INTEGER(10) NOT NULL,
    PRIMARY KEY (equip_code, cus_ID)
);

CREATE TABLE Log
(
    log_id     INTEGER     NOT NULL,
    result     VARCHAR(50),
    complaints VARCHAR(50),
    equip_code INTEGER(10) NOT NULL,
    cus_ID     INTEGER(10) NOT NULL,
    PRIMARY KEY (log_id, equip_code, cus_ID)
);

CREATE TABLE Customer
(
    cus_ID          INTEGER(10) NOT NULL,
    name            VARCHAR(30) NOT NULL,
    phone_number    INTEGER(15) NOT NULL,
    address         VARCHAR(50) NOT NULL,
    PRIMARY KEY (cus_ID)
);

CREATE TABLE PrivateCustomer
(
    cus_ID INTEGER(10) NOT NULL,
    radius FLOAT       NOT NULL,
    PRIMARY KEY (cus_ID)
);

CREATE TABLE BusinessCustomer
(
    code   VARCHAR (10) NOT NULL,
    cus_ID INTEGER(10) NOT NULL,
    PRIMARY KEY (code, cus_ID)
);

CREATE TABLE Membership
(
    code        VARCHAR (10) NOT NULL,
    title       VARCHAR(10) NOT NULL,
    discount    FLOAT NOT NULL,
    PRIMARY KEY (code)
);
COMMIT;

-- Alter table
ALTER TABLE Equipment
ADD CONSTRAINT fk_e_sup
    FOREIGN KEY (sup_name)
    REFERENCES Supplier (sup_name)
    ON DELETE CASCADE
    ON UPDATE CASCADE;
ALTER TABLE Equipment
ADD CONSTRAINT fk_e_cate
    FOREIGN KEY (cate_name)
    REFERENCES Category (cate_name)
    ON DELETE CASCADE
    ON UPDATE CASCADE;

ALTER TABLE Stock
ADD CONSTRAINT fk_st_e
    FOREIGN KEY (equip_code, equip_name)
    REFERENCES Equipment(equip_code, equip_name)
    ON DELETE CASCADE
    ON UPDATE CASCADE;
ALTER TABLE Stock
ADD CONSTRAINT fk_st_cname
    FOREIGN KEY (cate_name)
    REFERENCES Category(cate_name)
    ON DELETE CASCADE
    ON UPDATE CASCADE;


ALTER TABLE Transaction
ADD CONSTRAINT fk_trans_equip
    FOREIGN KEY (equip_code)
    REFERENCES Equipment(equip_code)
    ON DELETE CASCADE
    ON UPDATE CASCADE;
ALTER TABLE Transaction
ADD CONSTRAINT fk_trans_cus
    FOREIGN KEY (cus_ID)
    REFERENCES Customer(cus_ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE;

ALTER TABLE `Return`
ADD CONSTRAINT fk_replace_equip
    FOREIGN KEY (equip_code)
    REFERENCES Equipment(equip_code)
    ON DELETE CASCADE
    ON UPDATE CASCADE;
ALTER TABLE `Return`
ADD CONSTRAINT fk_replace_cus
    FOREIGN KEY (cus_ID)
    REFERENCES Customer(cus_ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE;

ALTER TABLE Log
ADD CONSTRAINT fk_log_equip
    FOREIGN KEY (equip_code)
    REFERENCES Equipment(equip_code)
    ON DELETE CASCADE
    ON UPDATE CASCADE;
ALTER TABLE Log
ADD CONSTRAINT fk_log_cus
    FOREIGN KEY (cus_ID)
    REFERENCES Customer(cus_ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE;

ALTER TABLE PrivateCustomer
ADD CONSTRAINT fk_pc
    FOREIGN KEY (cus_ID)
    REFERENCES Customer(cus_ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE;

ALTER TABLE BusinessCustomer
ADD CONSTRAINT fk_bc_mbs
    FOREIGN KEY (code)
    REFERENCES Membership(code)
    ON DELETE CASCADE
    ON UPDATE CASCADE;
ALTER TABLE BusinessCustomer
ADD CONSTRAINT fk_bc_cus
    FOREIGN KEY (cus_ID)
    REFERENCES Customer(cus_ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE;
COMMIT;

-- INSERT VALUES

-- Category
INSERT INTO category (cate_name) VALUES ('Gardening Equipment');
INSERT INTO category (cate_name) VALUES ('Building Equipment');
INSERT INTO category (cate_name) VALUES ('Access Equipment');
INSERT INTO category (cate_name) VALUES ('Decorating Equipment');
INSERT INTO category (cate_name) VALUES ('Car Maintenance');
INSERT INTO category (cate_name) VALUES ('Power Tools');
INSERT INTO category (cate_name) VALUES ('Heating and Lightning');
INSERT INTO category (cate_name) VALUES ('Miscellaneous');

-- Supplier
INSERT INTO supplier (sup_name, sup_contact, sup_address) VALUES ('Centurion', '0389989797', 'Hai Phong');
INSERT INTO supplier (sup_name, sup_contact, sup_address) VALUES ('Bosch', 'boschvn@yahoo.com', 'USA');
INSERT INTO supplier (sup_name, sup_contact, sup_address) VALUES ('Dale Lifting', '0384359897', 'Vung Tau');
INSERT INTO supplier (sup_name, sup_contact, sup_address) VALUES ('Craftsman', 'crafts@gmail.com', 'Hai Phong');
INSERT INTO supplier (sup_name, sup_contact, sup_address) VALUES ('Peiyork Emblem', 'peiyorktw@gmail.com', 'Taiwan');


-- Equipment
INSERT INTO equipment (equip_code, equip_name, brand, price, sup_name, cate_name, e_quantity)
VALUES (100600, 'Shovel', 'Gorilla', 25, 'Centurion', 'Gardening Equipment',25),
       (100700, 'Hand Pruner', 'Felco', 20, 'Craftsman', 'Gardening Equipment',28),
       (100800, 'Hand Sprayer', 'Chapin', 17, 'Amazon', 'Gardening Equipment',30),
       (200340, 'Compaction Plate', 'Evolution Hulk', 100, 'Bosch', 'Building Equipment',15),
       (200350, 'Light Tower', 'Wacker Neuson', 100, 'Peiyork Emblem', 'Building Equipment',27),
       (200370, 'Submersible Pump', 'Tsurumi Pump', 30, 'Hire Station', 'Building Equipment', 33),
       (300217, 'Scissor Lifts', 'HSS', 150, 'Dale Lifting', 'Access Equipment',30),
       (300230, 'Ladder', 'Pro Shelf', 80, 'Centurion', 'Access Equipment',19),
       (300280, 'Boom Lift Electric', 'Pro Lifts', 250, 'Coates Hire', 'Access Equipment', 12),
       (400105, 'Telescopic Rod', 'Beta Tools', 50, 'Craftsman', 'Car Maintenance',36),
       (400130, 'Battery Starter', 'Torxe', 70, 'Bosch', 'Car Maintenance',41),
       (400180, 'Air Compressor', 'Airmaster', 100, 'Machine Mart', 'Car Maintenance', 16),
       (500505, 'Portable Welders', 'Bell', 70, 'Peiyork Emblem', 'Miscellaneous',24),
       (600550, 'Jigsaw', 'Dewalt', 100, 'Centurion', 'Power Tools',17),
       (700870, 'Spray Gun', 'Erbauer', 30, 'Dale Lifting', 'Decorating Equipment',36),
       (800099, 'Air-conditioner', 'XV20i', 300, 'Craftsman', 'Heating and Lightning',23);

-- Stock
INSERT INTO stock (equip_code, equip_name, cate_name, s_quantity)
VALUES (100600, 'Shovel', 'Gardening Equipment', 25),
       (100700, 'Hand Pruner', 'Gardening Equipment',28),
       (100800, 'Hand Sprayer', 'Gardening Equipment',27),
       (200340, 'Compaction Plate', 'Building Equipment', 15),
       (200350, 'Light Tower', 'Building Equipment',27),
       (200370, 'Submersible Pump', 'Building Equipment', 20),
       (300217, 'Scissor Lifts', 'Access Equipment', 30),
       (300230, 'Ladder', 'Access Equipment',19),
       (300280, 'Boom Lift Electric', 'Access Equipment',8),
       (400105, 'Telescopic Rod', 'Car Maintenance', 36),
       (400130, 'Battery Starter', 'Car Maintenance',41),
       (400180, 'Air Compressor', 'Car Maintenance',13),
       (500505, 'Portable Welders', 'Miscellaneous', 24),
       (600550, 'Jigsaw', 'Power Tools',17),
       (700870, 'Spray Gun', 'Decorating Equipment',36),
       (800099, 'Air-conditioner', 'Heating and Lightning',21);

-- Transaction
INSERT INTO transaction (trans_code, hiring_date, t_quantity, delivery_time, cost,total_cost, expected_return_date, equip_code, cus_ID)
VALUES (41, '2020-05-01',4,2,120,2150.4,'2020-05-05',100600,3697822);
INSERT INTO transaction (trans_code, hiring_date, t_quantity, delivery_time, cost,total_cost, expected_return_date, equip_code, cus_ID)
VALUES (55, '2020-04-14',2,3,300,12768,'2020-05-03',200340,3697110);
INSERT INTO transaction (trans_code, hiring_date, t_quantity, delivery_time, cost,total_cost, expected_return_date, equip_code, cus_ID)
VALUES (68, '2020-04-15',1,1,200,1568,'2020-04-22',300217,3695769);
INSERT INTO transaction (trans_code, hiring_date, t_quantity, delivery_time, cost,total_cost, expected_return_date, equip_code, cus_ID)
VALUES (70, '2020-04-28',5,4,350,5880,'2020-05-02',400105,4697272);
INSERT INTO transaction (trans_code, hiring_date, t_quantity, delivery_time, cost,total_cost, expected_return_date, equip_code, cus_ID)
VALUES (72, '2020-05-02',3,6,290,1169.28,'2020-05-04',500505,4698612);
INSERT INTO transaction (trans_code, hiring_date, t_quantity, delivery_time, cost,total_cost, expected_return_date, equip_code, cus_ID)
VALUES (89, '2020-05-05',2,4,980,77616,'2020-07-10',800099,4698612);


INSERT INTO `return` (actual_date, equip_code, cus_ID) VALUES ('2020-05-06', 100600, 3697822);
INSERT INTO `return` (actual_date, equip_code, cus_ID) VALUES ('2020-05-02', 200340, 3697110);
INSERT INTO `return` (actual_date, equip_code, cus_ID) VALUES ('2020-04-28', 300217, 3695769);
INSERT INTO `return` (actual_date, equip_code, cus_ID) VALUES ('2020-05-04', 400105, 4697272);
INSERT INTO `return` (actual_date, equip_code, cus_ID) VALUES ('2020-03-25', 500505, 4698612);

INSERT INTO Log (log_id, result,complaints, equip_code, cus_ID) VALUES (001, 'refund','electricity supply fail', 100600, 3697822);
INSERT INTO Log (log_id, result,complaints, equip_code, cus_ID) VALUES (002, 'refund','wrong model', 200340, 3697110);
INSERT INTO Log (log_id, result,complaints, equip_code, cus_ID) VALUES (003, 'replace','broken wheels', 300217, 3695769);
INSERT INTO Log (log_id, result,complaints, equip_code, cus_ID) VALUES (004, 'refund','late delivery', 400105, 4697272);
INSERT INTO Log (log_id, result,complaints, equip_code, cus_ID) VALUES (005, 'replace','safety problems', 500505, 4698612);


INSERT INTO customer (cus_ID, name, phone_number, address) VALUES (3697822, 'Dat', 012345678,'Hoang Mai');
INSERT INTO customer (cus_ID, name, phone_number, address) VALUES (3697110, 'Linh', 034567298,'Le Chan');
INSERT INTO customer (cus_ID, name, phone_number, address) VALUES (3695769, 'Bach', 079865231,'Tran Nguyen Han');
INSERT INTO customer (cus_ID, name, phone_number, address) VALUES (3692796, 'Huy', 058742312,'Hoi An');
INSERT INTO customer (cus_ID, name, phone_number, address) VALUES (3695972, 'Nghia', 089582459,'Ca Mau');
INSERT INTO customer (cus_ID, name, phone_number, address) VALUES (4697272, 'Banh Mi Phuong', 058345410,'Hoi An');
INSERT INTO customer (cus_ID, name, phone_number, address) VALUES (4693598, 'Ben xe Niem Nghia', 098748238,'Tran Nguyen Han');
INSERT INTO customer (cus_ID, name, phone_number, address) VALUES (4698762, 'RMIT', 056342879,'Phu My Hung');
INSERT INTO customer (cus_ID, name, phone_number, address) VALUES (4698612, 'Vinpearl Phu Quoc',058964125 ,'Hoi An');
INSERT INTO customer (cus_ID, name, phone_number, address) VALUES (4695201, 'Lotte Mart', 076953871,'Quan 7');

INSERT INTO privatecustomer (cus_ID, radius) VALUES (3697822,8);
INSERT INTO privatecustomer (cus_ID, radius) VALUES (3697110,4);
INSERT INTO privatecustomer (cus_ID, radius) VALUES (3695769,3);
INSERT INTO privatecustomer (cus_ID, radius) VALUES (3692796,500);
INSERT INTO privatecustomer (cus_ID, radius) VALUES (3695972,300);

INSERT INTO businesscustomer (code, cus_ID) VALUES ('GD', 4697272);
INSERT INTO businesscustomer (code, cus_ID) VALUES ('SV', 4693598);
INSERT INTO businesscustomer (code, cus_ID) VALUES ('GD', 4698762);
INSERT INTO businesscustomer (code, cus_ID) VALUES ('DM', 4698612);
INSERT INTO businesscustomer (code, cus_ID) VALUES ('SV', 4695201);

INSERT INTO membership (code, title, discount) VALUES ('GD', 'Gold', 25);
INSERT INTO membership (code, title, discount) VALUES ('SV', 'Silver', 10);
INSERT INTO membership (code, title, discount) VALUES ('DM', 'Diamond', 40);
COMMIT;

SET FOREIGN_KEY_CHECKS=1;
COMMIT;

-- ---------

-- QUERIES:
-- Query 1.For given particular equipment, show current stock and current items on hire and the name of its category.
-- Author: Quang Huy
SELECT E.equip_code as code, E.equip_name as equipment, E.cate_name as category,
       (E.e_quantity - IFNULL(SUM(x.t_quantity), 0)) AS in_stock,
       IFNULL(SUM(x.t_quantity), 0) AS on_hire
FROM equipment E
    JOIN Stock st on E.cate_name = st.cate_name
    LEFT JOIN (
        SELECT t.equip_code, t.t_quantity
        FROM transaction t
        WHERE t.equip_code IN (
            SELECT t.equip_code
            FROM transaction t
            WHERE CURRENT_DATE BETWEEN t.hiring_date AND t.expected_return_date)
        ORDER BY t.equip_code) AS x on e.equip_code = x.equip_code
WHERE e.equip_code = '800099'
GROUP BY e.equip_code, e.cate_name;

-- 2. For a particular business customer, show the current items on hire with expected return dates
-- plus any previous complaints that made by that customer which involved a replacement of equipment or a full refund.
-- Author: Thanh Dat
select B.cus_ID, C.name as Customer, T.equip_code, E.equip_name as equipmennt
From businesscustomer B, transaction T, equipment E, customer C
where B.cus_ID = T.cus_ID
and T.equip_code = E.equip_code
and B.cus_ID = C.cus_ID
and B.cus_ID = 4698612;


-- Query 3: A list of names and addresses of all suppliers along with the total number of equipment
-- from all categories they currently supply.
-- Author: Quang Huy
SELECT s.sup_name, s.sup_address, SUM(e.e_quantity) AS total_equip
FROM supplier s JOIN equipment e on s.sup_name = e.sup_name JOIN stock st on e.equip_code = st.equip_code
GROUP BY s.sup_name, sup_address;


-- 4:For a given category, the total number of equipment (i.e. items) under that category available in stock
-- and the number currently on hire to customers.
-- Note: You should have at least three items under each category to display appropriate output.
-- Author: Thanh Dat
SELECT st.cate_name, SUM(st.s_quantity) AS cate_in_stock,
       IFNULL(SUM(x.t_quantity), 0) AS cate_on_hire
FROM stock st
    LEFT JOIN (
        SELECT t.equip_code, t.t_quantity
        FROM transaction t
        WHERE t.equip_code IN (
            SELECT t.equip_code
            FROM transaction t
            WHERE CURRENT_DATE BETWEEN t.hiring_date AND t.expected_return_date)
        ORDER BY t.equip_code) AS x on st.equip_code = x.equip_code
WHERE st.cate_name = 'Heating and Lightning'
GROUP BY st.cate_name;


-- 5.Summary of income from hiring equipment for last month.
-- The result should be sub-divided according to equipment categories.
-- Author: Quang Linh
select C.cate_name, sum(T.total_cost) as Sum_income
from Category C, Equipment E,  Transaction T
where E.cate_name = C.cate_name
and T.equip_code = E.equip_code
and MONTH(hiring_date) = MONTH(CURRENT_DATE)
group by C.cate_name;



