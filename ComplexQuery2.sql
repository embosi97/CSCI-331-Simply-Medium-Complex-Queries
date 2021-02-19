USE [AdventureWorks2014]
GO

/*
	Problem 15: Find the sales made last year by BusinessEntityId. Include Bonuses, Sales Quota, Address (City, Addressline1, and Territory Id), as well as the year of the Modified Date
	in descending order. Use tables [Sales].[SalesPerson] and [Sales].[SalesTerritory] in the [AdventureWorks2014] database. 
	CAST Sales into money so they'll be separated by commas and throw in $.
*/
SELECT SP.[BusinessEntityID]
	,CONCAT (
		'$'
		,CONVERT(VARCHAR, CAST(SP.[SalesLastYear] AS MONEY), 1)
		) AS 'Sales Last Year'
	,CONCAT (
		'$'
		,CONVERT(VARCHAR, CAST(SP.[Bonus] AS MONEY), 1)
		) AS 'Total Bonuses'
	,CONCAT (
		'$'
		,ISNULL(CONVERT(VARCHAR, CAST(SP.[SalesQuota] AS MONEY), 1), 0.00)
		) AS 'Sales Quota'
	,ISNULL(CAST(ST.[TerritoryID] AS VARCHAR), 'N/A') AS 'Territory Id'
	,YEAR(ST.[ModifiedDate]) AS 'Business Year'
	,CONCAT (
		PA.[City]
		,', '
		,PA.[AddressLine1]
		,', '
		,BE.[AddressID]
		) AS Address
		,[dbo].[plusBonus](SP.[SalesLastYear], SP.[Bonus]) AS SalesPlusBonus
FROM [Sales].[SalesPerson] AS SP
INNER JOIN [Person].[BusinessEntityAddress] AS BE ON SP.[BusinessEntityID] = BE.[BusinessEntityID]
INNER JOIN [Sales].[SalesTerritory] AS ST ON SP.[TerritoryID] = ST.[TerritoryID]
INNER JOIN [Person].[Address] AS PA ON BE.[AddressID] = PA.[AddressID]
ORDER BY SP.SalesLastYear DESC
FOR JSON PATH
	,ROOT('Sales Last Years')

