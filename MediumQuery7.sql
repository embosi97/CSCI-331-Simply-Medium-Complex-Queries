USE [AdventureWorks2014]
GO

/*
	Problem 12: Find the BusinessEntityID and OrgnizationNode of those whose BusinessID fall between 20 and 60 and 
	havv a log-in ID that ends with 0. Use HR.Employee and HR.EmployeeDepartmentHistory. Use Format() to format
	the HireDate by MM/dd/yyy.
*/
SELECT E.[BusinessEntityID]
	,E.[OrganizationNode]
	,E.[LoginID]
	,FORMAT(E.[HireDate], 'MM/dd/yyyy') AS HireDate
FROM [HumanResources].[Employee] AS E
WHERE (
		E.BusinessEntityID BETWEEN 20
			AND 60
		)
	AND EXISTS (
		SELECT [BusinessEntityID]
		FROM [HumanResources].[EmployeeDepartmentHistory] AS EA
		WHERE E.BusinessEntityID = EA.BusinessEntityID
		)
	AND E.LoginID LIKE '%0'
ORDER BY YEAR(E.HireDate) DESC
FOR JSON PATH
	,ROOT('Specific Business Entity IDs');