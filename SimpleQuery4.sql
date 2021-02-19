USE DB9_EmiljanoBodaj47
GO
/*
	Problem 04: Reduce the query results to the Customers (in [Sales].[Order] and [Sales].[Customer])
	who've made absolutely no orders using the EXCEPT clause
*/

SELECT CustomerId
FROM [Sales].[Customer]

EXCEPT

SELECT CustomerId
FROM [Sales].[Order]
ORDER BY CustomerId DESC
FOR JSON PATH
	,ROOT('Customer Orders')