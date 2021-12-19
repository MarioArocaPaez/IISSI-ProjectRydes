DROP TABLE IF EXISTS adCampaigns;
DROP TABLE IF EXISTS Reparations;
DROP TABLE IF EXISTS Tickets;
DROP TABLE IF EXISTS Scooters;
DROP TABLE IF EXISTS ScooterZones;
DROP TABLE IF EXISTS Warehouses;
DROP TABLE IF EXISTS StockManagers;
DROP TABLE IF EXISTS SalesManagers;
DROP TABLE IF EXISTS Customers;
DROP TABLE IF EXISTS Users;

CREATE TABLE Users(
	userId INT NOT NULL AUTO_INCREMENT,
	username VARCHAR(60),
	passworduser VARCHAR(60),
	PRIMARY KEY(userId),
	UNIQUE (username)
);

CREATE TABLE Customers(
	customerId INT NOT NULL AUTO_INCREMENT,
	dni CHAR(9),
	userId INT NOT NULL,
	balance DOUBLE,
	nameCus VARCHAR(20),
	surname VARCHAR(20),
	age INT,
	paymentMethod ENUM ('oneTime', 'monthly', 'yearly'), 
	PRIMARY KEY(customerId),
	FOREIGN KEY(userId) REFERENCES Users(userId)
					ON DELETE CASCADE,
	UNIQUE (dni),
	CONSTRAINT CustomerTooYoung CHECK (age>=18),
	CONSTRAINT NegativeBalance CHECK (balance>=0)
);

CREATE TABLE SalesManagers(
	salesManagerId INT NOT NULL AUTO_INCREMENT,
	dni CHAR(9),
	userId INT,
	NameSal VARCHAR(20),
	surname VARCHAR(20),
	PRIMARY KEY(salesManagerId),
	FOREIGN KEY(userId) REFERENCES Users(userId)
					ON DELETE CASCADE,
	UNIQUE (dni)
);

CREATE TABLE StockManagers(
	stockManagerId INT NOT NULL AUTO_INCREMENT,
	dni CHAR(9),
	userId INT,
	NameSto VARCHAR(20),
	surname VARCHAR(20),
	PRIMARY KEY(stockManagerId),
	FOREIGN KEY(userId) REFERENCES Users(userId)
					ON DELETE CASCADE,
	UNIQUE (dni)
);

CREATE TABLE Warehouses(
	warehouseId INT NOT NULL AUTO_INCREMENT,
	stockManagerId INT,
	location VARCHAR(60),
	PRIMARY KEY(warehouseId),
	FOREIGN KEY(stockManagerId) REFERENCES StockManagers (stockManagerId) 
			ON DELETE SET NULL
);

CREATE TABLE ScooterZones(
	scooterZoneId INT NOT NULL AUTO_INCREMENT,
	stockManagerId INT,
	location VARCHAR(60),
	PRIMARY KEY (scooterZoneId),
	FOREIGN KEY(stockManagerId) REFERENCES StockManagers (stockManagerId)
   		ON DELETE SET NULL
);

CREATE TABLE Scooters(
	scooterId INT NOT NULL AUTO_INCREMENT,
	licensePlate CHAR(4),
	scooterZoneId INT,
	warehouseId INT,
	scooterColor ENUM ('White','Black','Red','Blue','Yellow','Green'),
	battery INT,
	scooterType ENUM ('allTerrain','city','stroll'),
	PRIMARY KEY(scooterId),
	FOREIGN KEY(scooterZoneId) REFERENCES ScooterZones (scooterZoneId) 
							ON DELETE SET NULL,
	FOREIGN KEY(warehouseId) REFERENCES Warehouses (warehouseId)
							ON DELETE SET NULL,
	UNIQUE (licensePlate),
	CONSTRAINT ScooterOnlyOnWarehouseOrZone CHECK (
    (Scooters.scooterZoneId IS NOT NULL AND Scooters.warehouseId IS NULL)
    OR (Scooters.scooterZoneId IS NULL AND Scooters.warehouseId IS NOT NULL)),
   CONSTRAINT BatteryOutOfLimits CHECK(battery <= 100 AND battery >= 0)

);

CREATE TABLE Tickets(
   ticketId INT NOT NULL AUTO_INCREMENT,
   scooterId INT,
   customerId INT,
   numTicket VARCHAR(4) NOT NULL,
   startDate DATETIME,
   endDate DATETIME,
   ticketType ENUM ('oneTime', 'monthly', 'yearly'),
   PRIMARY KEY(ticketId),
   FOREIGN KEY(scooterId) REFERENCES Scooters(scooterId)
					ON DELETE SET NULL,
   FOREIGN KEY(customerId) REFERENCES Customers(customerId)
					ON DELETE SET NULL,
   UNIQUE (numTicket),
   CONSTRAINT EndDateBeforeOrSameStartDate CHECK (startdate < enddate)	
);

CREATE TABLE Reparations(
	reparationId INT NOT NULL AUTO_INCREMENT,
	scooterId INT,
	warehouseId INT,
	startDate DATE,
	endDate DATE,
	reparationProblem LONGTEXT,
	PRIMARY KEY(reparationId),
	FOREIGN KEY(scooterId) REFERENCES Scooters(scooterId)
					ON DELETE CASCADE,
	FOREIGN KEY(warehouseId) REFERENCES Warehouses (warehouseId)
						ON DELETE CASCADE,
	CONSTRAINT EndDateBeforeOrSameStartDate CHECK (startdate < enddate)	
);

CREATE TABLE adCampaigns(
	adCampaignId INT NOT NULL AUTO_INCREMENT,
	salesManagerId INT,
	description LONGTEXT,
	adDate DATE,
	moneySpent DOUBLE,
	profit DOUBLE, 
	PRIMARY KEY(adCampaignId),
	FOREIGN KEY(salesManagerId) REFERENCES salesmanagers (salesManagerId)
);