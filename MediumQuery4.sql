USE DB9_EmiljanoBodaj47
GO

/*
	Problem 09: Find the TOP .25% of ProductId, UnitPrice (Use a $ symbol) above $10.00, Discontinued status (Yes or No), Quantity, Discount Percentage, 
	and CategoryId in the CARTESIAN PRODUCT of [Sales].[OrderDetail] and [Production].[Product] using the NorthWind database. Order it by 
	Discount Percentage
*/
SELECT TOP (.25) PERCENT PR.[ProductId]
	,CONCAT (
		'$'
		,PR.[UnitPrice]
		) AS 'Unit Price'
	,CASE 
		WHEN PR.[Discontinued] = 1
			THEN 'Yes'
		WHEN PR.[Discontinued] = 0
			THEN 'No'
		END AS 'Discontinued?'
	,CONCAT (
		OD.[Quantity]
		,' Items'
		) AS Quantity
	,CONCAT (
		CONVERT(DOUBLE PRECISION, (OD.[DiscountPercentage] * 100))
		,'% '
		) AS 'Discount Percentage'
	,PR.[CategoryId]
FROM [Sales].[OrderDetail] AS OD
CROSS JOIN [Production].[Product] AS PR
WHERE PR.UnitPrice > 10.00
ORDER BY OD.[DiscountPercentage] DESC
FOR JSON PATH
	,ROOT('Top .25% of Discount Percentage')




