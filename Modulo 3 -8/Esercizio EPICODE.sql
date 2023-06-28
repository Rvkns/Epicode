/** Operazione DDL: creazione delle tabelle e definizione delle relazioni:

CREATE TABLE Consumer (
  Consumer_ID VARCHAR(10) PRIMARY KEY,
  City VARCHAR(50),
  State VARCHAR(50),
  Country VARCHAR(50),
  Latitude DECIMAL(9, 6),
  Longitude DECIMAL(9, 6),
  Smoker VARCHAR(3),
  Drink_Level VARCHAR(15),
  Transportation_Method VARCHAR(20),
  Marital_Status VARCHAR(20),
  Children VARCHAR(20),
  Age INTEGER,
  Occupation VARCHAR(50),
  Budget VARCHAR(10)
);

CREATE TABLE Restaurant (
  Restaurant_ID VARCHAR(10) PRIMARY KEY,
  Name VARCHAR(100),
  City VARCHAR(50),
  State VARCHAR(50),
  Country VARCHAR(50),
  Zip_Code VARCHAR(20),
  Latitude DECIMAL(9, 6),
  Longitude DECIMAL(9, 6),
  Alcohol_Service VARCHAR(20),
  Smoking_Allowed VARCHAR(3),
  Price VARCHAR(10),
  Franchise VARCHAR(3),
  Area VARCHAR(20),
  Parking VARCHAR(10)
);

CREATE TABLE Cuisine (
  Cuisine_ID VARCHAR(10) PRIMARY KEY,
  Cuisine VARCHAR(50)
);

CREATE TABLE Consumer_Preferences (
  Consumer_ID VARCHAR(10),
  Cuisine_ID VARCHAR(10),
  FOREIGN KEY (Consumer_ID) REFERENCES Consumer(Consumer_ID),
  FOREIGN KEY (Cuisine_ID) REFERENCES Cuisine(Cuisine_ID)
);

CREATE TABLE Ratings (
  Consumer_ID VARCHAR(10),
  Restaurant_ID VARCHAR(10),
  Overall_Rating INTEGER,
  Food_Rating INTEGER,
  Service_Rating INTEGER,
  FOREIGN KEY (Consumer_ID) REFERENCES Consumer(Consumer_ID),
  FOREIGN KEY (Restaurant_ID) REFERENCES Restaurant(Restaurant_ID)
);

CREATE TABLE Restaurant_Cuisines (
  Restaurant_ID VARCHAR(10),
  Cuisine_ID VARCHAR(10),
  FOREIGN KEY (Restaurant_ID) REFERENCES Restaurant(Restaurant_ID),
  FOREIGN KEY (Cuisine_ID) REFERENCES Cuisine(Cuisine_ID)
);

**/

--Selezionare tutti i ristoranti con il numero totale di valutazioni ricevute:
CREATE VIEW [dbo].[VA_RestaurantsTotalRatings] AS
SELECT 
	r.restaurant_ID,
	r.Name, 
	COUNT(ratings.restaurant_ID) AS Total_Ratings
FROM restaurants AS r
LEFT JOIN ratings ON r.restaurant_ID = Ratings.Restaurant_ID
GROUP BY r.Restaurant_ID, r.Name

SELECT Restaurant_ID, Overall_Rating, Food_Rating, Service_Rating
FROM ratings
SELECT Restaurant_ID
FROM restaurants

SELECT MAX(Total_Rating) AS Max_Rating
FROM (
    SELECT r.Restaurant_ID, SUM(rt.Overall_Rating) AS Total_Rating
    FROM Restaurants AS r
    JOIN Ratings AS rt ON r.Restaurant_ID = rt.Restaurant_ID
    GROUP BY r.Restaurant_ID
) AS RatingTotals;

SELECT COUNT(r.Restaurant_ID), r.Name, (rt.Overall_Rating + rt.Service_Rating + rt.Food_Rating) AS Total_Rating
FROM Restaurants AS r
JOIN Ratings AS rt ON r.Restaurant_ID = rt.Restaurant_ID
GROUP BY r.Restaurant_ID, r.Name, (rt.Overall_Rating + rt.Service_Rating + rt.Food_Rating) AS Total_Rating
ORDER BY Total_Rating DESC




--Ristoranti con un determinato tipo di cucina (ad esempio, "Mexican")
CREATE VIEW [dbo].[VA_RestaurantsMexicanCuisines] AS
SELECT Restaurant_ID, City, Name, Parking
FROM Restaurants
WHERE Restaurant_ID IN (SELECT Restaurant_ID FROM Restaurant_Cuisines WHERE Cuisine = 'Mexican');



--Somma dei tipi di cucina
CREATE VIEW [dbo].[VA_RestaurantsCuisineTypes] AS
SELECT  Cuisine, COUNT(*) AS TotalCuisineType
FROM restaurant_cuisines
GROUP BY Cuisine

--Numero dei ristoranti divisi per tipo di parcheggio disponibile
CREATE VIEW [dbo].[VA_RestaurantsParkingType] AS
SELECT
    Parking,
    COUNT(*) AS Total_Restaurants
FROM
    Restaurants
GROUP BY
    Parking;


SELECT * 
FROM restaurants


SELECT DISTINCT City
FROM restaurants

--Totale dei ristoranti divisi per città
CREATE VIEW [dbo].[VA_TotalRestaurantByCity] AS
SELECT City ,COUNT(r.City) as TotalRestaurantByCity
FROM restaurants as r
GROUP BY City

SELECT *
FROM consumers

SELECT AVG(c.Age) as AverageConsumerAge
FROM consumers AS c

SELECT MAX(c.Age) AS OldestConsumer
FROM consumers AS c

SELECT MIN(c.Age) AS YoungestConsumer
FROM consumers AS c

SELECT Name, Latitude, Longitude, State
FROM restaurants

SELECT Budget
FROM consumers