--1. Decode
--2. Subquries 
--3. copying the date to tables
--#############################################################
-- Function called DECODE
--############################################################

CREATE TABLE COLOR(
    ID INT,
    COLORCODE VARCHAR2(7)
);

INSERT INTO COLOR VALUES(1,'#FF0000');
INSERT INTO COLOR VALUES(2,'#00FF00');
INSERT INTO COLOR VALUES(3,'#0000FF');
INSERT INTO COLOR VALUES(4,NULL);

    
SELECT
    ID,COLORCODE,
    DECODE(COLORCODE,
    '#FF0000','RED',
    '#00FF00','GREEN',
    '#0000FF','BLUE',
    'COLOR CODE IS NOT MENTIONED') AS COLOR_NAME
FROM
    COLOR;


INSERT INTO COLOR VALUES(5,'#0000FF');
INSERT INTO COLOR VALUES(6,'#00FFFF');

--##########################################################################
--##########################################################################

--RANK FUNCTION , DENAE_RANK, ROW_NUMBER
--##########################################################################

SELECT EMPNO, ENAME,DEPTNO,SAL FROM EMP ORDER BY SAL;

SELECT 
    EMPNO, ENAME,DEPTNO,SAL, ROW_NUMBER() OVER(ORDER BY SAL)
FROM 
    EMP 
ORDER BY SAL;

--Above bith quries result is same 
-- Using ROW_NUMBER OVER(ORDER BY SAL) 



--#########################################################################--
--ROW_NUMBER_PARTITION()
-- will do group by and based on group data ranking will be given to that each record
--#########################################################################
-- USING ROW_NUMBER OVER( ORDER BY SAL) - FOR EVER DEPT

SELECT
    EMPNO,ENAME,DEPTNO,SAL, 
    ROW_NUMBER() OVER (PARTITION BY DEPTNO ORDER BY SAL) AS DEPT_RANK
FROM EMP ORDER BY DEPTNO,SAL;

--#####################################################################################
-- USING ROW_NUMBER() OVER (PARTITION BY DEPTNO ORDER BY SAL)
-- DISPLAY THE SECOND LOWEST VALUE
--#####################################################################################

SELECT 
    EMPNO, ENAME, DEPTNO, SAL
    ROW_NUMBER() OVER (PARTITION BY DEPTNO ORDER BY SAL)
FROM    
    EMP
ORDER BY 
    DEPTNO,SAL;
    
--#####################################################################################
-- USING RANK()
--A. RANK(CONTANT_VALUES, CONSTANT_VALUES,.....) WITHIN GROUP (ORDER BY COL1, COL2 )
--B. RANK() OVER (PARTITION BY DEPARTMENT_ID)
--#####################################################################################
--A. RANK(3000) WITHIN GROUP (ORDER BY SAL)
-- WE GET SINGLE RECORD 
-- IN EMP.SAL THE FIRST 3000 RANK IS RETURN BY THE RANK(3000) WITHIN GROUP(ORDER BY SAL)
--RANK(3000) WITHIN GROUP BY (ORDER BY SAL) WITH THIS WE CAN'T PRESENT OTHER COLUMNS
-- RANK(3000) WITHIN GROUP BY (ORDER BY SAL) WE CAN PASS COLUMN VALUES AS IT EXPECT ONLY CONSTANT VALUES
--#####################################################################################

SELECT 
    RANK(3000) WITHIN GROUP(ORDER BY SAL)
FROM
    EMP
ORDER BY SAL;


--##################################################################
--B. RANK() OVER (PARTITION BY department_id)
--##################################################################
SELECT 
    EMPNO, ENAME, DEPTNO, SAL,
    RANK() OVER(PARTITION BY DEPTNO ORDER BY SAL) AS RANK_OVER_GROUP_SAL
FROM 
    EMP
ORDER BY    
    DEPTNO;
    
    
    
----##################################################################
--USING DENSE_RANK
--A. RANK  
--##################################################################