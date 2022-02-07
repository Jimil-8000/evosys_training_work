/*View :

    window1 House which opens in garden view  -> Garden
    window2 House with opens in mountain view -> mountain 
    window3 House with opens in river view   -> river
    window4 -> garden river mounation view
*/
/*
Table => What to share with the user based on roles 
    
Sysdba => all access all privilages on every object oracle instance 
dba => access to role specific objects and proviliges on oracle instance 
user => grant permission on the userrole you can access objects on the oracle instance

*/

/*
    Some windows to be created on the tables so that we will share the information required.

    windows are nothing but VIRTUAL TABLE (View (virtual table)) which represents 
    Projection + restrictions on specific underline tables 
        a. View can be created on single table
        a. View can be created on multiple table
*/

/*
    Logically there some data whic is frequently required from the database 
    when we required certain data frequenly it indicates we are executing same query again and again 
    insted of we write the query again and again we can store this query as an object of view type
    
    Display the emplyee details (empno,ename,dname,job,sal,location)
    --emp
    --dept
    --branch
*/

SELECT 
    e.empno, e.ename, b.location,e.sal,d.dname
FROM
    emp e JOIN dept d
    ON
    e.deptno = d.deptno
    JOIN branch b
    ON
    b.branchno = d.branchno
ORDER BY 
    d.deptno;
    
-----------------------------------------------------------
--===============================
    --Creating view employee details 
--===============================

CREATE VIEW 
    vw_empdetails
AS
    SELECT 
        e.empno, e.ename, b.location,e.sal,d.dname
    FROM
        emp e JOIN dept d
        ON
        e.deptno = d.deptno
        JOIN branch b
        ON
        b.branchno = d.branchno
    ORDER BY 
        d.deptno;
        
        
----$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$]
Select * from vw_empdetails;



---- Get the manager name for each employee 
CREATE VIEW
    vw_mgr_details(ename,mgrname,deptno)
AS 
SELECT 
    E.ENAME ,M.ENAME ,E.DEPTNO
FROM
    EMP E JOIN EMP M
    ON
    E.MGR = M.EMPNO;

select * from vw_mgr_details
where 
    deptno = 30;

--##############################################################
-- view is created on single table 
-- WE CAN USE DML OPRATION ON IT SUCH AS INSERT/UPDATE/DELETE
--INCASE OF INSERT MUST HANDLE THE NULL VALUES
--##############################################################
-- iplay empno, ename, job, sal, comm, for an employee 
-- Department wide employee complete details related to job, sal comm along with 

SELECT
   deptno, empno, ename, job, sal, comm
FROM 
    emp
ORDER BY 
    deptno,empno;

CREATE VIEW vw_dept_wise_emp_details
(DEPTNO,EMPNO,ENAME,JOB,SAL,COMM)
AS
    SELECT
        deptno, empno, ename, job, sal, comm
    FROM 
        emp
    ORDER BY 
        deptno,empno;

select * from vw_dept_wise_emp_details;

select * from vw_dept_wise_emp_details where deptno = 30;

select * from vw_dept_wise_emp_details where deptno = 10;


UPDATE vw_dept_wise_emp_details
SET
    comm = 0
WHERE   
    deptno = 10;
    
create view 

as 
    select 
        d.dname,e.empno,ename,e.sal,COALESCE(e.comm,0)
    from 
        emp e join dept d
        on 
        e.deptno = d.deptno
    where 
        e.deptno = 30
        AND
        e.sal > (select avg(sal) from emp)
    order by 
        e.sal;
--Because ISNULL is a function, it is evaluated only once. As described above, the input values for the COALESCE expression can be evaluated multiple times.

-- branch(branchname, dept(dname)

select 
    dname,branchname
from 
    dept d, 
    Lateral (select *  from branch b where b.branchno = d.branchno)
order by 
    dname;