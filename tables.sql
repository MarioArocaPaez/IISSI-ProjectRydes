DROP TABLE IF EXISTS adCampaigns;
DROP TABLE IF EXISTS Reparations;
DROP TABLE IF EXISTS Rides;
DROP TABLE IF EXISTS Scooters;
DROP TABLE IF EXISTS ScooterZones;
DROP TABLE IF EXISTS Warehouses;
DROP TABLE IF EXISTS StockManagers;
DROP TABLE IF EXISTS SalesManagers;
DROP TABLE IF EXISTS Customers;
DROP TABLE IF EXISTS Users;

CREATE TABLE Users(
	userId INT NOT NULL AUTO_INCREMENT,
	username VARCHAR(60) NOT NULL,
	passworduser VARCHAR(60) NOT NULL,
	dni CHAR(9) NOT NULL,
	nameofuser VARCHAR(20),
	surname VARCHAR(20),
	PRIMARY KEY(userId),
	UNIQUE (username, dni)
);

CREATE TABLE Customers(
	customerId INT NOT NULL AUTO_INCREMENT,
	userId INT NOT NULL,
	balance DOUBLE NOT NULL DEFAULT 0,
	age INT NOT NULL,
	paymentMethod ENUM ('oneTime', 'monthly', 'yearly'), 
	PRIMARY KEY(customerId),
	FOREIGN KEY(userId) REFERENCES Users(userId)
					ON DELETE CASCADE,
	CONSTRAINT CustomerTooYoung CHECK (age>=18),
	CONSTRAINT NegativeBalance CHECK (balance>=0)
);

CREATE TABLE SalesManagers(
	salesManagerId INT NOT NULL AUTO_INCREMENT,
	userId INT NOT NULL,
	salary DOUBLE DEFAULT 900,
	PRIMARY KEY(salesManagerId),
	FOREIGN KEY(userId) REFERENCES Users(userId)
					ON DELETE CASCADE
);

CREATE TABLE StockManagers(
	stockManagerId INT NOT NULL AUTO_INCREMENT,
	userId INT NOT NULL,
	salary DOUBLE DEFAULT 900,
	PRIMARY KEY(stockManagerId),
	FOREIGN KEY(userId) REFERENCES Users(userId)
					ON DELETE CASCADE
);

CREATE TABLE Warehouses(
	warehouseId INT NOT NULL AUTO_INCREMENT,
	stockManagerId INT,
	location VARCHAR(60) NOT NULL,
	PRIMARY KEY(warehouseId),
	FOREIGN KEY(stockManagerId) REFERENCES StockManagers (stockManagerId) 
			ON DELETE SET NULL
);

CREATE TABLE ScooterZones(
	scooterZoneId INT NOT NULL AUTO_INCREMENT,
	stockManagerId INT,
	location VARCHAR(60) NOT NULL,
	PRIMARY KEY (scooterZoneId),
	FOREIGN KEY(stockManagerId) REFERENCES StockManagers (stockManagerId)
   		ON DELETE SET NULL
);

CREATE TABLE Scooters(
	scooterId INT NOT NULL AUTO_INCREMENT,
	licensePlate CHAR(4) NOT NULL,
	scooterZoneId INT,
	warehouseId INT,
	scooterColor ENUM ('White','Black','Red','Blue','Yellow','Green'),
	battery INT,
	scooterType ENUM ('allTerrain','city','stroll') NOT NULL,
	PRIMARY KEY(scooterId),
	FOREIGN KEY(scooterZoneId) REFERENCES ScooterZones (scooterZoneId) 
							ON DELETE SET NULL,
	FOREIGN KEY(warehouseId) REFERENCES Warehouses (warehouseId)
							ON DELETE SET NULL,
	UNIQUE (licensePlate),
	CONSTRAINT ScooterOnlyOnWarehouseOrZone CHECK (
    Scooters.warehouseId IS NULL
    OR Scooters.scooterZoneId IS NULL),
   CONSTRAINT BatteryOutOfLimits CHECK(battery BETWEEN 0 AND 100),
	CONSTRAINT RentingLess20Battery CHECK (Scooters.warehouseId IS NOT NULL OR Scooters.scooterZoneId IS NOT NULL OR battery >= 20)

);

CREATE TABLE Rides(
	rideId INT NOT NULL AUTO_INCREMENT,
   scooterId INT,
   customerId INT,
   numTicket VARCHAR(4) NOT NULL,
   startDate DATETIME NOT NULL,
   endDate DATETIME,
   ticketType ENUM ('oneTime', 'monthly', 'yearly'),
   PRIMARY KEY(rideid),
   FOREIGN KEY(scooterId) REFERENCES Scooters(scooterId)
					ON DELETE SET NULL,
   FOREIGN KEY(customerId) REFERENCES Customers(customerId)
					ON DELETE SET NULL,
   UNIQUE (numTicket),
   CONSTRAINT EndDateBeforeOrSameStartDate CHECK (startdate < enddate),
	CONSTRAINT NotRentedLonger3days CHECK (enddate - startdate < 3000000)
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
					ON DELETE SET NULL,
	FOREIGN KEY(warehouseId) REFERENCES Warehouses (warehouseId)
						ON DELETE SET NULL,
	CONSTRAINT EndDateBeforeOrSameStartDate CHECK (startdate < enddate )	
);

CREATE TABLE adCampaigns(
	adCampaignId INT NOT NULL AUTO_INCREMENT,
	salesManagerId INT,
	description LONGTEXT NOT NULL,
	adDate DATE,
	moneySpent DOUBLE,
	profit DOUBLE, 
	PRIMARY KEY(adCampaignId),
	FOREIGN KEY(salesManagerId) REFERENCES salesmanagers (salesManagerId)
);
