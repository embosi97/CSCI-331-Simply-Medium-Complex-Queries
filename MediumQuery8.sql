USE [AdventureWorks2014]
GO

/*
	Problem 13: Find the grouped ProductID's and the Total Quantity, Total Receieved Quantity, Total Rejected Quantity by ProductID
	for ProductID 317. 
*/
SELECT [ProductID]
	,FORMAT(CAST(SUM(UnitPrice) AS MONEY), '$#####.####') AS TotalUnitPriceByProductID
	,SUM([OrderQty]) AS TotalQuantityByProductID
	,SUM([ReceivedQty]) AS TotalReceivedQuantity
	,SUM([RejectedQty]) AS TotalRejectedQuantity
	,FORMAT(CAST(SUM([TaxAmt]) AS MONEY), '$######.####') AS TaxAmount
FROM [Purchasing].[PurchaseOrderDetail] AS POD
FULL OUTER JOIN [Purchasing].[PurchaseOrderHeader] AS POR ON POD.PurchaseOrderID = POR.PurchaseOrderID
WHERE POD.ProductID = (
		SELECT ProductID
		FROM [Purchasing].[PurchaseOrderDetail]
		WHERE ProductID = 317
		GROUP BY ProductID
		)
GROUP BY ProductID
FOR JSON PATH
	,ROOT('ProductID 317')