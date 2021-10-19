BEGIN TRANSACTION;

/* Create tables */
CREATE TABLE IF NOT EXISTS Employee(ID integer PRIMARY KEY, DepartmentID integer, 
ChiefID integer, Name text, Salary decimal(10,5));

CREATE TABLE IF NOT EXISTS Department(ID integer PRIMARY KEY, Name text);

/* Create few Toms in this company */
INSERT INTO Employee VALUES(1, 1, null, 'Chief-Tom1', 1000);
INSERT INTO Employee VALUES(2, 1, 1, 'Tom2', 1500);
INSERT INTO Employee VALUES(3, 1, 2, 'Tom3', 2000);
INSERT INTO Employee VALUES(4, 1, 2, 'Tom4', 2000);
INSERT INTO Employee VALUES(5, 1, 4, 'Tom5', 1600);
INSERT INTO Employee VALUES(6, 1, 5, 'Tom6', 1500);
INSERT INTO Employee VALUES(7, 2, null, 'Chief-Tom7', 2100);
INSERT INTO Employee VALUES(8, 2, 7, 'Tom8', 1000);
INSERT INTO Employee VALUES(9, 2, 7, 'Tom9', 1100);
INSERT INTO Employee VALUES(10, 2, 7, 'Tom10', 1000);
INSERT INTO Employee VALUES(11, 2, 10, 'Tom11', 3200);
INSERT INTO Employee VALUES(12, 2, 10, 'Tom12', 1000);
INSERT INTO Employee VALUES(13, 3, null, 'Chief-Tom13', 1300);
INSERT INTO Employee VALUES(14, 3, 13, 'Tom14', 1500);
INSERT INTO Employee VALUES(15, 3, 13, 'Tom15', 1400);
INSERT INTO Employee VALUES(16, 3, 13, 'Tom16', 1000);

INSERT INTO Department VALUES(1, 'Dep1');
INSERT INTO Department VALUES(2, 'Dep2');
INSERT INTO Department VALUES(3, 'Dep3');
COMMIT;

/*Connexus Query 1a
if one employee with the highest salary to be selected: */
    
    SELECT d.Name, e.Name, MAX(Salary) 
    FROM Employee AS e
    INNER JOIN Department AS d 
    ON d.ID = e.DepartmentID
    GROUP BY DepartmentID;
    
/*Connexus Query 1b
if multiple employees with the highest salary from the same department may be
encountered */  
    
    SELECT d.Name, e.Name, Salary 
    FROM Employee AS e
    INNER JOIN Department AS d 
    ON d.ID = e.DepartmentID
    WHERE (DepartmentID, Salary) 
    IN(
        SELECT DepartmentID, MAX(Salary)
        FROM Employee
        GROUP BY DepartmentID
    );
    
/*Connexus Query 2
determines heads of departments ( I suppose that ChiefId = null for chief of departments
since thay do not have a direct manager among id of this database,
otherwise id of the chairman of the Board may be indicated there*/  

    SELECT e.Name, d.Name
    FROM Employee AS e
    INNER JOIN Department AS d 
    ON d.ID = e.DepartmentID
    WHERE e.ChiefID IS NULL
    GROUP BY e.DepartmentID;
    
/*Connexus Query 3
calculates efficiency per department */

    SELECT d.Name, 
    ROUND(CAST((COUNT(*) *100000.00) AS decimal(10,5)) /
    CAST(SUM(e.Salary) AS decimal(10,5)) , 2)  AS efficiency
    
    FROM Employee AS e
    INNER JOIN Department AS d 
    ON d.ID = e.DepartmentID
    GROUP BY e.DepartmentID
    ORDER BY efficiency DESC;

/*Connexus Query 4
Determines maximum hierarchy in department */


WITH CTE AS (
         SELECT ID, ChiefID, DepartmentID, 0 AS [Level]  
         FROM Employee
         WHERE ChiefID IS NULL 

         UNION ALL 

         SELECT e.ID, e.ChiefID, e.DepartmentID, [Level] + 1
         FROM Employee e 
         INNER JOIN CTE AS cte 
         ON cte.ID = e.ChiefID
 )
 SELECT d.Name, cte.[Level] 
 FROM CTE AS cte
 INNER JOIN Department AS d 
 ON d.ID = cte.DepartmentID
 GROUP BY DepartmentID
 ORDER BY [Level] DESC
