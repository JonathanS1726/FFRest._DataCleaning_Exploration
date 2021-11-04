
-- DATA CLEANING AND EXPLORATION IN SQL

USE USFastFoodRestaurants

SELECT *
FROM Fast_Food_Restaurants



-- RENAMING COLUMNS TO MAKE MORE SENSE OF THE DATA

EXEC sp_rename 'Fast_Food_Restaurants.F1','RecordNumber', 'COLUMN';
EXEC sp_rename 'Fast_Food_Restaurants.province','State', 'COLUMN';



-- FIXING THE RecordNumber COLUMN SO IT STARTS AT 1 INSTEAD OF 0 

SELECT RecordNumber + 1 AS RecordNumber
FROM Fast_Food_Restaurants

UPDATE Fast_Food_Restaurants
SET RecordNumber = (RecordNumber + 1);



-- CLEANING UP THE RESTAURANT NAMES 

SELECT DISTINCT name
FROM Fast_Food_Restaurants
ORDER BY name

-- 560 Distinct records
-- However, a few names showed up with typos and a few misspelled letters:

-- (Arbys, Arby's, Arby's - Closed), (B Good, B.GOOD) ,(Baker's Drive Thru, Baker's Drive-thru), (Ben & Jerry's, Ben and Jerry's), (Bob Evans, Bob Evans Restaurant), (Burger King, Burger King¬Æ), (Carl's Jr, Carl's Jr.), (Carl's Jr / Green Burrito, Carl's Jr. / Green Burrito, Carl's Jr. / The Green Burrito), (Dunkin Donuts, Dunkin' Donuts), (Five Guys Burgers And Fries, Five Guys Burgers Fries), (Fosters Freeze, Foster's Freeze), (Hardees, Hardee's), (Hardee's / Red Burrito, Hardee's/red Burrito), (Jack in the Box, Jack in the Box -), (Jimmy Johns, Jimmy John's), (Little Caesars Pizza, Little Caesar's Pizza), (Long John Silvers, Long John Silver's), (Long John Silvers / A&W, Long John Silver's / AW),(Mc Donalds, McDonalds, McDonald's, McDonalds's), (Mr Hero, Mr. Hero), (Popeyes Chicken & Biscuits, Popeyes Chicken Biscuits), (Popeyes Louisiana Kitchen, Popeye's Louisiana Kitchen), (Quiznos, Quizno's), (Raising Canes, Raising Cane's), (Rallys, Rally's), (SONIC Drive In, SONIC Drive-In), (Steak N Shake, Steak 'n Shake), (SUBWAY, SUBWAY¬Æ), (Taco Bell / KFC, Taco Bell/KFC), (Toppers Pizza, Topper's Pizza)

SELECT	DISTINCT name,
	CASE	WHEN name = 'Arbys' THEN 'Arby''s'
				WHEN name = 'Arby''s - Closed' THEN 'Arby''s'
				WHEN name = 'B Good' THEN 'B.Good'
				WHEN name = 'B.GOOD' THEN 'B.Good'
				WHEN name = 'Baker''s Drive Thru' THEN 'Baker''s Drive-thru'
				WHEN name = 'Ben and Jerry''s' THEN 'Ben & Jerry''s'
				WHEN name = 'Bob Evans' THEN 'Bob Evans Restaurant'
				WHEN name = 'Burger King¬Æ' THEN 'Burger King'
				WHEN name = 'Carl''s Jr' THEN 'Carl''s Jr.'
				WHEN name = 'Carl''s Jr / Green Burrito' THEN 'Carl''s Jr. / Green Burrito'
				WHEN name = 'Carl''s Jr / The Green Burrito' THEN 'Carl''s Jr. / Green Burrito'
				WHEN name = 'Dunkin'' Donuts' THEN 'Dunkin Donuts'
				WHEN name = 'Five Guys Burgers Fries' THEN 'Five Guys Burgers And Fries'
				WHEN name = 'Fosters Freeze' THEN 'Foster''s Freeze'
				WHEN name = 'Hardees' THEN 'Hardee''s'
				WHEN name = 'Hardee''s / Red Burrito' THEN 'Hardee''s/red Burrito'
				WHEN name = 'Jack in the Box -' THEN 'Jack in the Box'
				WHEN name = 'Jimmy Johns' THEN 'Jimmy John''s'
				WHEN name = 'Little Caesars Pizza' THEN 'Little Caesar''s Pizza'
				WHEN name = 'Long John Silvers' THEN 'Long John Silver''s'
				WHEN name = 'Long John Silvers / A&W' THEN 'Long John Silver''s / AW'
				WHEN name = 'Mc Donalds' THEN 'McDonald''s'
				WHEN name = 'McDonalds' THEN 'McDonald''s'
				WHEN name = 'McDonalds''s' THEN 'McDonald''s'
				WHEN name = 'Mr Hero' THEN 'Mr. Hero'
				WHEN name = 'Popeyes Chicken Biscuits' THEN 'Popeyes Chicken & Biscuits'
				WHEN name = 'Popeye''s Louisiana Kitchen' THEN 'Popeyes Louisiana Kitchen'
				WHEN name = 'Quiznos' THEN 'Quizno''s'
				WHEN name = 'Raising Canes' THEN 'Raising Cane''s'
				WHEN name = 'Rallys' THEN 'Rally''s'
				WHEN name = 'SONIC Drive In' THEN 'SONIC Drive-In'
				WHEN name = 'Steak N Shake' THEN 'Steak ''n Shake'
				WHEN name = 'SUBWAY¬Æ' THEN 'SUBWAY'
				WHEN name = 'Taco Bell / KFC' THEN 'Taco Bell/KFC'
				WHEN name = 'Toppers Pizza' THEN 'opper''s Pizza'
				WHEN name = 'TheMINT Gastropub' THEN 'The MINT Gastropub'
	ELSE name
END 
FROM Fast_Food_Restaurants
ORDER BY 2

-- I will create variable to store the names that are wrong and another variable for the ones that have been corrected

DECLARE @NamesToChange TABLE (FromName NVARCHAR(100), ToName NVARCHAR(100))
INSERT INTO @NamesToChange (FromName,ToName)
	VALUES	('Arbys' , 'Arby''s'),
					('Arby''s - Closed', 'Arby''s'),
					('B Good' , 'B.Good'),
					('B.GOOD' , 'B.Good'),
					('Baker''s Drive Thru' , 'Baker''s Drive-thru'),
					('Ben and Jerry''s' , 'Ben & Jerry''s'),
					('Bob Evans' , 'Bob Evans Restaurant'),
					('Burger King¬Æ' , 'Burger King'),
					('Carl''s Jr' , 'Carl''s Jr.'),
					('Carl''s Jr / Green Burrito' , 'Carl''s Jr. / Green Burrito'),
					('Carl''s Jr / The Green Burrito' , 'Carl''s Jr. / Green Burrito'),
					('Dunkin'' Donuts' , 'Dunkin Donuts'),
					('Five Guys Burgers Fries' , 'Five Guys Burgers And Fries'),
					('Fosters Freeze' , 'Foster''s Freeze'),
					('Hardees' , 'Hardee''s'),
					('Hardee''s / Red Burrito' , 'Hardee''s/red Burrito'),
					('Jack in the Box -' , 'Jack in the Box'),
					('Jimmy Johns' , 'Jimmy John''s'),
					('Little Caesars Pizza' , 'Little Caesar''s Pizza'),
					('Long John Silvers' , 'Long John Silver''s'),
					('Long John Silvers / A&W' , 'Long John Silver''s / AW'),
					('Mc Donalds' , 'McDonald''s'),
					('McDonalds' , 'McDonald''s'),
					('McDonalds''s' , 'McDonald''s'),
					('Mr Hero' , 'Mr. Hero'),
					('Popeyes Chicken Biscuits' , 'Popeyes Chicken & Biscuits'),
					('Popeye''s Louisiana Kitchen' , 'Popeyes Louisiana Kitchen'),
					('Quiznos' , 'Quizno''s'),
					('Raising Canes' , 'Raising Cane''s'),
					('Rallys' , 'Rally''s'),
					('SONIC Drive In' , 'SONIC Drive-In'),
					('Steak N Shake' , 'Steak ''n Shake'),
					('SUBWAY¬Æ' , 'SUBWAY'),
					('Taco Bell / KFC' , 'Taco Bell/KFC'),
					('Toppers Pizza' , 'opper''s Pizza'),
					('TheMINT Gastropub' , 'The MINT Gastropub')

-- Then I updated the name column with the corrected names joining the Fast_Food_Restaurants to the new table (@NamesToChange) I just created

UPDATE ff SET name = ToName
FROM dbo.Fast_Food_Restaurants ff
	INNER JOIN @NamesToChange t
	ON ff.name = t.FromName;


SELECT DISTINCT name
FROM Fast_Food_Restaurants
ORDER BY name 

-- Now only 528 Distinct records are shown after cleaning up the restaurants names



-- REMOVING DUPLICATES

SELECT *
FROM Fast_Food_Restaurants

-- How many duplicates there are?

WITH RowNumCTE AS (
SELECT	*,
				ROW_NUMBER() OVER(
				PARTITION BY	address,
											latitude,
											longitude,
											postalCode
				ORDER BY	RecordNumber
													) row_num
FROM USFastFoodRestaurants..Fast_Food_Restaurants
)
DELETE -- Replaced SELECT * with DELETE in order to remove the duplicates
FROM RowNumCTE
WHERE row_num > 1
-- Looks like 661 records are duplicates in this dataset. I proceeded to delete the duplicates using the same query but changing the SELECT with a DELETE statement



-- LET'S CREATE SOME VIEWS


-- How manny restaurants are in the dataset after data clean up?

CREATE VIEW CountOfRestaurants_V
AS
SELECT COUNT(name) AS CountOfRestaurants
FROM Fast_Food_Restaurants

SELECT * FROM CountOfRestaurants_V



-- Top 10 states with most restaurants

CREATE VIEW TopTenStates_V
AS
SELECT TOP 10	State, 
							COUNT(name) AS NumberOfRestaurants
FROM Fast_Food_Restaurants
GROUP BY State
ORDER BY NumberOfRestaurants DESC

SELECT * FROM TopTenStates_V 



-- Top 10 cities with most restaurants

CREATE VIEW TopTenCities_V
AS
SELECT TOP 10	city, 
							COUNT(city) AS NumberOfRestaurants
FROM Fast_Food_Restaurants
GROUP BY city
ORDER BY NumberOfRestaurants DESC

SELECT * FROM TopTenCities_V 



-- Top 10 Restaurants with most outlets

CREATE VIEW TopTenChainsAndOutlets_V
AS
SELECT	TOP 10 name,
				COUNT(name) AS NumberOfRestaurants
FROM Fast_Food_Restaurants
GROUP BY name
ORDER BY NumberOfRestaurants DESC 

SELECT * FROM TopTenChainsAndOutlets_V

	

-- Top 10 Restaurants with most outlets by Category

CREATE VIEW TopTenChainsByCategory_V
AS
SELECT	TOP 10 name,
		CASE 
				WHEN name = 'McDonald''s' THEN 'Burgers'
				WHEN name = 'Taco Bell' THEN 'Mexican'
				WHEN name = 'SUBWAY' THEN 'Sandwiches'
				WHEN name = 'Burger King' THEN 'Burgers'
				WHEN name = 'Arby''s' THEN 'Sandwiches'
				WHEN name = 'Wendy''s' THEN 'Burgers'
				WHEN name = 'Jack in the Box' THEN 'Burgers'
				WHEN name = 'Pizza Hut' THEN 'Pizza'
				WHEN name = 'Domino''s Pizza' THEN 'Pizza'
				WHEN name = 'Chick-Fil-A' THEN 'Chicken'
		ELSE name
END AS Category,
				COUNT(name) AS NumberOfRestaurants
FROM Fast_Food_Restaurants
GROUP BY name
ORDER BY NumberOfRestaurants DESC 

SELECT * FROM TopTenChainsByCategory_V


-- Only selected columns to export data

CREATE VIEW SelectedData_V
AS
SELECT RecordNumber, categories, city, State,  postalCode, latitude, longitude, name
FROM Fast_Food_Restaurants

SELECT * FROM SelectedData_V




