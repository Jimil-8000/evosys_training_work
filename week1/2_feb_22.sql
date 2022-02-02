
--TABLE joins
https://www.javatpoint.com/oracle-tutorial
https://www.oracletutorial.com/oracle-basics/oracle-joins/
https://www.oracletutorial.com/oracle-string-functions/
https://www.javatpoint.com/oracle-anti-join
-----------------------------------------------------

ALTER TABLE emp
DROP COLUMN BRANCHNO;

----------------
----Display employee details such that ename,deptname and location of work is printed by the query

SELECT 
    e.ename, d.dname, b.branchname
FROM
    emp e JOIN dept d 
    ON
    e.deptno = d.deptno 
    JOIN branch b
    ON
    d.branchno = b.branchno;
    

--##################
-- LIST EMPNAME, JOB, MGR, HIREDATE, SAL, DNAME
-- EMP [ EMPNAME, JOB, MGR, HIREDATE, SAL]
-- DEPT [ DNAME ]
-- EMP.DEPTNO=DEPT.DEPTNO
---#############

SELECT 
    e.ename, e.job, e.mgr, e.hiredate, e.sal, d.dname
FROM
    emp e JOIN dept d 
    ON
    e.deptno = d.deptno;
    
   --######################################################################
   --OUUTER join WILL EXCLUDE THE COMMON INTERSACTON DATA FROM THE JOIN
   --######################################################################
   
--##################
-- LIST  ALL employees details such as EMPNAME, JOB, MGR, HIREDATE, SAL, DNAME
-- join to dept table
-- left join to dept table 
-- ALL emp details along with dname even is some emplot=yee has null value in deptno.
-- EMP [ EMPNAME, JOB, MGR, HIREDATE, SAL]
-- DEPT [ DNAME ]
-- EMP.DEPTNO=DEPT.DEPTNO
---############# 
    --> It will disply all the data from dept table from left side table which contains null also be comming 

SELECT 
    e.ename, e.job, e.mgr, e.hiredate, e.sal, d.dname
FROM
    emp e LEFT OUTER JOIN dept d 
    ON
    e.deptno = d.deptno;
 
 --##################
-- LIST  ALL employees details such as EMPNAME, JOB, MGR, HIREDATE, SAL, DNAME
-- join to dept table
-- right join to dept table 
-- ALL emp details along with dname even is some emplot=yee has null value in deptno.
-- EMP [ EMPNAME, JOB, MGR, HIREDATE, SAL]
-- DEPT [ DNAME ]
-- EMP.DEPTNO=DEPT.DEPTNO
---#############   
--> It will disply all the data from emp table from left side table which contains null also be comming 
SELECT 
    e.ename, e.job, e.mgr, e.hiredate, e.sal, d.dname
FROM
    emp e RIGHT OUTER JOIN dept d 
    ON
    e.deptno = d.deptno;
    
    
    
--######################################################################
--LIST  ALL employees details such as EMPNAME, JOB, MGR, HIREDATE, SAL, DNAME
-- EVEN FOR THE NULL VALUES IN BOTH TABLES
--######################################################################
--- ALL the Data will came from both the tables 

SELECT
    e.ename, e.job, e.mgr, e.hiredate, e.sal, d.dname
FROM
    emp e FULL OUTER JOIN dept d 
    ON
    e.deptno = d.deptno;


--######################################################################
--list ename, job, sal, branchname
--emp
--branch
--######################################################################
SELECT
    e.ename, e.job, e.sal, b.branchname
FROM
    emp e JOIN  dept d
    ON
        e.deptno = d.deptno JOIN
        branch b 
    ON
        d.branchno= b.branchno;


--######################################################################
--List ALL dname and emp count from each dept
--######################################################################

SELECT
    d.dname,count(e.empno)
FROM
    dept d JOIN emp e
    ON
    d.deptno = e.deptno
GROUP BY
    d.dname;
    
    
--######################################################################
-- List all branchname and emp count for each branch
--######################################################################

SELECT
    b.branchname,COUNT (e.empno)
FROM
    branch b JOIN dept d
    ON
    d.branchno = b.branchno
    JOIN emp e
    ON 
    e.deptno = d.deptno
GROUP BY
    b.branchname;







--LIST BRANCHNAME,DNAME,SUM OF SAL FOR THOSE BRANCH AND DEPT WHERE THE SUM IS >5000

SELECT 
    b.branchname, d.dname, SUM(e.sal)
FROM
    branch b JOIN dept d
    ON
    b.branchno = d.branchno
    JOIN emp e
    ON
    e.deptno = d.deptno

GROUP BY
    b.branchname,
    d.dname
HAVING
    SUM(e.sal) > 5000;

   
--######################################################################
-- List empno,enmae,mgr,manager name
--######################################################################
SELECT
    e.empno,e.ename,e.mgr,m.ename
FROM
    emp e JOIN emp m 
    ON
    e.mgr = m.empno;
    
    
--###########################################################################################
--Text Litral Example
-- The texr litreal '10' has datatype CHAR
-- Oreacle implicitly converts it to the NUMBER datatype if it appears in numeric
-- expression as in the following
--##########################################################################################

--Display emp salary  + 10
SELECT empno,ename,sal, sal+10 FROM emp;
SELECT empno,ename+'WELCOM',sal, sal+10 FROM emp; -- This will not work beacuse it is String having VARCAHR datatype.


---############# STRING FUNCTION FIND ################
--1.CONCATINATION : SELECT CONCAT(ename,' WELCOME') FROM emp;
--2.INDEX OF CHARACTER : 
--3.CONTAINS
--4.SUBSTRING
--########################################
















--#####################################################################################
-- to_char(datetim)


--#####################################################################################

CREATE TABLE date_tab (
   ts_col      TIMESTAMP,
   tsltz_col   TIMESTAMP WITH LOCAL TIME ZONE,
   tstz_col    TIMESTAMP WITH TIME ZONE);
   

INSERT INTO date_tab VALUES (  
   TIMESTAMP'1999-12-01 10:00:00',
   TIMESTAMP'1999-12-01 10:00:00',
   TIMESTAMP'1999-12-01 10:00:00');

SELECT * FROM date_tab;

ALTER SESSION SET TIME_ZONE = '-8:00';

INSERT INTO date_tab VALUES (  
   TIMESTAMP'1999-12-01 10:00:00',
   TIMESTAMP'1999-12-01 10:00:00',
   TIMESTAMP'1999-12-01 10:00:00');