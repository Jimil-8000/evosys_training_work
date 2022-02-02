
--DB Tables 
SELECT * FROM  Branch;

SELECT * FROM dept;

SELECT * from emp;

--#########################################################################################
        --ASSIGNMENT ON EMP DB
--########################################################################################## 
-- 1.Display all the information of the EMP table?
DESCRIBE emp;
--
SELECT 
    *
FROM
    emp;
--
SELECT 
    empno, ename, job, mgr, hiredate, sal, comm, deptno, branchno
FROM
    emp;
--########################################################################################## 
--2. Display unique Jobs from EMP table?

SELECT 
    DISTINCT job
FROM
    emp;

--########################################################################################## 
--3. List the emps in the asc order of their Salaries?

SELECT 
    empno,ename,sal
FROM
    emp
ORDER BY
    sal ASC;
    
--##########################################################################################    
--4.  List the details of the emps in asc order of the Dptnos and desc of Jobs?

SELECT 
    empno,ename, deptno, job
FROM    
    emp
ORDER BY
    deptno ASC,
    job DESC;

--########################################################################################## 
--5.  Display all the unique job groups in the descending order?

SELECT
    DISTINCT job
FROM
    emp
ORDER BY
    job DESC;
    
--########################################################################################## 
--6.  Display all the details of all ‘Mgrs’
SELECT 
    *
FROM
    emp
WHERE
    empno IN(
        SELECT
            mgr 
        FROM
            emp
    )
ORDER BY
    Mgr;

--##########################################################################################    
--7.List the emps who joined before 1981
SELECT 
    empno, ename, HIREDATE
FROM
    emp
WHERE
    YEAR(HIREDATE) < 81;
---
SELECT 
    empno, ename, HIREDATE
FROM
    emp
WHERE
    HIREDATE < ('1-01-81');


--##########################################################################################   
--8. List the Empno, Ename, Sal, Daily sal of all emps in the asc order of Annsal
SELECT
    empno, ename, sal, round(sal/30) as Daily_sal, sal*12 
FROM    
    emp
ORDER BY
    sal ASC;
  
--##########################################################################################   
--9.Display the Empno, Ename, job, Hiredate, Exp of all Mgrs
SELECT 
    empno, ename, job, hiredate, round(months_between(SYSDATE,hiredate)/12) exp
FROM
    emp
WHERE 
    empno IN(
    SELECT
        mgr
    FROM
        emp);

--##########################################################################################   
--10.  List the Empno, Ename, Sal, Exp of all emps working for Mgr 7369
SELECT
    empno, ename, job, hiredate, round(months_between(SYSDATE,hiredate)/12) exp
FROM
    emp
WHERE 
    mgr = 7369;

--########################################################################################## 
--11. Display all the details of the emps whose Comm  Is more than their Sal

SELECT
    empno, ename, sal, comm, branchno
FROM
    emp
WHERE
    comm > sal;

--########################################################################################## 
--13.  List the emps along with their Exp and Daily Sal is more than Rs 100 
SELECT
    empno, ename, job, round(months_between(SYSDATE,hiredate)/12) exp, round(sal/30) as Daily_sal
FROM
    emp
WHERE 
   round(sal/30) > 100;


--########################################################################################## 
--14.  List the emps who are either ‘CLERK’ or ‘ANALYST’ in the Desc order

SELECT
    empno,ename,job,deptno
FROM
    emp
WHERE
    job = 'CLERK' OR job = 'ANALYST';
    
--########################################################################################## 
--15.  List the emps who joined on 1-MAY-81,3-DEC-81,17-DEC-81,19-JAN-80 in asc order of seniority

SELECT 
    empno,ename,job,deptno
FROM
    emp
WHERE
    hiredate IN('1-MAY-81','3-DEC-81','17-DEC-81','19-JAN-80')
ORDER BY
    hiredate;
    
--########################################################################################## 
--16. List the emp who are working for the Deptno 10 or20

SELECT 
    empno,ename,job,deptno
FROM
    emp
WHERE
    deptno IN(10,20);
    
--##########################################################################################     
--17. List the emps who are joined in the year 81 
SELECT 
    empno,ename,job,deptno,hiredate
FROM    
    emp
WHERE
    hiredate BETWEEN ('01-jan-81') AND ('31-dec-81');
    
--########################################################################################## 
--19. List the emps Who Annual sal ranging from 22000 and 45000
 
SELECT 
    empno,ename,job,deptno,sal
FROM
    emp
WHERE   
    (sal*12) BETWEEN 22000 AND 45000;
    
 --########################################################################################## 
--20. List the Enames those are having five characters in their Names

SELECT 
    ename
FROM
    emp
WHERE
    ename LIKE ('_____'); -- five underscore
-----------
SELECT 
    ename
FROM 
    emp
WHERE
    LENGTH(ename) = 5;
    
 --########################################################################################## 
 --21.  List the Enames those are starting with ‘S’ and with five characters
 
SELECT 
    ename
FROM
    emp
WHERE
    ename LIKE('S____'); -- four underscore
----------
SELECT 
    ename
FROM
    emp
WHERE
    ename LIKE('S%') AND length(ename) = 5 ;
--##########################################################################################   
--22.  List the emps those are having four chars and third character must be ‘r’
SELECT 
    ename
FROM
    emp
WHERE
    ename LIKE('__R_');

--------
SELECT 
    ename
FROM
    emp
WHERE
    ename LIKE('__R%') AND length(ename) = 4;

--##########################################################################################
--23. List the Five character names starting with ‘S’ and ending with ‘H’
SELECT
    ename
FROM
    emp
WHERE
    ename LIKE ('S___H');
------
SELECT
    ename
FROM
    emp
WHERE
    ename LIKE ('S%H') AND LENGTH(ename) = 5;

--##########################################################################################
--24. List the emps who joined in January
SELECT 
    empno,ename,job,deptno,hiredate
FROM    
    emp
WHERE
    TO_CHAR(hiredate,'mm') = '01'; -- or TO_CHAR(hiredate,'mon') = 'jan'
    
--##########################################################################################
--27. List the emps whose names having a character set ‘LL’ together
SELECT
    ename
FROM
    emp
WHERE
    ename LIKE ('%LL%');

--##########################################################################################
--29.  List the emps who does not belong to Deptno 20
SELECT
    empno, ename, deptno
FROM    
    emp
WHERE
    deptno <> 20
ORDER BY
    deptno;
--##########################################################################################
--30.  List all the emps except ‘PRESIDENT’ & ‘MGR” in asc order of Salaries
SELECT
    empno, ename,job, deptno, mgr
FROM    
    emp
WHERE
    job != 'PRESIDENT'
ORDER BY
    deptno;

--##########################################################################################
--31.  List the emps whose Empno not starting with digit78
SELECT
    empno, ename,job, deptno, mgr
FROM    
    emp
WHERE
    empno NOT LIKE ('78%')
ORDER BY
    empno;

--##########################################################################################
-- 33. List the emps who are working under ‘MGR’

SELECT
    e.empno, e.ename, m.ename
FROM    
    emp e, emp m 
WHERE
   e.mgr = m.empno 
ORDER BY
    empno;

--##########################################################################################
--34.  List the emps who joined in any year but not belongs to the month of March
SELECT 
    empno,ename,job,deptno,hiredate
FROM    
    emp
WHERE
    TO_CHAR(hiredate,'mm') <> 03;

--##########################################################################################
--35.  List all the Clerks of Deptno 20
SELECT
    empno,ename,job,sal,deptno
FROM
    emp
WHERE
    job LIKE ('CLERK') AND deptno = 20;

--##########################################################################################
--36.  List the emps of Deptno 30 or 10 joined in the year 1981
SELECT
    empno,ename,hiredate,deptno
FROM
    emp
WHERE
    deptno IN(30,10) AND
    TO_CHAR(hiredate,'YY') LIKE '81'
ORDER BY
    deptno,
    hiredate ;


--##########################################################################################
--37. Display the details of SMITH
SELECT
    * 
FROM
    emp
WHERE
    ename LIKE ('SMITH');
--##########################################################################################
--38.  Display the location of SMITH
SELECT 
    e.empno , e.ename, b.branchname 
FROM
    emp e, branch b
WHERE
    e.ename LIKE ('SMITH') AND e.branchno = b.branchno;















