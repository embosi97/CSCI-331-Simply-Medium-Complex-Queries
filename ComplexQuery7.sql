USE DB9_EmiljanoBodaj47
GO

/*
	Problem 20: Output the Employee Name (Title + Surname), Title of Courtesy, Nationality, Age (Use Scalar Function), 
	EmployeeId, as well as the Years Hired using [HumanResources].[Employee] and [Sales].[Order] in NorthWind.
	The query should only display the employees that have been working at that company for the non-MAX Years Hired
	CROSS JOIN this gargatuan query with dbo.Nums and set N to represent the MIN years an Employee has worked
	at this location. 
	Order by Youngest Employee to the Oldest
*/
SELECT N.n AS SeniorityYear, 
[dbo].[getAge]([HireDate]) AS 'Years Working At Company' 
,[dbo].[getAge]([BirthDate]) AS Age, CONCAT (
		HRE.[EmployeeTitleOfCourtesy]
		,' '
		,HRE.[EmployeeLastName]
		) AS 'Employee Name'
	,CASE 
		WHEN HRE.EmployeeCountry = 'USA'
			THEN 'American'
		WHEN HRE.EmployeeCountry = 'Canada'
			THEN 'Canadian'
		WHEN HRE.EmployeeCountry IN (
				'Germany'
				,'UK'
				,'Norway'
				,'Belgium'
				,'Poland'
				,'Switzerland'
				,'France'
				,'Spain'
				,'Italy'
				,'Portugal'
				,'Denmark'
				,'Sweden'
				,'Finland'
				)
			THEN 'European'
		WHEN HRE.EmployeeCountry IN (
				'Brazil'
				,'Mexico'
				,'Argentina'
				,'Venezuela'
				)
			THEN 'Latin American'
		END AS 'Nationality'
	,SO.EmployeeId AS ID
FROM [HumanResources].[Employee] AS HRE
INNER JOIN [Sales].[Order] AS SO ON HRE.[EmployeeId] = SO.EmployeeId
CROSS JOIN dbo.Nums AS N
WHERE [dbo].[getAge]([HireDate]) != 7 AND N.n = (SELECT MAX([dbo].[getAge]([HireDate]))												  FROM HumanResources.Employee)
GROUP BY SO.EmployeeId
	,HRE.EmployeeFirstName
	,HRE.EmployeeLastName
	,HRE.EmployeeTitleOfCourtesy
	,HRE.EmployeeCountry
	,HRE.BirthDate
	,HRE.HireDate
	,N.n
ORDER BY [dbo].[getAge]([BirthDate]) ASC
FOR JSON PATH
	,ROOT('Employee non-Seniority')

	