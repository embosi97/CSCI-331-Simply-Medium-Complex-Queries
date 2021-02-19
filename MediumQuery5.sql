USE [AdventureWorks2014]
GO

/*
	Problem 10: Use the Full Outer Join to combine the [EmployeeDepartmentHistory] and [BusinessEntityContact] tables and use the EXCEPT operator
	to filter out to rows where BusinessEntity is Null and then when EndDate isn't Null ("Ongoing"). Use the AventureWorks2014 database. This problem
	will demonstrate understanding of EXCEPT.
*/
SELECT EDH.[BusinessEntityID]
	,EDH.[ShiftID]
	,EDH.[DepartmentID]
	,EDH.[StartDate]
	,ISNULL(CAST(EDH.[EndDate] AS VARCHAR), 'Ongoing') AS 'EndDate'
FROM [HumanResources].[EmployeeDepartmentHistory] AS EDH
FULL OUTER JOIN [Person].[BusinessEntityContact] AS BEC ON EDH.[BusinessEntityID] = BEC.[BusinessEntityID]

EXCEPT

SELECT EDH1.BusinessEntityID
	,EDH1.[ShiftID]
	,EDH1.[DepartmentID]
	,EDH1.[StartDate]
	,ISNULL(CAST(EDH1.[EndDate] AS VARCHAR), 'Ongoing') AS 'EndDate'
FROM [HumanResources].[EmployeeDepartmentHistory] AS EDH1
FULL OUTER JOIN [Person].[BusinessEntityContact] AS BEC1 ON EDH1.[BusinessEntityID] = BEC1.[BusinessEntityID]
WHERE EDH1.BusinessEntityID IS NULL

EXCEPT

SELECT EDH2.BusinessEntityID
	,EDH2.[ShiftID]
	,EDH2.[DepartmentID]
	,EDH2.[StartDate]
	,ISNULL(CAST(EDH2.[EndDate] AS VARCHAR), 'Ongoing') AS 'EndDate'
FROM [HumanResources].[EmployeeDepartmentHistory] AS EDH2
FULL OUTER JOIN [Person].[BusinessEntityContact] AS BEC2 ON EDH2.[BusinessEntityID] = BEC2.[BusinessEntityID]
WHERE (
		YEAR(EDH2.[EndDate]) BETWEEN 2009
			AND 2013
		)
ORDER BY (EDH.StartDate) DESC
FOR JSON PATH
	,ROOT('Customer Info')
