use Cinema;
--CREATE DATABASE Cinema;
CREATE TABLE halls
(hall_id INT NOT NULL identity(1,1),
hall_number INT NOT NULL,
place INT,
PRIMARY KEY(hall_id)
);

CREATE TABLE post(post_id INT NOT NULL identity(1,1),
post_name VARCHAR(20) NOT NULL,
post_mail VARCHAR(30) NOT NULL,
PRIMARY KEY(post_id));

CREATE TABLE postf(postf_id INT NOT NULL identity(1,1),
postf_number INT,
post_id INT FOREIGN KEY REFERENCES post(post_id),
postf_date DATE NOT NULL,
postf_price INT,
PRIMARY KEY(postf_id));

CREATE TABLE films(film_id INT NOT NULL identity(1,1),
film_name VARCHAR(20) NOT NULL,
film_zhanr VARCHAR(15) NOT NULL,
film_age VARCHAR(3) NOT NULL,
film_time TIME NOT NULL,
postf_id INT FOREIGN KEY REFERENCES postf(postf_id),
PRIMARY KEY(film_id));

CREATE TABLE seans(seans_id INT NOT NULL identity(1,1),
seans_date DATE NOT NULL,
seans_time TIME NOT NULL,
hall_id INT FOREIGN KEY REFERENCES halls(hall_id),
film_id INT FOREIGN KEY REFERENCES films(film_id),
PRIMARY KEY(seans_id));

CREATE TABLE cassa(cassa_id INT NOT NULL identity(1,1),
cassa_number INT,
cassir VARCHAR(30) NOT NULL,
PRIMARY KEY(cassa_id));

CREATE TABLE client(client_id INT NOT NULL identity(1,1),
client_name VARCHAR(20) NOT NULL,
client_mail VARCHAR(30) NOT NULL,
client_phone VARCHAR(11) NOT NULL,
PRIMARY KEY(client_id));

CREATE TABLE pay(pay_id INT NOT NULL identity(1,1),
pay_number INT NOT NULL,
pay_date DATE NOT NULL,
pay_time TIME NOT NULL,
client_id INT FOREIGN KEY REFERENCES client(client_id),
cassa_id INT FOREIGN KEY REFERENCES cassa(cassa_id),
PRIMARY KEY(pay_id));

CREATE TABLE sell(sell_id INT NOT NULL identity(1,1),
ticket_number INT NOT NULL,
pay_id INT FOREIGN KEY REFERENCES pay(pay_id),
seans_id INT FOREIGN KEY REFERENCES seans(seans_id),
sell_pay INT,
seat INT NOT NULL,
row_seat INT NOT NULL,
PRIMARY KEY (sell_id));

INSERT INTO halls (hall_number, place)
VALUES (22,100),(33,120), (55,110),(66,100), (77,120);

INSERT INTO post (post_name, post_mail)
VALUES ('Star','star123@gmail.com'),('Diamond','daimondcr@gmail.com'),('Soft','softandwet@gmail.com'),
('Tusk','actthree@gmail.com'), ('Stone','stonefree@gmail.com');

INSERT INTO postf (postf_number, post_id, postf_date, postf_price)
VALUES (2334,1,'2022.09.23',2000),
(3432,3,'2022.10.01',3000),
(1234,2,'2022.10.05',5000),
(4532,1,'2022.10.13',1500),
(2323,1,'2022.10.22',2000),
(7574,4,'2022.10.23',3450),
(0394,5,'2022.10.25',4930);

INSERT INTO films (film_name,film_zhanr,film_age,film_time, postf_id)
VALUES ('White','Боевик','16+','01:10:10',1),
('Steel Race','Комедия', '12+','01:15:39',1),
('Mr.Presedent','Комедия', '16+','02:10:39',2),
('Abyss','Детектив', '12+','02:05:40',2),
('Stone Ocean','Драма', '16+','01:30:05',3),
('Nightwing','Боевик', '16+','02:10:17',4),
('Silver Chariot','Комедия', '6+','01:45:37',5),
('Man in the mirror','Драма','12+','01:32:32',6),
('Oh no','Комедия','16+','01:54:23',7)
;

INSERT INTO seans (seans_date, seans_time, hall_id, film_id)
VALUES ('2022.11.01','13:50:00',1, 2),
('2022.11.02','13:00:00',2, 3),
('2022.11.02','17:00:00',2, 1),
('2022.11.02','20:00:00',1, 4),
('2022.11.03','09:00:00',1, 7),
('2022.11.03','12:40:00',2, 5),
('2022.11.05','18:20:00',2, 6);

INSERT INTO cassa (cassa_number, cassir)
VALUES (22,'VL022'),
(33,'SD546'),
(55,'WQ034'),
(66,'KO039'),
(77,'WP657');

INSERT INTO client (client_name, client_mail, client_phone)
VALUES ('CLIENT1','clientone@gmail.com','8996---6645'),
('CLIENT2','clienttwo@gmail.com','8987---7805'),
('CLIENT3','clientthree@gmail.com','8993---1253'),
('CLIENT4','clientfour@gmail.com','8995---1673'),
('CLIENT5','clientfive@gmail.com','8968---1624');

INSERT INTO pay (pay_number, pay_date, pay_time,client_id, cassa_id)
VALUES 
(490,'2022.11.01','15:20:13',1,2),
(350,'2022.11.01','12:20:13', 2,2),
(789,'2022.11.01','14:15:15', 3,1),
(568,'2022.11.01','16:18:35', 5,5),
(667,'2022.11.01','17:23:07', 4,1);

INSERT INTO sell (ticket_number,pay_id,seans_id, sell_pay, seat, row_seat)
VALUES 
(23, 1, 3, 500,10,8),
(25, 5, 4, 500,3,1),
(27, 3, 2,500,10,5),
(29, 2, 5,700,6,3),
(34,4,7,700,3,2);

SELECT film_name, film_zhanr, film_age, postf_number, post_name from films, postf, post where films.postf_id=postf.postf_id and postf.post_id=post.post_id;
UPDATE films SET film_name='Steel Ball Run' where film_name='Steel Race';
SELECT film_name, film_zhanr, film_age, postf_number, post_name from films, postf, post where films.postf_id=postf.postf_id and postf.post_id=post.post_id;
UPDATE films SET film_name='White Album' where film_name='White';
SELECT film_name, film_zhanr, film_age, postf_number, post_name from films, postf, post where films.postf_id=postf.postf_id and postf.post_id=post.post_id;

SELECT film_name, hall_number, seans_date, seans_time, cassa_number, client_name, sell_pay, ticket_number, seat, row_seat FROM films, halls, seans, cassa, client,pay,sell
where sell.pay_id=pay.pay_id AND pay.cassa_id=cassa.cassa_id AND pay.client_id=client.client_id AND sell.seans_id=seans.seans_id AND seans.hall_id=halls.hall_id
AND seans.film_id=films.film_id;

update client SET client_name='Terentiy' where client_name='CLIENT1';
update client SET client_name='Vladimir' where client_name='CLIENT2';
update client SET client_name='Giorno' where client_name='CLIENT3';
update client SET client_name='Trish' where client_name='CLIENT4';
update client SET client_name='Narancia' where client_name='CLIENT5';
SELECT film_name, hall_number, seans_date, seans_time, cassa_number, client_name, sell_pay, ticket_number, seat, row_seat FROM films, halls, seans, cassa, client,pay,sell
where sell.pay_id=pay.pay_id AND pay.cassa_id=cassa.cassa_id AND pay.client_id=client.client_id AND sell.seans_id=seans.seans_id AND seans.hall_id=halls.hall_id
AND seans.film_id=films.film_id;
update seans SET seans_date='2022.11.07' where seans_date='2022.11.02';
update seans SET seans_date='2022.11.08' where seans_date='2022.11.03';
update seans SET seans_date='2022.11.10' where seans_date='2022.11.05';
SELECT film_name, hall_number, seans_date, seans_time, cassa_number, client_name, sell_pay, ticket_number, seat, row_seat FROM films, halls, seans, cassa, client,pay,sell
where sell.pay_id=pay.pay_id AND pay.cassa_id=cassa.cassa_id AND pay.client_id=client.client_id AND sell.seans_id=seans.seans_id AND seans.hall_id=halls.hall_id
AND seans.film_id=films.film_id;

INSERT INTO pay (pay_number, pay_date, pay_time,client_id, cassa_id)
VALUES 
(563,'2022.11.02','12:23:16',1,3),
(756,'2022.11.02','13:20:06',1,3),
(643,'2022.11.02','13:45:15',3,4),
(796,'2022.11.02','16:12:32',3,4),
(345,'2022.11.02','16:23:07',3,4);

select * from pay;

INSERT INTO sell (ticket_number,pay_id,seans_id,sell_pay,seat, row_seat)
VALUES 
(56, 6, 7,700,10,8),
(65, 7, 5,700,3,1),
(76, 8, 2,500,10,5),
(77, 9, 5,700,6,3),
(73,10,7,700,3,2);

select * from sell;

DELETE sell WHERE ticket_number=23;
DELETE sell WHERE ticket_number=25;
DELETE sell WHERE ticket_number=27;
DELETE sell WHERE ticket_number=29;
DELETE sell WHERE ticket_number=34;
select * from sell;

DELETE pay WHERE pay_number=490;
DELETE pay WHERE pay_number=350;
DELETE pay WHERE pay_number=789;
DELETE pay WHERE pay_number=568;
DELETE pay WHERE pay_number=667;
select * from pay;