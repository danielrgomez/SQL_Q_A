USE AdventureWorks2019;
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

--12
--a
select CONCAT(PP.FirstName,' ',PP.LastName) as CEO_Name from HumanResources.Employee as HRE Inner Join Person.Person as PP On HRE.BusinessEntityID = PP.BusinessEntityID where JobTitle = 'Chief Executive Officer';

--b
select CONCAT(PP.FirstName,' ',PP.LastName) as CEO_Name, HRE.HireDate from HumanResources.Employee as HRE Inner Join Person.Person as PP On HRE.BusinessEntityID = PP.BusinessEntityID where JobTitle = 'Chief Executive Officer';

--c
select PP.FirstName, PP.LastName, JobTitle from HumanResources.Employee as HRE Inner Join Person.Person as PP On HRE.BusinessEntityID = PP.BusinessEntityID Where HRE.OrganizationLevel = 1



--13
--a
select PP.FirstName, PP.LastName, JobTitle from HumanResources.Employee as HRE Inner Join Person.Person as PP On HRE.BusinessEntityID = PP.BusinessEntityID Where PP.FirstName = 'John' and PP.LastName = 'Evans'

--b
select PP.FirstName, PP.LastName, JobTitle, HRD.Name as Dept_Name
from HumanResources.Employee as HRE 
Inner Join Person.Person as PP 
On HRE.BusinessEntityID = PP.BusinessEntityID 
Inner Join HumanResources.EmployeeDepartmentHistory as HREDH
On HRE.BusinessEntityID = HREDH.BusinessEntityID
Inner Join HumanResources.Department as HRD
On HREDH.DepartmentID = HRD.DepartmentID
Where PP.FirstName = 'John' and PP.LastName = 'Evans'


--14
--a
select Name, AccountNumber, CreditRating from Purchasing.Vendor order by CreditRating Desc;

--b
select Name, AccountNumber, CreditRating, PreferredVendorStatus from Purchasing.Vendor order by CreditRating Desc;

--c resetting
Update Purchasing.Vendor
Set PreferredVendorStatus =
Case 
	When PreferredVendorStatus = 'Preferred' Then 1 
	When PreferredVendorStatus = 'Not Preferred' Then 0 
End 
from Purchasing.Vendor;

--c setting
Update Purchasing.Vendor
Set PreferredVendorStatus =
Case 
	When PreferredVendorStatus = 1 Then 'Preferred' 
	When PreferredVendorStatus =  0 Then 'Not Preferred'
End 
from Purchasing.Vendor;


--d
select Count(Name) as Count_Active_Preferred from Purchasing.Vendor where ActiveFlag = 1 and PreferredVendorStatus = 'Preferred';



--15
--a
Select NationalIDNumber, BirthDate, DATEDIFF(YEAR,BirthDate,'08-15-2014') Age from HumanResources.Employee as HRE
Select NationalIDNumber, BirthDate, Cast(DATEDIFF(YEAR,BirthDate,'08-15-2014') as decimal) Age from HumanResources.Employee as HRE order by Age desc;


--b
Select OrganizationLevel, Avg(cast(DATEDIFF(YEAR,BirthDate,'08-15-2014') as decimal)) as Age from HumanResources.Employee as HRE Group By OrganizationLevel;

--c
Select OrganizationLevel, Ceiling(Avg(cast(DATEDIFF(YEAR,BirthDate,'08-15-2014') as decimal))) as Age from HumanResources.Employee as HRE Group By OrganizationLevel;

--d
Select OrganizationLevel, Floor(Avg(cast(DATEDIFF(YEAR,BirthDate,'08-15-2014') as decimal))) as Age from HumanResources.Employee as HRE Group By OrganizationLevel;


Select OrganizationLevel, Ceiling(Avg(cast(DATEDIFF(YEAR,BirthDate,'08-15-2014') as decimal))) as AgeCeiling, Floor(Avg(cast(DATEDIFF(YEAR,BirthDate,'08-15-2014') as decimal))) as AgeFloor from HumanResources.Employee as HRE Group By OrganizationLevel;



--16
-- a
select count(ProductID) ProductCount from Production.Product

--b
select count(ProductID) ProductCount from Production.Product where FinishedGoodsFlag = 1;

--c
select 
count(case when Makeflag = 1 Then ProductID Else Null End) as CountInHouse,
count(case when Makeflag = 0 Then ProductID Else Null End) as CountPurchased
from Production.Product where FinishedGoodsFlag = 1;