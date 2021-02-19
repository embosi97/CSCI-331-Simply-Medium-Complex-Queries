USE DB9_EmiljanoBodaj47
GO

/*
	Problem 03: Find the OrderId, CustomerId, CustomerCountry, and CustomerContactTitle using the tables [Sales].[Customer]
	and [Sales].[Order]. The people who made NO orders should be displayed at the top of the output. Those who
	haven't made an order shouldn't have a CustomerId as well. (NorthWind).
*/

SELECT O.[OrderId]
	,O.CustomerId
	,C.CustomerCountry
	,C.[CustomerContactTitle]
FROM [Sales].[Order] AS O
RIGHT JOIN [Sales].[Customer] AS C ON O.CustomerId = C.CustomerId
ORDER BY O.OrderId
FOR JSON PATH
	,ROOT('Customer and Order INFO');