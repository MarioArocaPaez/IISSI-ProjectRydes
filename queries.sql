-- FR-001 Advertisement
CREATE OR REPLACE VIEW fFR001Advertisement AS
    SELECT adCampaignId, profit
    FROM adCampaignS
    ORDER BY profit DESC;

SELECT * FROM fFR001Advertisement;

	
-- FR002 Customer Registration
DELIMITER //
CREATE OR REPLACE PROCEDURE 
	 PFR002CustomerRegistration (username2 VARCHAR(60), passworduser2 VARCHAR(60), dni2 CHAR(9), 
	 nameofuser2 VARCHAR(20), surname2 VARCHAR(20), balance2 DOUBLE, age2 INT, paymentMethod2 ENUM('oneTime', 'monthly', 'yearly'))
	BEGIN
   	 DECLARE num2 INT;
   	 SET num2 = ((SELECT MAX(userid) FROM users) +1);
   	 INSERT INTO users (userId, username, passworduser, dni, nameofuser, surname) VALUES (num2, username2,  passworduser2, dni2, nameofuser2, surname2);
   	 INSERT INTO customers (userId, balance, age, paymentMethod) VALUES (num2, balance2, age2, paymentMethod2);
	END //
DELIMITER ;

CALL PFR002CustomerRegistration('josemi55', 'hfashfiafwi', '23456745M', 'Carlos', 'Rodriguez', 200.0, 23, 'oneTime');
DELETE FROM users WHERE username = 'josemi55';


-- FR004 Stock Consultation
DELIMITER //
CREATE OR REPLACE PROCEDURE
    pFR004StockConsultation()
BEGIN 
    SELECT COUNT(*), scooterType
    FROM scooters
    GROUP BY scooterType;
END //
DELIMITER ;

CALL pFR004StockConsultation();


-- FR-005 Scooter Subscriptions
DELIMITER //
CREATE OR REPLACE PROCEDURE
    pFR005ScooterSubscriptions()
BEGIN
    SELECT ticketType, COUNT(*)
    FROM rides
    GROUP BY ticketType
    ORDER BY COUNT(*) DESC;
END //
DELIMITER ;

CALL pFR005ScooterSubscriptions();


-- FR006 Number Scooters In Zone
DELIMITER //
CREATE OR REPLACE FUNCTION 
   FR006numberScootersInZone(zone VARCHAR(64)) RETURNS INT
BEGIN
   RETURN (SELECT COUNT(*)
      FROM scooters NATURAL JOIN scooterzones
      WHERE zone = scooterzones.location);
END //
DELIMITER ;

SELECT FR006numberScootersInZone('Nervión');


-- FR008
DELIMITER //
CREATE OR REPLACE PROCEDURE
    pFR008AddScooter(scooterId2 INT, licensePlate2 CHAR(4), scooterZoneId2 INT, warehouseId2 INT, scooterColor2 ENUM('White','Black','Red','Blue','Yellow','Green'), battery2 INT, scooterType2 ENUM('allTerrain','city','stroll'))
BEGIN
   DECLARE num INTEGER;
   SET num = ((SELECT MAX(scooterId) FROM scooters) +1); 
    IF (scooterId2 is NULL) THEN
        INSERT INTO scooters(scooterId,licensePlate, scooterZoneId, warehouseId, scooterColor, battery, scooterType) VALUES (num,licensePlate2, scooterZoneId2, warehouseId2, scooterColor2, battery2, scooterType2);
    END IF;
    IF (scooterId2 IS NOT NULL) THEN
        UPDATE scooters SET scooterId=scooterId2, licensePlate=licensePlate2, scooterZoneId=scooterZoneId2, warehouseId=warehouseId2, scooterColor=scooterColor2, battery=battery2, scooterType=scooterType2 WHERE scooterId=scooterId2;
    END IF;
END //
DELIMITER ;

CALL pFR008AddScooter(NULL, '412M', 6,NULL, 'White', 50, 'city');
CALL pFR008AddScooter(2, '468Z', 6,NULL, 'White', 50, 'city');
DELETE FROM scooters WHERE licenseplate = '412M';
DELETE FROM scooters WHERE licenseplate = '468Z';
