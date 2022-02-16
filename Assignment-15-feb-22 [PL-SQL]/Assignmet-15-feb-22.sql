Part I: Create user called northwind identified by root.

Hint: Use xe connection (sys as sysdba/root) execute below command before creating user
alter session set "_ORACLE_SCRIPT"=true

    ==> Created the northwind connection 
    ==> Created the user using XE connection as using below command
 
         
        CREATE USER 
            c##northwind 
            IDENTIFIED BY root;
            
        ----------------------------
        
        => To view user details 
        
        SELECT 
            username,
            default_tablespace,
            profile,
            authentication_type
        FROM 
            dba_users
        WHERE
            account_status = 'OPEN';
    
    --------------------------------------------------------
    
        ==> Giving the privileges to the user using XE connection
        
        GRANT CREATE SESSION TO c##northwind;
        GRANT ALL PRIVILEGES TO c##northwind;
    
    --------------------------------------------------------

---$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
   Part II: CREATING TABLES FOR THE DATABASE
---$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
    =>    To create the tables we have just run the file given 
    =>    commad is run using sql Plus and user c##northwind
    
    SQL>@C:\Evosys\training_work\evosys_training_work\Assignment-15-feb-22 [PL-SQL]\Assignment_Northwind_Database_15Feb22\Oracle_Northwind_CreateObjects.sql
    
---$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
    Part III :INSERTING THE DATE INTO THE TABLES 
---$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
    => Here we have inserted the data same way as we have created the tables by running the .sql file 
    =>    commad is run using sql Plus and user c##northwind
    
    SQL>@C:\Evosys\training_work\evosys_training_work\Assignment-15-feb-22 [PL-SQL]\Assignment_Northwind_Database_15Feb22\Oracle_Northwind_InsertData.sql


---$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
    Part IV: Write queries on Northwind db
---$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
_______________________________________________________________________________________________________________________________________________________________________________________________________________________________________

1. Get a list of latest order IDs for all customers by using the max function on Order_ID column
-------------------------------------------------------------------------------------------------
SELECT 
    MAX(orderid) 
FROM 
    orders 
WHERE
    orderdate = (SELECT MAX(orderdate) FROM orders)
GROUP BY 
    orderdate;
    
---------------------------------------------------------------------------------------------------
output :
        11077
_______________________________________________________________________________________________________________________________________________________________________________________________________________________________________

2. Find suppliers who sell more than one product to Northwind Trader.
---------------------------------------------------------------------------------------------------

Query Break Down 
/*select * from suppliers;
select * from Products;
select * from Region;

supplier who sell more than one product 
SELECT 
     COUNT(p.supplierid),s.supplierID, s.companyName 
FROM 
    products p JOIN suppliers s 
    ON
    p.supplierid = s.supplierid
GROUP BY 
    p.supplierid;
    
select s.companyname from suppliers s where s.supplierid  IN (
                                                        SELECT p.supplierid from products p group by p.supplierid HAVING COUNT(p.supplierid) > 1 ORDER BY count(p.supplierid)
                                                    )


SELECT p.supplierid from products p,suppliers s where p.supplierid = s.supplierid group by p.supplierid HAVING COUNT(p.supplierid) > 1 ORDER BY count(p.supplierid); -- Suppliers who sell's more then one product 

SELECT 
    productid 
FROM
    products 
WHERE 
    supplierid IN(
                SELECT p.supplierid FROM products p 
                GROUP BY p.supplierid 
                HAVING COUNT(p.supplierid) > 1 
                );

select * from employees
select * from orders
select * from region
select * from territories where regionid = 3

select e.emnployeeid, e.firstName, 

select distinct(e.employeeid) from  territories t JOIN region r ON t.regionid = r.regionid ,employeeterritories e where r.regiondescription = 'Northern' ; --id of employee who treds in Northern region 

SELECT 
    DISTINCT(e.employeeid) 
FROM  
    territories t JOIN region r 
    ON t.regionid = r.regionid,
    employeeterritories e 
WHERE 
    r.regiondescription = 'Northern' ;

select o.orderid from orders o JOIN employeeterritories et ON o.employeeid = et.employeeid; -- Get the order id from orders table where employee ids are same 

select productid from orderDetails where orderid IN (select o.orderid from orders o JOIN employeeterritories et ON o.employeeid = et.employeeid); -- getting product id from order details table  based on order shown in order table 



SELECT p.supplierid from products p,suppliers s where p.supplierid = s.supplierid group by p.supplierid HAVING COUNT(p.supplierid) > 1;

SELECT companyName FROM suppliers 
WHERE 
supplierid IN(SELECT p.supplierid from products p,suppliers s where p.supplierid = s.supplierid group by p.supplierid HAVING COUNT(p.supplierid) > 1);
*/

SELECT companyName 
FROM suppliers
WHERE 
    supplierid IN(
                SELECT p.supplierid 
                FROM products p JOIN suppliers s ON p.supplierid = s.supplierid 
                WHERE p.productid IN(
                                    SELECT productid 
                                    FROM orderDetails 
                                    WHERE 
                                        orderid IN (
                                                        SELECT o.orderid 
                                                        FROM orders o JOIN employeeterritories et 
                                                        ON o.employeeid = et.employeeid
                                                        WHERE o.employeeid IN (
                                                                                SELECT DISTINCT(e.employeeid) 
                                                                                FROM  territories t JOIN region r ON t.regionid = r.regionid ,employeeterritories e 
                                                                                WHERE r.regiondescription = 'Northern')
                                                    )                    
                                    )
                GROUP BY 
                    p.supplierid 
                HAVING COUNT(p.supplierid) > 1
    );
---------------------------------------------------------------------------------------------------
output:

Exotic Liquids
New Orleans Cajun Delights
Grandma Kelly's Homestead
Tokyo Traders
Cooperativa de Quesos 'Las Cabras'
Mayumi's
Pavlova, Ltd.
Specialty Biscuits, Ltd.
PB Knäckebröd AB
Heli Süßwaren GmbH Co. KG
Plutzer Lebensmittelgroßmärkte AG
Formaggi Fortini s.r.l.
Norske Meierier
Bigfoot Breweries
Svensk Sjöföda AB
Aux joyeux ecclésiastiques
New England Seafood Cannery
Leka Trading
Lyngbysild
Zaanse Snoepfabriek
Karkki Oy
G'day, Mate
Ma Maison
Pasta Buttini s.r.l.
Gai pâturage
Forêts d'érables
_______________________________________________________________________________________________________________________________________________________________________________________________________________________________________


_______________________________________________________________________________________________________________________________________________________________________________________________________________________________________

3. Create a function to get latest order date for entered customer_id
---------------------------------------------------------------------------------------------------

select * from customers ;
select customerid,orderdate from orders;
--------------------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION get_latest_order_for_customer(c_id IN VARCHAR)
RETURN VARCHAR
IS
    o_date VARCHAR(20);
    
    CURSOR let_order_date IS
            SELECT orderdate FROM orders WHERE customerid = c_id ORDER BY orderdate DESC FETCH FIRST 1 ROWS ONLY;    
    
BEGIN
    OPEN let_order_date;
    FETCH let_order_date INTO o_date;
    
    RETURN o_date;
END;
-----------------------------------------------------------------------------------------------------------------------------------

DECLARE
  v_order_date VARCHAR2(20);
  --v_customerid VARCHAR2(10):= &v_customerid;
BEGIN
--  v_order_date := get_latest_order_for_customer(TO_CHAR(v_customerid));
  v_order_date := get_latest_order_for_customer('ALFKI');
  dbms_output.put_line('Latest order date for ALFKI is ' || v_order_date);
END;


---------------------------------------------------------------------------------------------------
output:
    Latest order date for ALFKI is 09-04-98
_______________________________________________________________________________________________________________________________________________________________________________________________________________________________________

_______________________________________________________________________________________________________________________________________________________________________________________________________________________________________

4. Get the top 10 most expensive products.

---------------------------------------------------------------------------------------------------

SELECT 
    productname AS TOP_MOST_EXPENSIVE_PRODUCTS, unitprice 
FROM 
    products 
ORDER BY 
    unitprice DESC 
    FETCH FIRST 10 ROWS ONLY;
---------------------------------------------------------------------------------------------------
output:

Côte de Blaye	        263.5
Thüringer Rostbratwurst	123.79
Mishi Kobe Niku	        97
Sir Rodney's Marmalade	81
Carnarvon Tigers	    62.5
Raclette Courdavault	55
Manjimup Dried Apples	53
Tarte au sucre	        49.3
Ipoh Coffee	            46
Rössle Sauerkraut	    45.6
_______________________________________________________________________________________________________________________________________________________________________________________________________________________________________

_______________________________________________________________________________________________________________________________________________________________________________________________________________________________________

5. Rank products by the number of units in stock in each product category.
---------------------------------------------------------------------------------------------------
select * from products

SELECT categoryid,sum(unitsinstock) from products group by categoryid

SELECT categoryid,SUM(unitsinstock) FROM products GROUP BY categoryid;

SELECT 
		productname, 
		categoryid,
        unitsinstock,
		RANK() OVER(
			PARTITION BY categoryid
			ORDER BY unitsinstock DESC) 
			u_rank
	FROM 
		products
---------------------------------------------------------------------------------------------------
output:

Rhönbräu Klosterbier	    1	125	1
Sasquatch Ale	            1	111	2
Chartreuse verte	        1	69	3
Lakkalikööri	            1	57	4
Laughing Lumberjack Lager	1	52	5
Chai	                    1	39	6
Steeleye Stout          	1	20	7
Guaraná Fantástica      	1	20	7
Côte de Blaye	            1	17	9
Ipoh Coffee	                1	17	9
Chang	                    1	17	9
Outback Lager	            1	15	12
Grandma's Boysenberry Spread2	120	1
Sirop d'érable	            2	113	2
Louisiana Fiery Hot Pepper Sauce	2	76	3
Chef Anton's Cajun Seasoning	2	53	4
Genen Shouyu	            2	39	5
Original Frankfurter grüne Soße	2	32	6
Gula Malacca	            2	27	7
Vegie-spread	            2	24	8
Aniseed Syrup	            2	13	9
Northwoods Cranberry Sauce	2	6	10
Louisiana Hot Spiced Okra	2	4	11
Chef Anton's Gumbo Mix	    2	0	12
NuNuCa Nuß-Nougat-Creme	    3	76	1
Valkoinen suklaa	        3	65	2
Schoggi Schokolade	        3	49	3
Sir Rodney's Marmalade	    3	40	4
Zaanse koeken	            3	36	5
Pavlova	                    3	29	6
Teatime Chocolate Biscuits	3	25	7
Tarte au sucre	            3	17	8
Gumbär Gummibärchen	        3	15	9
Chocolade	                3	15	9
Maxilaku                	3	10	11
Scottish Longbreads	        3	6	12
Sir Rodney's Scones	        3	3	13
_______________________________________________________________________________________________________________________________________________________________________________________________________________________________________

_______________________________________________________________________________________________________________________________________________________________________________________________________________________________________

6. Rank customers by the total sales amount within each order date
---------------------------------------------------------------------------------------------------

select * from customers
select count(*) from orders

SELECT CUSTOMERID FROM ORDERS WHERE ORDERDATE IN (SELECT DISTINCT(orderdate) FROM ORDERS)

SELECT SUM(freight) FROM orders WHERE GROUP BY 

SELECT O.* FROM ORDERS O,ORDERS S WHERE O.ORDERDATE = S.ORDERDATE AND O.CUSTOMERID = S.CUSTOMERID
---------------------------------------------------------------------------------------------------
output:
_______________________________________________________________________________________________________________________________________________________________________________________________________________________________________

_______________________________________________________________________________________________________________________________________________________________________________________________________________________________________

7. For each order, calculate a subtotal for each Order (identified by OrderID)
---------------------------------------------------------------------------------------------------
select * from orders;

SELECT 
    orderid,SUM(unitprice * quantity * (1-discount)) as Subtotal 
FROM 
    orderdetails
GROUP BY 
    orderid
ORDER BY 
    orderid;

---------------------------------------------------------------------------------------------------
output:
10248	440
10249	1863.4
10250	1552.6
10251	654.06
10252	3597.9
.......
_______________________________________________________________________________________________________________________________________________________________________________________________________________________________________

_______________________________________________________________________________________________________________________________________________________________________________________________________________________________________

8. Sales by Year for each order. Hint: Get Subtotal as sum(UnitPrice * Quantity * (1 - Discount)) for every order_id then join with orders  table.
---------------------------------------------------------------------------------------------------

SELECT 
    DISTINCT TO_DATE(a.ShippedDate) AS ShippedDate, 
    a.OrderID, 
    b.Subtotal
FROM Orders a 
    INNER JOIN
    (
        SELECT DISTINCT OrderID, 
             SUM(UnitPrice * Quantity * (1 - Discount)) AS Subtotal
        FROM orderdetails
        GROUP BY OrderID  
        
    ) b 
    ON a.OrderID = b.OrderID
WHERE
        a.ShippedDate IS NOT NULL
        AND
        a.ShippedDate BETWEEN TO_DATE('1996-12-24','yyyy-mm-dd') AND TO_DATE('1997-09-30','yyyy-mm-dd')
ORDER BY 
    a.ShippedDate;
---------------------------------------------------------------------------------------------------
output:
_______________________________________________________________________________________________________________________________________________________________________________________________________________________________________

_______________________________________________________________________________________________________________________________________________________________________________________________________________________________________

9. Get Employee sales by country name
---------------------------------------------------------------------------------------------------
select * from categories
select * from products
select * from orderdetails

SELECT e.country, e.Lastname, e.Firstname,o.shippedDate,o.orderid,(od.unitprice * od.quantity) 
FROM
    employees e JOIN orders o ON e.employeeid = o.employeeid, orderdetails od 

WHERE 
    o.orderid = od.orderid 

ORDER BY lastname

---------------------------------------------------------------------------------------------------
output:

UK	Buchanan	Steven	25-03-97	10477	216
UK	Buchanan	Steven	25-03-97	10477	168
UK	Buchanan	Steven	25-03-97	10477	288
UK	Buchanan	Steven	09-05-97	10529	336
UK	Buchanan	Steven	09-05-97	10529	250
UK	Buchanan	Steven	09-05-97	10529	360
UK	Buchanan	Steven	30-05-97	10549	687.5
UK	Buchanan	Steven	30-05-97	10549	950
UK	Buchanan	Steven	30-05-97	10549	2544
............
_______________________________________________________________________________________________________________________________________________________________________________________________________________________________________

_______________________________________________________________________________________________________________________________________________________________________________________________________________________________________

10. Alphabetical list of product
---------------------------------------------------------------------------------------------------
select * from products 

SELECT 
    productname, supplierid, categoryid, quantityperunit, unitprice 
FROM 
    products 
ORDER BY 
    productname;
---------------------------------------------------------------------------------------------------
output:

Alice Mutton	        7	6	20 - 1 kg tins	39
Aniseed Syrup	        1	2	12 - 550 ml bottles	10
Boston Crab Meat	    19	8	24 - 4 oz tins	18.4
Camembert Pierrot	    28	4	15 - 300 g rounds	34
Carnarvon Tigers	    7	8	16 kg pkg.	62.5
Chai	                1	1	10 boxes x 20 bags	18
Chang	                1	1	24 - 12 oz bottles	19
Chartreuse verte	    18	1	750 cc per bottle	18
.........
_______________________________________________________________________________________________________________________________________________________________________________________________________________________________________

_______________________________________________________________________________________________________________________________________________________________________________________________________________________________________

11. Display the current Productlist Hint: Discontinued=’N’
---------------------------------------------------------------------------------------------------
select * from products 

SELECT productid, productname 
FROM
    products
WHERE 
    discontinued = 0;


---------------------------------------------------------------------------------------------------
output:

1	Chai
2	Chang
3	Aniseed Syrup
4	Chef Anton's Cajun Seasoning
6	Grandma's Boysenberry Spread
7	Uncle Bob's Organic Dried Pears
8	Northwoods Cranberry Sauce
10	Ikura
11	Queso Cabrales

...........
_______________________________________________________________________________________________________________________________________________________________________________________________________________________________________

_______________________________________________________________________________________________________________________________________________________________________________________________________________________________________

12. Calculate sales price for each order after discount is applied
---------------------------------------------------------------------------------------------------
select * from products;
select * from orderdetails;

SELECT 
        o.orderid, o.productid, p.productname, o.unitprice, o.quantity, o.discount, (o.unitprice * o.quantity * (1 - o.discount)) 
FROM 
    orderdetails o INNER JOIN products p 
    ON o.productid = p.productid
---------------------------------------------------------------------------------------------------
output:

10747	69	Gudbrandsdalsost	    36	30	0	1080
10748	23	Tunnbröd	            9	44	0	396
10748	40	Boston Crab Meat	    18.4	40	0	736
10748	56	Gnocchi di nonna Alice	38	28	0	1064
10749	56	Gnocchi di nonna Alice	38	15	0	570
10749	59	Raclette Courdavault	55	6	0	330
10749	76	Lakkalikööri	        18	10	0	180
10750	14	Tofu	                23.25	5	0.15	98.8125
10750	45	Rogede sild	            9.5	40	0.15	323
.....
_______________________________________________________________________________________________________________________________________________________________________________________________________________________________________

_______________________________________________________________________________________________________________________________________________________________________________________________________________________________________

13. Sales by Category: For each category, we get the list of products sold and the total sales amount

---------------------------------------------------------------------------------------------------
select * from Categories

SELECT o.productid, sum(o.unitprice * o.quantity * (1 - o.discount)) as productSales FROM orderdetails o GROUP BY productid;

SELECT p.categoryid, c.categoryName, p.productName, s.productSales
FROM products p JOIN Categories c ON p.categoryid = c.categoryid 
                JOIN (SELECT o.productid, sum(o.unitprice * o.quantity * (1 - o.discount)) as productSales 
                        FROM orderdetails o GROUP BY productid) s 
                ON p.productid = s.productid; 
---------------------------------------------------------------------------------------------------
output:

4	Dairy Products	Gudbrandsdalsost	        21942.36
5	Grains/Cereals	Tunnbröd	                4601.7
8	Seafood	Boston Crab Meat	                17910.63
5	Grains/Cereals	Gnocchi di nonna Alice	    42593.06
4	Dairy Products	Raclette Courdavault	    71155.7
1	Beverages	    Lakkalikööri	            15760.44
7	Produce	        Tofu	                    7991.49
8	Seafood	Rogede sild	                        4338.175
3	Confections	Gumbär Gummibärchen	            19849.1445

........
_______________________________________________________________________________________________________________________________________________________________________________________________________________________________________

_______________________________________________________________________________________________________________________________________________________________________________________________________________________________________

14. Create below views

1.vwProducts_Above_Average_Price
Displays products(productname,unitprice) who’s price is greater than avg(price)
---------------------------------------------------------------------------------------------------
CREATE VIEW 
    vwProducts_Above_Average_Price 
AS 
SELECT 
    productName,unitprice 
FROM 
    products 
WHERE 
    unitprice > (SELECT AVG(unitprice) FROM products) 
ORDER BY unitprice; 

----
SELECT * FROM vwProducts_Above_Average_Price;

---------------------------------------------------------------------------------------------------
output:

Uncle Bobs Organic Dried Pears	30
Ikura	                        31
Gumbär Gummibärchen	            31.23
Mascarpone Fabioli	            32
Perth Pasties	                32.8
Wimmers gute Semmelknödel	    33.25
Camembert Pierrot	            34
Mozzarella di Giovanni	        34.8
Gudbrandsdalsost	            36
Queso Manchego La Pastora	    38
Gnocchi di nonna Alice	        38
Alice Mutton	                39
Northwoods Cranberry Sauce	    40
Vegie-spread	                43.9
Schoggi Schokolade	            43.9
Rössle Sauerkraut	            45.6
Ipoh Coffee	                    46
Tarte au sucre	                49.3
Manjimup Dried Apples	        53
Raclette Courdavault	        55
Carnarvon Tigers	            62.5
Sir Rodney's Marmalade	        81
Mishi Kobe Niku	                97    
.....
_______________________________________________________________________________________________________________________________________________________________________________________________________________________________________

_______________________________________________________________________________________________________________________________________________________________________________________________________________________________________

2. vwQuarterly_Orders_by_Product

Display product(productname), customers(companyname), orders(orderyear)
---------------------------------------------------------------------------------------------------
select * from customers

CREATE VIEW 
    vwQuarterly_Orders_by_Product 
AS
    SELECT p.productName,c.companyName,EXTRACT(year FROM o.orderDate) AS year FROM products p, customers c, orders o, orderdetails od 
    WHERE 
        od.orderId = o.orderid AND od.productid = p.productid AND o.customerid = c.customerid;


select * from vwQuarterly_Orders_by_Product;
---------------------------------------------------------------------------------------------------
output:

Alice Mutton	                Hungry Coyote Import Store	1997
Geitost         	            Hungry Coyote Import Store	1997
Teatime Chocolate Biscuits	    Wartian Herkku	1997
Perth Pasties	                Wartian Herkku	1997
Ravioli Angelo	                Wartian Herkku	1997
Côte de Blaye	                Simons bistro	1997
Spegesild	                    Simons bistro	1997
Scottish Longbreads	            Simons bistro	1997
Original Frankfurter grüne Soße	Simons bistro	1997
Chang	                        QUICK-Stop	1997

......
_______________________________________________________________________________________________________________________________________________________________________________________________________________________________________

_______________________________________________________________________________________________________________________________________________________________________________________________________________________________________

3. vwUnitsInStock
Display Supplier Continent wise sum of unitinstock.

'Europe'= ('UK','Spain','Sweden','Germany','Norway','Denmark','Netherlands','Finland','Italy','France')
'America'= ('USA','Canada','Brazil')
'Asia-Pacific'

SELECT DECODE (region, 1,'USA',2,'Canada',3,'Brazil','America') FROM suppliers;

SELECT NVL (DECODE (region, 1,'UK', 2,'Spain', 3,'Sweden', 4,'Germany', 5,'Norway', 6,'Denmark', 7,'Netherlands', 8,'Finland', 9,'Italy', 10,'France'), 'Europe')
  FROM Suppliers;
---------------------------------------------------------------------------------------------------
select * from suppliers

---------------------------------------------------------------------------------------------------
output:
_______________________________________________________________________________________________________________________________________________________________________________________________________________________________________

_______________________________________________________________________________________________________________________________________________________________________________________________________________________________________
'
4. vw10Most_Expensive_Products

Display top 10 expensive products
---------------------------------------------------------------------------------------------------
CREATE VIEW vw10Most_Expensive_Products
AS
SELECT 
    productname AS TOP_MOST_EXPENSIVE_PRODUCTS, unitprice 
FROM 
    products 
ORDER BY 
    unitprice DESC 
    FETCH FIRST 10 ROWS ONLY;
    
----
select * from vw10Most_Expensive_Products;
---------------------------------------------------------------------------------------------------
output:
Côte de Blaye	263.5
Thüringer Rostbratwurst	123.79
Mishi Kobe Niku	97
Sir Rodney's Marmalade	81
Carnarvon Tigers	62.5
Raclette Courdavault	55
Manjimup Dried Apples	53
Tarte au sucre	49.3
Ipoh Coffee	46
Rössle Sauerkraut	45.6
_______________________________________________________________________________________________________________________________________________________________________________________________________________________________________
_______________________________________________________________________________________________________________________________________________________________________________________________________________________________________

5. vwCustomer_Supplier_by_City
    
    Display customer supplier by city
---------------------------------------------------------------------------------------------------

CREATE VIEW 
        vwCustomer_Supplier_by_City
AS 

--------
SELECT city, companyName, contactName, 
        CASE  WHEN customers.customerid IN (SELECT customers.customerid FROM customers JOIN suppliers ON customers.contacttitle = suppliers.contacttitle) THEN 'supplier'
        ELSE
            'customer' 
        END
FROM customers
ORDER BY CITY;

/*
select *  from customers;

SELECT city, companyName, contactName FROM customers order by city

select customers.customerid from customers join suppliers on customers.contacttitle = suppliers.contacttitle
*/
---------------------------------------------------------------------------------------------------
output:
Aachen	Drachenblut Delikatessen	Sven Ottlieb	supplier
Albuquerque	Rattlesnake Canyon Grocery	Paula Wilson	customer
Anchorage	Old World Delicatessen	Rene Phillips	supplier
Barcelona	Galería del gastrónomo	Eduardo Saavedra	supplier
Barquisimeto	LILA-Supermercado	Carlos González	supplier
Bergamo	Magazzini Alimentari Riuniti	Giovanni Rovelli	supplier
Berlin	Alfreds Futterkiste	Maria Anders	supplier
Bern	Chop-suey Chinese	Yang Wang	supplier
