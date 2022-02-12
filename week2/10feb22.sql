https://youtu.be/5nnyG0y5Qro



-- PL/SQL
--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

--#Language [PL/SQL]
-- 1.Data types
-- 2.Variables, Type of variable (const, Varyig, Values), Scop (Global/Local)
-- 3.Operators, keywords [Arithmetic, Assignment, conditional, Logical]
-- 4.Conditional Statment  [if..else, case when then]
-- 5.Looping Statment [do-while, while, for(fix)]
-- 6.Reuseable-> functions, Procedure
-- 7.OOP

--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

-- PL/SQL Anonumus block
-- Anonymuous block without name
--  Name Block ==> Call again and again procerdure or function 
-- block begin ... END;
-- Space Before the begin kwyword we can use it for declration of variables

-- EXAMPLE

BRGIN 
    -- INSTRUTIONS TO BE EXECUTED
    -- ANYTHIN GOES WRONG YOU WILL RAISE ERROR/EXCEPTIONS
    -- IF EXCEPTIOJNS OCCUERD WE NEED TO HANDLE THE EXCEPTIONS
    
END;



-- Hello world;
--  WE NEED TO SET SERVER OUT PUT ON FOR THE NO NAME PROCEDURE TO RUN AND SHOW THE OUT PUT
SET SERVEROUTPUT ON;

BEGIN
    DBMS_OUTPUT.put_line('Hello world');
    DBMS_OUTPUT.put_line(10+20);
END;

-- DBMS_OUTPUT --> IT IS THE OBJECT
-- OUPUTLINE --> WILL UNDERSTAND THAT WHAT IS GIVEN STRING OR NUMERIC VALUES
            --> TAKES ONLY ONE ARGUMENT 
            --> CONCATINATION IS NOT ALLOWD 

--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

--PRINT MESSAGE == "HELLO WORLD USING VARIABLE " 
-- HERE = IS USED FOR COMPARISON OPRATOR FOR EQUALITY 
-- N=10 -> CHECKING WHETHER N HAS VALUE AS 10 IF YES IT RETURNS TRUE OTHERWISE FALSE
-- PL/SQL we use ':=' as an assignment oprator 
-- lhs := rhs will have rhs value
-- lhs = rhs indicates lhs is equal to rhs

DECLARE 
    V_MESSAGE VARCHAR2(50) := 'HELLO WORLD!';
BEGIN
    dbms_output.put_line(V_MESSAGE);
END;

--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    v_message   -> Naming convention
                    -> all variables must start with v_
                    -> must be meaningful names in camelcase if varying values
                    -> must be meaningful names in capitalcase if constant values
--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
-- exception handaling 
-- number can't be devided by zero => error error decide by zero 
--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
-- without handaling exception 
DECLARE 
    v_result number := 0;
BEGIN
    v_result := 1/0;
END;

--- With handing the exeption 
DECLARE 
    v_result number := 0;

BEGIN
    v_result := 1/0;
    EXCEPTION 
        WHEN ZERO_DIVIDE THEN
            dbms_output.put_line('zero devide error');
END;

--###########################################################################                            
--    DBMS_OUTPUT.put_line(SQLERRM );
--    ORA-01476: divisor is equal to zero    
--    PL/SQL procedure successfully completed.
--###########################################################################                        
--    DBMS_OUTPUT.put_line('zero devide error');
--    zero devide error
--    PL/SQL procedure successfully completed.
--###########################################################################    

-- LOCAL VARIABLE
--###########################################################################                        
DECLARE
    l_ename varchar2(50):='KING';
    l_mgr  number:=0;
BEGIN
    DBMS_OUTPUT.put_line(l_ename);
    DBMS_OUTPUT.put_line(l_mgr);
END;
--###########################################################################                        
-- anchored
-- get ename for empno 7788
--SELECT ENAME FROM EMP WHERE EMPNO=7788;

--###########################################################################                        
DECLARE
    v_ename  varchar2(50);
BEGIN
        SELECT ename into v_ename from emp where empno=7788;
        
        DBMS_OUTPUT.PUT_LINE(v_ename);
END;
--###########################################################################                        
--    SCOTT
--    PL/SQL procedure successfully completed.
--###########################################################################                        
DECLARE
    v_ename emp.ename%Type;
    v_sal   emp.sal%Type;
BEGIN
    SELECT
        ename,sal 
        INTO
        v_ename,v_sal
    FROM 
        emp
    WHERE 
        empno=7788;
    DBMS_OUTPUT.PUT_LINE(v_ename|| ':' || v_sal);
       
END;
--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

--###########################################################################                            
-- In above examples we have focused on getting result for only single record
-- a. query returns more than one record[one or more columns] 
--  SELECT ENAME,SAL FROM EMP WHERE DEPTNO=30; -- 7 RECORDS ARE SHOWN
-- b. query returns exactly one record[one or more columns]
--SELECT ENAME,SAL FROM EMP WHERE EMPNO=7788;  -- 1 RECORD ARE SHOWN
--###########################################################################
DECLARE 
    v_ename emp.ename%type;
    v_sal emp.sal%type;
    v_comm emp.comm%type;
    v_incentive constant emp.comm%type:=0.10;
BEGIN
        SELECT ENAME,SAL,nvl(comm,0) INTO v_ename,v_sal,v_comm 
        from emp where empno=7788;
--        v_incentive:=0.2; expression 'V_INCENTIVE' cannot be used as an assignment target
        v_sal:=v_sal+v_comm+v_incentive;
        
        DBMS_OUTPUT.PUT_line('Total Salary is '||v_sal);
END;
--###########################################################################
--    Total Salary is 3000.1
--    PL/SQL procedure successfully completed.
--###########################################################################
--###########################################################################
--Section 2. Conditional control
-- conditional will work on expressions which returns true or false
-- if expression returns true there are set of instructions
-- if expression returns false there are another set of instructions
--IF statements – introduce you various IF statement to either execute or skip a sequence of statements based on a condition.
--CASE statements – learn how to choose one sequence of statements out of many possible sequences to execute.
--GOTO – explain the GOTO statement and shows how to use it to transfer control to a labeled block or statement.
--NULL statement – show you how to use the NULL statement to make the code more clear.
--###########################################################################
--        – IF THEN
--        – IF THEN ELSE
--        – IF THEN ELSIF

--            IF condition THEN
--                statements;
--            END IF;
--###########################################################################
-- max(sal)<6000 then print Salary revision is needed
--###########################################################################
DECLARE 
    v_maxsal emp.sal%type;
BEGIN
    select max(sal) into v_maxsal from emp;
    IF v_maxsal<6000 THEN 
        DBMS_OUTPUT.PUT_LINE('SALARY REVISION IS REQUIRED');
    END IF;
END;
--###########################################################################
--        SALARY REVISION IS REQUIRED
--        PL/SQL procedure successfully completed.
--###########################################################################
DECLARE 
    v_maxsal emp.sal%type;
BEGIN
    select max(sal) into v_maxsal from emp;
    IF v_maxsal<=4000 THEN 
        DBMS_OUTPUT.PUT_LINE('SALARY REVISION IS REQUIRED');
    ELSE  
        DBMS_OUTPUT.PUT_LINE('CAN CONSIDER IN NEXT YEAR');
    END IF;
END;

--###########################################################################
DECLARE 
    v_maxsal emp.sal%type;
BEGIN
    select max(sal) into v_maxsal from emp;
    IF v_maxsal<3000 THEN 
        DBMS_OUTPUT.PUT_LINE('MAX SALARY <3000');
    ELSIF   v_maxsal<4000 THEN 
        DBMS_OUTPUT.PUT_LINE('MAX SALARY <4000');
    ELSE
        DBMS_OUTPUT.PUT_LINE('MAX SALARY <=5000');
    END IF;
END;


--###########################################################################
--VARIABLE =(SET VALUES ) BASED ON VALUES OF THIS VARIABLE WE WANT TO MAKE DESCIONS 
--CASE STATEMENT IS USEFULL IN EQUALITY CHECK
--        CASE selector
--        WHEN selector_value_1 THEN
--            statements_1
--        WHEN selector_value_1 THEN 
--            statement_2
--        ...
--        ELSE
--            else_statements
--        END CASE;
--###########################################################################
DECLARE
        v_color color.colorcode%type;
BEGIN
    select colorcode into v_color from color where id=1;
    case v_color
        when '#FF0000' then dbms_output.put_line('RED');
        when '#00FF00' then dbms_output.put_line('GREEN');
        when '#0000FF' then dbms_output.put_line('BLUE')  ;  
        else  dbms_output.put_line('NO COLOR');
    end case;    
END;

--###########################################################################
-- PRINT FIRST 5 RECORDS[ENAME] FROM EMP
--###########################################################################
DECLARE
    v_i NUMBER := 1;
    v_ename emp.ename%type;
BEGIN
    LOOP
        select ename INTO v_ename FROM emp WHERE empno = 7368 + v_i ORDER BY empno;
        dbms_output.put_line(v_ename);
       -- v_i := v_i+1;
        
       /* IF v_i = 5 THEN
            EXIT;
        END IF;*/
        
    END LOOP;
END;

DECLARE 
    v_i NUMBER := 1;
    v_ename emp.ename%type;
BEGIN
    FOR a in 7369..7374 LOOP 
            select ename into v_ename from emp where empno = a;
     --   select ename.NEXTVAL INTO v_ename FROM emp WHERE EMPNO = a ORDER BY empno;
        dbms_output.put_line('value of a: ' || a); 
  END LOOP; 
END;


DECLARE
    v_i NUMBER := 1;
    v_e_row NUMBER := 0;
    v_ename emp.ename%type;
    
    CURSOR emp_det IS
        SELECT ROW_NUMBER() OVER(ORDER BY empno) AS r_num, ename FROM emp ;
        
BEGIN 
    OPEN emp_det;
    LOOP 
        FETCH emp_det INTO v_e_row, v_ename;
        IF v_i <= 5 THEN 
            dbms_output.put_line(v_ename);
        ELSE
            EXIT;
        END IF;
    END LOOP;
END;

select ename from emp where 1 IN (select ROW_NUMBER() OVER(ORDER BY empno) from emp);

select ename from emp where 1 = ROW_NUMBER() OVER(ORDER BY empno)

describe emp
select * from color;


