SET SERVEROUTPUT ON;

SELECT * FROM EMP;


--
DECLARE 
    v_ename emp.ename%TYPE;
    v_job emp.job%TYPE;
    v_hiredate emp.hiredate%TYPE;
    v_deptno emp.deptno%TYPE := &depno;  
    
BEGIN
    SELECT 
            ename,job,hiredate 
            INTO 
            v_ename,v_job,v_hiredate 
    FROM 
        emp 
    WHERE 
        deptno = v_deptno;
    
    EXCEPTION 
        WHEN NO_DATA_FOUND THEN 
            DBMS_OUTPUT.put_line('DEPT NO '||v_deptno||' NO RECORDS FOUND');
            
        WHEN TOO_MANY_ROWS THEN 
            DBMS_OUTPUT.put_line('DEPT NO '||v_deptno||' MORE THEN ONE RECORDS FOUND');
END;

---
DECLARE 
    v_salary_to_high EXCEPTION;
    PRAGMA EXCEPTION_INIT(v_salary_to_high,-20001);
    
    
    v_maxsal emp.sal%TYPE;
    v_newsal emp.sal%TYPE := &new_sal;
    v_empno emp.empno%TYPE := &empno;

BEGIN
    SELECT MAX(SAL) INTO v_maxsal FROM emp;
    
    IF v_newsal > v_maxsal THEN RAISE v_salary_to_high;
    ELSE
        UPDATE emp SET sal = v_newsal WHERE empno = v_empno;
    END IF;
    
    EXCEPTION
        WHEN v_salary_to_high THEN 
            DBMS_OUTPUT.PUT_LINE(v_newsal||' is too high than '|| v_maxsal || ' hence sal not revised');
END;

--#############################################
--create custom exception without handaling it 
----#############################################
DECLARE 
    v_salary_to_high EXCEPTION;
    PRAGMA EXCEPTION_INIT(v_salary_to_high,-20001);
    
    
    v_maxsal emp.sal%TYPE;
    v_newsal emp.sal%TYPE := &new_sal;
    v_empno emp.empno%TYPE := &empno;

BEGIN
    SELECT MAX(SAL) INTO v_maxsal FROM emp;
    
    IF v_newsal > v_maxsal THEN RAISE v_salary_to_high;
    ELSE
        UPDATE emp SET sal = v_newsal WHERE empno = v_empno;
    END IF;
    
    EXCEPTION
        WHEN v_salary_to_high THEN 
            DBMS_OUTPUT.PUT_LINE(v_newsal||' is too high than '|| v_maxsal || ' hence sal not revised');
END;

--****************************************************************************************************************
-- %ROWTYPE
--****************************************************************************************************************
DECLARE 
    v_emp_det emp%ROWTYPE;
BEGIN
    SELECT empno,ename,job,mgr,hiredate,sal,comm,deptno INTO v_emp_det FROM emp WHERE empno = 7788;
        DBMS_OUTPUT.PUT_LINE(v_emp_det.empno,v_emp_det.ename);
END;



--****************************************************************************************************************
--PL/SQL CURSOR 
-- IT will start point and end point within the file /page t read the data 
-- file system
-- read only 
-- ReadWrite 
-- Append
--fetch record from underline entities 
-- modification 
--****************************************************************************************************************

DECLARE 
    CURSOR c_emp IS SELECT * FROM emp WHERE deptno = 10;
    rec_emp emp%ROWTYPE;
    
BEGIN 
    OPEN c_emp;
    
    LOOP 
        FETCH c_emp INTO rec_emp;
        DBMS_OUTPUT.PUT_LINE(rec_emp.ename || ' ' || rec_emp.job);
        EXIT WHEN c_emp%NOTFOUND;
    END LOOP;
END;
--###########################################################################
-- Create custom exception with exception handling and custom message
--###########################################################################

DECLARE 
    v_salary_to_high Exception;
    PRAGMA exception_init(v_salary_to_high,-20101);
    v_maxsal emp.sal%type;
    v_newsal emp.sal%type:=&new_sal;
    v_empno emp.empno%type:=&empno;
BEGIN
     SELECT MAX(SAL) INTO v_maxsal FROM EMP;
     IF v_newsal > v_maxsal 
        THEN RAISE v_salary_to_high;
     ELSE
        UPDATE EMP SET SAL=v_newsal WHERE empno=v_empno;
     END IF;
     EXCEPTION
        WHEN v_salary_to_high THEN DBMS_OUTPUT.PUT_LINE(v_newsal||' is to high than max(sal) hence update not allowed');
END;

--###########################################################################
-- Create custom exception without exception handling
--raise_application_error(-20101,'new sal > max(sal) hence salary not updated');
--###########################################################################
DECLARE 
    v_salary_to_high Exception;
    PRAGMA exception_init(v_salary_to_high,-20101);
    v_maxsal emp.sal%type;
    v_newsal emp.sal%type:=&new_sal;
    v_empno emp.empno%type:=&empno;
BEGIN
     SELECT MAX(SAL) INTO v_maxsal FROM EMP;
     IF v_newsal > v_maxsal 
        THEN raise_application_error(-20101,'new sal > max(sal) hence salary not updated');
     ELSE
        UPDATE EMP SET SAL=v_newsal WHERE empno=v_empno;
     END IF;
END;

---$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
--CREATE A CURSOR FOR SELECT * FROM EMP AND RECORD ROR EMP%ROWTYPE
--IF REC_EMO.COMM IS NULL UPDATE COMM TO 0
---$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

DECLARE
    v_rec_emp emp%ROWTYPE;
    CURSOR  v_emp_cursor IS SELECT * FROM emp ;
BEGIN
    OPEN v_emp_cursor;
    LOOP
        FETCH v_emp_cursor INTO v_rec_emp;
        EXIT WHEN v_emp_cursor%NOTFOUND; 
        IF v_rec_emp.comm IS NULL THEN 
            UPDATE emp
            SET comm = 0
            WHERE empno = v_rec_emp.empno;
         END IF;
    END LOOP;
END;

select * from emp;
rollback;

--$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
--CREATE A CURSOR FOR SELECT * FROM EMP AND RECORD ROR EMP%ROWTYPE
--IF REC_EMO.COMM IS NULL UPDATE COMM TO 0
--$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

