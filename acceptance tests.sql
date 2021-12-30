--#1 Customer Registration AT-FR-002
-- ACCEPTANCE TEST
-- Select this piece of code and execute
SET AUTOCOMMIT=0;
START TRANSACTION;
INSERT INTO Customers(userid, paymentMethod) VALUES 
    (35, 'monthly');
    /*Error de SQL (1364): Field 'age' doesn't have a default value*/
SELECT * FROM customers;
COMMIT;


--#7 Rental of available scooters AT-BR-004
-- ACCEPTANCE TEST 
-- Select this piece of code and execute
SET AUTOCOMMIT=0;
START TRANSACTION;
	INSERT INTO scooters(scooterId, licensePlate, scooterZoneId, warehouseId, scooterColor, battery, scooterType) VALUES
    (50, '451V', NULL, Null, 'Black', 56, 'city');
   INSERT INTO reparations(scooterId, warehouseId, startDate, endDate, reparationProblem) VALUES
    (50, 1, '2021-1-1', NULL, 'WHEELS ARE BROKEN');
    /*Error de SQL (1644): A scooter cannot be used while it is being repaired*/
SELECT * FROM scooters JOIN reparations ON scooters.scooterId = reparations.scooterId;
COMMIT;


-- #4 Balance Management AT-BR-009
-- ACCEPTANCE TEST 
-- Select this piece of code and execute
SET AUTOCOMMIT=0;
START TRANSACTION;
INSERT INTO Customers(userId, balance, age, paymentMethod) VALUES 
    (35, -20.34, 19, 'monthly');
    /*Error de SQL (4025): CONSTRAINT `NegativeBalance` failed for `rydes`.`customers`*/
SELECT * FROM customers;
COMMIT;


-- #5 Salary Management AT-BR-009
-- ACCEPTANCE TEST
-- Select this piece of code and execute
SET AUTOCOMMIT=0;
START TRANSACTION;
INSERT INTO SalesManagers(userId, salary) VALUES
    (35, 100.0);
    /*Error de SQL (4025): CONSTRAINT `IllegalSalary` failed for `rydes`.`salesmanagers`*/
SELECT * FROM salesmanagers;
COMMIT;


-- #2 Customer too Young AT-BR-001
-- ACCEPTANCE TEST CONSTRAINT MORE THAN 18 YEARS OLD
-- Select this piece of code and execute
SET AUTOCOMMIT=0;
START TRANSACTION;
INSERT INTO Customers(userId, balance, age, paymentMethod) VALUES 
    (35, 47500.34, 16, 'monthly');
    /*Error de SQL (4025): CONSTRAINT `CustomerTooYoung` failed for `rydes`.`customers`*/
SELECT * FROM customers;
COMMIT;


-- #6 Rules about scooters’ repairments AT-BR-006
-- ACCEPTANCE TEST BR006 #1
-- Select this piece of code and execute
SET AUTOCOMMIT=0;
START TRANSACTION;
INSERT INTO reparations(scooterId, warehouseId, startDate, endDate, reparationProblem) VALUES
    (1, 1, '2021-1-1', '2021-1-2', 'WHEELS ARE BROKEN'),
    (1, 4,'2021-11-23','2021-11-26','NO LIGHT');
    /*Error de SQL (1644): A SCOOTER CANNOT BE REPAIRED MORE THAN 2 TIMES THE SAME YEAR*/
SELECT * FROM reparations;
COMMIT;
-- ACCEPTANCE TEST BR006 #2
-- Select this piece of code and execute
SET AUTOCOMMIT=0;
START TRANSACTION;
INSERT INTO reparations(scooterId, warehouseId, startDate, endDate, reparationProblem) VALUES
    (35, 1, '2014-1-2', '2014-1-3', 'WHEELS ARE BROKEN'),
    (35, 1, '2016-1-2', '2016-1-3', 'WHEELS ARE BROKEN'),
    (35, 4,'2018-11-23','2018-11-26','NO LIGHT'),
    (35, 4,'2020-11-23','2020-11-26','NO LIGHT');
    /*Error de SQL (1644): A SCOOTER CANNOT BE REPAIRED MORE THAN 3 TIMES*/
SELECT * FROM reparations;
COMMIT;
-- ACCEPTANCE TEST BR006 #3
-- Select this piece of code and execute
SET AUTOCOMMIT=0;
START TRANSACTION;
INSERT INTO reparations(scooterId, warehouseId, startDate, endDate, reparationProblem) VALUES
    (35, 1, '2014-1-2', '2014-1-3', 'WHEELS ARE BROKEN'),
    (35, 1, '2020-1-2', '2020-1-3', 'WHEELS ARE BROKEN');
    /*Error de SQL (1644): A SCOOTER CANNOT HAVE MORE THAN 5 YEARS BETWEEN REPARATIONS*/
SELECT * FROM reparations;
COMMIT;


-- #5 No repairment during sundays AT-BR-007
-- ACCEPTANCE TEST
-- Select this piece of code and execute
SET AUTOCOMMIT=0;
START TRANSACTION;
INSERT INTO reparations(scooterId, warehouseId, startDate, endDate, reparationProblem) VALUES
    (1, 1, '2017-1-1', '2021-1-2', 'WHEELS ARE BROKEN');
    /*Error de SQL (1644): A REPARATION CAN NOT START ON SUNDAY*/
SELECT * FROM reparations;
COMMIT;