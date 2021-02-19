USE DB9_EmiljanoBodaj47
GO

/*
	Problem 07: Find the CustId, CustomerCompanyName (Without 'Customer'), OrderDate (NULLs must be 'XXXXXXX'), OrderId (NULLs must be 'N/A')
	for order that were made at the end of the semester for either the Fall or Spring, with every other date being NULL. Order by Order Date
*/
SELECT SC.[CustomerId]
	,REPLACE(SC.[CustomerCompanyName], 'Customer', '') AS 'Company Name'
	,ISNULL(CONVERT(VARCHAR(30), SO.OrderDate, 121), 'XXXXXXXX') AS 'Order Date'
	,ISNULL(CONVERT(VARCHAR(30), SO.OrderId, 121), 'N/A') AS 'Order Id'
FROM [Sales].[Customer] AS SC
LEFT OUTER JOIN [Sales].[Order] AS SO ON SC.CustomerId = SO.CustomerId
	AND DAY(SO.OrderDate) IN (
		21
		,20
		)
	AND MONTH(SO.OrderDate) IN (
		12
		,5
		)
--Group By won't make a difference
ORDER BY SO.OrderDate DESC
FOR JSON PATH
	,ROOT('Customer Info')

