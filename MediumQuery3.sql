USE DB9_EmiljanoBodaj47
GO

/*
	Problem 08: Using the Intersect and Except Set Operations, write a query that'll print out all the Orders made at the END OF THE MONTH between 2015 and 2016. Use [Sales].[Order] and
	[Northwinds2019TSQLV5]. Order it in ascending order and don't forget the fact that 2015 was a leap year.   
*/
SELECT EmployeeId
	,CustomerId
	,OrderDate
FROM [Sales].[Order]
WHERE MONTH(OrderDate) IN (
		SELECT MONTH(OrderDate)
		FROM [Sales].[Order]
		WHERE MONTH(OrderDate) BETWEEN 1
				AND 6
		)

INTERSECT

SELECT EmployeeId
	,CustomerId
	,OrderDate
FROM [Sales].[Order]
WHERE YEAR(OrderDate) IN (
		SELECT YEAR(OrderDate)
		FROM [Sales].[Order]
		WHERE YEAR(OrderDate) BETWEEN 2015
				AND 2016
		)

EXCEPT

SELECT EmployeeId
	,CustomerId
	,OrderDate
FROM [Sales].[Order]
WHERE DAY(OrderDate) != DAY(EOMONTH(OrderDate))
ORDER BY OrderDate
FOR JSON PATH
	,ROOT('2015-2016 EOMONTH Orders')