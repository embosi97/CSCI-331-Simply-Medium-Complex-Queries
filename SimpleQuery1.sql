USE DB9_EmiljanoBodaj47
GO

/*
	Problem 01: Find the Supplier Contact Title, the Product ID, the Product Name, and the Unit Price for
	products that are LESS expensive than the average unit price using [Production].[Supplier]
	and [Production].[Product]? Order it by Unit Price from least to greatest. 
*/
SELECT PS.[SupplierContactTitle]
	,P.[ProductId]
	,SUBSTRING(P.ProductName, CHARINDEX(' ', P.ProductName) + 1, LEN(P.ProductName)) AS ProductName
	,P.[UnitPrice]
FROM [Production].[Product] AS P
INNER JOIN [Production].[Supplier] AS PS ON P.SupplierId = PS.SupplierId
WHERE UnitPrice < (
		SELECT AVG(UnitPrice)
		FROM [Production].[Product]
		)
ORDER BY UnitPrice ASC
FOR JSON PATH
	,ROOT('Supplier INFO')