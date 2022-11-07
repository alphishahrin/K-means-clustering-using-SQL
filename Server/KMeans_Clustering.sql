CLEAR SCREEN;
SET SERVEROUTPUT ON;
SET VERIFY OFF;

DROP TABLE ClusterTable;
CREATE TABLE ClusterTable(id INT, clusterid INT);

CREATE OR REPLACE PACKAGE K_Means AS
    PROCEDURE dataAssign(P1 IN NUMBER, P2 IN NUMBER, P3 IN NUMBER, P4 IN NUMBER, P5 IN NUMBER, P6 IN NUMBER, P7 IN NUMBER, P8 IN NUMBER, P9 IN NUMBER, P10 IN NUMBER, P11 IN NUMBER, P12 IN NUMBER, P13 IN NUMBER, 
	                      P14 IN NUMBER, P15 IN NUMBER, P16 IN NUMBER, P17 IN NUMBER, P18 IN NUMBER, P19 IN NUMBER, P20 IN NUMBER, P21 IN NUMBER, P22 IN NUMBER, P23 IN NUMBER,
						  Q1 IN NUMBER, Q2 IN NUMBER, Q3 IN NUMBER, Q4 IN NUMBER, Q5 IN NUMBER, Q6 IN NUMBER, Q7 IN NUMBER, Q8 IN NUMBER, Q9 IN NUMBER, Q10 IN NUMBER, Q11 IN NUMBER, Q12 IN NUMBER, Q13 IN NUMBER, 
	                      Q14 IN NUMBER, Q15 IN NUMBER, Q16 IN NUMBER, Q17 IN NUMBER, Q18 IN NUMBER, Q19 IN NUMBER, Q20 IN NUMBER, Q21 IN NUMBER, Q22 IN NUMBER, Q23 IN NUMBER);
	PROCEDURE clusterUpdate(P1 OUT NUMBER, P2 OUT NUMBER, P3 OUT NUMBER, P4 OUT NUMBER, P5 OUT NUMBER, P6 OUT NUMBER, P7 OUT NUMBER, P8 OUT NUMBER, P9 OUT NUMBER, P10 OUT NUMBER, P11 OUT NUMBER, P12 OUT NUMBER, P13 OUT NUMBER, 
	                      P14 OUT NUMBER, P15 OUT NUMBER, P16 OUT NUMBER, P17 OUT NUMBER, P18 OUT NUMBER, P19 OUT NUMBER, P20 OUT NUMBER, P21 OUT NUMBER, P22 OUT NUMBER, P23 OUT NUMBER,
						  Q1 OUT NUMBER, Q2 OUT NUMBER, Q3 OUT NUMBER, Q4 OUT NUMBER, Q5 OUT NUMBER, Q6 OUT NUMBER, Q7 OUT NUMBER, Q8 OUT NUMBER, Q9 OUT NUMBER, Q10 OUT NUMBER, Q11 OUT NUMBER, Q12 OUT NUMBER, Q13 OUT NUMBER, 
	                      Q14 OUT NUMBER, Q15 OUT NUMBER, Q16 OUT NUMBER, Q17 OUT NUMBER, Q18 OUT NUMBER, Q19 OUT NUMBER, Q20 OUT NUMBER, Q21 OUT NUMBER, Q22 OUT NUMBER, Q23 OUT NUMBER);
	FUNCTION pricePrediction(P1 IN NUMBER, P2 IN NUMBER, P3 IN NUMBER, P4 IN NUMBER, P5 IN NUMBER, P6 IN NUMBER, P7 IN NUMBER, P8 IN NUMBER, P9 IN NUMBER, P10 IN NUMBER, P11 IN NUMBER, P12 IN NUMBER, P13 IN NUMBER, 
	                         P14 IN NUMBER, P15 IN NUMBER, P16 IN NUMBER, P17 IN NUMBER, P18 IN NUMBER, P19 IN NUMBER, P20 IN NUMBER, P21 IN NUMBER, P22 IN NUMBER, P23 IN NUMBER,
						     Q1 IN NUMBER, Q2 IN NUMBER, Q3 IN NUMBER, Q4 IN NUMBER, Q5 IN NUMBER, Q6 IN NUMBER, Q7 IN NUMBER, Q8 IN NUMBER, Q9 IN NUMBER, Q10 IN NUMBER, Q11 IN NUMBER, Q12 IN NUMBER, Q13 IN NUMBER, 
	                         Q14 IN NUMBER, Q15 IN NUMBER, Q16 IN NUMBER, Q17 IN NUMBER, Q18 IN NUMBER, Q19 IN NUMBER, Q20 IN NUMBER, Q21 IN NUMBER, Q22 IN NUMBER, Q23 IN NUMBER,
							 A1 IN NUMBER, A2 IN NUMBER, A3 IN NUMBER, A4 IN NUMBER, A5 IN NUMBER, A6 IN NUMBER, A7 IN NUMBER, A8 IN NUMBER, A9 IN NUMBER, A10 IN NUMBER, A11 IN NUMBER, A12 IN NUMBER, A13 IN NUMBER, 
	                         A14 IN NUMBER, A15 IN NUMBER, A16 IN NUMBER, A17 IN NUMBER, A18 IN NUMBER, A19 IN NUMBER, A20 IN NUMBER, A21 IN NUMBER, A22 IN NUMBER, A23 IN NUMBER)
    RETURN NUMBER;	
    	
END K_Means;
/

CREATE OR REPLACE PACKAGE BODY K_Means AS
    PROCEDURE dataAssign(P1 IN NUMBER, P2 IN NUMBER, P3 IN NUMBER, P4 IN NUMBER, P5 IN NUMBER, P6 IN NUMBER, P7 IN NUMBER, P8 IN NUMBER, P9 IN NUMBER, P10 IN NUMBER, P11 IN NUMBER, P12 IN NUMBER, P13 IN NUMBER, 
	                      P14 IN NUMBER, P15 IN NUMBER, P16 IN NUMBER, P17 IN NUMBER, P18 IN NUMBER, P19 IN NUMBER, P20 IN NUMBER, P21 IN NUMBER, P22 IN NUMBER, P23 IN NUMBER,
						  Q1 IN NUMBER, Q2 IN NUMBER, Q3 IN NUMBER, Q4 IN NUMBER, Q5 IN NUMBER, Q6 IN NUMBER, Q7 IN NUMBER, Q8 IN NUMBER, Q9 IN NUMBER, Q10 IN NUMBER, Q11 IN NUMBER, Q12 IN NUMBER, Q13 IN NUMBER, 
	                      Q14 IN NUMBER, Q15 IN NUMBER, Q16 IN NUMBER, Q17 IN NUMBER, Q18 IN NUMBER, Q19 IN NUMBER, Q20 IN NUMBER, Q21 IN NUMBER, Q22 IN NUMBER, Q23 IN NUMBER)
	IS 
	distance1 int := 0;
	distance2 int := 0;
	apNo int;
	BEGIN  
	    execute immediate 'TRUNCATE TABLE ClusterTable';
		FOR R IN (SELECT * FROM joinedTable@site1) 
		LOOP
		    --apNo := R.AparNo;
		    distance1:= (((P1 - R.AparNo)*(P1 - R.AparNo)) + ((P2 - R.HeatingType)*(P2 - R.HeatingType)) +
			             ((P3 - R.AptManageType)*(P3 - R.AptManageType)) + ((P4 - R.Parkinglot_Ground)*(P4 - R.Parkinglot_Ground)) +
						 ((P5 - R.Parkinglot_Basement)*(P5 - R.Parkinglot_Basement)) + ((P6 - R.N_APT)*(P6 - R.N_APT)) +
						 ((P7 - R.N_manager)*(P7 - R.N_manager)) + ((P8 - R.N_elevators)*(P8 - R.N_elevators)) +
						 ((P9 - R.Sizee)*(P9 - R.Sizee)) + ((P10 - R.Floorr)*(P10 - R.Floorr)) + ((P11 - R.HallwayType)*(P11 - R.HallwayType)) + 
					     ((P12 - R.Subway)*(P12 - R.Subway)) + ((P13 - R.PublicOffice)*(P13 - R.PublicOffice)) +
						 ((P14 - R.Hospital)*(P14 - R.Hospital)) + ((P15 - R.Dpartmentstore)*(P15 - R.Dpartmentstore)) + 
						 ((P16 - R.Mall)*(P16 - R.Mall)) + ((P17 - R.ETC)*(P17 - R.ETC)) + ((P18 - R.Park)*(P18 - R.Park)) +
						 ((P19 - R.School)*(P19 - R.School)) + ((P20 - R.YearBuilt)*(P20 - R.YearBuilt)) +
						 ((P21 - R.YrSold)*(P21 - R.YrSold)) + ((P22 - R.MonthSold)*(P22 - R.MonthSold)) + ((P23 - R.SalePrice)*(P23 - R.SalePrice)));
						 
			distance2:= (((Q1 - R.AparNo)*(Q1 - R.AparNo)) + ((Q2 - R.HeatingType)*(Q2 - R.HeatingType)) +
			             ((Q3 - R.AptManageType)*(Q3 - R.AptManageType)) + ((Q4 - R.Parkinglot_Ground)*(Q4 - R.Parkinglot_Ground)) +
						 ((Q5 - R.Parkinglot_Basement)*(Q5 - R.Parkinglot_Basement)) + ((Q6 - R.N_APT)*(Q6 - R.N_APT)) +
						 ((Q7 - R.N_manager)*(Q7 - R.N_manager)) + ((Q8 - R.N_elevators)*(Q8 - R.N_elevators)) +
						 ((Q9 - R.Sizee)*(Q9 - R.Sizee)) + ((Q10 - R.Floorr)*(Q10 - R.Floorr)) + ((Q11 - R.HallwayType)*(Q11 - R.HallwayType)) + 
					     ((Q12 - R.Subway)*(Q12 - R.Subway)) + ((Q13 - R.PublicOffice)*(Q13 - R.PublicOffice)) +
						 ((Q14 - R.Hospital)*(Q14 - R.Hospital)) + ((Q15 - R.Dpartmentstore)*(Q15 - R.Dpartmentstore)) + 
						 ((Q16 - R.Mall)*(Q16 - R.Mall)) + ((Q17 - R.ETC)*(Q17 - R.ETC)) + ((Q18 - R.Park)*(Q18 - R.Park)) +
						 ((Q19 - R.School)*(Q19 - R.School)) + ((Q20 - R.YearBuilt)*(Q20 - R.YearBuilt)) +
						 ((Q21 - R.YrSold)*(Q21 - R.YrSold)) + ((Q22 - R.MonthSold)*(Q22 - R.MonthSold)) + ((Q23 - R.SalePrice)*(Q23 - R.SalePrice)));
			distance1:=SQRT(distance1);
			distance2:=SQRT(distance2);
			--DBMS_OUTPUT.PUT_LINE(distance1 || ' ' || distance2);
			IF distance1 < distance2 THEN
			    INSERT into ClusterTable VALUES(R.AparNo, 1);
			ELSIF distance1 > distance2 THEN
			    INSERT into ClusterTable VALUES(R.AparNo, 2);
			END IF;
			
		END LOOP;
	END dataAssign;
	
	PROCEDURE clusterUpdate(P1 OUT NUMBER, P2 OUT NUMBER, P3 OUT NUMBER, P4 OUT NUMBER, P5 OUT NUMBER, P6 OUT NUMBER, P7 OUT NUMBER, P8 OUT NUMBER, P9 OUT NUMBER, P10 OUT NUMBER, P11 OUT NUMBER, P12 OUT NUMBER, P13 OUT NUMBER, 
	                        P14 OUT NUMBER, P15 OUT NUMBER, P16 OUT NUMBER, P17 OUT NUMBER, P18 OUT NUMBER, P19 OUT NUMBER, P20 OUT NUMBER, P21 OUT NUMBER, P22 OUT NUMBER, P23 OUT NUMBER,
						    Q1 OUT NUMBER, Q2 OUT NUMBER, Q3 OUT NUMBER, Q4 OUT NUMBER, Q5 OUT NUMBER, Q6 OUT NUMBER, Q7 OUT NUMBER, Q8 OUT NUMBER, Q9 OUT NUMBER, Q10 OUT NUMBER, Q11 OUT NUMBER, Q12 OUT NUMBER, Q13 OUT NUMBER, 
	                        Q14 OUT NUMBER, Q15 OUT NUMBER, Q16 OUT NUMBER, Q17 OUT NUMBER, Q18 OUT NUMBER, Q19 OUT NUMBER, Q20 OUT NUMBER, Q21 OUT NUMBER, Q22 OUT NUMBER, Q23 OUT NUMBER)
	IS
	ApNo INT;
	count1 NUMBER:=0;
	count2 NUMBER:=0;
	BEGIN 
	    SELECT COUNT(*) INTO count1 FROM ClusterTable WHERE clusterid=1;
		SELECT COUNT(*) INTO count2 FROM ClusterTable WHERE clusterid=2;
		P1:=0; P2:=0; P3:=0; P4:=0; P5:=0; P6:=0; P7:=0; P8:=0; P9:=0; P10:=0; P11:=0; P12:=0; P13:=0; P14:=0; P15:=0; P16:=0; P17:=0; 
		P18:=0; P19:=0; P20:=0; P21:=0; P22:=0; P23:=0;
		Q1:=0; Q2:=0; Q3:=0; Q4:=0; Q5:=0; Q6:=0; Q7:=0; Q8:=0; Q9:=0; Q10:=0; Q11:=0; Q12:=0; Q13:=0; Q14:=0; Q15:=0; Q16:=0; Q17:=0; 
		Q18:=0; Q19:=0; Q20:=0; Q21:=0; Q22:=0; Q23:=0;
	    FOR K IN (SELECT * FROM ClusterTable WHERE clusterid=1) 
		LOOP
		    --ApNo:=K.id;
			FOR J IN (SELECT * FROM joinedTable@site1 WHERE AparNo=K.id)
			LOOP
			    P1:=P1+J.AparNo; P2:=P2+J.HeatingType; P3:=P3+J.AptManageType; P4:=P4+J.Parkinglot_Ground; 
				P5:=P5+J.Parkinglot_Basement; P6:=P6+J.N_APT; P7:=P7+J.N_manager; P8:=P8+J.N_elevators; 
				P9:=P9+J.Sizee; P10:=P10+J.Floorr; P11:=P11+J.HallwayType; P12:=P12+J.Subway; 
				P13:=P13+J.PublicOffice; P14:=P14+J.Hospital; P15:=P15+J.Dpartmentstore; P16:=P16+J.Mall; 
				P17:=P17+J.ETC; P18:=P18+J.Park; P19:=P19+J.School; P20:=P20+J.YearBuilt; 
				P21:=P21+J.YrSold; P22:=P22+J.MonthSold; P23:=P23+J.SalePrice;
			END LOOP;
		END LOOP;
		FOR K IN (SELECT * FROM ClusterTable WHERE clusterid=2) 
		LOOP
		    --ApNo:=K.id;
			FOR J IN (SELECT * FROM joinedTable@site1 WHERE AparNo=K.id)
			LOOP
			    Q1:=Q1+J.AparNo; Q2:=Q2+J.HeatingType; Q3:=Q3+J.AptManageType; Q4:=Q4+J.Parkinglot_Ground; 
				Q5:=Q5+J.Parkinglot_Basement; Q6:=Q6+J.N_APT; Q7:=Q7+J.N_manager; Q8:=Q8+J.N_elevators; 
				Q9:=Q9+J.Sizee; Q10:=Q10+J.Floorr; Q11:=Q11+J.HallwayType; Q12:=Q12+J.Subway; 
				Q13:=Q13+J.PublicOffice; Q14:=Q14+J.Hospital; Q15:=Q15+J.Dpartmentstore; Q16:=Q16+J.Mall; 
				Q17:=Q17+J.ETC; Q18:=Q18+J.Park; Q19:=Q19+J.School; Q20:=Q20+J.YearBuilt; 
				Q21:=Q21+J.YrSold; Q22:=Q22+J.MonthSold; Q23:=Q23+J.SalePrice;
			END LOOP;
		END LOOP;
		--DBMS_OUTPUT.PUT_LINE(count1 || ' ' || count2);
		P1:=P1/count1; P2:=P2/count1; P3:=P3/count1; P4:=P4/count1; P5:=P5/count1; P6:=P6/count1; P7:=P7/count1; P8:=P8/count1; P9:=P9/count1; 
		P10:=P10/count1; P11:=P11/count1; P12:=P12/count1; P13:=P13/count1; P14:=P14/count1; P15:=P15/count1; P16:=P16/count1; P17:=P17/count1; 
		P18:=P18/count1; P19:=P19/count1; P20:=P20/count1; P21:=P21/count1; P22:=P22/count1; P23:=P23/count1;
		
		Q1:=Q1/count2; Q2:=Q2/count2; Q3:=Q3/count2; Q4:=Q4/count2; Q5:=Q5/count2; Q6:=Q6/count2; Q7:=Q7/count2; Q8:=Q8/count2; Q9:=Q9/count2; 
		Q10:=Q10/count2; Q11:=Q11/count2; Q12:=Q12/count2; Q13:=Q13/count2; Q14:=Q14/count2; Q15:=Q15/count2; Q16:=Q16/count2; Q17:=Q17/count2; 
		Q18:=Q18/count2; Q19:=Q19/count2; Q20:=Q20/count2; Q21:=Q21/count2; Q22:=Q22/count2; Q23:=Q23/count2;
	END clusterUpdate;
	
	FUNCTION pricePrediction(P1 IN NUMBER, P2 IN NUMBER, P3 IN NUMBER, P4 IN NUMBER, P5 IN NUMBER, P6 IN NUMBER, P7 IN NUMBER, P8 IN NUMBER, P9 IN NUMBER, P10 IN NUMBER, P11 IN NUMBER, P12 IN NUMBER, P13 IN NUMBER, 
	                         P14 IN NUMBER, P15 IN NUMBER, P16 IN NUMBER, P17 IN NUMBER, P18 IN NUMBER, P19 IN NUMBER, P20 IN NUMBER, P21 IN NUMBER, P22 IN NUMBER, P23 IN NUMBER,
						     Q1 IN NUMBER, Q2 IN NUMBER, Q3 IN NUMBER, Q4 IN NUMBER, Q5 IN NUMBER, Q6 IN NUMBER, Q7 IN NUMBER, Q8 IN NUMBER, Q9 IN NUMBER, Q10 IN NUMBER, Q11 IN NUMBER, Q12 IN NUMBER, Q13 IN NUMBER, 
	                         Q14 IN NUMBER, Q15 IN NUMBER, Q16 IN NUMBER, Q17 IN NUMBER, Q18 IN NUMBER, Q19 IN NUMBER, Q20 IN NUMBER, Q21 IN NUMBER, Q22 IN NUMBER, Q23 IN NUMBER,
							 A1 IN NUMBER, A2 IN NUMBER, A3 IN NUMBER, A4 IN NUMBER, A5 IN NUMBER, A6 IN NUMBER, A7 IN NUMBER, A8 IN NUMBER, A9 IN NUMBER, A10 IN NUMBER, A11 IN NUMBER, A12 IN NUMBER, A13 IN NUMBER, 
	                         A14 IN NUMBER, A15 IN NUMBER, A16 IN NUMBER, A17 IN NUMBER, A18 IN NUMBER, A19 IN NUMBER, A20 IN NUMBER, A21 IN NUMBER, A22 IN NUMBER, A23 IN NUMBER)
    RETURN NUMBER
	IS
	dis_cluster1 NUMBER:=0;
	dis_cluster2 NUMBER:=0;
	BEGIN
	    dis_cluster1:= (((P2 - A2)*(P2 - A2)) + ((P3 - A3)*(P3 - A3)) + ((P4 - A4)*(P4 - A4)) + ((P5 - A5)*(P5 - A5)) + 
	                ((P6 - A6)*(P6 - A6)) + ((P7 - A7)*(P7 - A7)) + ((P8 - A8)*(P8 - A8)) + ((P9 - A9)*(P9 - A9)) + 
					((P10 - A10)*(P10 - A10)) + ((P11 - A11)*(P11 - A11)) + ((P12 - A12)*(P12 - A12)) + 
					((P13 - A13)*(P13 - A13)) + ((P14 - A14)*(P14 - A14)) + ((P15 - A15)*(P15 - A15)) + 
					((P16 - A16)*(P16 - A16)) + ((P17 - A17)*(P17 - A17)) + ((P18 - A18)*(P18 - A18)) +
					((P19 - A19)*(P19 - A19)) + ((P20 - A20)*(P20 - A20)) + ((P21 - A21)*(P21 - A21)) + 
					((P22 - A22)*(P22 - A22)));
						 
	    dis_cluster2:= (((Q2 - A2)*(Q2 - A2)) + ((Q3 - A3)*(Q3 - A3)) + ((Q4 - A4)*(Q4 - A4)) + ((Q5 - A5)*(Q5 - A5)) + 
	                ((Q6 - A6)*(Q6 - A6)) + ((Q7 - A7)*(Q7 - A7)) + ((Q8 - A8)*(Q8 - A8)) + ((Q9 - A9)*(Q9 - A9)) + 
					((Q10 - A10)*(Q10 - A10)) + ((Q11 - A11)*(Q11 - A11)) + ((Q12 - A12)*(Q12 - A12)) + 
					((Q13 - A13)*(Q13 - A13)) + ((Q14 - A14)*(Q14 - A14)) + ((Q15 - A15)*(Q15 - A15)) + 
					((Q16 - A16)*(Q16 - A16)) + ((Q17 - A17)*(Q17 - A17)) + ((Q18 - A18)*(Q18 - A18)) +
					((Q19 - A19)*(Q19 - A19)) + ((Q20 - A20)*(Q20 - A20)) + ((Q21 - A21)*(Q21 - A21)) + 
					((Q22 - A22)*(Q22 - A22)));
		dis_cluster1:=SQRT(dis_cluster1);
	    dis_cluster2:=SQRT(dis_cluster2);

	    IF dis_cluster1 < dis_cluster2 THEN
	        RETURN 1;
	    ELSIF dis_cluster1 > dis_cluster2 THEN
	        RETURN 2;
	    END IF;
	END pricePrediction;
END K_Means;
/


ACCEPT X2 NUMBER PROMPT "Enter Heating Type(individual_heating-1, central_heating-2): ";
ACCEPT X3 NUMBER PROMPT "Enter Manager Type(management_in_trust-1, self_management-2): ";
ACCEPT X4 NUMBER PROMPT "Enter Parking Lot Ground: ";
ACCEPT X5 NUMBER PROMPT "Enter Parking Lot Basement: ";
ACCEPT X6 NUMBER PROMPT "Enter No of Apartment: ";
ACCEPT X7 NUMBER PROMPT "Enter No of Manager: ";
ACCEPT X8 NUMBER PROMPT "Enter No of Elevator: ";
ACCEPT X9 NUMBER PROMPT "Enter Size(sqf): ";
ACCEPT X10 NUMBER PROMPT "Enter Floor: ";
ACCEPT X11 NUMBER PROMPT "Enter Hallway Type(Terraced-1, Corridor-2, Mixed-3): ";
ACCEPT X12 NUMBER PROMPT "Enter No of Subway: ";
ACCEPT X13 NUMBER PROMPT "Enter No of Public Office: ";
ACCEPT X14 NUMBER PROMPT "Enter No of Hospital: ";
ACCEPT X15 NUMBER PROMPT "Enter No of Departmental Store: ";
ACCEPT X16 NUMBER PROMPT "Enter No of Mall: ";
ACCEPT X17 NUMBER PROMPT "Enter No of ETC: ";
ACCEPT X18 NUMBER PROMPT "Enter No of Park: ";
ACCEPT X19 NUMBER PROMPT "Enter No of School: ";
ACCEPT X20 NUMBER PROMPT "Enter Year Built: ";
ACCEPT X21 NUMBER PROMPT "Enter Selling Year: ";
ACCEPT X22 NUMBER PROMPT "Enter Selling Month: ";

DECLARE
	P1 INT; P2 INT; P3 INT; P4 INT; P5 INT; P6 INT; P7 INT; P8 INT; P9 INT; P10 INT; P11 INT; P12 INT; 
	P13 INT; P14 INT; P15 INT; P16 INT; P17 INT; P18 INT; P19 INT; P20 INT; P21 INT; P22 INT; P23 INT;
	Q1 INT; Q2 INT; Q3 INT; Q4 INT; Q5 INT; Q6 INT; Q7 INT; Q8 INT; Q9 INT; Q10 INT; Q11 INT; Q12 INT; 
	Q13 INT; Q14 INT; Q15 INT; Q16 INT; Q17 INT; Q18 INT; Q19 INT; Q20 INT; Q21 INT; Q22 INT; Q23 INT;
	upd INT;
	A1 NUMBER:=101; A2 NUMBER:='&X2';  A3 NUMBER:='&X3';  A4 NUMBER:='&X4';  A5 NUMBER:='&X5';  A6 NUMBER:='&X6';  
    A7 NUMBER:='&X7';  A8 NUMBER:='&X8';  A9 NUMBER:='&X9';  A10 NUMBER:='&X10';  A11 NUMBER:='&X11';  A12 NUMBER:='&X12';  
    A13 NUMBER:='&X13';  A14 NUMBER:='&X14';  A15 NUMBER:='&X15';  A16 NUMBER:='&X16';  A17 NUMBER:='&X17';  A18 NUMBER:='&X18';  
	A19 NUMBER:='&X19'; A20 NUMBER:='&X20';  A21 NUMBER:='&X21';  A22 NUMBER:='&X22';  A23 NUMBER:=0; 
	
	HeatingEXCEPTION EXCEPTION;
	ManagerEXCEPTION EXCEPTION;
	HallwayEXCEPTION EXCEPTION;
	YearEXCEPTION EXCEPTION;
	prediction NUMBER;
	
BEGIN
    FOR R IN (SELECT * FROM joinedTable@site1 WHERE joinedTable.AparNo = 15) LOOP
	    P1:=R.AparNo; P2:=R.HeatingType; P3:=R.AptManageType; P4:=R.Parkinglot_Ground; P5:=R.Parkinglot_Basement;
		P6:=R.N_APT; P7:=R.N_manager; P8:=R.N_elevators; P9:=R.Sizee; P10:=R.Floorr; P11:=R.HallwayType; P12:=R.Subway;
		P13:=R.PublicOffice; P14:=R.Hospital; P15:=R.Dpartmentstore; P16:=R.Mall; P17:=R.ETC; P18:=R.Park; P19:=R.School;
		P20:=R.YearBuilt; P21:=R.YrSold; P22:=R.MonthSold; P23:=R.SalePrice;
	END LOOP;
	FOR R IN (SELECT * FROM joinedTable@site1 WHERE joinedTable.AparNo = 71) LOOP
	    Q1:=R.AparNo; Q2:=R.HeatingType; Q3:=R.AptManageType; Q4:=R.Parkinglot_Ground; Q5:=R.Parkinglot_Basement;
		Q6:=R.N_APT; Q7:=R.N_manager; Q8:=R.N_elevators; Q9:=R.Sizee; Q10:=R.Floorr; Q11:=R.HallwayType; Q12:=R.Subway;
		Q13:=R.PublicOffice; Q14:=R.Hospital; Q15:=R.Dpartmentstore; Q16:=R.Mall; Q17:=R.ETC; Q18:=R.Park; Q19:=R.School;
		Q20:=R.YearBuilt; Q21:=R.YrSold; Q22:=R.MonthSold; Q23:=R.SalePrice;
	END LOOP;
	
	FOR I IN 1..5 
	LOOP
	    K_Means.dataAssign(P1,P2,P3,P4,P5,P6,P7,P8,P9,P10,P11,P12,P13,P14,P15,P16,P17,P18,P19,P20,P21,P22,P23,
		                   Q1,Q2,Q3,Q4,Q5,Q6,Q7,Q8,Q9,Q10,Q11,Q12,Q13,Q14,Q15,Q16,Q17,Q18,Q19,Q20,Q21,Q22,Q23);
	    K_Means.clusterUpdate(P1,P2,P3,P4,P5,P6,P7,P8,P9,P10,P11,P12,P13,P14,P15,P16,P17,P18,P19,P20,P21,P22,P23,
	                          Q1,Q2,Q3,Q4,Q5,Q6,Q7,Q8,Q9,Q10,Q11,Q12,Q13,Q14,Q15,Q16,Q17,Q18,Q19,Q20,Q21,Q22,Q23);
	END LOOP;
	
	CASE
	    WHEN A2>2 OR A2<1 THEN
		    RAISE HeatingEXCEPTION;
		WHEN A3>2 OR A3<1 THEN
		    RAISE ManagerEXCEPTION;
		WHEN A11>3 OR A11<1 THEN
		    RAISE HallwayEXCEPTION;
		WHEN A21<A20 THEN
		    RAISE YearEXCEPTION;
		ELSE
		    prediction:=K_Means.pricePrediction(P1,P2,P3,P4,P5,P6,P7,P8,P9,P10,P11,P12,P13,P14,P15,P16,P17,P18,P19,P20,P21,P22,P23,
		                                        Q1,Q2,Q3,Q4,Q5,Q6,Q7,Q8,Q9,Q10,Q11,Q12,Q13,Q14,Q15,Q16,Q17,Q18,Q19,Q20,Q21,Q22,Q23,
												A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11,A12,A13,A14,A15,A16,A17,A18,A19,A20,A21,A22,A23);
			
	END CASE;
	
	DBMS_OUTPUT.PUT_LINE('\n');
	DBMS_OUTPUT.PUT_LINE('********************K MEANS CLUSTERING********************');
	
	IF prediction = 1 THEN	    
		DBMS_OUTPUT.PUT_LINE('Apartment Belongs To Cluster 1');
		DBMS_OUTPUT.PUT_LINE('Price of Apartment in Cluster 1: ' || P23);
	ELSIF prediction = 2 THEN
		DBMS_OUTPUT.PUT_LINE('Apartment Belongs To Cluster 2');
		DBMS_OUTPUT.PUT_LINE('Price of Apartment in Cluster 2: ' || Q23);
	END IF;
	
EXCEPTION
    WHEN HeatingEXCEPTION THEN
	    DBMS_OUTPUT.PUT_LINE('');
	    DBMS_OUTPUT.PUT_LINE('ERROR! Heating Type Must be 1 or 2');
	WHEN ManagerEXCEPTION THEN
	    DBMS_OUTPUT.PUT_LINE('');
	    DBMS_OUTPUT.PUT_LINE('ERROR! Manager Type Must be 1 or 2');
	WHEN HallwayEXCEPTION THEN
	    DBMS_OUTPUT.PUT_LINE('');
	    DBMS_OUTPUT.PUT_LINE('ERROR! Hallway Type Must be within 1 to 3');
	WHEN YearEXCEPTION THEN
	    DBMS_OUTPUT.PUT_LINE('');
	    DBMS_OUTPUT.PUT_LINE('ERROR! Selling Year Cannot Be Less Than Building Year!');
		
END;
/

COMMIT;


