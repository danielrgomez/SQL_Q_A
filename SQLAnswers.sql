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


--17
--a
Select Format(sum(LineTotal),'C') from Sales.SalesOrderDetail

--b
Select Format(Sum(LineTotal),'C') as LineTotalAmt,(Case When MakeFlag = 1 Then 'Manufactured' Else 'Purchased' End) as MakeFlagCase From Production.Product as PP Inner Join Sales.SalesOrderDetail as SSOD On PP.ProductID = SSOD.ProductID Group By (Case When MakeFlag = 1 Then 'Manufactured' Else 'Purchased' End)

--c
Select Count(Distinct SSOD.SalesOrderID) as DistinctSalesOrderID, Format(Sum(LineTotal),'C') as LineTotalAmt,(Case When MakeFlag = 1 Then 'Manufactured' Else 'Purchased' End) as MakeFlagCase From Production.Product as PP Inner Join Sales.SalesOrderDetail as SSOD On PP.ProductID = SSOD.ProductID Group By (Case When MakeFlag = 1 Then 'Manufactured' Else 'Purchased' End)

--d
Select Distinct SSOD.SalesOrderID as DistinctSalesOrderID, Format(avg(LineTotal),'C') AvgLineTotal From Sales.SalesOrderDetail as SSOD Group By SSOD.SalesOrderID



--18
--a
select * from Production.TransactionHistoryArchive


Select 
	Case 
		When TransactionType = 'W' Then 'WorkOrder' 
		When TransactionType = 'S' Then 'SalesOrder'
		When TransactionType = 'P' Then 'PurchaseOrder' 
	End
From Production.TransactionHistory

--b
select * from Production.TransactionHistory as PTH Union Select * from Production.TransactionHistoryArchive as PTHA


--c
Select Min(TransactionDate) as MinTransDate, Max(TransactionDate) as MaxTransDate From (
Select TransactionDate from Production.TransactionHistory as PTH 
Union 
Select TransactionDate from Production.TransactionHistoryArchive as PTHA) as union_result;




--d
Select 
	(Case 
		When TransactionType = 'W' Then 'WorkOrder' 
		When TransactionType = 'S' Then 'SalesOrder'
		When TransactionType = 'P' Then 'PurchaseOrder' 
	End) TransactionTypeName, 
Max(TransactionDate) MinTransDate, 
Min(TransactionDate) MaxTransDate
From (
	Select TransactionType, TransactionDate from Production.TransactionHistory as PTH 
	Union 
	Select TransactionType, TransactionDate from Production.TransactionHistoryArchive as PTHA
	) as union_result
	Group By TransactionType;




--19
Select format(min(OrderDate),'yyyy-MM-dd'), format(max(OrderDate),'yyyy-MM-dd') from Sales.SalesOrderHeader

--20
--a
Select format(min(OrderDate),'yyyy-MM-dd'), format(max(OrderDate),'yyyy-MM-dd') from Purchasing.PurchaseOrderHeader

Select format(min(DueDate),'yyyy-MM-dd'), format(max(DueDate),'yyyy-MM-dd') from Production.Workorder

--b

--21
--a
Select Name, CountryRegionCode from Person.StateProvince


--b
Select PSP.Name, CountryRegionCode, TaxRate from Person.StateProvince as PSP Left Join Sales.SalesTaxRate as SSTR On PSP.StateProvinceID = SSTR.StateProvinceID

--c
Select PSP.Name, CountryRegionCode, count(TaxRate) TaxRateCount, PSP.StateProvinceID from Person.StateProvince as PSP Left Join Sales.SalesTaxRate as SSTR On PSP.StateProvinceID = SSTR.StateProvinceID Group By PSP.Name, CountryRegionCode, PSP.StateProvinceID Order By count(TaxRate) desc;


--d
Select Top 1 PSP.Name, CountryRegionCode, TaxRate from Person.StateProvince as PSP Left Join Sales.SalesTaxRate as SSTR On PSP.StateProvinceID = SSTR.StateProvinceID Order By TaxRate Desc;




--22
--a
Select count(BusinessEntityID) CustomerCount from Person.Person where PersonType = 'IN'



--b
--Select count(BusinessEntityID) CustomerCount from Person.Person as PP Inner Join Sales.Customer as SC On PP.BusinessEntityID = SC.CustomerID
Select PCR.Name as CountryName, count(PP.BusinessEntityID) as CountOfPeople from Person.Person as PP 
Inner Join Person.BusinessEntity as PBE On PP.BusinessEntityID = PBE.BusinessEntityID 
Inner Join Person.BusinessEntityAddress as PBEA On PP.BusinessEntityID = PBEA.BusinessEntityID 
Inner Join Person.Address as PA On PA.AddressID = PBEA.AddressID
Inner Join Person.StateProvince as PSP On PSP.StateProvinceID = PA.StateProvinceID
Inner Join Person.CountryRegion as PCR On PSP.CountryRegionCode = PCR.CountryRegionCode
Where PP.PersonType = 'IN'
Group By PCR.Name


--c
Select 
PCR.Name as CountryName, 
count(PP.BusinessEntityID) as CountOfPeople,
Format(Cast(count(Distinct PP.BusinessEntityID) as float) / (Select Count(BusinessEntityID) from Person.Person as PP Where PP.PersonType = 'IN'),'P') as PercentageOfPop
from Person.Person as PP 
Inner Join Person.BusinessEntity as PBE On PP.BusinessEntityID = PBE.BusinessEntityID 
Inner Join Person.BusinessEntityAddress as PBEA On PP.BusinessEntityID = PBEA.BusinessEntityID 
Inner Join Person.Address as PA On PA.AddressID = PBEA.AddressID
Inner Join Person.StateProvince as PSP On PSP.StateProvinceID = PA.StateProvinceID
Inner Join Person.CountryRegion as PCR On PSP.CountryRegionCode = PCR.CountryRegionCode
Where PP.PersonType = 'IN'
Group By PCR.Name

--23
DECLARE @TotalRetailCustomers float;
SET @TotalRetailCustomers = (Select count(BusinessEntityID) from Person.Person Where PersonType = 'IN');

Select 
	cr.Name as Country
	,Format(count(Distinct p.BusinessEntityID),'N0') as CNT
	,Format(Cast(count(Distinct p.BusinessEntityID) as float)
		/
			@TotalRetailCustomers,'P') as '%ofTotal'
 
from Person.Person p
	Inner Join Person.BusinessEntityAddress bea on bea.BusinessEntityID = p.BusinessEntityID
	Inner Join Person.Address a on a.AddressID = bea.AddressID
	Inner Join Person.StateProvince sp on sp.StateProvinceID = a.StateProvinceID
	Inner Join Person.CountryRegion cr on cr.CountryRegionCode = sp.CountryRegionCode
Where PersonType = 'IN'
Group by cr.Name
Order by 2 desc


--24
--a
Select SalesOrderID, TotalDue, SubTotal, (TotalDue - SubTotal) SubtractAmt, TaxAmt, Freight, (TaxAmt + Freight) TxPlusFreight from Sales.SalesOrderHeader Where SalesOrderID = '69411'


--b
Select SalesOrderID, Sum(LineTotal) SubTotal from Sales.SalesOrderDetail Where SalesOrderid = '69411' Group By SalesOrderID

--c
Select TotalDue, (Subtotal + Freight + TaxAmt) TotalDueCalculation From Sales.SalesOrderHeader Where SalesOrderID = '69411'

--d
Select * from Sales.SalesOrderDetail Where SalesOrderID = '69411'
Select productID, (OrderQty * UnitPrice) LineTotalCalc from Sales.SalesOrderDetail Where SalesOrderID = '69411'

--25

--26
