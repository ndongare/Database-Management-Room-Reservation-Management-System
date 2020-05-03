CREATE TABLE customer (CustomerID varchar(30), 
                       CustomerPassword varchar(25) NOT NULL,
                       CFName varchar(30) NOT NULL, 
					   CLName varchar(30) NOT NULL, 
					   CPhone char(12) NOT NULL, 
					   CEmail varchar(50) NOT NULL, 
					   CAptNo INT NOT NULL, 
					   CStreetName varchar(30) NOT NULL, 
					   CCity varchar(30) NOT NULL,
					   CState char(2) NOT NULL, 
					   CZip char(5) NOT NULL,
					   IDProof varchar(15) NOT NULL, 
					   IDNumber varchar(15) NOT NULL,					   

					   CONSTRAINT pass CHECK (len(CustomerPassword)>(8) AND [CustomerPassword] like '%[0-9]%' AND [CustomerPassword] <> Lower([CustomerPassword]) 
					   COLLATE Latin1_General_CS_AI),
                       CONSTRAINT CID_PK PRIMARY KEY(CustomerID),
					   CONSTRAINT email_check CHECK (CEmail LIKE '%@%'),
					   CONSTRAINT IDP CHECK (IDProof='Driving License' OR IDProof='Passport')	);
					   

CREATE TABLE property (PropertyId varchar(10), 
                       PropertyTypeId varchar(10) NOT NULL,                       
					   AptNo int NOT NULL, 
					   PStreetName varchar(30) NOT NULL, 
					   PCity varchar(30) NOT NULL,
					   PState char(2) NOT NULL, 
					   NoOfRooms int NOT NULL,
					   PropertyStatus varchar(10) NOT NULL, 
					   
                       CONSTRAINT PID_PK PRIMARY KEY(PropertyId),
					   CONSTRAINT PID_FK FOREIGN KEY(PropertyTypeId) REFERENCES property_type,
					   CONSTRAINT PS CHECK (PropertyStatus='Available' OR PropertyStatus='Reserved') 	);

CREATE TABLE property_type ( 
                       PropertyTypeId varchar(10) NOT NULL, 
					   MaxGuestsAllowed int NOT NULL, 
					   RatePerDay DECIMAL NOT NULL, 
					   PropertyType varchar(15) NOT NULL,
					   
                       CONSTRAINT PTID_PK PRIMARY KEY(PropertyTypeId),					   
					   CONSTRAINT PT CHECK(PropertyType='Villa' OR PropertyType='Bungalow' OR PropertyType='Apartment' OR PropertyType='Cottage'));

CREATE TABLE reservation (
                       ReservationID INT IDENTITY(100,1) NOT NULL ,
					   CustomerID varchar(30) NOT NULL,
					   PropertyId varchar(10) NOT NULL,
					   CancellationStatus varchar(10) DEFAULT 'Reserved',
                       CheckinDate Date NOT NULL, 
					   CheckoutDate Date NOT NULL, 
					   ReservationDate DATETIME default getdate() NOT NULL, 
					   TotalAmount DECIMAL DEFAULT 0 NOT NULL, 
					   NoOfGuests INT NOT NULL, 
					   CancellationDate DATE DEFAULT NULL, 
								  
                       CONSTRAINT RID_PK PRIMARY KEY(ReservationID),
					   CONSTRAINT RID_FK FOREIGN KEY(CustomerId) REFERENCES customer,
					   CONSTRAINT RID_FK1 FOREIGN KEY(PropertyId) REFERENCES property,
					   CONSTRAINT CheckinC CHECK(CheckinDate>getDate()),
					   CONSTRAINT CheckoutC CHECK(CheckoutDate > getDate()),
					   CONSTRAINT CS CHECK (CancellationStatus='Reserved' or CancellationStatus='Cancelled')	);


CREATE TABLE available_services (
                       ServiceID varchar(10) NOT NULL, 
                       ServiceName varchar(25) NOT NULL, 
					   ServiceDesc varchar(100) NOT NULL, 
					   ServiceCost Decimal NOT NULL, 					   

                       CONSTRAINT SID_PK PRIMARY KEY(ServiceID)	);

CREATE TABLE reservation_services (
                       ServiceID varchar(10) NOT NULL, 
                       ReservationID INT NOT NULL,
                       ServiceDate Date default getdate() NOT NULL, 			   

                       CONSTRAINT RSID_PK PRIMARY KEY(ServiceId, ReservationId),
					   CONSTRAINT RSID_FK1 FOREIGN KEY(ServiceId) REFERENCES available_services,
					   CONSTRAINT RSID_FK2 FOREIGN KEY(ReservationId) REFERENCES reservation
					   	);
						

CREATE TABLE payment_method(
                       PaymentMethodID INT IDENTITY(10000,1) NOT NULL, 
                       ReservationID INT NOT NULL,
                       CardNumber Numeric(16) NOT NULL,
					   ExpiryDate Date NOT NULL,
					   NameonCard varchar(30) NOT NULL,
					   CVV NUMERIC(3) NOT NULL

                       CONSTRAINT PM_PK PRIMARY KEY(PaymentMethodID),
					   CONSTRAINT PM_FK FOREIGN KEY(ReservationID) REFERENCES reservation,
					   	);

CREATE TABLE Customer_feedback(
                       PropertyID varchar(10) NOT NULL, 
					   ReservationID INT NOT NULL,
					   Feedback varchar(100) NOT NULL,
					   Ratings numeric(1) NOT NULL

                       CONSTRAINT CF_PK PRIMARY KEY(PropertyID, ReservationID),
					   CONSTRAINT CF_FK1 FOREIGN KEY(PropertyID) REFERENCES property,
					   CONSTRAINT CF_FK2 FOREIGN KEY(ReservationID) REFERENCES reservation,
					   CONSTRAINT CFR CHECK(Ratings<=5 and Ratings>=0)
					   	);
-----------------------------------------------------------------------------------------------------------------------------------
Drop table Customer_feedback
Drop table reservation_services
Drop table available_services
drop table payment_method

Drop table customer
Drop table reservation
Drop table property_type
Drop table property
-------------------------------------------------------------------------------------------------------------------------------------------

--Insertion:

INSERT INTO customer values('akshay','Akshay123', 'akshay', 'sigar','315-913-5157','akshays@gmail.com','112','Lafayeete Rd','Syracuse','NY','13205','Passport','P123465');
INSERT INTO customer values('nikita','Nikita567', 'Nikita', 'Dongare','315-913-5125','nikita11@gmail.com','512','Lancaster Ave','Syracuse','NY','13210','Passport','P875263');
INSERT INTO customer values('rahul','Rahul2309', 'Rahul', 'Wable','315-628-7280','rahulwable@gmail.com','203','Dell St','Syracuse','NY','13205','Driving License','S7215631');
INSERT INTO customer values('josh','Magnitude56', 'Josh', 'Steve','315-913-2880','josh97@gmail.com','720','Westcott St','Syracuse','NY','13210','Passport','S2503674');
INSERT INTO customer values('meghan','Sqlite127', 'Meghan', 'James','315-913-2057','meghanj@gmail.com','920','Comstock Ave','Syracuse','NY','13210','Driving License','D8567561');
INSERT INTO customer values('neha','Nehad1234', 'Neha', 'D','315-913-7458','neha123@gmail.com','540','Lafayeete Rd','Syracuse','NY','13205','Passport','P785741');
INSERT INTO customer values('nick','Thomas2597', 'Nick', 'Thomas','315-417-0012','nickth@gmail.com','741','Lancaster Ave','Syracuse','NY','13210','Driving License','D7458741');
INSERT INTO customer values('sophia','SophiaJo45', 'Sophia', 'Jaden','315-621-7880','sophiaj@gmail.com','23','Dell St','Syracuse','NY','13210','Driving License','D4215042');
INSERT INTO customer values('Joey','Joeyt1997', 'Joey', 'Johnson','315-728-0578','joeyt@gmail.com','270','Westcott St','Syracuse','NY','13210','Passport','P745892');
INSERT INTO customer values('Mark','Chocolates579', 'Mark', 'Bing','315-913-7847','bingmark@gmail.com','120','Comstock Ave','Syracuse','NY','13210','Passport','D7854697');


INSERT INTO property_type values('PT01','8','200','Villa')
INSERT INTO property_type values('PT02','4','100','Apartment')
INSERT INTO property_type values('PT03','6','300','Bungalow')
INSERT INTO property_type values('PT04','5','250','Cottage')
INSERT INTO property_type values('PT05','10','500','Villa')
INSERT INTO property_type values('PT06','5','200','Apartment')


INSERT INTO property values('P1','PT01', '12', 'East Gennese St','Syracuse','NY','6','Available');
INSERT INTO property values('P2','PT02', '53', 'Columbus Ave','Syracuse','NY','3','Available');
INSERT INTO property values('P3','PT01', '414', 'South Beech St','Syracuse','NY','6','Available');
INSERT INTO property values('P4','PT03', '115', 'Maryland Ave','Syracuse','NY','6','Available');
INSERT INTO property values('P5','PT04', '531', 'East Gennese St','Syracuse','NY','4','Available');
INSERT INTO property values('P6','PT05', '258', 'Lancaster Ave','Syracuse','NY','6','Available');
INSERT INTO property values('P7','PT01', '721', 'Ostrom Ave','Syracuse','NY','5','Available');
INSERT INTO property values('P8','PT05', '400', 'Liverpool','Syracuse','NY','6','Available');
INSERT INTO property values('P9','PT02', '95', 'Maryland Ave','Syracuse','NY','2','Available');
INSERT INTO property values('P10','PT06', '148', 'Westcotte St','Syracuse','NY','4','Available');


INSERT INTO reservation(CustomerID,PropertyID,CancellationStatus,CheckinDate,CheckoutDate,ReservationDate,TotalAmount,NoofGuests,CancellationDate) 
values('nikita', 'P5','Reserved','2020-11-12','2020-11-14','2018-11-10','570','4',DEFAULT);
INSERT INTO reservation values('akshay', 'P2','Reserved','2020-08-10','2020-08-13','2019-08-08','435','3',DEFAULT);
INSERT INTO reservation values('akshay', 'P4','Reserved','2019-08-10','2020-08-13','2019-08-08','435','3',DEFAULT);
INSERT INTO reservation values('akshay', 'P8','Reserved','2019-12-18','2019-12-19','2019-08-08','435','3',DEFAULT);
INSERT INTO reservation values('akshay', 'P1','Reserved','2020-08-10','2020-08-13','2019-08-08','435','3',DEFAULT);
INSERT INTO reservation values('akshay', 'P3','Reserved','2020-08-10','2020-08-13','2019-08-08','435','3',DEFAULT);
INSERT INTO reservation values('nikita', 'P5','Reserved','2019-10-12','2019-10-14','2019-10-10','515','4',DEFAULT);
INSERT INTO reservation values('rahul', 'P5','Reserved','2016-12-12','2016-12-14','2016-12-10','520','4',DEFAULT);
INSERT INTO reservation values('josh', 'P3','Reserved','2018-12-25','2018-12-31','2018-12-23','1220','6',DEFAULT);
INSERT INTO reservation values('meghan', 'P1','Reserved','2018-12-27','2018-12-31','2018-12-25','850','8',DEFAULT);
INSERT INTO reservation values('neha', 'P3','Reserved','2019-10-25','2019-10-27','2019-10-15','500','7',DEFAULT);
INSERT INTO reservation values('nick', 'P7','Reserved','2019-10-12','2019-10-14','2019-09-30','435','5',DEFAULT);
INSERT INTO reservation values('nikita', 'P1','Reserved','2017-12-12','2017-12-16','2017-12-1','800','8',DEFAULT);
INSERT INTO reservation values('sophia', 'P1','Reserved','2019-10-02','2019-10-05','2019-09-23','600','6',DEFAULT);
INSERT INTO reservation values('mark', 'P6','Reserved','2019-10-27','2019-10-31','2019-09-25','2070','4',DEFAULT);
INSERT INTO reservation values('joey', 'P4','Reserved','2019-10-6','2019-10-14','2019-09-15','2400','5',DEFAULT);
INSERT INTO reservation values('akshay', 'P8','Reserved','2019-10-12','2019-10-16','2019-09-01','2020','8',DEFAULT);
INSERT INTO reservation values('sophia', 'P9','Reserved','2018-10-02','2018-10-05','2018-09-23','315','6',DEFAULT);
INSERT INTO reservation values('mark', 'P10','Reserved','2015-10-27','2015-10-31','2015-09-25','850','4',DEFAULT);
INSERT INTO reservation values('nick', 'P1','Reserved','2019-10-20','2019-10-22','2019-09-25','400','5',DEFAULT);

INSERT INTO available_services values('S1','Gym','Well equiped professional gym and other recreational activities','50')
INSERT INTO available_services values('S2','WiFi','24*7 Internet Access','20')
INSERT INTO available_services values('S3','Laundry','Laundry within the house is charged at $15 per load','15')
INSERT INTO available_services values('S4','Breakfast, Lunch & Dinner','Food buffets charged per person','50')

INSERT INTO reservation_services values('S1','100','2018-11-12')
INSERT INTO reservation_services values('S2','100','2018-11-12')
INSERT INTO reservation_services values('S4','101','2019-08-10')
INSERT INTO reservation_services values('S2','101','2019-08-10')
INSERT INTO reservation_services values('S3','101','2019-08-10')
INSERT INTO reservation_services values('S1','101','2019-08-10')
INSERT INTO reservation_services values('S3','102','2019-10-12')
INSERT INTO reservation_services values('S2','103','2016-12-12')
INSERT INTO reservation_services values('S2','104','2018-12-25')
INSERT INTO reservation_services values('S1','105','2018-12-27')
INSERT INTO reservation_services values('S1','106','2019-10-25')
INSERT INTO reservation_services values('S4','106','2019-10-25')
INSERT INTO reservation_services values('S3','107','2019-10-12')
INSERT INTO reservation_services values('S2','107','2019-10-12')
INSERT INTO reservation_services values('S2','110','2019-10-27')
INSERT INTO reservation_services values('S1','110','2019-10-27')
INSERT INTO reservation_services values('S3','113','2018-10-02')
INSERT INTO reservation_services values('S1','114','2015-10-27')
INSERT INTO reservation_services values('S2','112','2019-10-12')


INSERT INTO payment_method (ReservationID,CardNumber,ExpiryDate,NameonCard,CVV)
values('100','6011524011201111','2024-10-25','Nikita Dongare','251')
INSERT INTO payment_method values('101','9000525242417896','2023-11-05','Akshay Sigar','101')
INSERT INTO payment_method values('102','6001002504050789','2021-10-30','Nikita Dongare','875')
INSERT INTO payment_method values('103','5278142563529874','2019-12-31','Rahul Wable','485')
INSERT INTO payment_method values('104','9785100050004102','2020-07-25','Josh Steve','633')
INSERT INTO payment_method values('105','7412853695221000','2024-05-05','Meghan James','114')
INSERT INTO payment_method values('106','9896152045894447','2022-11-05','Neha Dongare','310')
INSERT INTO payment_method values('107','5078902557850012','2021-11-03','Nick Thomas','785')
INSERT INTO payment_method values('108','6001002504050789','2021-10-30','Nikita Dongare','875')
INSERT INTO payment_method values('109','5201258442261002','2024-01-25','Sophia Jaden','753')
INSERT INTO payment_method values('110','9875632100257586','2023-07-05','Mark Bing','856')
INSERT INTO payment_method values('111','6006657842531025','2024-01-30','Joey Johnson','505')
INSERT INTO payment_method values('112','9000525242417896','2023-11-05','Akshay Sigar','101')
INSERT INTO payment_method values('113','5201258442261002','2024-01-25','Sophia Jaden','753')
INSERT INTO payment_method values('114','9875632100257586','2023-07-05','Mark Bing','856')
INSERT INTO payment_method values('115','5078902557850012','2021-11-03','Nick Thomas','785')

INSERT INTO customer_feedback values('P5','100','Amazing experience','5')
INSERT INTO customer_feedback values('P2','101','Good Host! Clean property','3')
INSERT INTO customer_feedback values('P5','102','Great experience','4')
INSERT INTO customer_feedback values('P5','103','Amazing experience','4')
INSERT INTO customer_feedback values('P3','104','Unclean property','1')
INSERT INTO customer_feedback values('P1','105','Great experience! Would definitely visit again','5')
INSERT INTO customer_feedback values('P3','106','Unclean property, Shady location','2')
INSERT INTO customer_feedback values('P7','107','Enjoyed the stay, value for money','3')
INSERT INTO customer_feedback values('P1','108','Amazing location, definitely recommended','4')
INSERT INTO customer_feedback values('P1','109','Value for money, Good Host','5')
INSERT INTO customer_feedback values('P6','110','Friendly caretaker, Services provided were great','3')
INSERT INTO customer_feedback values('P4','111','Lovely experience! Would definitely visit again','5')
INSERT INTO customer_feedback values('P8','112','Amazing experience','5')
INSERT INTO customer_feedback values('P9','113','Location is not good','1')
INSERT INTO customer_feedback values('P10','114','Great experience!','4')
INSERT INTO customer_feedback values('P1','115','Great experience! Would definitely visit again','5')

--------------------------------------------
--select queries:

select * from customer
select * from reservation
select * from property_type
select * from property
select * from available_services
select * from reservation_services
select * from payment_method
select * from customer_feedback
---------------------------
---Triggers

--Trigger 1:
CREATE TRIGGER totalamt
ON reservation
AFter INSERT
AS
BEGIN

    UPDATE reservation 
    SET TotalAmount=(Select PT.Rateperday*(DATEDIFF(d, i.CheckinDate, i.CheckoutDate))
FROM inserted i
JOIN property P
ON P.PropertyId=i.propertyid
JOIN property_type PT
ON PT.propertytypeId= P.propertytypeId
) where reservation.ReservationID=(select ReservationID from inserted)
END

drop trigger totalamt


--trigger2

CREATE TRIGGER totalamtwservices
ON reservation_services
AFter INSERT
AS
BEGIN

    UPDATE reservation 
    SET TotalAmount=(
	Select x.total+y.total from

(Select distinct PT.Rateperday*(DATEDIFF(d, i.CheckinDate, i.CheckoutDate))as total 
FROM reservation i
JOIN 
inserted rs
ON
i.reservationID=rs.reservationID
JOIN
property P
ON P.PropertyId=i.propertyid
JOIN property_type PT
ON PT.propertytypeId= P.propertytypeId)y,

(select sum(a.ServiceCost)as total from available_services a
JOIN
reservation_services rs
ON a.serviceID=rs.serviceID
where rs.reservationID=(select ReservationID from inserted)
group by rs.reservationID)x 
	
) where reservation.ReservationID=(select ReservationID from inserted)
END



-------------------
--Views:
DROP VIEW PropertyPresent

Create View PropertyPresent as
select p.propertyID,p.propertyTypeID,p.AptNo,p.PStreetName,p.PCity,p.PState,p.NoOfRooms,pt.MaxGuestsAllowed,pt.RateperDay,pt.PropertyType 
from property p
JOIN
Property_type pt
ON
p.propertyTypeID=pt.propertyTypeID


--------------------------------------------------------
--DATA QUESTIONS
--3.WHICH PROPERTIES HAVE RECEIVED AN AVERAGE RATING OF MORE THAN 3?

SELECT P.PropertyId, P.PropertyTypeId,PT.PropertyType, P.AptNo,P.PStreetName,P.PCity,P.PState,P.NoOfRooms,PT.Rateperday, a.Average_Rating
FROM (SELECT AVG(CF.Ratings) as Average_Rating, CF.PropertyId 
from Customer_feedback as CF 
GROUP BY CF.PropertyId
HAVING AVG(CF.Ratings) > 3) a
JOIN Property as P
ON a.PropertyId=P.PropertyId
JOIN Property_type as PT
ON P.PropertyTypeId=PT.PropertyTypeId

--4. Which customer made the maximum reservations between  2015 and 2019?
SELECT C.CustomerId,C.CFName,C.CLName, COUNT(C.CustomerId) as NoOfreservations 
FROM Reservation as R
JOIN Customer as C
ON C.CustomerId=R.CustomerId
WHERE YEAR(R.ReservationDate)>=2015 and YEAR(R.ReservationDate)<=2019
GROUP BY C.CustomerId,C.CFName,C.CLName
ORDER BY NoOfreservations DESC

SELECT C.CustomerId,C.CFName,C.CLName, COUNT(R.CustomerId) as NumberofReservations 
FROM Customer as C
JOIN Reservation as R
ON C.CustomerId=R.CustomerId    
WHERE YEAR(R.ReservationDate)>=2015 and YEAR(R.ReservationDate)<=2019
GROUP BY C.CustomerId,C.CFName,C.CLName
HAVING COUNT(R.CustomerId)= (SELECT MAX(a.NoOfreservations) FROM (SELECT CustomerId, COUNT(CustomerId) as NoOfreservations FROM Reservation 
GROUP BY CustomerId)a)

--1. Which month had maximum number of reservations?
SELECT DATENAME(MONTH,(CheckinDate)) as Month_, COUNT(DATENAME(MONTH,CheckinDate)) as NoOfreservations
FROM Reservation
GROUP BY DATENAME(MONTH,CheckinDate)

SELECT DATENAME(MONTH,CheckinDate) as Month_ ,COUNT(DATENAME(MONTH,CheckinDate)) as NumberofReservations 
FROM Reservation 
GROUP BY DATENAME(MONTH,CheckinDate)
HAVING COUNT(DATENAME(MONTH,CheckinDate)) = (SELECT MAX(b.NoOfreservations) as NoOfreservations
FROM (SELECT DATENAME(MONTH,(CheckinDate)) as Month_, COUNT(DATENAME(MONTH,CheckinDate)) as NoOfreservations
FROM Reservation
GROUP BY DATENAME(MONTH,CheckinDate)) b )

--5. Which type of property was booked maximum number of times? e.g villa,cottage,eTC

SELECT R.PropertyId, Count(R.PropertyId) as Numberofreservations
FROM Reservation as R
GROUP BY R.PropertyId

CREATE VIEW PropTypereserve as (
SELECT C.PropertyId, C.Numberofreservations, PT.PropertytypeId,PT.PropertyType
FROM
(SELECT PropertyId, Count(PropertyId) as Numberofreservations
FROM Reservation 
GROUP BY PropertyId)C
JOIN Property as P
ON C.PropertyId=P.PropertyId
JOIN Property_type as PT
ON PT.PropertyTypeId=P.PropertyTypeId
)

SELECT Propertytype, SUM(Numberofreservations) as Numberofreservations
FROM PropTypereserve
GROUP BY Propertytype
HAVING SUM(Numberofreservations)= (SELECT MAX(D.Numberofreservations)
FROM (SELECT PropertyType, SUM(Numberofreservations) as NumberOfreservations
FROM PropTypereserve
GROUP BY PropertyType)D)

--2.Which month had most service requests in 2019?

SELECT DATENAME(MONTH,(ServiceDate)) as Month_, COUNT(DATENAME(MONTH,ServiceDate)) as NoOfservicereservations
FROM Reservation_services
WHERE YEAR(ServiceDate)=2019
GROUP BY DATENAME(MONTH,ServiceDate)

SELECT DATENAME(MONTH,ServiceDate) as Month_ ,COUNT(DATENAME(MONTH,ServiceDate)) as NumberofserviceReservations 
FROM Reservation_services
WHERE YEAR(ServiceDate)=2019
GROUP BY DATENAME(MONTH,ServiceDate)
HAVING COUNT(DATENAME(MONTH,ServiceDate)) = (SELECT MAX(b.NoOfservicereservations) as NoOfservicereservations
FROM (SELECT DATENAME(MONTH,(ServiceDate)) as Month_, COUNT(DATENAME(MONTH,ServiceDate)) as NoOfservicereservations
FROM Reservation_services
WHERE YEAR(ServiceDate)=2019
GROUP BY DATENAME(MONTH,ServiceDate)) b )


--------------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE Administrator (AdminID varchar(30), 
                       AdminPassword varchar(25) NOT NULL,

					   CONSTRAINT passw CHECK (len(AdminPassword)>(8) AND [AdminPassword] like '%[0-9]%' AND [AdminPassword] <> Lower([AdminPassword]) 
					   COLLATE Latin1_General_CS_AI),
                       CONSTRAINT AID_PK PRIMARY KEY(AdminID))

INSERT INTO Administrator VALUES('Admin','Admin12345')

Select x.PropertyType as PropertyType, Sum(x.NoOfReservation) as TotalNoOfReservation from
(
SELECT  C.Numberofreservations as NoOfReservation, PT.PropertyType as PropertyType
FROM
(SELECT PropertyId, Count(PropertyId) as Numberofreservations
FROM Reservation
GROUP BY PropertyId)C
JOIN Property as P
ON C.PropertyId=P.PropertyId
JOIN Property_type as PT
ON PT.PropertyTypeId=P.PropertyTypeId
)x group by x.PropertyType having SUM(x.NoOfReservation)=

(Select Max(y.TotalNoOfReservation) from
(Select Sum(x.NoOfReservation) as TotalNoOfReservation,x.PropertyType as PropertyType from
(
SELECT  C.Numberofreservations as NoOfReservation, PT.PropertyType as PropertyType
FROM
(SELECT PropertyId, Count(PropertyId) as Numberofreservations
FROM Reservation
GROUP BY PropertyId)C
JOIN Property as P
ON C.PropertyId=P.PropertyId
JOIN Property_type as PT
ON PT.PropertyTypeId=P.PropertyTypeId
)x group by x.PropertyType)y)


select * from reservation

select DATEDIFF(d,'2019/12/15','2019/12/11') from reservation where ReservationId='100'

DATEDIFF(d,'2019/12/12','2019/12/11')