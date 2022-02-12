https://www.oracletutorial.com/oracle-synonym/oracle-drop-synonym/
https://www.oracletutorial.com/oracle-sequence/
https://www.oracletutorial.com/oracle-administration/


---######################################################################################################################
Oracle Synonym
---######################################################################################################################
 => create aliases for schema objects such as tables, views, materialized views, sequences, procedures, and stored function.
 
 => Synonyms provide a level of security by hiding the name and owner of a schema object such as a table or a view. 
 
 =>Synonyms create a level of abstraction
 
 =>
---######################################################################################################################
---######################################################################################################################


SELECT * FROM MEMBERS;

CREATE PUBLIC SYNONYM
    fname 
FOR 
    members.first_name;
    
------------------------------------------

SELECT 
    *
FROM 
    fname;
    
/*
    ORA-00980: synonym translation is no longer valid
00980. 00000 -  "synonym translation is no longer valid"
*Cause:    A synonym did not translate to a legal target object. This
           could happen for one of the following reasons:
           1. The target schema does not exist.
           2. The target object does not exist.
           3. The synonym specifies an incorrect database link.
           4. The synonym is not versioned but specifies a versioned
           target object.
*Action:   Change the synonym definition so that the synonym points at
           a legal target object.
Error at Line: 33 Column: 5
*/

so we are dropin this synonym here 

DROP PUBLIC SYNONYM fname FORCE;

CREATE PUBLIC SYNONYM 
    first_name
FOR 
    members.first_name;
    
select * from first_name;

---######################################################################################################################
Oracle Sequence
---######################################################################################################################

A sequence is a list of integers in which their orders are important. For example, the (1,2,3,4,5) and (5,4,3,2,1) are
totally different sequences even though they have the same members.
---######################################################################################################################
---######################################################################################################################

Creating sequnece

CREATE SEQUENCE item_seq;

SELECT 
    item_seq.NEXTVAL
FROM 
    dual;
    
$$$$ Once, you acquire the sequence number through the NEXTVAL pseudo-column, you can access it repeatedly using the CURRVAL pseudo-column:

SELECT 
    item_seq.CURRVAL
FROM 
    dual;
------------------------------------------

SELECT 
    item_seq.NEXTVAL
FROM   
    dual
CONNECT BY level <= 5;


---------------------------
CREATE TABLE items(
    item_id NUMBER
);

----------------------------------------------------
INSERT INTO items(item_id) VALUES(item_seq.NEXTVAL);
INSERT INTO items(item_id) VALUES(item_seq.NEXTVAL);
------------------------------------------------------
COMMIT;

SELECT item_id FROM items;


--))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
Modifying a sequence

ALTER SEQUENCE item_seq MAXVALUE 100;

--))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
Removing a sequence

DROP SEQUENCE item_seq;

--))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
Oracle sequence privileges

GRANT CREATE SEQUENCE 
TO user_name;





&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
DBA tasks
&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&


Oracle CREATE USER statement

    => allows you to create a new database user which you can use to ;log in to the database

 CREATE USER username
    IDENTIFIED BY password
    [DEFAULT TABLESPACE tablespace]
    [QUOTA {size | UNLIMITED} ON tablespace]
    [PROFILE profile]
    [PASSWORD EXPIRE]
    [ACCOUNT {LOCK | UNLOCK}];


---------------------------------------------------------

CREATE USER 
    C##demo_user
IDENTIFIED BY root;

---------------------------------------------------------

SELECT 
    username, 
    default_tablespace, 
    profile, 
    authentication_type
FROM
    dba_users
WHERE 
    account_status = 'OPEN';

---------------------------------------------------------

SQL> connect
Enter user-name: c##demo_user
Enter password:
ERROR:
ORA-01045: user C##DEMO_USER lacks CREATE SESSION privilege; logon denied 

---------------------------------------------------------

2) Using Oracle CREATE USER statement to create a new local user with password expired example

CREATE USER 
        C##jane 
IDENTIFIED BY 
        abcd1234 
PASSWORD EXPIRE;




  
SELECT 
    username, 
    default_tablespace, 
    profile, 
    authentication_type
FROM
    dba_users
WHERE 
    username LIKE ('C##%');
--________________________________________________________________________________

GRANT CREATE SESSION TO C##jane;


SQL> connect
Enter user-name: c##jane
Enter password:
ERROR:
ORA-28001: the password has expired

____________________________________________________________________________________________

 GRANT 

____________________________________________________________________________________________

GRANT CREATE SESSION TO C##DEMO_USER;

___________________________________________________
The most important system privileges are:

 CREATE SESSION
 CREATE TABLE
 CREATE VIEW
 CREATE PROCEDURE
 SYSDBA
 SYSOPER
___________________________________________________
Object privileges

 INSERT
 UPDATE
 DELETE
 INDEX
 EXECUTE
___________________________________________

CREATE USER c##jhon IDENTIFIED BY root;

commit ;
GRANT CREATE SESSION TO c##jhon;

GRANT CREATE TABLE TO C##jhon;

SELECT * FROM session_privs;

SQL> SELECT * FROM session_privs;

PRIVILEGE
----------------------------------------
CREATE SESSION
CREATE TABLE

------------------------------------------------------------------------------------

ALTER USER c##jhon QUOTA UNLIMITED ON USERS;

__________________________________________________________


REVOKE 


___________________________________________________________

The Oracle REVOKE statement revokes system and object privileges from a user. Here is the basic syntax of the Oracle REVOKE statement:

REVOKE ALL PRIVILEGES FROM C##JANE;

----------------------------------------

CREATE USER 
        c##bob 
IDENTIFIED BY 
    abcd1234;

-----------------------------------
GRANT CREATE SESSION TO c##bob;


---------------------------------------------

GRANT SELECT, INSERT, UPDATE, DELETE ON emp TO c##bob;



REVOKE SELECT, INSERT, UPDATE, DELETE ON emp
FROM C##bob;

REVOKE CREATE SESSION FROM c##bob;


__________________________________________________

DROP USER

___________________________________________________

CREATE USER c##foo IDENTIFIED BY abcd1234;

DROP USER c##foo;

______________________
 Using Oracle DROP USER to delete a user that has schema objects
 
 ____________________________________________________
CREATE USER 
    C##bar 
    IDENTIFIED BY abcd1234 
    QUOTA 5m ON EMP;

GRANT 
    CREATE SESSION,
    CREATE TABLE
TO C##bar;




________________________________________________________________________________

Oracle CREATE ROLE

 ==> A role is a group of privileges. Instead of granting individual privileges to users,
    you can group related privileges into a role and grant this role to users. Roles help 
    manage privileges more efficiently.
_____________________________________________________________________________________________
CREATE ROLE role_name
[IDENTIFIED BY password]
[NOT IDENTIFIED]

_____________________________________________________________________________________________

GRANT role_name TO another_role_name;

GRANT {system_privileges | object_privileges} TO role_name;


1) Using Oracle CREATE ROLE without a password example

CREATE ROLES c##mdm;

GRANT 
    SELECT, INSERT, UPDATE, DELETE
ON 
    customers
TO 
    C##mdm;

GRANT 
    SELECT, INSERT, UPDATE, DELETE
ON 
    contacts
TO 
    c##mdm;

GRANT 
    SELECT, INSERT, UPDATE, DELETE
ON 
    products
TO 
    c##mdm;

GRANT 
    SELECT, INSERT, UPDATE, DELETE
ON 
    product_categories
TO 
    C##mdm;

GRANT 
    SELECT, INSERT, UPDATE, DELETE
ON 
    warehouses
TO 
    C##mdm;

GRANT 
    SELECT, INSERT, UPDATE, DELETE
ON 
    locations
TO 
    C##mdm;

GRANT 
    SELECT, INSERT, UPDATE, DELETE
ON 
    employees
TO 
    C##mdm;


----------------------------------

CREATE USER 
    C##alice 
    IDENTIFIED BY abcd1234;

GRANT CREATE SESSION TO c##alice;

GRANT C##mdm TO C##alice;

SET ROLE C##mdm;


SELECT * FROM session_roles;

drop role c##mdm;


___________________________________________________________________________________________________

User Profiles
___________________________________________________________________________________________________

A user profile is a set of limits on the database resources and the user password. 
Once you assign a profile to a user, then that user cannot exceed the database resource and 
password limits.

SELECT 
  * 
FROM 
    dba_profiles
WHERE 
    PROFILE = 'DEFAULT'
ORDER BY 
    resource_type, 
    resource_name;


-----------------
CREATE PROFILE c##CRM_USERS LIMIT 
    SESSIONS_PER_USER          UNLIMITED
    CPU_PER_SESSION            UNLIMITED 
    CPU_PER_CALL               3000 
    CONNECT_TIME               15;


CREATE USER c##crm IDENTIFIED BY abcd1234
PROFILE crm_users;

