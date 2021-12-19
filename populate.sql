DELETE FROM adCampaigns;
DELETE FROM Reparations;
DELETE FROM Tickets;
DELETE FROM Scooters;
DELETE FROM ScooterZones;
DELETE FROM Warehouses;
DELETE FROM StockManagers;
DELETE FROM SalesManagers;
DELETE FROM Customers;
DELETE FROM Users;

INSERT INTO Users(username,passworduser) VALUES
		('enrcab', '12345'),
		('mar23', 'password'),
		('f4t', 'passwerd'),
		('deltuu4', '777'),
		('daaabab', '123456'),
		('josemi1', 'aaaaaa'),
		('josemi2', '093821'),
		('josemi3', '987665'),
		('undertal3', '1234566666'),
		('andr34', 'sangregorio'),
		('sevillista2', 'sangresevilla'),
		('betico5', 'muchobeti'),
		('diosmio', 'acaba'),
		('nomasejemplos', 'conmi'),
		('nopuedomas', 'sufrimiento'),
      ('semiproGamer', 'coolpass'),
  	   ('beticoReal','12345'),
      ('willirex','007'),
      ('EdeEnrique','dfsatfg'),
      ('Santolaya','tortilla'),
      ('Cruzcampo','megustacruzcampo'),
      ('elCisterna','soyViolinista'),
      ('Bostonfk','soyrapero100'),
      ('raquelg','noestoybien'),
      ('alvaroH','megustas'),
      ('JorgeADEEstudiante','estoymamadisimo'),
      ('Gabriela','CamisetadeGrupo'),
      ('NachoJuan','tengomuchascasas69'),
      ('gormitilover61', '12345'),
      ('chuletedelbarrio101', 'martavuelveporfavor'),
      ('dreamergirl', 'harrystylessss'),
      ('miguelitoguapo', 'pewdiepie'),
      ('milkenjoyer', 'chicagobulls'),
      ('hellogoodbye', 'goodbyehello'),
      ('chess2', 'notmypassword');
		
INSERT INTO Customers(userId, dni, balance, nameCus, surname, age, paymentMethod) VALUES 
    (1, '14419838A', 47500.34, 'Benjamin', 'Shapiro', 40, 'monthly'),
    (2, '74932472M', 543.0, 'Andres', 'Shapiro', 18, 'oneTime'),
    (3, '40934402W', 10.0, 'Antonio', 'Muñoz', 20, 'monthly'),
    (4, '424324I2E', 26.7, 'David', 'Montes', 32, 'oneTime'),
    (5, '41412042P', 413.5, 'Felix', 'Undertale', 19, 'yearly'),
    (6, '48129248C', 41.4, 'Felix', 'Deltarune', 20, 'monthly'),
    (7, '12321412G', 29.8, 'Margarita', 'Flores', 79, 'monthly'),
    (8, '46890987C', 1321.4, 'Nuria', 'Jimenez', 69, 'monthly'),
    (9, '24124248H', 1345.0, 'Marcos', 'Marcos', 33, 'monthly');
    

INSERT INTO SalesManagers(userId, dni, nameSal, surname) VALUES
    (10, '19419838A', 'BenjaminMan', 'ShapiroMan'),
    (30, '15513681T', 'Patrick', 'Mclovin'),
    (31, '64736546D', 'María', 'Lorenzo'),
    (32, '98364826S', 'Naruto', 'Uzumaki'),
    (33, '43452465P', 'Sasuke', 'Uchiha'),
    (34, '54645546D', 'Luffy', 'Monkey'),
    (35, '59376949F', 'Kakashi', 'Hatake'),
    (29, '59374545F', 'Madara', 'Uchiha');
    
INSERT INTO StockManagers(userId, dni, nameSto, surname) VALUES
     (11, '15419838A', 'BenjaminSto', 'ShapiroSto'),
     (12, '11879389B', 'Lewis', 'Alonso'),
     (13, '51857355C', 'Paco', 'Corales'),
     (14, '31879385T', 'Rodolfo', 'Alonso'),
     (15, '11279381T', 'Rufino', 'Blanco'),
     (16, '41879481B', 'Martin', 'Pepino'),
     (17, '71879387T', 'Javier', 'Bezos'),
     (18, '11879585S', 'Travis', 'Scott');
    
INSERT INTO Warehouses(stockManagerId, location) VALUES
    (1, 'Avenida Taladro');
    
INSERT INTO ScooterZones(stockManagerId, location) VALUES
    (1, 'Nervión');
    
INSERT INTO scooters(licensePlate, scooterZoneId, warehouseId, scooterColor, battery, scooterType) VALUES
    ('523B', 1, null, 'Black', 56, 'city'),
    ('777V', 1, Null, 'Black', 70, 'allTerrain'),
 	 ('333V', 1, Null, 'Black', 50, 'allTerrain'),
 	 ('737V', 1, Null, 'Black', 30, 'allTerrain'),
	 ('707V', null, 1, 'Black', 30, 'allTerrain'),
	 ('709V', null, 1, 'Black', 30, 'allTerrain'),
    ('787V', 1, Null, 'Blue', 90, 'allTerrain');

INSERT INTO tickets(scooterId, customerId, numTicket, startDate, endDate, ticketType) VALUES
    (1, 1, 'T333', '2021-5-21 12:43:31', '2021-5-22 13:22:14', 'oneTime');
    
INSERT INTO reparations(scooterId, warehouseId, startDate, endDate, reparationProblem) VALUES
    (1, 1, '2021-1-1', '2021-1-2', 'WHEELS ARE BROKEN');
    
INSERT INTO AdCampaigns (salesManagerId, description, adDate, moneySpent, profit) VALUES
    (1, 'TAKE A SCOOTER YOU FOOL', '2021-12-4', 1231.45, 324.0);
    

		
