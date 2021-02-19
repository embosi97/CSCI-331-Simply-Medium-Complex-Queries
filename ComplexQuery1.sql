USE [DB9_EmiljanoBodaj47]
GO

/*
	Problem 14: Find the top 50 Order Id's with the greatest Total Values (Quantity + UnitPrice), including the decimal Discount Percentage, the Total Value
	BEFORE the Discount Percentage, as well as the total freight. Use NorthWind with the [Sales].[Customer], [Sales].[Order], and [Sales].[OrderDetail] tables.
*/
SELECT TOP 50 OD.OrderId
	,SUM([dbo].[qtyTimesPrice](OD.Quantity, OD.[UnitPrice])) AS 'Total Value'
	,CONCAT (
		CONVERT(DOUBLE PRECISION, SUM(OD.[DiscountPercentage] * 100))
		,'% '
		) AS 'Discount Percentage'
	,CONVERT(DOUBLE PRECISION, ((SUM(OD.Quantity * OD.[UnitPrice]) * SUM(OD.DiscountPercentage)) + SUM(OD.Quantity * OD.[UnitPrice]))) AS 'Price Before Discount'
	,SUM(SO.Freight) AS 'Total Freight'
FROM [Sales].[OrderDetail] AS OD
INNER JOIN [Sales].[Order] AS SO ON SO.OrderId = OD.OrderId
INNER JOIN [Sales].[Customer] AS SA ON SO.CustomerId = SA.[CustomerId]
GROUP BY OD.OrderID
	,SA.CustomerId
HAVING SUM(OD.DiscountPercentage) > 0.000
ORDER BY SUM(OD.Quantity * OD.[UnitPrice]) DESC
FOR JSON PATH
	,ROOT('Discount by OrderId')
