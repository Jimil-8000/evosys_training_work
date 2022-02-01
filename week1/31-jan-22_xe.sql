/*#### 31-Jan-22
Agenda: 
0. Create 31Jan22_xe.sql file in your d:\trainingad2022\week1
1. DDL -> create user c##<username> identified by <password>
2. Check the available user in database instance
3. Granting permission to our custom user -> c##aduser
4. connect to Oracle server using c##aduser -> we call that connection adHR
5. create 31Jan22_hr.sql 
6. DDL -> create dept,branch,emp
7. DML -> insert into dept/branch/emp
8. DQL-> from,select,where,order by etc. */

--To create the user in Oracle 
-- CREATE USER c##<user naem> identified by <password>

--check all users in oracle 
-- To check users in Oracle instance
SELECT 
    username, 
    default_tablespace, 
    profile, 
    authentication_type
FROM
    dba_users 
WHERE 
    account_status = 'OPEN'
ORDER BY
    username;



--3. Granting permission to our custom user -> c##aduser

GRANT create session To c##aduser; --Grant succeeded.

--object to be executed by the user which permisions need to given 

GRANT create table To c##aduser; --Grant succeeded.

GRANT create view TO c##aduser;

GRANT create any trigger TO c##aduser;

GRANT create any procedure TO c##aduser;

GRANT create sequence TO c##aduser;

GRANT create synonym TO c##aduser;

--------------------------------------
GRANT ALL PRIVILEGES TO c##aduser;

GRANT CONNECT TO c##aduser;
GRANT RESOURCE TO c##aduser;
GRANT DBA TO c##aduser;

-- ##############################################################
--connect to Oracle server using c##aduser 
-- ##############################################################

connect c##aduser/root --Connection created by CONNECT script command disconnected
