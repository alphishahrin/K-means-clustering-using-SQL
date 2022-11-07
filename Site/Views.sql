CLEAR SCREEN;
DROP VIEW joinedSale;
DROP VIEW joinedTable;

CREATE OR REPLACE VIEW joinedSale
AS
SELECT AparNo, YearBuilt, YrSold, MonthSold, SalePrice
FROM 
    (SELECT AparNo, YearBuilt, YrSold, MonthSold, SalePrice FROM HouseSale2019@usersite) 
    UNION 
    (SELECT AparNo, YearBuilt, YrSold, MonthSold, SalePrice FROM HouseSale2020@usersite);


CREATE OR REPLACE VIEW joinedTable
AS
SELECT HouseFacility.AparNo, HouseFacility.HeatingType, HouseFacility.AptManageType, HouseFacility.Parkinglot_Ground, 
HouseFacility.Parkinglot_Basement, HouseFacility.N_APT, HouseFacility.N_manager, HouseFacility.N_elevators,
HouseDetails.Sizee, HouseDetails.Floorr, HouseDetails.HallwayType,
House_FacilitiesNearBy.Subway, House_FacilitiesNearBy.PublicOffice, House_FacilitiesNearBy.Hospital, House_FacilitiesNearBy.Dpartmentstore, 
House_FacilitiesNearBy.Mall, House_FacilitiesNearBy.ETC, House_FacilitiesNearBy.Park, House_FacilitiesNearBy.School,
joinedSale.YearBuilt, joinedSale.YrSold, joinedSale.MonthSold, joinedSale.SalePrice
FROM HouseFacility
     JOIN HouseDetails ON HouseFacility.AparNo=HouseDetails.AparNo
	 JOIN joinedSale ON HouseFacility.AparNo=joinedSale.AparNo
	 JOIN House_FacilitiesNearBy ON HouseFacility.AparNo=House_FacilitiesNearBy.AparNo;
	 




COMMIT;
