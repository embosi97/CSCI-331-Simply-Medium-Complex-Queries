USE [AdventureWorks2014]
GO

/*
	Problem 16: Find the ProductID, Bin, ListPrice , Quantity, ProductReview, and Price of Stock (Qty * Price)
	that are in Shelves E and C with the tables [Production].[ProductInventory], [Production].[ProductCostHistory], 
	and [Production].[ProductReview]. Use group by to remove exact duplicates. 
*/
SELECT I.[ProductID]
	,I.[Shelf]
	,I.[Bin]
	,PLPH.[ListPrice]
	,I.[Quantity]
	,ISNULL(CAST(PR.[ProductReviewID] AS NVARCHAR), 'N/A') AS ProductRating
	,[dbo].[getStockPrice](I.Quantity, PLPH.ListPrice) AS PriceOfStock
FROM [Production].[ProductInventory] AS I
RIGHT JOIN [Production].[ProductCostHistory] AS CH ON I.ProductID = CH.ProductID
	AND (I.Shelf != 'N/A')
LEFT OUTER JOIN [Production].[ProductReview] AS PR ON I.ProductID = PR.ProductID
INNER JOIN [Production].[ProductListPriceHistory] AS PLPH ON I.[ProductID] = PLPH.[ProductID]
WHERE (I.ProductID IS NOT NULL)
	AND (I.Shelf IN(N'E', N'C'))
GROUP BY I.[ProductID]
	,I.[Shelf]
	,I.[Bin]
	,PLPH.[ListPrice]
	,I.[Quantity]
	,PR.[ProductReviewID]
ORDER BY PR.ProductReviewID DESC
FOR JSON PATH
	,ROOT('Product Info');
