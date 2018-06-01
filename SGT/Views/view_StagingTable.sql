CREATE VIEW [SGT].view_StagingTable AS
SELECT 
TRY_CAST(BusinessEntityID AS INT) AS BusinessEntityID, 
Title, 
FirstName, 
LastName, 
JobTitle, 
TRY_CAST(EmployeeModifiedDate AS DATE) AS EmployeeModifiedDate,
TRY_CAST(PersonModifiedDate AS DATE) AS PersonModifiedDate,
TRY_CAST(Sallary AS MONEY) AS Salary
FROM SGT.StagingTable