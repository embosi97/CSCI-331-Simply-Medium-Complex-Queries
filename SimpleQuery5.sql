USE DB9_EmiljanoBodaj47
GO

/*
	Problem 05: Find the ShipperID, complete Shipping Address (Country, City, Region, Postal Code) and Orderdate between 2015 and 2016,
	excluding the months of December, January, February, and March using Set Operators. Use Northwind2019TSQLV5
*/
SELECT [ShipperId]
	,CONCAT (
		[ShipToCountry]
		,', '
		,[ShipToCity]
		,', '
		,[ShipToRegion]
		,' '
		,[ShipToPostalCode]
		) AS ShippingAddress
	,[OrderDate]
FROM [Sales].[Order]
WHERE (
		YEAR(OrderDate) BETWEEN 2015
			AND 2016
		)

EXCEPT

SELECT [ShipperId]
	,CONCAT (
		[ShipToCountry]
		,', '
		,[ShipToCity]
		,', '
		,[ShipToRegion]
		,' '
		,[ShipToPostalCode]
		) AS ShippingAddress
	,[OrderDate]
FROM [Sales].[Order]
WHERE (
		MONTH(OrderDate) IN (
			12
			,1
			,2
			,3
			)
		)
ORDER BY OrderDate
FOR JSON PATH
	,ROOT('Specific OrderDates')