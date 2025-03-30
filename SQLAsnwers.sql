--Question 11
--a
Select count(NationalIDNumber) as Number_Of_Employees from HumanResources.Employee;

--b
Select count(NationalIDNumber) as Number_Of_Employees from HumanResources.Employee where CurrentFlag = 1;

--c
Select Count(HRE.JobTitle) Count_Of_SP_Person_Type from HumanResources.Employee as HRE Inner Join Person.Person as PP on HRE.BusinessEntityID = PP.BusinessEntityID Where PP.PersonType = 'SP' Group BY PP.PersonType;

--d
Select Count(HRE.JobTitle) Count_Of_SP_Person_Type 
from HumanResources.Employee as HRE 
Inner Join Person.Person as PP 
on HRE.BusinessEntityID = PP.BusinessEntityID
Inner Join HumanResources.EmployeeDepartmentHistory as HREDH
on HRE.BusinessEntityID = HREDH.BusinessEntityID
Inner Join HumanResources.Department HRD on
HREDH.DepartmentID = HRD.DepartmentID
where PP.PersonType = 'SP' and HRD.Name = 'Sales' group by  PP.PersonType;




select * from HumanResources.Department;



Select top (5) * from Person.Person where PersonType = 'SP';

--d

Select top (5) * from HumanResources.Employee;