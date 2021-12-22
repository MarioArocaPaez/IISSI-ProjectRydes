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
   	 SET num2 = ((SELECT COUNT(*) FROM users) +1);
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