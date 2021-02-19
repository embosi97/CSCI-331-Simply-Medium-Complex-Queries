USE [AdventureWorks2014]
GO

/*
	Problem 11: Find the Full Names of Employee who are Production Technicians in division WC40, their EmailAddress, JobTitle, the number of years
	they've worked at that position, as well as their average Vacation + Sick hours by year (estimated). Sort them 
*/
SELECT CONCAT (
		P.[LastName]
		,', '
		,P.[FirstName]
		,' '
		,P.[MiddleName]
		) AS EmployeeName
	,EA.[EmailAddress]
	,E.[JobTitle]
	,DATEDIFF(YEAR, [HireDate], SYSDATETIME()) AS YearsEmployed
	,((VacationHours + SickLeaveHours) / DATEDIFF(YEAR, [HireDate], SYSDATETIME())) AS AverageVacationAndSickHoursbyYear
FROM [Person].[Person] AS P
INNER JOIN [HumanResources].[Employee] AS E ON P.BusinessEntityID = E.BusinessEntityID
INNER JOIN [Person].[EmailAddress] AS EA ON E.[BusinessEntityID] = EA.[BusinessEntityID]
WHERE EXISTS (
		SELECT JobTitle
		FROM Person.Person
		WHERE JobTitle LIKE '%Production Technician%'
			AND JobTitle LIKE '%WC40%'
		)
ORDER BY AverageVacationAndSickHoursbyYear DESC
FOR JSON PATH
	,ROOT('Average Unworked Hours')
