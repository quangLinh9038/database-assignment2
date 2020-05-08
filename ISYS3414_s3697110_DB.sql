


SET FOREIGN_KEY_CHECKS=0;
DROP TABLE IF EXISTS Equipment;
DROP TABLE IF EXISTS Supplier;
DROP TABLE IF EXISTS Category;
DROP TABLE IF EXISTS Stock;
DROP TABLE IF EXISTS Transaction;
DROP TABLE IF EXISTS Replacement;
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

CREATE TABLE Replacement
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

ALTER TABLE Replacement
ADD CONSTRAINT fk_replace_equip
    FOREIGN KEY (equip_code)
    REFERENCES Equipment(equip_code)
    ON DELETE CASCADE
    ON UPDATE CASCADE;
ALTER TABLE Replacement
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
INSERT INTO category (cate_name) VALUES ('Gardening Equipment');
INSERT INTO category (cate_name) VALUES ('Building Equipment');
INSERT INTO category (cate_name) VALUES ('Access Equipment');
INSERT INTO category (cate_name) VALUES ('Decorating Equipment');
INSERT INTO category (cate_name) VALUES ('Car Maintenance');
INSERT INTO category (cate_name) VALUES ('Power Tools');
INSERT INTO category (cate_name) VALUES ('Heating and Lightning');
INSERT INTO category (cate_name) VALUES ('Miscellaneous');

INSERT INTO supplier (sup_name, sup_contact, sup_address) VALUES ('Centurion', '0389989797', 'Hai Phong');
INSERT INTO supplier (sup_name, sup_contact, sup_address) VALUES ('Bosch', 'boschvn@yahoo.com', 'USA');
INSERT INTO supplier (sup_name, sup_contact, sup_address) VALUES ('Dale Lifting', '0384359897', 'Vung Tau');
INSERT INTO supplier (sup_name, sup_contact, sup_address) VALUES ('Craftsman', 'crafts@gmail.com', 'Hai Phong');
INSERT INTO supplier (sup_name, sup_contact, sup_address) VALUES ('Peiyork Emblem', 'peiyorktw@gmail.com', 'Taiwan');

INSERT INTO equipment (equip_code, equip_name, brand, price,e_quantity, sup_name, cate_name) VALUES (100600, 'Shovel', 'Gorilla', 25,50, 'Centurion', 'Gardening Equipment');
INSERT INTO equipment (equip_code, equip_name, brand, price,e_quantity, sup_name, cate_name) VALUES (100700, 'Hand Pruner', 'Felco', 20,150, 'Amazon', 'Gardening Equipment');
INSERT INTO equipment (equip_code, equip_name, brand, price,e_quantity, sup_name, cate_name) VALUES (200340, 'Compaction Plate', 'Evolution Hulk', 100,350, 'Bosch', 'Building Equipment');
INSERT INTO equipment (equip_code, equip_name, brand, price,e_quantity, sup_name, cate_name) VALUES (200350, 'Light Tower', 'Wacker Neuson', 100,5, 'Lake Dale', 'Building Equipment');
INSERT INTO equipment (equip_code, equip_name, brand, price,e_quantity, sup_name, cate_name) VALUES (300217, 'Scissor Lifts', 'HSS', 150,56, 'Dale Lifting', 'Access Equipment');
INSERT INTO equipment (equip_code, equip_name, brand, price,e_quantity, sup_name, cate_name) VALUES (300230, 'Ladder', 'Pro Shelf', 80,87, 'Speedy', 'Access Equipment');
INSERT INTO equipment (equip_code, equip_name, brand, price,e_quantity, sup_name, cate_name) VALUES (400105, 'Telescopic Rod', 'Beta Tools', 50,234, 'Craftsman', 'Car Maintenance');
INSERT INTO equipment (equip_code, equip_name, brand, price,e_quantity, sup_name, cate_name) VALUES (400130, 'Battery Starter', 'Torxe', 70,74, 'Carid', 'Car Maintenance');
INSERT INTO equipment (equip_code, equip_name, brand, price,e_quantity, sup_name, cate_name) VALUES (500505, 'Portable Welders', 'Bell', 70,12, 'Peiyork Emblem', 'Miscellaneous');
INSERT INTO equipment (equip_code, equip_name, brand, price,e_quantity, sup_name, cate_name) VALUES (600550, 'Jigsaw', 'Dewalt', 100,87, 'CPOoutlets', 'Power Tools');
INSERT INTO equipment (equip_code, equip_name, brand, price,e_quantity, sup_name, cate_name) VALUES (700870, 'Spray Gun', 'Erbauer', 30,67, 'Screwfix', 'Decorating Equipment');
INSERT INTO equipment (equip_code, equip_name, brand, price,e_quantity, sup_name, cate_name) VALUES (800099, 'Air-conditioner', 'XV20i', 300,123, 'Freshome', 'Heating and Lightning');

INSERT INTO stock (equip_code, equip_name, cate_name, s_quantity) VALUES (100600, 'Shovel', 'Gardening Equipment', 4);
INSERT INTO stock (equip_code, equip_name, cate_name, s_quantity) VALUES (200340, 'Compaction Plate', 'Building Equipment', 2);
INSERT INTO stock (equip_code, equip_name, cate_name, s_quantity) VALUES (300217, 'Scissor Lifts', 'Access Equipment', 2);
INSERT INTO stock (equip_code, equip_name, cate_name, s_quantity) VALUES (400105, 'Telescopic Rod', 'Car Maintenance', 6);
INSERT INTO stock (equip_code, equip_name, cate_name, s_quantity) VALUES (500505, 'Portable Welders', 'Miscellaneous', 10);

INSERT INTO transaction (trans_code, hiring_date, t_quantity, delivery_time, cost,total_cost, expected_return_date, equip_code, cus_ID)
VALUES (41, '2020-05-01',4,2,120,537.6,'2020-05-05',100600,3697822);
INSERT INTO transaction (trans_code, hiring_date, t_quantity, delivery_time, cost,total_cost, expected_return_date, equip_code, cus_ID)
VALUES (55, '2020-04-14',2,3,300,672,'2020-05-03',200340,3697110);
INSERT INTO transaction (trans_code, hiring_date, t_quantity, delivery_time, cost,total_cost, expected_return_date, equip_code, cus_ID)
VALUES (68, '2020-04-15',1,1,200,224,'2020-04-22',300217,3695769);
INSERT INTO transaction (trans_code, hiring_date, t_quantity, delivery_time, cost,total_cost, expected_return_date, equip_code, cus_ID)
VALUES (70, '2020-04-28',5,4,350,1470,'2020-05-02',400105,4697272);
INSERT INTO transaction (trans_code, hiring_date, t_quantity, delivery_time, cost,total_cost, expected_return_date, equip_code, cus_ID)
VALUES (72, '2020-05-02',3,6,290,584.64,'2020-05-04',500505,4698612);

INSERT INTO replacement (actual_date, equip_code, cus_ID) VALUES ('2020-05-06', 100600, 3697822);
INSERT INTO replacement (actual_date, equip_code, cus_ID) VALUES ('2020-05-02', 200340, 3697110);
INSERT INTO replacement (actual_date, equip_code, cus_ID) VALUES ('2020-04-28', 300217, 3695769);
INSERT INTO replacement (actual_date, equip_code, cus_ID) VALUES ('2020-05-04', 400105, 4697272);
INSERT INTO replacement (actual_date, equip_code, cus_ID) VALUES ('2020-03-25', 500505, 4698612);

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

-- QUERY
-- 5.Summary of income from hiring equipment for last month. The result should be sub-divided according to equipment categories.
select C.cate_name, sum(T.total_cost) as Sum_income
from Category C, Equipment E,  Transaction T
where E.cate_name = C.cate_name
and T.equip_code = E.equip_code
and MONTH(hiring_date) = MONTH(CURRENT_DATE)
group by C.cate_name;



