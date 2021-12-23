-- FR011
DELIMITER //
CREATE OR REPLACE PROCEDURE
    pFR011NScooterEachDayOfTheWeek()
BEGIN
    SELECT DAYNAME(startDate), COUNT(*)
    FROM Rides
    GROUP BY DAYNAME(startDate)
	 ORDER BY DAYOFWEEK(startDate);
END //
DELIMITER ;

CALL pFR011NScooterEachDayOfTheWeek;


-- FR012
DELIMITER //
CREATE OR REPLACE PROCEDURE
    pFR012BusiestDayOfTheWeekRentingScooter()
BEGIN
    SELECT DAYNAME(startDate), COUNT(*)
    FROM Rides
    GROUP BY DAYNAME(startDate) HAVING COUNT(*) >= ALL
        ( SELECT COUNT(*)
          FROM Rides
          GROUP BY DAYNAME(startDate))
	 ORDER BY DAYOFWEEK(startDate);
END //
DELIMITER ;

CALL pFR012BusiestDayOfTheWeekRentingScooter();


-- FR013
DELIMITER //
CREATE OR REPLACE PROCEDURE
    pFR013StockReplenishment(n INTEGER)
BEGIN 
    SELECT location, COUNT(scooters.scooterId)
    FROM scooterzones LEFT JOIN scooters ON
    scooterzones.scooterZoneId = scooters.scooterZoneId
    GROUP BY location HAVING COUNT(*) <= n
    ;
END //
DELIMITER ;

CALL pFR013StockReplenishment(5);


-- FR015
DELIMITER //
CREATE OR REPLACE PROCEDURE
    pFR015ScooterMostCommonColor()
BEGIN
    SELECT scooterColor, COUNT(*)
    FROM Scooters
    GROUP BY scooterColor HAVING COUNT(*) >= ALL
        ( SELECT COUNT(*)
          FROM Scooters
          GROUP BY scooterColor);
END //
DELIMITER ;

CALL pFR015ScooterMostCommonColor();