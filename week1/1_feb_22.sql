SELECT 
   * -- eno,ename,job,mgr,hiredate,sal,comm,depno,branchno
FROM 
    emp;
    
-- 12.1 Display all emp working in deptno 10
-- ----------------------------------------
SELECT
    empno,ename,deptno
FROM
    emp
WHERE 
    deptno=10;
    
-- 12.2 Display employee no,name, working department no 10
SELECT
    empno, ename, deptno
FROM 
    emp
WHERE
    deptno = 10;
    
--- 12.3 Display employee no,name, working department no 10 or 20
--- using OR
--- using IN
SELECT
    empno, ename, deptno
FROM 
    emp
WHERE
    deptno = 10 OR deptno = 20;
    
----- IN
SELECT
    empno, ename, deptno
FROM 
    emp
WHERE
    deptno IN(10,20);
    
    
--- 12.3 Display employee no,name, not working department no 10 or 20
--- using OR
--- using IN
SELECT
    empno, ename, deptno
FROM 
    emp
WHERE
    deptno != 10 OR deptno != 20;
    
----- IN  // IN will not compare the NULL values
SELECT
    empno, ename, deptno
FROM 
    emp
WHERE
    deptno NOT IN(10,20);

----12.3 Display all emoloyee working in dep no 10 or 20 or 30
    
----- IN  // IN will not compare the NULL values
----- Below query will not give any recordes as we are comparing values from list (10,20,30)
SELECT
    empno, ename, deptno
FROM 
    emp
WHERE
    deptno IN(10,20,30)
ORDER BY
    deptno;
    
---- not in depno 10 or 20 or 30
----- No Depno indicates NULL value hence we use 'IS NULL'
SELECT
    empno, ename, deptno
FROM 
    emp
WHERE
    deptno IS NULL
ORDER BY
    deptno;


---12.6 Display all emp who's depno is not null
SELECT
    empno, ename, deptno
FROM 
    emp
WHERE
    deptno IS NOT NULL
ORDER BY
    deptno;
    
    
--- 12.7 Display emp no,nam, comm working dep no 30 and earning some commission
SELECT
    empno, ename, deptno
FROM 
    emp
WHERE 
    deptno = 30 AND comm IS NOT NULL AND comm > 0
ORDER BY
    deptno;
    

--- 12.8 Display all employee not earning any commision
SELECT
    empno, ename, deptno
FROM 
    emp
WHERE 
    deptno = 30 AND (comm IS NULL OR comm = 0)
ORDER BY
    deptno;
    
---12.9 Display all employees waening salary in range 1000 to 300 including the boundry values 
SELECT
    empno, ename, sal, deptno
FROM 
    emp
WHERE 
    sal >= 1000 AND sal <= 3000
ORDER BY
    sal;
--------- using Between
SELECT
    empno, ename, sal, deptno
FROM 
    emp
WHERE 
    sal BETWEEN 1000 AND 3000
ORDER BY
    sal;

--- 12.10 Display all emolyees salaryu 1000 to 3000 excluding boundry values

SELECT
    empno, ename, sal, deptno
FROM 
    emp
WHERE 
    sal > 1000 AND sal < 3000
ORDER BY
    sal;
----
SELECT
    empno, ename, sal, deptno
FROM 
    emp
WHERE 
   sal NOT BETWEEN 1000 AND 3000
ORDER BY
    sal;
    
-----12,12 Display all emp earning exact 5000

SELECT
    empno, ename, sal, deptno
FROM 
    emp
WHERE 
   sal=5000
ORDER BY
    sal;
    
-----12.12 Display all emp not earning exact 5000

SELECT
    empno, ename, sal, deptno
FROM 
    emp
WHERE 
   sal!=5000
ORDER BY
    sal;
    -------
SELECT
    empno, ename, sal, deptno
FROM 
    emp
WHERE 
   sal<>5000
ORDER BY
    sal;
    
    
-----13.1 Display all details of SMITH
SELECT
    empno,ename
FROM
    emp
WHERE
    ename='SMITH';
    
--- 13.2 display emp who's name starts with 'S'
---- Begins with 'S%'
----Ends with '%S'
---Contains     '%LL%'
---Single Character '_Mith'   -- don't know the full name but i know that it has Mith in it

SELECT
    empno,ename
FROM
    emp
WHERE
    ename LIKE 'S%';
    
---- NOT LIKE
SELECT
    empno,ename
FROM
    emp
WHERE
    ename NOT LIKE 'S%';
    
    
-----13.3 Display all details of Emp who's name ends with S
SELECT
    empno,ename
FROM
    emp
WHERE
    ename LIKE '%S';

---13.4 Display emp whos name contains LL

SELECT
    empno,ename
FROM
    emp
WHERE
    ename LIKE '%LL%';
    
----13.5 Display emp who's name contains _
SELECT
    empno,ename
FROM
    emp
WHERE
    ename LIKE '%_%'; --// this is will give the all the data 
    
---- for single character match
SELECT
    empno,ename
FROM
    emp
WHERE
    ename LIKE '%\_%'; --- this will also not work // this will try to find name haiving \ in name
    
-----
SELECT
    empno,ename
FROM
    emp
WHERE
    ename LIKE '%\_%' ESCAPE'\';
    


--############################################################################
-- Aggregate function 

-- 14. Aggregate functions
--     SUM
--     AVG
--     COUNT
--     MAX
--     MIN


-- 14.1 Display count of employees
-- count(*) including null values     
SELECT
    COUNT(*), COUNT(empno),count(deptno)
FROM 
    emp;
    
-- 14.2 Display count of employees WORKING IN SOME DEPT
-- count(deptno) excludes the null vlaue 

select count(DEPTNO) from emp;
    
--14.3 Display max,min,sum,avg sallary of Employes

SELECT 
    MIN(sal), MAX(sal), COUNT(sal), SUM(sal), AVG(sal)
FROM
    emp;


---#################################################
--15.1 Display department wise count of employee

SELECT 
    deptno,count(empno)
FROM
    emp
GROUP BY
    deptno
ORDER BY
    deptno;
-----
-- Display job group by
SELECT 
    job,count(empno)
FROM
    emp
GROUP BY
    job
ORDER BY
    job;
    
SELECT 
    job,count(empno)
FROM
    emp
GROUP BY
    job
ORDER BY
    count(empno);
    
    
--- 15.2 Display department wise max,min,avg salary
SELECT 
    deptno,MAX(sal),MIN(sal),round(AVG(sal))
FROM
    emp
GROUP BY
    deptno
ORDER BY
    MIN(sal);
    
    
    
-- 15.3 Dis dept wise max,min,abg salary where avg(salary) < 25000
SELECT
    deptno,MAX(sal),MIN(sal),round(AVG(sal))
FROM    
    emp
GROUP BY
    deptno
HAVING 
    avg(sal) < 25000
ORDER BY
    deptno;


-- 16. Special functions nvl() 
-- If comm is null display 0
-- Display empno,ename,sal,comm and total sal=sal+comm for all employees 
-- 0+1 = 1 
-- null+1 = null
-- for calcluation purpose we can give some default values for null values in a column
-- for that oracle has function nvl()


SELECT 
    empno,ename,sal,comm,sal+nvl(comm,0)
FROM 
    emp
ORDER BY
    comm;

-- if comm 0 or comm is null -> 100
-- of comm > 0 comm

SELECT 
    empno,ename,sal,comm,
    case
        WHEN comm IS NULL OR comm = 0
             THEN 100
        WHEN comm > 0
              THEN comm
     end as UPDATED_COMMISSION,
     
     SAL+case
     WHEN comm IS NULL OR comm = 0
             THEN 100
        WHEN comm > 0
              THEN comm
     end as TOTAL_SALARY
FROM 
    emp
ORDER BY
    comm;
    
    
    
----- 17. Distinct values 
-- for unique records 
SELECT
    DISTINCT deptno
FROM
    emp;
    
    
--#########################################
--18. SUB QUERY

--18. Dis the emp empno,ename, and sal who are earning more then avg salary
        -- Query within Query 
        --inner Query and outer Query 
            --
    -- 1. Display empno,enmae,sal
SELECT 
    e.empno,e.ename,e.sal
FROM
    emp e;
    
    
    -- avg(sal)
SELECT 
    AVG(sal)
FROM
    emp;
    
    -- sal>avg(sal)
SELECT 
    e.empno,e.ename,e.sal
FROM
    emp e
WHERE
    sal > 
    (SELECT 
        AVG(sal)
     FROM    
        emp);
        
--18.1 Disp empno, ename, deptno for all emp working in 'ACCOUNTING'

--1. 
SELECT 
    empno, ename, deptno
FROM
    emp;
    
--2. 
SELECT 
    deptno
FROM
    dept
WHERE
    dname = 'ACCOUNTING';


--3 
SELECT 
    empno, ename, deptno
FROM
    emp
WHERE
    deptno =(
    SELECT 
        deptno
    FROM
        dept
    WHERE
        dname = 'ACCOUNTING'
    );
    
    
    
--- 18.3 Dis empno,ename,deptno, for all emp from dept having emp earning max salary

--1. DEpartment having emploee earning maz salary

SELECT
    deptno
FROM 
    emp
WHERE
    sal IN (
    SELECT 
        deptno,MAX(sal)
    FROM
        emp
        );
 
 
--2.    
SELECT 
    empno,ename,deptno
FROM 
    emp
GROUP BY
    deptno
HAVING 
    MAX(sal);

    
--- 18.3 Dis empno,ename,deptno, for all emp from dept having emp earning salary > avg salary

--1.
SELECT 
    deptno
FROM
    emp
WHERE
    sal>(
    SELECT 
        AVG(sal)
    FROM
        emp
    )
ORDER BY
    deptno;
    
--2. emp details
SELECT 
    empno,ename,deptno
FROM 
    emp
    
--3. final
SELECT 
    empno,ename,deptno
FROM 
    emp
WHERE
    deptno IN
    (
    SELECT 
        deptno 
    FROM
        emp
    WHERE
        sal > (SELECT AVG(sal) FROM emp)
    )
ORDER BY
    deptno;
    
    
--- 18.3 Dis empno,ename,deptno, for emp earning greater than any from emp of dept 30
--1. emp details
SELECT 
    empno,ename,deptno
FROM 
    emp