USE [Northwinds2019TSQLV5]
GO

/*
	Problem 02: Find the personal information, the Country, Name, Address, Phone #, and Postal Code (in that order) of the suppliers, 
	with the supplementary Product Name and ID's of all Québecois/Québec-based suppliers?
	Concatenate the Supplier's Region and Country for brevity's sake then order by the Company Name.
*/
SELECT CONCAT (
		PS.[SupplierRegion]
		,', '
		,PS.[SupplierCountry]
		) AS SupplierArea
	,PS.[SupplierContactName]
	,PS.[SupplierPhoneNumber]
	,PS.[SupplierAddress]
	,PS.[SupplierPostalCode]
	,SUBSTRING(P.ProductName, CHARINDEX(' ', P.ProductName) + 1, LEN(P.ProductName)) AS ProductName
	,P.[ProductId]
FROM [Production].[Product] AS P
INNER JOIN [Production].[Supplier] AS PS ON P.SupplierId = PS.SupplierId
WHERE PS.SupplierRegion = N'Québec'
ORDER BY SupplierCompanyName
FOR JSON PATH
	,ROOT('Supplier Personal INFO');