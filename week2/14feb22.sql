https://www.javatpoint.com/pl-sql-tutorial

cursor -> point to the reacords from query

c_name cursor is select * from <table_name>

c_name(dept_no) cursor is select * from <table_name> where deptno = p_deptno

logic is some set instruction IPO

-> Input
-> Process 
-> Output -> Result set

For that we are using a concept of ref cusror 

Cursor impliclit / explicit
explicit => you declare the 

1. Strong : at any given pointof time this cursor will return only emp record
            Syntx :  Type_name_cursor ref CURSOR RETURN table_name%ROWTYPE;
            //declaring type 
            Type emp_cursor ref CURSOR RETURN emp%ROWTYPE;
            //instantiate the emp_cursor
            c_emp emp_cursor
            
            
2. weak : 
        create a cursor which can refer any entity at any give point of time
                Type_name_cursor ref CURSOR;
                Type ref_cursor ref CURSOR;



----------------------------------------------------------------------------------------------------------------------------------------

SYntex to create a function 

Create or replace function <function_name> 






CREATE OR REPLACE FUNCTION get_emp_by_deptno (p_deptno emp.deptno%type)
RETURN SYS_REFCURSOR
AS
    EMP_REF_CURSOR SYS_REFCURSOR; -- DECLARATION OF SYS_REFCURSOR VARIABLE
BEGIN
    OPEN EMP_REF_CURSOR FOR SELECT * FROM emp WHERE deptno = p_deptno;
    RETURN EMP_REF_CURSOR;
END;

--------
OUTPUT OF ABOVE CODE : "Function GET_EMP_BY_DEPTNO compiled"

---------

SET SERVEROUTPUT ON


DECLARE 
    EMP_REF_CURSOR SYS_REFCURSOR; 
    v_EMPNO emp.empno%type;
    v_ENAME emp.ename%type;
    v_JOB   emp.job%type;
    v_SAL   emp.sal%type;
    v_COMM  emp.comm%type;
    v_deptno emp.deptno%type:=&deptno;
BEGIN
     -- call function 
     EMP_REF_CURSOR := get_emp_by_deptno(v_deptno);
     
     LOOP
        FETCH
            EMP_REF_CURSOR
        INTO    v_EMPNO,v_ENAME,v_JOB,v_SAL,v_COMM;
        
        EXIT WHEN EMP_REF_CURSOR%NOTFOUND;
        
            DBMS_OUTPUT.PUT_LINE(
                v_EMPNO ||','||
                v_ENAME ||','||
                v_JOB   ||','||
                v_SAL   ||','||
                v_COMM 
                );
     END LOOP;
END;

----------------------------------
DECLARE 
    EMP_REF_CURSOR SYS_REFCURSOR;
    v_EMPNO emp.empno%type;
    v_ENAME emp.ename%type;
    v_JOB   emp.job%type;
    v_SAL   emp.sal%type;
    v_COMM  emp.comm%type;
    v_deptno emp.deptno%type:=&deptno;
BEGIN
    --   call the function
    EMP_REF_CURSOR:=get_emp_by_deptno(v_deptno);
    --   READ THE RECORDS FROM THE REF CURSOR    
        LOOP
            FETCH EMP_REF_CURSOR INTO v_EMPNO, v_ENAME,v_JOB,v_SAL,v_COMM;
            EXIT WHEN EMP_REF_CURSOR%NOTFOUND;
                DBMS_OUTPUT.PUT_LINE(
                v_EMPNO ||', '||
                v_ENAME ||', '||
                v_JOB   ||', '||
                v_SAL   ||', '||
                v_COMM 
                );
        END LOOP;  
END;


-----------

CREATE OR REPLACE FUNCTION TOTAL_SAL(SAL emp.sal%type,COMM emp.comm%type)
RETURN  emp.sal%type
AS
    v_total_sal emp.sal%type;
BEGIN
        IF COMM IS NULL THEN v_total_sal:=SAL+0;
        ELSE
            v_total_sal:=SAL+COMM;
        END IF;
        RETURN v_total_sal;
END;

SELECT ENAME,SAL,COMM, TOTAL_SAL(SAL,COMM) TOTAL_SAL FROM EMP;


--######################################################################
-- Use procedure to display all details of employee using empno-> single record
--######################################################################

CREATE OR REPLACE FUNCTION get_emp_by_empno(p_empno emp.empno%type)
RETURN SYS_REFCURSOR
AS
    EMPNO_REF_CURSOR SYS_REFCURSOR; -- DECLARATION OF SYS_REFCURSOR VARIABLE
BEGIN
    OPEN EMPNO_REF_CURSOR FOR SELECT * FROM emp WHERE empno = p_empno;
    RETURN EMPNO_REF_CURSOR;
END;


select * from emp;
DECLARE 
    EMPNO_REF_CURSOR SYS_REFCURSOR;
    v_EMPNO emp.empno%type := &empno;
    v_ENAME emp.ename%type;
    v_JOB   emp.job%type;
    v_SAL   emp.sal%type;
    v_COMM  emp.comm%type;
    v_deptno emp.deptno%type;
BEGIN
    --   call the function
    EMPNO_REF_CURSOR:=get_emp_by_deptno(v_empno);
    --   READ THE RECORDS FROM THE REF CURSOR    
        LOOP
            FETCH EMPNO_REF_CURSOR INTO v_EMPNO, v_ENAME,v_JOB,v_SAL,v_COMM,v_deptno;
            EXIT WHEN EMPNO_REF_CURSOR%NOTFOUND;
                DBMS_OUTPUT.PUT_LINE(
                v_EMPNO ||', '||
                v_ENAME ||', '||
                v_JOB   ||', '||
                v_SAL   ||', '||
                v_COMM 
                );
        END LOOP;  
END;



--######################################################################
-- Use procedure to display all details of employee using deptno-> mutliple record *cursor + for loop
--######################################################################