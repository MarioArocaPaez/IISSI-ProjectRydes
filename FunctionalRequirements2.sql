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


-- FR014
CREATE OR REPLACE VIEW VFR014ScooterStatus AS
    SELECT S.scooterId, S.scooterZoneId, S.warehouseId, R.reparationId
    FROM scooters S LEFT JOIN reparations R
    ON (S.scooterId = R.scooterId AND R.endDate IS NULL);
    
    SELECT * FROM VFR014ScooterStatus;


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

-- FR016
DELIMITER //
CREATE OR REPLACE PROCEDURE 	
   FR016SearchOfReparationProblems(problem VARCHAR(64))
BEGIN
   SELECT DISTINCT reparationProblem, COUNT(reparationProblem)
      FROM reparations
      WHERE reparations.reparationProblem LIKE problem
      GROUP BY reparationProblem
		ORDER BY COUNT(reparationProblem) desc;
END //
DELIMITER ;

CALL FR016SearchOfReparationProblems('%WHEEL%');
CALL FR016SearchOfReparationProblems('%BROKEN%');
CALL FR016SearchOfReparationProblems('%');


-- FR017
DELIMITER //
CREATE OR REPLACE PROCEDURE
    FR017()
BEGIN
    SELECT COUNT(DISTINCT reparationProblem), location, warehouses.warehouseId
        FROM warehouses JOIN reparations
        WHERE warehouses.warehouseId = reparations.warehouseId AND reparations.endDate IS NOT NULL
        GROUP BY warehouses.warehouseId 
        ORDER BY COUNT(reparationProblem) desc;
        
END //
DELIMITER ;

CALL FR017();


-- FR018
DELIMITER //
CREATE OR REPLACE PROCEDURE FR018(ScoId INT, wareId INT,Sdate DATE, Problem LONGTEXT)
BEGIN
    INSERT INTO reparations(scooterId, warehouseId, startDate, endDate, reparationProblem) VALUES
    (ScoId, wareId, Sdate, NULL, Problem);
   UPDATE scooters
   SET scooters.warehouseId = wareId, scooters.scooterZoneId=NULL WHERE ScoId = scooters.scooterId;
END //
DELIMITER ;

-- CALL FR018(2,8,'2021-1-1','NO HANDLEBAR');


-- FR019
DELIMITER //
CREATE OR REPLACE PROCEDURE FR019(RepId INT, Edate DATE)
BEGIN
   UPDATE reparations
   SET reparations.EndDate = Edate WHERE RepId = reparations.ReparationId;
END //
DELIMITER ;

-- CALL FR019(52, '2021-1-2');
