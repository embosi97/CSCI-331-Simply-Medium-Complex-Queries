USE DB9_EmiljanoBodaj47
GO

/*
	Problem 06: Find the Full Name (concat), Title of Courtesy, Nationality, Age (datediff()), and EmployeeId and order it by the employee's 
	surname? Use [HumanResources].[Employee] and [Sales].[Order] in NorthWind
*/
SELECT CONCAT (
		HRE.[EmployeeLastName]
		,', '
		,HRE.[EmployeeFirstName]
		) AS 'Full Name'
	,HRE.[EmployeeTitleOfCourtesy] AS 'Title of Courtesy'
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
	,DATEDIFF(year, [BirthDate], GETDATE()) AS Age
	,SO.EmployeeId AS ID
FROM [HumanResources].[Employee] AS HRE
INNER JOIN [Sales].[Order] AS SO ON HRE.[EmployeeId] = SO.EmployeeId
GROUP BY SO.EmployeeId
	,HRE.EmployeeFirstName
	,HRE.EmployeeLastName
	,HRE.EmployeeTitleOfCourtesy
	,HRE.EmployeeCountry
	,HRE.BirthDate
ORDER BY SUBSTRING(HRE.[EmployeeLastName], 1, 1)
FOR JSON PATH
	,ROOT('Employee Nationality')